Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 1/4] dbus-common: Map GAP Appearance characteristic to icon
Date: Tue, 27 Mar 2012 09:29:35 -0400
Message-Id: <1332854978-26072-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
References: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add function appearance_to_icon() to map values from Appearance
Characteristic to icon available.

Note: The Appearance Characteristic is composed of a category (10-bits)
and sub-categories (6-bits). These categories are defined at:
http://developer.bluetooth.org/gatt/characteristics/Pages/
CharacteristicViewer.aspx?u=org.bluetooth.characteristic.gap.appearance.xml
---
 src/dbus-common.c |   33 +++++++++++++++++++++++++++++++++
 src/dbus-common.h |    1 +
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index ef3b375..7e1bc94 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -243,3 +243,36 @@ const char *class_to_icon(uint32_t class)
 
 	return NULL;
 }
+
+const char *gap_appearance_to_icon(uint16_t appearance)
+{
+	switch ((appearance & 0xffc0) >> 6) {
+	case 0x01:
+		return "phone";
+	case 0x02:
+		return "computer";
+	case 0x05:
+		return "video-display";
+	case 0x0a:
+		return "multimedia-player";
+	case 0x0b:
+		return "scanner";
+	case 0x0f: /* HID Generic */
+		switch (appearance & 0x3f) {
+		case 0x01:
+			return "input-keyboard";
+		case 0x02:
+			return "input-mouse";
+		case 0x03:
+		case 0x04:
+			return "input-gaming";
+		case 0x05:
+			return "input-tablet";
+		case 0x08:
+			return "scanner";
+		}
+		break;
+	}
+
+	return NULL;
+}
diff --git a/src/dbus-common.h b/src/dbus-common.h
index b196a1b..b9531f2 100644
--- a/src/dbus-common.h
+++ b/src/dbus-common.h
@@ -45,3 +45,4 @@ void set_dbus_connection(DBusConnection *conn);
 DBusConnection *get_dbus_connection(void);
 
 const char *class_to_icon(uint32_t class);
+const char *gap_appearance_to_icon(uint16_t appearance);
-- 
1.7.5.4

