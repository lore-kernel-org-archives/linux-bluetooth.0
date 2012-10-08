Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 6/6] Bluetooth: AMP: Hanlde AMP_LINK case in conn_put
Date: Mon,  8 Oct 2012 17:52:12 +0300
Message-Id: <1349707932-10006-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle AMP link when setting up disconnect timeout.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 744713b..0cc8c85 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -604,7 +604,10 @@ static inline void hci_conn_put(struct hci_conn *conn)
 
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		unsigned long timeo;
-		if (conn->type == ACL_LINK || conn->type == LE_LINK) {
+
+		switch (conn->type) {
+		case ACL_LINK:
+		case LE_LINK:
 			del_timer(&conn->idle_timer);
 			if (conn->state == BT_CONNECTED) {
 				timeo = conn->disc_timeout;
@@ -613,12 +616,20 @@ static inline void hci_conn_put(struct hci_conn *conn)
 			} else {
 				timeo = msecs_to_jiffies(10);
 			}
-		} else {
+			break;
+
+		case AMP_LINK:
+			timeo = conn->disc_timeout;
+			break;
+
+		default:
 			timeo = msecs_to_jiffies(10);
+			break;
 		}
+
 		cancel_delayed_work(&conn->disc_work);
 		queue_delayed_work(conn->hdev->workqueue,
-					&conn->disc_work, timeo);
+				   &conn->disc_work, timeo);
 	}
 }
 
-- 
1.7.9.5

