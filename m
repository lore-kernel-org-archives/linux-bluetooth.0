Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Move PIN codes to an external database
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Txxtf+7WEaY/momOmAQQ"
Date: Fri, 28 Nov 2008 15:36:55 +0000
Message-Id: <1227886615.26649.1181.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Txxtf+7WEaY/momOmAQQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

This is a patch to move the PIN quirks to an external tab-separated text
file. The parser is very simple and naive, but does the job for all the
devices I tested.

string_to_type() should probably be using an array instead of the
current code, and I've managed to move the current quirks to the
external file without a problem.

When this gets in, I'll work on moving all the quirks filed as bugs
against the wizard[1] into bluez-gnome proper.

Cheers

[1]: http://bugzilla.gnome.org/buglist.cgi?product=bluez-gnome&bug_status=NEW&bug_status=REOPENED&bug_status=ASSIGNED&bug_status=UNCONFIRMED&component=wizard

--=-Txxtf+7WEaY/momOmAQQ
Content-Disposition: attachment; filename="0001-Move-the-PIN-quirks-to-an-external-database.patch"
Content-Type: text/x-patch; name="0001-Move-the-PIN-quirks-to-an-external-database.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From a09d96d61f1fdf691abd9a35ade5151c466992d1 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 28 Nov 2008 15:27:54 +0000
Subject: [PATCH] Move the PIN quirks to an external database

Move the PIN quirks to a simple tab-separated text file.
---
 wizard/Makefile.am           |    7 ++-
 wizard/main.c                |  112 ++++++++++++++++++++++++++++++++++--------
 wizard/pin-code-database.txt |   24 +++++++++
 3 files changed, 120 insertions(+), 23 deletions(-)
 create mode 100644 wizard/pin-code-database.txt

diff --git a/wizard/Makefile.am b/wizard/Makefile.am
index 0a2ba45..ddf2cab 100644
--- a/wizard/Makefile.am
+++ b/wizard/Makefile.am
@@ -6,12 +6,15 @@ bluetooth_wizard_SOURCES = main.c
 bluetooth_wizard_LDADD = $(top_builddir)/common/libcommon.a \
 						@GTK_LIBS@ @DBUS_LIBS@
 
-AM_CFLAGS = @DBUS_CFLAGS@ @GTK_CFLAGS@
+AM_CFLAGS = -DPKGDATADIR="\"$(pkgdatadir)\"" @DBUS_CFLAGS@ @GTK_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common
 
+pin_DATA = pin-code-database.txt
+pindir = $(pkgdatadir)
+
 man_MANS = bluetooth-wizard.1
 
-EXTRA_DIST = $(man_MANS)
+EXTRA_DIST = $(man_MANS) $(pin_DATA)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/wizard/main.c b/wizard/main.c
index 09209a9..b29552c 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -37,6 +37,7 @@
 #include "helper.h"
 
 #define AGENT_PATH "/org/bluez/agent/wizard"
+#define PIN_CODE_DB "pin-code-database.txt"
 
 static BluetoothClient *client;
 static BluetoothAgent *agent;
@@ -56,32 +57,100 @@ static GtkWidget *label_passkey = NULL;
 
 static GtkTreeSelection *search_selection = NULL;
 
