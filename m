Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix error handling for l2cap_init()
Date: Sun, 21 Nov 2010 11:13:38 -0400
Message-Id: <1290352418-4589-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

create_singlethread_workqueue() may fail with errors such as -ENOMEM. If
this happens, the return value is not set to a negative value and the
module load will succeed. It will then crash on module unload because of
a destroy_workqueue() call on a NULL pointer.

Additionally, the _busy_wq workqueue is not being destroyed if any
errors happen on l2cap_init().

Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
---
 net/bluetooth/l2cap.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 18a802c..7980e24 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4875,8 +4875,10 @@ static int __init l2cap_init(void)
 		return err;
 
 	_busy_wq = create_singlethread_workqueue("l2cap");
-	if (!_busy_wq)
-		goto error;
+	if (!_busy_wq) {
+		err = -ENOMEM;
+		goto error_busy_wq;
+	}
 
 	err = bt_sock_register(BTPROTO_L2CAP, &l2cap_sock_family_ops);
 	if (err < 0) {
@@ -4904,6 +4906,8 @@ static int __init l2cap_init(void)
 	return 0;
 
 error:
+	destroy_workqueue(_busy_wq);
+error_busy_wq:
 	proto_unregister(&l2cap_proto);
 	return err;
 }
-- 
1.7.0.4

