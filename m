Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support creating virtual AMP controllers
Date: Mon,  2 Sep 2013 10:41:39 -0700
Message-Id: <1378143699-51039-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So far the only option to create a virtual AMP controller was by
setting a module parameter for the hci_vhci driver. This patch adds
the functionality to define inline to create either a BR/EDR or an
AMP controller.

In addition the client will be informed which HCI controller index
it got assigned. That is especially useful for automated end-to-end
testing.

To keep backwards compatibility with existing userspace, the command
for creating a controller type needs to be send right after opening
the device node. If the command is not send, it defaults back to
automatically creating a BR/EDR controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_vhci.c | 169 +++++++++++++++++++++++++++++++------------
 1 file changed, 123 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index a1ea5b1..c04a3e6 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/module.h>
+#include <asm/unaligned.h>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -39,17 +40,17 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#define VERSION "1.3"
+#define VERSION "1.4"
 
 static bool amp;
 
 struct vhci_data {
 	struct hci_dev *hdev;
 
-	unsigned long flags;
-
 	wait_queue_head_t read_wait;
 	struct sk_buff_head readq;
+
+	struct delayed_work open_timeout;
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -99,16 +100,62 @@ static int vhci_send_frame(struct sk_buff *skb)
 	skb_queue_tail(&data->readq, skb);
 
 	wake_up_interruptible(&data->read_wait);
+	return 0;
+}
+
+static int vhci_create_device(struct vhci_data *data, __u8 dev_type)
+{
+	struct hci_dev *hdev;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(4, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		kfree_skb(skb);
+		return -ENOMEM;
+	}
+
+	data->hdev = hdev;
+
+	hdev->bus = HCI_VIRTUAL;
+	hdev->dev_type = dev_type;
+	hci_set_drvdata(hdev, data);
+
+	hdev->open  = vhci_open_dev;
+	hdev->close = vhci_close_dev;
+	hdev->flush = vhci_flush;
+	hdev->send  = vhci_send_frame;
 
+	if (hci_register_dev(hdev) < 0) {
+		BT_ERR("Can't register HCI device");
+		hci_free_dev(hdev);
+		data->hdev = NULL;
+		kfree_skb(skb);
+		return -EBUSY;
+	}
+
+	bt_cb(skb)->pkt_type = HCI_VENDOR_PKT;
+
+	*skb_put(skb, 1) = 0xff;
+	*skb_put(skb, 1) = dev_type;
+	put_unaligned_le16(hdev->id, skb_put(skb, 2));
+	skb_queue_tail(&data->readq, skb);
+
+	wake_up_interruptible(&data->read_wait);
 	return 0;
 }
 
 static inline ssize_t vhci_get_user(struct vhci_data *data,
-					const char __user *buf, size_t count)
+				    const char __user *buf, size_t count)
 {
 	struct sk_buff *skb;
+	__u8 pkt_type, dev_type;
+	int ret;
 
-	if (count > HCI_MAX_FRAME_SIZE)
+	if (count < 2 || count > HCI_MAX_FRAME_SIZE)
 		return -EINVAL;
 
 	skb = bt_skb_alloc(count, GFP_KERNEL);
@@ -120,27 +167,70 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		return -EFAULT;
 	}
 
-	skb->dev = (void *) data->hdev;
-	bt_cb(skb)->pkt_type = *((__u8 *) skb->data);
+	pkt_type = *((__u8 *) skb->data);
 	skb_pull(skb, 1);
 
