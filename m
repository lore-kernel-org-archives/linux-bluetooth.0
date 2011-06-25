Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 25 Jun 2011 17:32:35 -0400
Subject: [PATCH] Bluetooth: Fix hidp disconnect deadlock
Message-ID: <1309037555.2143.5.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Release reader lock on r/w sem before stopping khidp thread (which needs to
claim the writer lock on sem before unlinking the session).

NB: kthread_stop waits for thread completion.
---
 net/bluetooth/hidp/core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index c405a95..16d75d7 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1096,6 +1096,7 @@ int hidp_del_connection(struct hidp_conndel_req *req)
 {
 	struct hidp_session *session;
 	int err = 0;
+	bool stop_thread = false;
 
 	BT_DBG("");
 
@@ -1111,12 +1112,14 @@ int hidp_del_connection(struct hidp_conndel_req *req)
 			skb_queue_purge(&session->ctrl_transmit);
 			skb_queue_purge(&session->intr_transmit);
 
-			kthread_stop(session->task);
+			stop_thread = true;
 		}
 	} else
 		err = -ENOENT;
 
 	up_read(&hidp_session_sem);
+	if (stop_thread)
+		kthread_stop(session->task);
 	return err;
 }
 
-- 
1.7.4.1

