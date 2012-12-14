Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] device: Fix memory leak in load_att_info()
Date: Fri, 14 Dec 2012 10:43:22 +0100
Message-Id: <1355478202-10022-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7bde970..bb0db30 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1903,15 +1903,18 @@ static void load_att_info(struct btd_device *device, const gchar *local,
 	groups = g_key_file_get_groups(key_file, NULL);
 
 	for (handle = groups; *handle; handle++) {
+		gboolean uuid_ok;
+
 		str = g_key_file_get_string(key_file, *handle, "UUID", NULL);
 		if (!str)
 			continue;
 
-		if (!g_str_equal(str, prim_uuid))
-			continue;
-
+		uuid_ok = g_str_equal(str, prim_uuid);
 		g_free(str);
 
+		if (!uuid_ok)
+			continue;
+
 		str = g_key_file_get_string(key_file, *handle, "Value", NULL);
 		if (!str)
 			continue;
@@ -1938,6 +1941,8 @@ static void load_att_info(struct btd_device *device, const gchar *local,
 			}
 			break;
 		default:
+			g_free(str);
+			g_free(prim);
 			continue;
 		}
 
-- 
1.7.9.5

