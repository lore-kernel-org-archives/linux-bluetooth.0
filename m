Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 03/12] adapter: Fix device storage creation
Date: Fri, 30 Nov 2012 15:46:57 +0100
Message-Id: <1354286826-24016-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create device storage directory and file only if there
is data to write.
---
 src/adapter.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f134dfe..8e3251b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2604,14 +2604,17 @@ static void convert_entry(char *key, char *value, void *user_data)
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 			converter->address, key);
 	filename[PATH_MAX] = '\0';
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 	converter->cb(key_file, value);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, data, length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
 	g_free(data);
 
 	g_key_file_free(key_file);
-- 
1.7.9.5

