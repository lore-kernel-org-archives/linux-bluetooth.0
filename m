Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/15] device: Retrieve device technology from storage
Date: Thu, 13 Dec 2012 21:39:16 +0100
Message-Id: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/src/device.c b/src/device.c
index e7aa44d..515ee61 100644
--- a/src/device.c
+++ b/src/device.c
@@ -244,6 +244,35 @@ static gboolean store_device_info_cb(gpointer user_data)
 		g_key_file_remove_key(key_file, "General", "Class", NULL);
 	}
 
+	switch (device->bdaddr_type) {
+	case BDADDR_BREDR:
+		g_key_file_set_string(key_file, "General",
+					"SupportedTechnologies", "BR/EDR");
+		g_key_file_remove_key(key_file, "General",
+					"AddressType", NULL);
+		break;
+
+	case BDADDR_LE_PUBLIC:
+		g_key_file_set_string(key_file, "General",
+					"SupportedTechnologies", "LE");
+		g_key_file_set_string(key_file, "General",
+					"AddressType", "public");
+		break;
+
+	case BDADDR_LE_RANDOM:
+		g_key_file_set_string(key_file, "General",
+					"SupportedTechnologies", "LE");
+		g_key_file_set_string(key_file, "General",
+					"AddressType", "static");
+		break;
+
+	default:
+		g_key_file_remove_key(key_file, "General",
+					"SupportedTechnologies", NULL);
+		g_key_file_remove_key(key_file, "General",
+					"AddressType", NULL);
+	}
+
 	g_key_file_set_boolean(key_file, "General", "Trusted",
 							device->trusted);
 
@@ -1714,6 +1743,9 @@ static void load_info(struct btd_device *device, const gchar *local,
 	gboolean store_needed = FALSE;
 	gboolean blocked;
 	int source, vendor, product, version;
+	char **techno, **t;
+	gboolean bredr = FALSE;
+	gboolean le = FALSE;
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", local, peer);
 	filename[PATH_MAX] = '\0';
@@ -1750,6 +1782,42 @@ static void load_info(struct btd_device *device, const gchar *local,
 		g_free(str);
 	}
 
+	/* Load device technology */
+	techno = g_key_file_get_string_list(key_file, "General",
+					"SupportedTechnologies", NULL, NULL);
+	if (!techno)
+		goto next;
+
+	for (t = techno; *t; t++) {
+		if (g_str_equal(*t, "BR/EDR"))
+			bredr = TRUE;
+		else if (g_str_equal(*t, "LE"))
+			le = TRUE;
+		else
+			error("Unknown device technology");
+	}
+
+	if (bredr && le) {
+		/* TODO: Add correct type for dual mode device */
+	} else if (bredr) {
+		device->bdaddr_type = BDADDR_BREDR;
+	} else if (le) {
+		str = g_key_file_get_string(key_file, "General",
+						"AddressType", NULL);
+
+		if (str && g_str_equal(str, "public"))
+			device->bdaddr_type = BDADDR_LE_PUBLIC;
+		else if (str && g_str_equal(str, "static"))
+			device->bdaddr_type = BDADDR_LE_RANDOM;
+		else
+			error("Unknown LE device technology");
+
+		g_free(str);
+	}
+
+	g_strfreev(techno);
+
+next:
 	/* Load trust */
 	device->trusted = g_key_file_get_boolean(key_file, "General",
 							"Trusted", NULL);
-- 
1.7.9.5

