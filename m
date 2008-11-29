Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] More PIN quirks
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-gQjUhWU27TPuP+xwXYP9"
Date: Sat, 29 Nov 2008 16:39:17 +0000
Message-Id: <1227976757.26649.2692.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-gQjUhWU27TPuP+xwXYP9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This builds on top of the move to a PIN database.

This fixes all but one bug filed against the wizard in the GNOME
bugzilla.

I hope it shows that the PIN database is workable.

Cheers

--=-gQjUhWU27TPuP+xwXYP9
Content-Disposition: attachment; filename="0001-Add-other-audio-devices.patch"
Content-Type: text/x-patch; name="0001-Add-other-audio-devices.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From e3419bae8524e86902b69c7d9bfdd580ea394786 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sat, 29 Nov 2008 16:18:46 +0000
Subject: [PATCH] Add other audio devices

And special-case them in the wizard.
---
 common/bluetooth-client.c    |    4 ++++
 common/bluetooth-client.h    |   13 +++++++------
 wizard/main.c                |    1 +
 wizard/pin-code-database.txt |    1 +
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/common/bluetooth-client.c b/common/bluetooth-client.c
index 5c55a00..bd42132 100644
--- a/common/bluetooth-client.c
+++ b/common/bluetooth-client.c
@@ -92,6 +92,8 @@ const gchar *bluetooth_type_to_string(guint type)
 		return N_("Headset");
 	case BLUETOOTH_TYPE_HEADPHONE:
 		return N_("Headphone");
+	case BLUETOOTH_TYPE_OTHER_AUDIO:
+		return N_("Audio device");
 	case BLUETOOTH_TYPE_KEYBOARD:
 		return N_("Keyboard");
 	case BLUETOOTH_TYPE_MOUSE:
@@ -134,6 +136,8 @@ static guint class_to_type(guint32 class)
 			return BLUETOOTH_TYPE_HEADSET;
 		case 0x06:
 			return BLUETOOTH_TYPE_HEADPHONE;
+		default:
+			return BLUETOOTH_TYPE_OTHER_AUDIO;
 		}
 		break;
 	case 0x05:
diff --git a/common/bluetooth-client.h b/common/bluetooth-client.h
index 09f91ab..5c35213 100644
--- a/common/bluetooth-client.h
+++ b/common/bluetooth-client.h
@@ -112,12 +112,13 @@ enum {
 	BLUETOOTH_TYPE_NETWORK		= 1 << 4,
 	BLUETOOTH_TYPE_HEADSET		= 1 << 5,
 	BLUETOOTH_TYPE_HEADPHONE	= 1 << 6,
-	BLUETOOTH_TYPE_KEYBOARD		= 1 << 7,
-	BLUETOOTH_TYPE_MOUSE		= 1 << 8,
-	BLUETOOTH_TYPE_CAMERA		= 1 << 9,
-	BLUETOOTH_TYPE_PRINTER		= 1 << 10,
-	BLUETOOTH_TYPE_JOYPAD		= 1 << 11,
-	BLUETOOTH_TYPE_TABLET		= 1 << 12,
+	BLUETOOTH_TYPE_OTHER_AUDIO	= 1 << 7,
+	BLUETOOTH_TYPE_KEYBOARD		= 1 << 8,
+	BLUETOOTH_TYPE_MOUSE		= 1 << 9,
+	BLUETOOTH_TYPE_CAMERA		= 1 << 10,
+	BLUETOOTH_TYPE_PRINTER		= 1 << 11,
+	BLUETOOTH_TYPE_JOYPAD		= 1 << 12,
+	BLUETOOTH_TYPE_TABLET		= 1 << 13,
 };
 
 #define _BLUETOOTH_TYPE_NUM_TYPES 12
diff --git a/wizard/main.c b/wizard/main.c
index b29552c..2342040 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -68,6 +68,7 @@ static guint string_to_type(const char *type)
 	TYPE_IS ("keyboard", BLUETOOTH_TYPE_KEYBOARD);
 	TYPE_IS ("headset", BLUETOOTH_TYPE_HEADSET);
 	TYPE_IS ("headphone", BLUETOOTH_TYPE_HEADPHONE);
+	TYPE_IS ("audio", BLUETOOTH_TYPE_OTHER_AUDIO);
 
 	g_warning ("unhandled type '%s'", type);
 	return BLUETOOTH_TYPE_ANY;
diff --git a/wizard/pin-code-database.txt b/wizard/pin-code-database.txt
index 653fc2c..a12dcb4 100644
--- a/wizard/pin-code-database.txt
+++ b/wizard/pin-code-database.txt
@@ -22,3 +22,4 @@ any	00:0D:B5:	GPS-GW-005	0000
 # Headphones and headsets
 headphone			0000
 headset			0000
+audio			0000
-- 
1.6.0.4


--=-gQjUhWU27TPuP+xwXYP9
Content-Disposition: attachment; filename="0002-Handle-printers-in-the-wizard.patch"
Content-Type: text/x-patch; name="0002-Handle-printers-in-the-wizard.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 9890adcebaf94a8051d948e215d752e3b22a2f3b Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sat, 29 Nov 2008 16:20:33 +0000
Subject: [PATCH] Handle printers in the wizard

.
---
 wizard/main.c                |    1 +
 wizard/pin-code-database.txt |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/wizard/main.c b/wizard/main.c
index 2342040..763d5e3 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -69,6 +69,7 @@ static guint string_to_type(const char *type)
 	TYPE_IS ("headset", BLUETOOTH_TYPE_HEADSET);
 	TYPE_IS ("headphone", BLUETOOTH_TYPE_HEADPHONE);
 	TYPE_IS ("audio", BLUETOOTH_TYPE_OTHER_AUDIO);
