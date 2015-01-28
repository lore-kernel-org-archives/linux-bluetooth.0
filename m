Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Perform a power cycle when receiving a HW Error
Date: Wed, 28 Jan 2015 15:13:19 +0200
Message-Id: <1422450799-18548-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1422450799-18548-1-git-send-email-johan.hedberg@gmail.com>
References: <1422450799-18548-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we receive a Hardware Error HCI event the controller should be
assumed to be non-functional until a full reset procedure has been
performed with it. This patch adds a new hci_reset() helper function
that can be triggered through a workqueue, and schedules the function to
be called whenever a Hardware Error event occurs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 15 +++++++++++++++
 net/bluetooth/hci_event.c        |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0f5e59f1e3cb..3e3380c1e2d9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -293,6 +293,7 @@ struct hci_dev {
 
 	struct work_struct	power_on;
 	struct delayed_work	power_off;
+	struct work_struct	reset;
 
 	__u16			discov_timeout;
 	struct delayed_work	discov_off;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 46aa702c189d..a6afce413842 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2140,6 +2140,20 @@ static void hci_power_off(struct work_struct *work)
 	smp_unregister(hdev);
 }
 
+static void hci_reset(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, reset);
+
+	BT_DBG("%s", hdev->name);
+
+	if (hci_dev_do_close(hdev))
+		return;
+
+	smp_unregister(hdev);
+
+	hci_dev_do_open(hdev);
+}
+
 static void hci_discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev;
@@ -2932,6 +2946,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
 	INIT_WORK(&hdev->power_on, hci_power_on);
+	INIT_WORK(&hdev->reset, hci_reset);
 
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4175470ff48e..0fd6f4d97b4a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3101,6 +3101,8 @@ static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_ev_hardware_error *ev = (void *) skb->data;
 
 	BT_ERR("%s hardware error 0x%2.2x", hdev->name, ev->code);
+
+	queue_work(hdev->req_workqueue, &hdev->reset);
 }
 
 static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.1.0

