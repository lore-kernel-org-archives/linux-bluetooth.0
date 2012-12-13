Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/15] adapter: Convert device profiles list
Date: Thu, 13 Dec 2012 21:39:18 +0100
Message-Id: <1355431170-12897-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 940cc0a..3bb1ea6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2553,6 +2553,12 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
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
@@ -2660,6 +2666,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 	/* Convert blocked */
 	convert_file("blocked", address, convert_blocked_entry, TRUE);
 
+	/* Convert profiles */
+	convert_file("profiles", address, convert_profiles_entry, TRUE);
+
 	/* Convert linkkeys */
 	convert_file("linkkeys", address, convert_linkkey_entry, TRUE);
 
-- 
1.7.9.5

