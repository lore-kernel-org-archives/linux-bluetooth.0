Return-Path: <cyrus@holtmann.org>
Message-ID: <1361197591.4983.1.camel@dellpc>
Subject: Resend RFC [PATCH] hci: Fix race between hidp_session and hci code
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 18 Feb 2013 14:26:31 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Karl Relton <karllinuxtest.relton@ntlworld.com>

Fix race between hidp_session and hci code that can lead to
 hci device being removed from sysfs before its children
 devices. The removal is now delayed until the last
 reference to it in the hci code is removed.

Signed-off-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
---
 include/net/bluetooth/hci_core.h |   10 +++-------
 net/bluetooth/hci_core.c         |   15 +++++++++++++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 90cf75a..47c9d30 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -198,6 +198,7 @@ struct hci_dev {
 
 	unsigned long	quirks;
 
+	atomic_t	ref_cnt;
 	atomic_t	cmd_cnt;
 	unsigned int	acl_cnt;
 	unsigned int	sco_cnt;
@@ -646,19 +647,14 @@ static inline void hci_conn_put(struct hci_conn *conn)
 }
 
 /* ----- HCI Devices ----- */
-static inline void hci_dev_put(struct hci_dev *d)
-{
-	BT_DBG("%s orig refcnt %d", d->name,
-	       atomic_read(&d->dev.kobj.kref.refcount));
-
-	put_device(&d->dev);
-}
+void hci_dev_put(struct hci_dev *d);
 
 static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 {
 	BT_DBG("%s orig refcnt %d", d->name,
 	       atomic_read(&d->dev.kobj.kref.refcount));
 
+	atomic_inc(&d->ref_cnt);
 	get_device(&d->dev);
 	return d;
 }
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 618ca1a..c187a84 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -891,6 +891,19 @@ int hci_dev_close(__u16 dev)
 	return err;
 }
 
+void hci_dev_put(struct hci_dev *d)
+{
+	BT_DBG("%s orig refcnt %d", d->name,
+	       atomic_read(&d->dev.kobj.kref.refcount));
+
+	if(atomic_dec_and_test(&d->ref_cnt)) {
+		hci_del_sysfs(d);
+	}
+	put_device(&d->dev);
+}
+EXPORT_SYMBOL(hci_dev_put);
+
+
 int hci_dev_reset(__u16 dev)
 {
 	struct hci_dev *hdev;
@@ -1884,8 +1897,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		rfkill_destroy(hdev->rfkill);
 	}
 
-	hci_del_sysfs(hdev);
-
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
 
-- 
1.7.9.5



