Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/13] adapter: Convert appearances file
Date: Mon, 17 Dec 2012 16:09:45 +0100
Message-Id: <1355756994-18953-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1279145..c95e341 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2190,6 +2190,11 @@ static void convert_profiles_entry(GKeyFile *key_file, void *value)
 	g_key_file_set_string(key_file, "General", "Services", value);
 }
 
+static void convert_appearances_entry(GKeyFile *key_file, void *value)
+{
+	g_key_file_set_string(key_file, "General", "Appearance", value);
+}
+
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
@@ -2642,6 +2647,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 		textfile_put(filename, "converted", "yes");
 	}
 	free(str);
+
+	/* Convert appearances */
+	convert_file("appearances", address, convert_appearances_entry, FALSE);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