+#define TYPE_IS(x, r) {				\
+	if (g_str_equal(type, x)) return r;	\
+}
+
+static guint string_to_type(const char *type)
+{
+	TYPE_IS ("any", BLUETOOTH_TYPE_ANY);
+	TYPE_IS ("mouse", BLUETOOTH_TYPE_MOUSE);
+	TYPE_IS ("keyboard", BLUETOOTH_TYPE_KEYBOARD);
+	TYPE_IS ("headset", BLUETOOTH_TYPE_HEADSET);
+	TYPE_IS ("headphone", BLUETOOTH_TYPE_HEADPHONE);
+
+	g_warning ("unhandled type '%s'", type);
+	return BLUETOOTH_TYPE_ANY;
+}
+
+static char *set_pincode_for_device(guint type, const char *address, const char *name)
+{
+	char *contents, **lines;
+	char *ret_pin = NULL;
+	guint i;
+
+	/* Load the PIN database and split it in lines */
+	if (!g_file_get_contents(PIN_CODE_DB, &contents, NULL, NULL)) {
+		char *filename;
+
+		filename = g_build_filename(PKGDATADIR, PIN_CODE_DB, NULL);
+		if (!g_file_get_contents(filename, &contents, NULL, NULL)) {
+			g_warning("Could not load "PIN_CODE_DB);
+			g_free (filename);
+			return NULL;
+		}
+		g_free (filename);
+	}
+
+	lines = g_strsplit(contents, "\n", -1);
+	g_free (contents);
+	if (lines == NULL) {
+		g_warning("Could not parse "PIN_CODE_DB);
+		return NULL;
+	}
+
+	/* And now process each line */
+	for (i = 0; lines[i] != NULL; i++) {
+		char **items;
+		guint ltype;
+		const char *laddress, *lname, *lpin;
+
+		/* Ignore comments and empty lines */
+		if (lines[i][0] == '#' || lines[i][0] == '\0')
+			continue;
+
+		items = g_strsplit(lines[i], "\t", 4);
+		ltype = string_to_type(items[0]);
+
+		if (ltype != BLUETOOTH_TYPE_ANY && ltype != type) {
+			g_strfreev (items);
+			continue;
+		}
+		laddress = items[1];
+		lname = items[2];
+		lpin = items[3];
+
+		/* If we have an address, does the OUI prefix match? */
+		if (strlen(laddress) > 0 && g_str_has_prefix(address, laddress) == FALSE) {
+			g_strfreev (items);
+			continue;
+		}
+
+		/* If we have a name, does it match? */
+		if (strlen(lname) > 0 && g_str_equal(name, lname) == FALSE) {
+			g_strfreev (items);
+			continue;
+		}
+
+		/* Everything matches, we have a pincode */
+		ret_pin = g_strdup(lpin);
+		g_strfreev(items);
+		break;
+	}
+
+	g_strfreev(lines);
+	return ret_pin;
+}
+
 static gboolean pincode_callback(DBusGMethodInvocation *context,
 					DBusGProxy *device, gpointer user_data)
 {
-	const char *pincode = target_pincode;
+	char *pincode;
 	gchar *text;
 
-	/* Apple Wireless and Mighty Mouse */
-	if (target_type == BLUETOOTH_TYPE_MOUSE && 
-				(g_str_has_prefix(target_address,
-							"00:0A:95:") == TRUE ||
-				g_str_has_prefix(target_address,
-							"00:14:51:") == TRUE))
-		pincode = "0000";
-
-	/* Most headsets are using 0000 as pincode */
-	if (target_type == BLUETOOTH_TYPE_HEADSET ||
-				target_type == BLUETOOTH_TYPE_HEADPHONE)
-		pincode = "0000";
-
-	/* Most GPS devices are using 0000 as pincode */
-	if (g_str_has_prefix(target_address, "00:0D:B5") == TRUE &&
-				(g_str_equal(target_name,
-					"TomTom Wireless GPS MkII") == TRUE ||
-				g_str_equal(target_name,
-						"GPS-GW-005") == TRUE))
-		pincode = "0000";
+	pincode = set_pincode_for_device(target_type, target_address, target_name);
+	if (pincode == NULL)
+		pincode = g_strdup(target_pincode);
 
 	text = g_strdup_printf(_("Please enter the following PIN code: %s"),
 								pincode);
@@ -89,6 +158,7 @@ static gboolean pincode_callback(DBusGMethodInvocation *context,
 	g_free(text);
 
 	dbus_g_method_return(context, pincode);
+	g_free(pincode);
 
 	return TRUE;
 }
diff --git a/wizard/pin-code-database.txt b/wizard/pin-code-database.txt
new file mode 100644
index 0000000..653fc2c
--- /dev/null
+++ b/wizard/pin-code-database.txt
@@ -0,0 +1,24 @@
+# This is a PIN code database for use in the Bluetooth wizard.
+#
+# The syntax is a simple tab-separated file with 4 fields:
+# type	bdaddr_prefix	device_name	device_pin
+# 
+# Lines starting with # (such as this one) and empty lines are ignored
+# Recognised types are:
+# any, mouse, keyboard, headset, headphones
+# 
+# The bdaddr_prefix and device_name fields can be left empty
+
+# Apple Wireless and Mighty Mouse
+mouse	00:0A:95:		0000
+mouse	00:14:51:		0000
+
+# GPS devices
+any	00:0D:B5:	TomTom Wireless GPS MkII	0000
+any	00:0D:B5:	GPS-GW-005	0000
+
+######## Generic type ########
+
+# Headphones and headsets
+headphone			0000
+headset			0000
-- 
1.6.0.4


--=-Txxtf+7WEaY/momOmAQQ--