+	TYPE_IS ("printer", BLUETOOTH_TYPE_PRINTER);
 
 	g_warning ("unhandled type '%s'", type);
 	return BLUETOOTH_TYPE_ANY;
diff --git a/wizard/pin-code-database.txt b/wizard/pin-code-database.txt
index a12dcb4..4eaf23c 100644
--- a/wizard/pin-code-database.txt
+++ b/wizard/pin-code-database.txt
@@ -19,6 +19,9 @@ any	00:0D:B5:	GPS-GW-005	0000
 
 ######## Generic type ########
 
+# Printers
+printer			0000
+
 # Headphones and headsets
 headphone			0000
 headset			0000
-- 
1.6.0.4


--=-gQjUhWU27TPuP+xwXYP9
Content-Disposition: attachment; filename="0003-Add-quirks-for-loads-of-GPS-devices.patch"
Content-Type: text/x-patch; name="0003-Add-quirks-for-loads-of-GPS-devices.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 90d37d576e95685f0d46be13008cea2f5a0b85b6 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sat, 29 Nov 2008 16:28:25 +0000
Subject: [PATCH] Add quirks for loads of GPS devices

All from the GNOME bugzilla.
---
 wizard/pin-code-database.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/wizard/pin-code-database.txt b/wizard/pin-code-database.txt
index 4eaf23c..773d69b 100644
--- a/wizard/pin-code-database.txt
+++ b/wizard/pin-code-database.txt
@@ -16,6 +16,22 @@ mouse	00:14:51:		0000
 # GPS devices
 any	00:0D:B5:	TomTom Wireless GPS MkII	0000
 any	00:0D:B5:	GPS-GW-005	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=560870
+any	00:0A:3A:	BT GPS	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=560606
+any	00:1B:C1:	HOLUX_M-241	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=560713
+any	00:0B:24:	Triceiver	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=560715
+any	00:00:00:	BT-Q880	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=560625
+any	00:11:67:	eGPS-397	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=560604
+any	00:1B:C1:	HOLUX_M-1000	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=561326
+any	00:0B:0D:	G-Rays1	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=561327
+any	00:0A:3A:	HUDGPS	0000
 
 ######## Generic type ########
 
-- 
1.6.0.4


--=-gQjUhWU27TPuP+xwXYP9
Content-Disposition: attachment; filename="0004-Add-more-PIN-quirks.patch"
Content-Type: text/x-patch; name="0004-Add-more-PIN-quirks.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 7e0ec64061abb7b17a6d7dbe9cbbd2a6036e857a Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sat, 29 Nov 2008 16:34:41 +0000
Subject: [PATCH] Add more PIN quirks

>From GNOME bugzilla again.
---
 wizard/main.c                |    1 +
 wizard/pin-code-database.txt |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/wizard/main.c b/wizard/main.c
index 763d5e3..f165778 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -70,6 +70,7 @@ static guint string_to_type(const char *type)
 	TYPE_IS ("headphone", BLUETOOTH_TYPE_HEADPHONE);
 	TYPE_IS ("audio", BLUETOOTH_TYPE_OTHER_AUDIO);
 	TYPE_IS ("printer", BLUETOOTH_TYPE_PRINTER);
+	TYPE_IS ("network", BLUETOOTH_TYPE_NETWORK);
 
 	g_warning ("unhandled type '%s'", type);
 	return BLUETOOTH_TYPE_ANY;
diff --git a/wizard/pin-code-database.txt b/wizard/pin-code-database.txt
index 773d69b..3971ae2 100644
--- a/wizard/pin-code-database.txt
+++ b/wizard/pin-code-database.txt
@@ -32,6 +32,18 @@ any	00:1B:C1:	HOLUX_M-1000	0000
 any	00:0B:0D:	G-Rays1	0000
 # http://bugzilla.gnome.org/show_bug.cgi?id=561327
 any	00:0A:3A:	HUDGPS	0000
+# http://bugzilla.gnome.org/show_bug.cgi?id=562479
+any	00:0B:0D:	iBT-GPS	0000
+
+# Audio devices
+# http://bugzilla.gnome.org/show_bug.cgi?id=560315
+headset		X3 micro	1234
+# http://bugzilla.gnome.org/show_bug.cgi?id=561324
+headset	00:03:C9:	BT Headset	1111
+
+# Network devices
+# http://bugzilla.gnome.org/show_bug.cgi?id=561325
+network	00:06:66:	OBDPros scantool	1234
 
 ######## Generic type ########
 
-- 
1.6.0.4


--=-gQjUhWU27TPuP+xwXYP9
Content-Disposition: attachment; filename="0001-Add-icon-for-other-audio-device.patch"
Content-Type: text/x-patch; name="0001-Add-icon-for-other-audio-device.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 9c85f509761b3f5484f988c485bc42b555c03871 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sat, 29 Nov 2008 16:17:53 +0000
Subject: [PATCH] Add icon for other audio device

.
---
 src/dbus-hci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index f2b6f2e..a0de9a0 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -85,6 +85,8 @@ const char *class_to_icon(uint32_t class)
 			return "audio-card";	/* Headset */
 		case 0x06:
 			return "audio-card";	/* Headphone */
+		default:
+			return "audio-card";	/* Other audio device */
 		}
 		break;
 	case 0x05:
-- 
1.6.0.4


--=-gQjUhWU27TPuP+xwXYP9--

