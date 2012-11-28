Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/8] adapter: Convert storage linkkeys file
Date: Wed, 28 Nov 2012 14:39:24 +0100
Message-Id: <1354109967-6238-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index f9382fd..5bad0f9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2644,6 +2644,34 @@ static void convert_did_entry(GKeyFile *key_file, void *value)
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
@@ -2744,6 +2772,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
 	/* Convert device ids */
 	convert_file("did", address, "info", convert_did_entry);
+
+	/* Convert linkkeys */
+	convert_file("linkkeys", address, "keys", convert_linkkey_entry);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

