# Directory Cleaner Script

This script allows you to clean specified file extensions from a given directory. It supports both command-line arguments and interactive dialogs for user input.

## Features

- Clean files based on specified extensions.
- Interactive dialog for selecting directory and file extensions.
- Command-line options for automation.
- Confirmation dialogs to prevent accidental deletions.

## Usage

### Command-line Options

```bash
Usage: ./clean_directory.sh [-d directory] [-e extensions] [-h]
  -d directory      Specify the directory to clean
  -e extensions     Specify file extensions to remove (comma-separated)
  -h                Display help
```

## Example

To clean `.log` and `.tmp` files from the `/path/to/directory`:

```bash
./clean_directory.sh -d /path/to/directory -e log,tmp
```

## Interactive Mode

If no command-line options are provided, the script will enter interactive mode, where you can select the directory and file extensions through dialogs.

## Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/directory-cleaner.git
cd directory-cleaner
```

Make the script executable:

```bash
chmod +x clean_directory.sh
```

## Dependencies
Ensure you have zenity and dialog installed on your system. You can install them using:

```bash
sudo apt-get install zenity dialog
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a pull request

## Acknowledgments

- [Zenity](https://help.gnome.org/users/zenity/stable/) - Display graphical dialog boxes from the command line.
- [Dialog](https://invisible-island.net/dialog/dialog.html) - Display dialog boxes from shell scripts.

