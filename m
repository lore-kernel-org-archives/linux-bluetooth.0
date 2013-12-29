Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for vectored writes to virtual HCI driver
Date: Sat, 28 Dec 2013 21:57:14 -0800
Message-Id: <1388296634-46026-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth virtual HCI driver is using a misc character device to
allow emulation of HCI devices from userspace. This change enables the
support for vectored writes. Previously this was failing with EINVAL
since no complete H:4 packet was written.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_vhci.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 7b167385a1c4..1ef6990a5c7e 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -141,22 +141,28 @@ static int vhci_create_device(struct vhci_data *data, __u8 dev_type)
 }
 
 static inline ssize_t vhci_get_user(struct vhci_data *data,
-				    const char __user *buf, size_t count)
+				    const struct iovec *iov,
+				    unsigned long count)
 {
+	size_t len = iov_length(iov, count);
 	struct sk_buff *skb;
 	__u8 pkt_type, dev_type;
+	unsigned long i;
 	int ret;
 
-	if (count < 2 || count > HCI_MAX_FRAME_SIZE)
+	if (len < 2 || len > HCI_MAX_FRAME_SIZE)
 		return -EINVAL;
 
-	skb = bt_skb_alloc(count, GFP_KERNEL);
+	skb = bt_skb_alloc(len, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-	if (copy_from_user(skb_put(skb, count), buf, count)) {
-		kfree_skb(skb);
-		return -EFAULT;
+	for (i = 0; i < count; i++) {
+		if (copy_from_user(skb_put(skb, iov[i].iov_len),
+				   iov[i].iov_base, iov[i].iov_len)) {
+			kfree_skb(skb);
+			return -EFAULT;
+		}
 	}
 
 	pkt_type = *((__u8 *) skb->data);
@@ -205,7 +211,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 		return -EINVAL;
 	}
 
-	return (ret < 0) ? ret : count;
+	return (ret < 0) ? ret : len;
 }
 
 static inline ssize_t vhci_put_user(struct vhci_data *data,
@@ -272,12 +278,13 @@ static ssize_t vhci_read(struct file *file,
 	return ret;
 }
 
-static ssize_t vhci_write(struct file *file,
-			  const char __user *buf, size_t count, loff_t *pos)
+static ssize_t vhci_write(struct kiocb *iocb, const struct iovec *iov,
+			  unsigned long count, loff_t pos)
 {
+	struct file *file = iocb->ki_filp;
 	struct vhci_data *data = file->private_data;
 
-	return vhci_get_user(data, buf, count);
+	return vhci_get_user(data, iov, count);
 }
 
 static unsigned int vhci_poll(struct file *file, poll_table *wait)
@@ -342,7 +349,7 @@ static int vhci_release(struct inode *inode, struct file *file)
 static const struct file_operations vhci_fops = {
 	.owner		= THIS_MODULE,
 	.read		= vhci_read,
-	.write		= vhci_write,
+	.aio_write	= vhci_write,
 	.poll		= vhci_poll,
 	.open		= vhci_open,
 	.release	= vhci_release,
-- 
1.8.4.2

