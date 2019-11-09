using Gtk;

public class Day01App : Gtk.Application {
    
    private TextView text_view;
    private Entry entPart1;
    private Entry entPart2;

    private int part1solution;
    private int part2solution;

    public Day01App () {
        Object (
            application_id: "com.github.stquinton.AoC2018.Day01App",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 500;
        main_window.default_width = 500;
        main_window.title = "Day 01 Solver";
        
        var lblInputs = new Label.with_mnemonic ("_Inputs:");

        this.text_view = new TextView();
        this.text_view.editable = false;
        this.text_view.cursor_visible = false;

        var scroll = new ScrolledWindow (null, null);
        scroll.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scroll.add (this.text_view);
        scroll.set_vexpand(true);

        try {
            string inputs;
            FileUtils.get_contents ("./input.txt", out inputs);
            this.text_view.buffer.text = inputs;
        }
        catch {
            this.text_view.buffer.text = "import failed";
        }

        var btnBox = new Box (Orientation.HORIZONTAL, 20);
        var btnSolvePart1 = new Button.with_mnemonic("_Solve Part 1");
        entPart1 = new Entry();
        entPart1.sensitive = false;
        btnSolvePart1.clicked.connect (part1solver);

        var btnSolvePart2 = new Button.with_mnemonic("_Solve Part 2");
        entPart2 = new Entry();
        entPart2.sensitive = false;
        btnSolvePart2.clicked.connect (part2solver);

        btnBox.pack_start (btnSolvePart1, false, true, 5);
        btnBox.pack_start (entPart1, false, true, 5);
        btnBox.pack_start (btnSolvePart2, false, true, 5);
        btnBox.pack_start (entPart2, false, true, 5);

        var main_box = new Box (Orientation.VERTICAL, 2);
        main_box.pack_start (lblInputs, false, true, 2);
        main_box.pack_start (scroll, false, true, 2);
        main_box.pack_end (btnBox, false, true, 2);

        main_window.add (main_box);
        main_window.show_all ();
    }

    private void part1solver (Button source) {
        string inputs = this.text_view.buffer.text;
        string[] lines = inputs.split("\n");
        part1solution = 0;
        
        for (int i = 0; i < lines.length; i++) {
            part1solution += int.parse(lines[i]);
        }
        entPart1.text = part1solution.to_string();
    }

    private void part2solver (Button source) {
        string inputs = this.text_view.buffer.text;
        string[] lines = inputs.split("\n");
        bool foundDup = false;
        int[] freqs = {};

        while (foundDup == false) {
            for (int i = 0; i < lines.length; i++) {
                part2solution += int.parse(lines[i]);

                for (int x = 0; x < freqs.length; x++) {
                    if (freqs[x] == part2solution) {
                        foundDup = true;
                        entPart2.text = part2solution.to_string();
                        break;
                    }
                }
                if (foundDup) {
                    break;
                } else {
                    freqs += part2solution;  
                    //print (freqs[freqs.length - 1].to_string() + " - " + part2solution.to_string() + "\n"); 
                }
            }
        }
    }

    public static int main (string[] args) {
        var app = new Day01App ();
        return app.run (args);
    }
}