Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 10/12] adapter: Convert storage longtermkeys file
Date: Fri, 30 Nov 2012 15:47:04 +0100
Message-Id: <1354286826-24016-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 17f478c..ff9d2e7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2655,6 +2655,46 @@ static void convert_linkkey_entry(GKeyFile *key_file, void *value)
 	g_key_file_set_integer(key_file, "LinkKey", "PINLength", val);
 }
 
+static void convert_ltk_entry(GKeyFile *key_file, void *value)
+{
+	char *auth_str, *rand_str, *str;
+	int i, ret;
+	unsigned char auth, master, enc_size;
+	unsigned short ediv;
+
+	auth_str = strchr(value, ' ');
+	if (!auth_str)
+		return;
+
+	*(auth_str++) = 0;
+
+	for (i = 0, rand_str = auth_str; i < 4; i++) {
+		rand_str = strchr(rand_str, ' ');
+		if (!rand_str || rand_str[1] == '\0')
+			return;
+
+		rand_str++;
+	}
+
+	ret = sscanf(auth_str, " %hhd %hhd %hhd %hd", &auth, &master,
+							&enc_size, &ediv);
+	if (ret < 4)
+		return;
+
+	str = g_strconcat("0x", value, NULL);
+	g_key_file_set_string(key_file, "LongTermKey", "Key", str);
+	g_free(str);
+
+	g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
+	g_key_file_set_integer(key_file, "LongTermKey", "Master", master);
+	g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
+	g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);
+
+	str = g_strconcat("0x", rand_str, NULL);
+	g_key_file_set_string(key_file, "LongTermKey", "Rand", str);
+	g_free(str);
+}
+
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
@@ -2766,6 +2806,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	/* Convert linkkeys */
 	convert_file("linkkeys", address, convert_linkkey_entry, TRUE);
 
+	/* Convert longtermkeys */
+	convert_file("longtermkeys", address, convert_ltk_entry, TRUE);
+
 	/* Convert classes */
 	convert_file("classes", address, convert_classes_entry, FALSE);
 
-- 
1.7.9.5

