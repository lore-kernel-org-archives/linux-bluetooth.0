Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] src/gatt-dbus: Add GATT Extended props bit fields
Date: Thu, 19 Feb 2015 14:27:46 +0530
Message-id: <1424336266-17437-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed the TODO and added the GATT  Characteristic Extended
Properties Bitfield values as per core spec 4.2 - page 2227.
---
 attrib/gatt.h   | 4 ++++
 src/gatt-dbus.c | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index f6db10f..c26a286 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -42,6 +42,10 @@
 #define GATT_CHR_PROP_AUTH				0x40
 #define GATT_CHR_PROP_EXT_PROP				0x80
 
+/* GATT Characteristic Extended Properties Bitfield values */
+#define GATT_CHRC_EXT_PROP_RELIABLE_WRITE	0x01
+#define GATT_CHRC_EXT_PROP_WRITABLE_AUX 	0x02
+
 /* Client Characteristic Configuration bit field */
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
 #define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index c22e8af..a5a9faf 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -154,11 +154,13 @@ static uint8_t flags_string2int(const char *proper)
 		value = GATT_CHR_PROP_INDICATE;
 	else if (!strcmp("authenticated-signed-writes", proper))
 		value = GATT_CHR_PROP_AUTH;
+	else if (!strcmp("reliable-write", proper))
+		value = GATT_CHRC_EXT_PROP_RELIABLE_WRITE;
+	else if (!strcmp("writable-auxiliaries", proper))
+		value = GATT_CHRC_EXT_PROP_WRITABLE_AUX ;
 	else
 		value = 0;
 
-	/* TODO: Extended properties. Ref core spec 4.1 page 2185  */
-
 	return value;
 }
 
-- 
1.9.1

