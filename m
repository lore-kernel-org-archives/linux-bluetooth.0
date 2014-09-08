Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: 6lowpan: Increase the connection timeout value
Date: Mon,  8 Sep 2014 12:11:43 +0300
Message-Id: <1410167505-30889-2-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1410167505-30889-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1410167505-30889-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the default connection timeout value defined in l2cap.h because
the current timeout was too short and most of the time the connection
attempts timed out.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 35ebe79..5532e6e 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -890,7 +890,7 @@ static void chan_resume_cb(struct l2cap_chan *chan)
 
 static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
 {
-	return msecs_to_jiffies(1000);
+	return L2CAP_CONN_TIMEOUT;
 }
 
 static const struct l2cap_ops bt_6lowpan_chan_ops = {
-- 
1.8.3.1

