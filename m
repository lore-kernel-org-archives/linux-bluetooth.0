Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 05/12] adapter: Convert device type
Date: Fri, 30 Nov 2012 15:46:59 +0100
Message-Id: <1354286826-24016-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each time an entry is converted, check device technology and
update device info file
---
 src/adapter.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index a976793..c5e856d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2530,6 +2530,44 @@ struct device_converter {
 	gboolean force;
 };
 
+static void set_device_type(GKeyFile *key_file, char type)
+{
+	char *techno;
+	char *addr_type = NULL;
+	char *str;
+
+	switch (type) {
+	case BDADDR_BREDR:
+		techno = "BR/EDR";
+		break;
+	case BDADDR_LE_PUBLIC:
+		techno = "LE";
+		addr_type = "public";
+		break;
+	case BDADDR_LE_RANDOM:
+		techno = "LE";
+		addr_type = "static";
+		break;
+	default:
+		return;
+	}
+
+	str = g_key_file_get_string(key_file, "General",
+					"SupportedTechnologies", NULL);
+	if (!str)
+		g_key_file_set_string(key_file, "General",
+					"SupportedTechnologies", techno);
+	else if (!strstr(str, techno))
+		g_key_file_set_string(key_file, "General",
+					"SupportedTechnologies", "BR/EDR;LE");
+
+	g_free(str);
+
+	if (addr_type)
+		g_key_file_set_string(key_file, "General", "AddressType",
+					addr_type);
+}
+
 static void convert_aliases_entry(GKeyFile *key_file, void *value)
 {
 	g_key_file_set_string(key_file, "General", "Alias", value);
@@ -2592,13 +2630,16 @@ static void convert_did_entry(GKeyFile *key_file, void *value)
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
+	char device_type = -1;
 	char filename[PATH_MAX + 1];
 	GKeyFile *key_file;
 	char *data;
 	gsize length = 0;
 
-	if (key[17] == '#')
+	if (key[17] == '#') {
 		key[17] = '\0';
+		device_type = key[18] - '0';
+	}
 
 	if (bachk(key) != 0)
 		return;
@@ -2622,6 +2663,10 @@ static void convert_entry(char *key, char *value, void *user_data)
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	if (device_type >= 0)
+		set_device_type(key_file, device_type);
+
 	converter->cb(key_file, value);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-- 
1.7.9.5

