Return-Path: <cyrus@holtmann.org>
From: doron.keren.bluez@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Doron Keren <doronkeren@ti.com>, Ilia Kolominsky <iliak@ti.com>
Subject: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HCI connection name.
Date: Wed, 17 Aug 2011 19:01:24 +0300
Message-Id: <1313596884-8733-1-git-send-email-doronkeren@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Doron Keren <doronkeren@ti.com>

The patch fixes kernel panic which is due to race condition
between the setup of incomming connection and clean-up of the
dead one. Observed in the following case: attached HID device
disconnects unexpectedly (without performing ACL disconnect ),
the device tries to connect again before the ACL link time-out
fires, this translates to the HCI_DISCONNECT, HCI_CONNECT_REQ
events on the same handle, since HCI_DISCONNECT trigers the clean
up of the HID device and handled in different context, the
linking/unlinking connection object to sysfs, may mess up.

Signed-off-by: Ilia Kolominsky <iliak@ti.com>
---
 net/bluetooth/hci_sysfs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index a6c3aa8..5967d63 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -9,6 +9,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+static int acl_conn_index = 0;
 static struct class *bt_class;
 
 struct dentry *bt_debugfs;
@@ -91,7 +92,8 @@ static void add_conn(struct work_struct *work)
 	struct hci_conn *conn = container_of(work, struct hci_conn, work_add);
 	struct hci_dev *hdev = conn->hdev;
 
-	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
+	acl_conn_index++;
+	dev_set_name(&conn->dev, "%s:%d:%d", hdev->name, conn->handle, acl_conn_index);
 
 	dev_set_drvdata(&conn->dev, conn);
 
-- 
1.7.4.1

