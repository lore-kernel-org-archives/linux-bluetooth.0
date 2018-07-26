Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] shared/gatt-client: Fix crash on ext prop read failure
Date: Thu, 26 Jul 2018 16:25:22 +0200
Message-Id: <20180726142522.19485-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Program received signal SIGSEGV, Segmentation fault.
ext_prop_read_cb (success=false, att_ecode=0 '\000', value=0x0,
    length=0, user_data=0x72ad30) at src/shared/gatt-client.c:711
(gdb) bt
    length=0, user_data=0x72ad30) at src/shared/gatt-client.c:711
    at src/shared/att.c:547
                                         user_data=0x716070)
    at src/shared/att.c:580
                                          cond=<optimized out>,
                                          user_data=<optimized out>)
    at src/shared/io-glib.c:170
    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
    from /lib/x86_64-linux-gnu/libglib-2.
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 2e153db5c..3c2aa293b 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -708,6 +708,9 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 	bool discovering;
 	struct gatt_db_attribute *desc_attr = NULL;
 
+	if (!success)
+		goto done;
+
 	util_debug(client->debug_callback, client->debug_data,
 				"Ext. prop value: 0x%04x", (uint16_t)value[0]);
 
-- 
2.17.1

