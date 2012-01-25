Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: [PATCH v3 4/6] Bluetooth: Add hci_le_scan()
Date: Wed, 25 Jan 2012 19:52:27 -0300
Message-Id: <1327531949-29463-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
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
---
 include/net/bluetooth/hci_core.h |   12 ++++++++++++
 net/bluetooth/hci_core.c         |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d157762..8da5eac 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -126,6 +126,13 @@ struct adv_entry {
 	u8 bdaddr_type;
 };
 
+struct le_scan_params {
+	u8 type;
+	u16 interval;
+	u16 window;
+	int timeout;
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -268,6 +275,9 @@ struct hci_dev {
 	wait_queue_head_t	le_scan_wait_q;
 	u8			le_scan_result;
 
+	struct work_struct	le_scan;
+	struct le_scan_params	le_scan_params;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -1027,5 +1037,7 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
+int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 22abc37..d77e586 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -779,6 +779,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->service_cache);
 
+	cancel_work_sync(&hdev->le_scan);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 
 	hci_dev_lock(hdev);
@@ -1646,6 +1647,37 @@ static void le_scan_disable_work(struct work_struct *work)
 	send_le_scan_enable_cmd(hdev, 0);
 }
 
+static void le_scan_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, le_scan);
+	struct le_scan_params *params = &hdev->le_scan_params;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_do_le_scan(hdev, params->type, params->interval,
+					params->window, params->timeout);
+}
+
+int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
+								int timeout)
+{
+	struct le_scan_params *params = &hdev->le_scan_params;
+
+	BT_DBG("%s", hdev->name);
+
+	if (work_busy(&hdev->le_scan))
+		return -EINPROGRESS;
+
+	params->type = type;
+	params->interval = interval;
+	params->window = window;
+	params->timeout = timeout;
+
+	queue_work(system_long_wq, &hdev->le_scan);
+
+	return 0;
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1731,6 +1763,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	atomic_set(&hdev->promisc, 0);
 
+	INIT_WORK(&hdev->le_scan, le_scan_work);
+
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 
 	init_waitqueue_head(&hdev->le_scan_wait_q);
-- 
1.7.8.4
