Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: Re: Cannot use any submenu in bluetoothctl since bluez 5.48
To: Vincent Petry <pvince81@googlemail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1135e315-5170-76b4-2c91-b0ab7a24cf5b@gmail.com>
Message-ID: <900b876a-6a72-b6a4-69fd-10db545d46fb@jp.fujitsu.com>
Date: Mon, 5 Feb 2018 17:21:16 +0900
MIME-Version: 1.0
In-Reply-To: <1135e315-5170-76b4-2c91-b0ab7a24cf5b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincent,

On 02/05/2018 03:57 PM, Vincent Petry wrote:
> Hello,
> 
> It appears that since bluez 5.48, the gatt commands and others have been
> moved into a submenu in the bluetoothctl shell.
> 
> I'm struggling to find a way to access the gatt commands. In the past I
> could just type "list-attributes" but now it says "Invalid command".
> 
> None of the following commands work:
> 
> - gatt
> - gatt help
> - help gatt
> - list-attributes
> 
> I had a quick look at the source code and I have the feeling that there
> is actually no way to access these commands.
> 
> If there is a way already, please make it easier and more intuitive to find.
> 

You can input "menu gatt" to enter gatt submenu and can use available commands
in gatt submenu (e.g. "list-attributes"). If you want to return to main menu,
you input "back". Then you can use available commands in main menu or enter
another submenu.

When inputting an invalid command, we may be able to add the messages like

  [bluetooth]# gatt
  Invalid command: gatt

  Use "help" for a list of available commands in a menu.
  Use "menu <submenu>" if you want to enter any submenu.
  Use "back" if you want to return to main menu.

with the following patch.

---
 src/shared/shell.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index f1b85f202..fad421ef1 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -335,6 +335,16 @@ static int menu_exec(const struct bt_shell_menu_entry *entry,
 	return -ENOENT;
 }
 
+static void help_messages(char *arg)
+{
+	print_text(COLOR_HIGHLIGHT,
+		"Invalid command: %s\n\n"
+		"Use \"help\" for a list of available commands in a menu.\n"
+		"Use \"menu <submenu>\" if you want to enter any submenu.\n"
+		"Use \"back\" if you want to return to main menu.",
+		arg);
+}
+
 static void shell_exec(int argc, char *argv[])
 {
 	if (!data.menu || !argv[0])
@@ -342,7 +352,7 @@ static void shell_exec(int argc, char *argv[])
 
 	if (menu_exec(default_menu, argc, argv) == -ENOENT) {
 		if (menu_exec(data.menu->entries, argc, argv) == -ENOENT)
-			print_text(COLOR_HIGHLIGHT, "Invalid command");
+			help_messages(argv[0]);
 	}
 }
 
-- 
2.14.1


Regards,
Eramoto

> My env:
> - openSUSE Tumbleweed snapshot 20180130
> - bluez 5.48
> - kernel 4.14.15-1-default
> 
> Thanks,
> 
> Vincent
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

