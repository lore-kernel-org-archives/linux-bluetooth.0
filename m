Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/6] Bluetooth: Add hci_le_scan()
Date: Fri,  3 Feb 2012 17:48:00 -0300
Message-Id: <1328302082-17405-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
References: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are not supposed to block in start_discovery() because
start_discovery code is running in write() syscall context
and this would block the write operation on the mgmt socket.
This way, we cannot directly call hci_do_le_scan() to scan
LE devices in start_discovery(). To overcome this issue a
derefered work (hdev->le_scan) was created so we can properly
call hci_do_le_scan().

The helper function hci_le_scan() simply set LE scan parameters
and queue hdev->le_scan work. The work is queued on system_long_wq
since it can sleep for a few seconds in the worst case (timeout).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    6 ++++++
 net/bluetooth/hci_core.c         |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3e70872..7107790 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -126,6 +126,7 @@ struct le_scan_params {
 	u8 type;
 	u16 interval;
 	u16 window;
+	int timeout;
 };
 
 #define NUM_REASSEMBLY 4
@@ -269,6 +270,9 @@ struct hci_dev {
 
 	struct delayed_work	le_scan_disable;
 
+	struct work_struct	le_scan;
+	struct le_scan_params	le_scan_params;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -1033,5 +1037,7 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
+int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ae86cdd..3d09f4b4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -735,6 +735,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
 
+	cancel_work_sync(&hdev->le_scan);
+
 	hci_req_cancel(hdev, ENODEV);
 	hci_req_lock(hdev);
 
@@ -1668,6 +1670,37 @@ static void le_scan_disable_work(struct work_struct *work)
 	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
+static void le_scan_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, le_scan);
+	struct le_scan_params *param = &hdev->le_scan_params;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_do_le_scan(hdev, param->type, param->interval,
+					param->window, param->timeout);
+}
+
+int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout)
+{
+	struct le_scan_params *param = &hdev->le_scan_params;
+
+	BT_DBG("%s", hdev->name);
+
+	if (work_busy(&hdev->le_scan))
+		return -EINPROGRESS;
+
+	param->type = type;
+	param->interval = interval;
+	param->window = window;
+	param->timeout = timeout;
+
+	queue_work(system_long_wq, &hdev->le_scan);
+
+	return 0;
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1754,6 +1787,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	atomic_set(&hdev->promisc, 0);
 
+	INIT_WORK(&hdev->le_scan, le_scan_work);
+
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 
 	write_unlock(&hci_dev_list_lock);
-- 
1.7.9

