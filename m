Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] adapter: Convert storage classes
Date: Thu, 15 Nov 2012 18:31:36 +0100
Message-Id: <1353000701-16605-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index ea2d2ad..5157b46 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2545,6 +2545,11 @@ static void convert_trusts_entry(GKeyFile *key_file, void *value)
 	g_key_file_set_boolean(key_file, "General", "Trusted", TRUE);
 }
 
+static void convert_classes_entry(GKeyFile *key_file, void *value)
+{
+	g_key_file_set_string(key_file, "General", "Class", value);
+}
+
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
@@ -2624,6 +2629,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
 	/* Convert trusts */
 	convert_file("trusts", address, convert_trusts_entry);
+
+	/* Convert classes */
+	convert_file("classes", address, convert_classes_entry);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

