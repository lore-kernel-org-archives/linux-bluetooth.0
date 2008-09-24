Return-Path: <cyrus@holtmann.org>
Message-ID: <48DA1762.7050206@nokia.com>
Date: Wed, 24 Sep 2008 13:33:06 +0300
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] DUT mode support for kernel
Content-Type: multipart/mixed;
 boundary="------------050306040307020706050708"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050306040307020706050708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In good old days the only action needed to enable DUT mode was "hcitool 
cmd 0x06 0x0003" or similar. However now after having full connection 
tracking also for incoming connection this doesn't work anymore.

At least R&S tester does only ACL link to the device and therefore BlueZ 
disconnects it after 10 secs. Connection tracking needs to be disabled 
somehow. I prepared one proposal how to deal with it. The disable DUT 
mode command is missing because the Spec says the DUT mode is disabled 
by resetting the chip. Thus it can be done with "hciconfig hci0 reset" 
command.

With this patch against bluetooth-2.6 tree the DUT mode is enabled by 
echoing "enabled\n" to new sysfs entry. Maybe some other interface 
should be used instead?

Any comments?

-- 
Ville


--------------050306040307020706050708
Content-Type: text/x-patch;
 name="0001--BLUETOOTH-DUT-mode-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001--BLUETOOTH-DUT-mode-support.patch"

>From 2b50cc6a4cb4715ae3a83a41c4c3d2d76c66fdd7 Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Wed, 24 Sep 2008 13:25:43 +0300
Subject: [PATCH] [BLUETOOTH] DUT mode support

Bluetooth specification has command to enable special mode in bluetooth
chip called Device Under Test (DUT) mode. It is used to measure
for example RF performance of the Bluetooth hardware design. This patch
adds kernel support for DUT mode.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3cc2949..1279788 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -72,6 +72,8 @@ enum {
 	HCI_INQUIRY,
 
 	HCI_RAW,
+
+	HCI_DUT_MODE,
 };
 
 /* HCI ioctl defines */
@@ -577,6 +579,11 @@ struct hci_rp_read_bd_addr {
 	bdaddr_t bdaddr;
 } __attribute__ ((packed));
 
+#define HCI_OP_ENABLE_DUT_MODE		0x1803
+struct hci_rp_enable_dut_mode {
+	__u8	status;
+} __attribute__ ((packed));
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 46a43b7..019cd93 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -355,6 +355,9 @@ static inline void hci_conn_put(struct hci_conn *conn)
 				timeo = msecs_to_jiffies(10);
 		} else
 			timeo = msecs_to_jiffies(10);
+
+		if (test_bit(HCI_DUT_MODE, &conn->hdev->flags) && !conn->out)
+			return;
 		mod_timer(&conn->disc_timer, jiffies + timeo);
 	}
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ad7a553..6d024df 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -535,6 +535,16 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, rp->status);
 }
 
+static void hci_cc_enable_dut_mode(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_enable_dut_mode *rp = (void *) skb->data;
+
+	if (!rp->status)
+		set_bit(HCI_DUT_MODE, &hdev->flags);
+
+	hci_req_complete(hdev, rp->status);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1294,6 +1304,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_ENABLE_DUT_MODE:
+		hci_cc_enable_dut_mode(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index f4f6615..05c5b61 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -356,6 +356,27 @@ static ssize_t store_sniff_min_interval(struct device *dev, struct device_attrib
 	return count;
 }
 
+static ssize_t show_dut_mode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hci_dev *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", test_bit(HCI_DUT_MODE, &hdev->flags) ? "enabled" : "disabled");
+}
+
+static ssize_t store_dut_mode(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct hci_dev *hdev = dev_get_drvdata(dev);
+	int err;
+
+	if (!test_bit(HCI_DUT_MODE, &hdev->flags) && !strncmp(buf, "enabled\n", count)) {
+		err = hci_send_cmd(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL);
+		if (err < 0)
+			return err;
+	}
+
+	return count;
+}
+
 static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static DEVICE_ATTR(class, S_IRUGO, show_class, NULL);
@@ -372,6 +393,7 @@ static DEVICE_ATTR(sniff_max_interval, S_IRUGO | S_IWUSR,
 				show_sniff_max_interval, store_sniff_max_interval);
 static DEVICE_ATTR(sniff_min_interval, S_IRUGO | S_IWUSR,
 				show_sniff_min_interval, store_sniff_min_interval);
+static DEVICE_ATTR(dut_mode, S_IRUGO | S_IWUSR, show_dut_mode, store_dut_mode);
 
 static struct attribute *bt_host_attrs[] = {
 	&dev_attr_type.attr,
@@ -386,6 +408,7 @@ static struct attribute *bt_host_attrs[] = {
 	&dev_attr_idle_timeout.attr,
 	&dev_attr_sniff_max_interval.attr,
 	&dev_attr_sniff_min_interval.attr,
+	&dev_attr_dut_mode.attr,
 	NULL
 };
 
-- 
1.5.6.3


--------------050306040307020706050708--
