Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] adapter: Convert storage did file
Date: Wed, 21 Nov 2012 14:49:50 +0100
Message-Id: <1353505791-21134-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 3dafacb..0d1dfea 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2548,6 +2548,45 @@ static void convert_blocked_entry(GKeyFile *key_file, void *value)
 	g_key_file_set_boolean(key_file, "General", "Blocked", TRUE);
 }
 
+static void convert_did_entry(GKeyFile *key_file, void *value)
+{
+	char *vendor_str, *product_str, *version_str;
+	uint16_t val;
+
+	vendor_str = strchr(value, ' ');
+	if (!vendor_str)
+		return;
+
+	*(vendor_str++) = 0;
+
+	if (g_str_equal(value, "FFFF"))
+		return;
+
+	product_str = strchr(vendor_str, ' ');
+	if (!product_str)
+		return;
+
+	*(product_str++) = 0;
+
+	version_str = strchr(product_str, ' ');
+	if (!version_str)
+		return;
+
+	*(version_str++) = 0;
+
+	val = (uint16_t) strtol(value, NULL, 16);
+	g_key_file_set_integer(key_file, "DeviceID", "Source", val);
+
+	val = (uint16_t) strtol(vendor_str, NULL, 16);
+	g_key_file_set_integer(key_file, "DeviceID", "Vendor", val);
+
+	val = (uint16_t) strtol(product_str, NULL, 16);
+	g_key_file_set_integer(key_file, "DeviceID", "Product", val);
+
+	val = (uint16_t) strtol(version_str, NULL, 16);
+	g_key_file_set_integer(key_file, "DeviceID", "Version", val);
+}
+
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
@@ -2633,6 +2672,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
 	/* Convert blocked */
 	convert_file("blocked", address, convert_blocked_entry);
+
+	/* Convert device ids */
+	convert_file("did", address, convert_did_entry);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

