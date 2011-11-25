Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/9] Bluetooth: Add dev_flags to struct hci_dev
Date: Fri, 25 Nov 2011 20:53:38 -0300
Message-Id: <1322265226-6404-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the dev_flags field to struct hci_dev. This new
flags variable should be used to define flags related to BR/EDR
and/or LE controller itself. It should be used to define flags
which represents states from the controller. The dev_flags is
cleared in case the controller sends a Reset Command Complete
Event to the host.

Also, this patch adds the HCI_LE_SCAN flag which was created to
track if the controller is performing LE scan or not. The flag
is set/cleared when the controller starts/stops scanning.

This is an initial effort to stop using hdev->flags to define
internal flags since it is exported to userspace by an ioctl.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    8 ++++++++
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |    1 +
 net/bluetooth/hci_event.c        |    6 ++++++
 4 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 376c574..c949a67 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -88,6 +88,14 @@ enum {
 	HCI_RESET,
 };
 
+/*
+ * BR/EDR and/or LE controller flags: the flags defined here should represent
+ * states from the controller.
+ */
+enum {
+	HCI_LE_SCAN,
+};
+
 /* HCI ioctl defines */
 #define HCIDEVUP	_IOW('H', 201, int)
 #define HCIDEVDOWN	_IOW('H', 202, int)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1795257..b2d7514 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -250,6 +250,8 @@ struct hci_dev {
 
 	struct module		*owner;
 
+	unsigned long		dev_flags;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ef0423e..dcbe1d2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1458,6 +1458,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	spin_lock_init(&hdev->lock);
 
 	hdev->flags = 0;
+	hdev->dev_flags = 0;
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dfe6fbc..9f74879 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -194,6 +194,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	clear_bit(HCI_RESET, &hdev->flags);
 
 	hci_req_complete(hdev, HCI_OP_RESET, status);
+
+	hdev->dev_flags = 0;
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
@@ -960,12 +962,16 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		return;
 
 	if (cp->enable == 0x01) {
+		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
+
 		del_timer(&hdev->adv_timer);
 
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
 		hci_dev_unlock(hdev);
 	} else if (cp->enable == 0x00) {
+		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
+
 		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
 	}
 }
-- 
1.7.7.1