-	hci_recv_frame(skb);
+	switch (pkt_type) {
+	case HCI_EVENT_PKT:
+	case HCI_ACLDATA_PKT:
+	case HCI_SCODATA_PKT:
+		if (!data->hdev) {
+			kfree_skb(skb);
+			return -ENODEV;
+		}
+
+		skb->dev = (void *) data->hdev;
+		bt_cb(skb)->pkt_type = pkt_type;
+
+		ret = hci_recv_frame(skb);
+		break;
+
+	case HCI_VENDOR_PKT:
+		if (data->hdev) {
+			kfree_skb(skb);
+			return -EBADFD;
+		}
 
-	return count;
+		cancel_delayed_work_sync(&data->open_timeout);
+
+		dev_type = *((__u8 *) skb->data);
+		skb_pull(skb, 1);
+
+		if (skb->len > 0) {
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+
+		kfree_skb(skb);
+
+		if (dev_type != HCI_BREDR && dev_type != HCI_AMP)
+			return -EINVAL;
+
+		ret = vhci_create_device(data, dev_type);
+		break;
+
+	default:
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return (ret < 0) ? ret : count;
 }
 
 static inline ssize_t vhci_put_user(struct vhci_data *data,
-			struct sk_buff *skb, char __user *buf, int count)
+				    struct sk_buff *skb,
+				    char __user *buf, int count)
 {
 	char __user *ptr = buf;
-	int len, total = 0;
+	int len;
 
 	len = min_t(unsigned int, skb->len, count);
 
 	if (copy_to_user(ptr, skb->data, len))
 		return -EFAULT;
 
-	total += len;
+	if (!data->hdev)
+		return len;
 
 	data->hdev->stat.byte_tx += len;
 
@@ -148,21 +238,19 @@ static inline ssize_t vhci_put_user(struct vhci_data *data,
 	case HCI_COMMAND_PKT:
 		data->hdev->stat.cmd_tx++;
 		break;
-
 	case HCI_ACLDATA_PKT:
 		data->hdev->stat.acl_tx++;
 		break;
-
 	case HCI_SCODATA_PKT:
 		data->hdev->stat.sco_tx++;
 		break;
 	}
 
-	return total;
+	return len;
 }
 
 static ssize_t vhci_read(struct file *file,
-				char __user *buf, size_t count, loff_t *pos)
+			 char __user *buf, size_t count, loff_t *pos)
 {
 	struct vhci_data *data = file->private_data;
 	struct sk_buff *skb;
@@ -185,7 +273,7 @@ static ssize_t vhci_read(struct file *file,
 		}
 
 		ret = wait_event_interruptible(data->read_wait,
-					!skb_queue_empty(&data->readq));
+					       !skb_queue_empty(&data->readq));
 		if (ret < 0)
 			break;
 	}
@@ -194,7 +282,7 @@ static ssize_t vhci_read(struct file *file,
 }
 
 static ssize_t vhci_write(struct file *file,
-			const char __user *buf, size_t count, loff_t *pos)
+			  const char __user *buf, size_t count, loff_t *pos)
 {
 	struct vhci_data *data = file->private_data;
 
@@ -213,10 +301,17 @@ static unsigned int vhci_poll(struct file *file, poll_table *wait)
 	return POLLOUT | POLLWRNORM;
 }
 
+static void vhci_open_timeout(struct work_struct *work)
+{
+	struct vhci_data *data = container_of(work, struct vhci_data,
+					      open_timeout.work);
+
+	vhci_create_device(data, amp ? HCI_AMP : HCI_BREDR);
+}
+
 static int vhci_open(struct inode *inode, struct file *file)
 {
 	struct vhci_data *data;
-	struct hci_dev *hdev;
 
 	data = kzalloc(sizeof(struct vhci_data), GFP_KERNEL);
 	if (!data)
@@ -225,35 +320,13 @@ static int vhci_open(struct inode *inode, struct file *file)
 	skb_queue_head_init(&data->readq);
 	init_waitqueue_head(&data->read_wait);
 
-	hdev = hci_alloc_dev();
-	if (!hdev) {
-		kfree(data);
-		return -ENOMEM;
-	}
-
-	data->hdev = hdev;
-
-	hdev->bus = HCI_VIRTUAL;
-	hci_set_drvdata(hdev, data);
-
-	if (amp)
-		hdev->dev_type = HCI_AMP;
-
-	hdev->open     = vhci_open_dev;
-	hdev->close    = vhci_close_dev;
-	hdev->flush    = vhci_flush;
-	hdev->send     = vhci_send_frame;
-
-	if (hci_register_dev(hdev) < 0) {
-		BT_ERR("Can't register HCI device");
-		kfree(data);
-		hci_free_dev(hdev);
-		return -EBUSY;
-	}
+	INIT_DELAYED_WORK(&data->open_timeout, vhci_open_timeout);
 
 	file->private_data = data;
 	nonseekable_open(inode, file);
 
+	schedule_delayed_work(&data->open_timeout, msecs_to_jiffies(1000));
+
 	return 0;
 }
 
@@ -262,8 +335,12 @@ static int vhci_release(struct inode *inode, struct file *file)
 	struct vhci_data *data = file->private_data;
 	struct hci_dev *hdev = data->hdev;
 
-	hci_unregister_dev(hdev);
-	hci_free_dev(hdev);
+	cancel_delayed_work_sync(&data->open_timeout);
+
+	if (hdev) {
+		hci_unregister_dev(hdev);
+		hci_free_dev(hdev);
+	}
 
 	file->private_data = NULL;
 	kfree(data);
-- 
1.8.3.1

