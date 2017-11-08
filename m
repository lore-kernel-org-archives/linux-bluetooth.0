Return-Path: <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Bluetooth: Use common error handling code in bt_init()
Message-ID: <cc83ce48-c0a4-1b83-8fdc-a474eb102fe0@users.sourceforge.net>
Date: Wed, 8 Nov 2017 08:14:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 8 Nov 2017 08:03:04 +0100

* Improve jump targets so that a bit of exception handling can be better
  reused at the end of this function.

* Adjust five condition checks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 net/bluetooth/af_bluetooth.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 91e3ba280706..f044202346c6 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -766,43 +766,39 @@ static int __init bt_init(void)
 		return err;
 
 	err = sock_register(&bt_sock_family_ops);
-	if (err < 0) {
-		bt_sysfs_cleanup();
-		return err;
-	}
+	if (err)
+		goto cleanup_sysfs;
 
 	BT_INFO("HCI device and connection manager initialized");
 
 	err = hci_sock_init();
-	if (err < 0)
-		goto error;
+	if (err)
+		goto unregister_socket;
 
 	err = l2cap_init();
-	if (err < 0)
-		goto sock_err;
+	if (err)
+		goto cleanup_socket;
 
 	err = sco_init();
-	if (err < 0) {
-		l2cap_exit();
-		goto sock_err;
-	}
+	if (err)
+		goto cleanup_cap;
 
 	err = mgmt_init();
-	if (err < 0) {
-		sco_exit();
-		l2cap_exit();
-		goto sock_err;
-	}
+	if (err)
+		goto cleanup_sco;
 
 	return 0;
 
-sock_err:
+cleanup_sco:
+	sco_exit();
+cleanup_cap:
+	l2cap_exit();
+cleanup_socket:
 	hci_sock_cleanup();
-
-error:
+unregister_socket:
 	sock_unregister(PF_BLUETOOTH);
+cleanup_sysfs:
 	bt_sysfs_cleanup();
-
 	return err;
 }
 
-- 
2.15.0
