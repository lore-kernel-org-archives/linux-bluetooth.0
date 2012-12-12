Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/14] adapter: Convert device profiles list
Date: Wed, 12 Dec 2012 16:47:52 +0100
Message-Id: <1355327283-1558-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 7fcd42c..7ab2389 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2556,6 +2556,12 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
 	g_free(str);
 }
 
+static void convert_profiles_entry(GKeyFile *key_file, void *value)
+{
+	g_strdelimit(value, " ", ';');
+	g_key_file_set_string(key_file, "General", "Profiles", value);
+}
+
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
@@ -2663,6 +2669,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	/* Convert blocked */
 	convert_file("blocked", address, convert_blocked_entry, TRUE);
 
+	/* Convert profiles */
+	convert_file("profiles", address, convert_profiles_entry, TRUE);
+
 	/* Convert linkkeys */
 	convert_file("linkkeys", address, convert_linkkey_entry, TRUE);
 
-- 
1.7.9.5

