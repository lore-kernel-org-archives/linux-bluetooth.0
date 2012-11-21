Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] adapter: Convert storage device blocked
Date: Wed, 21 Nov 2012 14:49:48 +0100
Message-Id: <1353505791-21134-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An entry exists in blocked file only when a device is blocked.
So, we do not need to check entry value and set device (entry key) as
blocked.
---
 src/adapter.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 0f6a078..3dafacb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2543,6 +2543,11 @@ static void convert_classes_entry(GKeyFile *key_file, void *value)
 	g_key_file_set_string(key_file, "General", "Class", value);
 }
 
+static void convert_blocked_entry(GKeyFile *key_file, void *value)
+{
+	g_key_file_set_boolean(key_file, "General", "Blocked", TRUE);
+}
+
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
@@ -2625,6 +2630,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
 	/* Convert classes */
 	convert_file("classes", address, convert_classes_entry);
+
+	/* Convert blocked */
+	convert_file("blocked", address, convert_blocked_entry);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

