Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] adapter: Convert storage linkkeys file
Date: Tue, 27 Nov 2012 09:49:50 +0100
Message-Id: <1354006193-7199-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354006193-7199-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354006193-7199-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 9d6554a..32d3930 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2618,6 +2618,34 @@ static void convert_did_entry(GKeyFile *key_file, void *value)
 	g_key_file_set_integer(key_file, "DeviceID", "Version", val);
 }
 
+static void convert_linkkey_entry(GKeyFile *key_file, void *value)
+{
+	char *type_str, *length_str, *str;
+	gint val;
+
+	type_str = strchr(value, ' ');
+	if (!type_str)
+		return;
+
+	*(type_str++) = 0;
+
+	length_str = strchr(type_str, ' ');
+	if (!length_str)
+		return;
+
+	*(length_str++) = 0;
+
+	str = g_strconcat("0x", value, NULL);
+	g_key_file_set_string(key_file, "LinkKey", "Key", str);
+	g_free(str);
+
+	val = strtol(type_str, NULL, 16);
+	g_key_file_set_integer(key_file, "LinkKey", "Type", val);
+
+	val = strtol(length_str, NULL, 16);
+	g_key_file_set_integer(key_file, "LinkKey", "PINLength", val);
+}
+
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
@@ -2707,6 +2735,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
 	/* Convert device ids */
 	convert_file("did", address, "info", convert_did_entry);
+
+	/* Convert linkkeys */
+	convert_file("linkkeys", address, "keys", convert_linkkey_entry);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

