Return-Path: <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org,
	john.stultz@linaro.org,
	Eyal Reizer <eyalr@ti.com>,
	Gigi Joseph <gigi.joseph@ti.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] bluetooth: hci_uart: add LL protocol serdev driver support
Date: Wed, 18 Jan 2017 12:05:00 -0600
Message-Id: <20170118180500.7791-3-robh@kernel.org>
In-Reply-To: <20170118180500.7791-1-robh@kernel.org>
References: <20170118180500.7791-1-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Turns out that the LL protocol and the TI-ST are the same thing AFAICT.
The TI-ST adds firmware loading, GPIO control, and shared access for
NFC, FM radio, etc. For now, we're only implementing what is needed for
BT. This mirrors other drivers like BCM and Intel, but uses the new
serdev bus.

The firmware loading is greatly simplified by using existing
infrastructure to send commands. It may be a bit slower than the
original code using synchronous functions, but the real bottleneck is
likely doing firmware load at 115.2kbps.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
---
 drivers/bluetooth/hci_ll.c | 248 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 02692fe30279..716c610fa54a 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -34,20 +34,23 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
+#include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
 #include <linux/poll.h>
 
 #include <linux/slab.h>
-#include <linux/tty.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/signal.h>
 #include <linux/ioctl.h>
+#include <linux/serdev.h>
 #include <linux/skbuff.h>
+#include <linux/ti_wilink_st.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <linux/gpio/consumer.h>
 
 #include "hci_uart.h"
 
@@ -76,6 +79,12 @@ struct hcill_cmd {
 	u8 cmd;
 } __packed;
 
+struct ll_device {
+	struct hci_uart hu;
+	struct serdev_device *serdev;
+	struct gpio_desc *nshutdown;
+};
+
 struct ll_struct {
 	unsigned long rx_state;
 	unsigned long rx_count;
@@ -164,6 +173,11 @@ static int ll_close(struct hci_uart *hu)
 
 	kfree_skb(ll->rx_skb);
 
+	if (hu->serdev) {
+		struct ll_device *lldev = serdev_device_get_drvdata(hu->serdev);
+		gpiod_set_value_cansleep(lldev->nshutdown, 1);
+	}
+
 	hu->priv = NULL;
 
 	kfree(ll);
@@ -171,6 +185,184 @@ static int ll_close(struct hci_uart *hu)
 	return 0;
 }
 
+static int read_local_version(struct hci_dev *hdev)
+{
+	int err = 0;
+	unsigned short version = 0;
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *ver;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading TI version information failed (%ld)",
+			   PTR_ERR(skb));
+		err = PTR_ERR(skb);
+		goto out;
+	}
+	if (skb->len != sizeof(*ver)) {
+		err = -EILSEQ;
+		goto out;
+	}
+
+	ver = (struct hci_rp_read_local_version *)skb->data;
+	if (le16_to_cpu(ver->manufacturer) != 13) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	version = le16_to_cpu(ver->lmp_subver);
+
+out:
+	if (err) bt_dev_err(hdev, "Failed to read TI version info: %d", err);
+	kfree_skb(skb);
+	return err ? err : version;
+}
+
+/**
+ * download_firmware -
+ *	internal function which parses through the .bts firmware
+ *	script file intreprets SEND, DELAY actions only as of now
+ */
+static int download_firmware(struct ll_device *lldev)
+{
+	unsigned short chip, min_ver, maj_ver;
+	int version, err, len;
+	unsigned char *ptr, *action_ptr;
+	unsigned char bts_scr_name[40];	/* 40 char long bts scr name? */
+	const struct firmware *fw;
+	struct sk_buff *skb;
+	struct hci_command *cmd;
+
+	version = read_local_version(lldev->hu.hdev);
+	if (version < 0)
+		return version;
+
+	chip = (version & 0x7C00) >> 10;
+	min_ver = (version & 0x007F);
+	maj_ver = (version & 0x0380) >> 7;
+	if (version & 0x8000)
+		maj_ver |= 0x0008;
+
+	snprintf(bts_scr_name, sizeof(bts_scr_name),
+		 "ti-connectivity/TIInit_%d.%d.%d.bts",
+		 chip, maj_ver, min_ver);
+
+	err = request_firmware(&fw, bts_scr_name, &lldev->serdev->dev);
+	if (err || !fw->data || !fw->size) {
+		pr_err(" request_firmware failed(errno %d) for %s", err,
+			   bts_scr_name);
+		return -EINVAL;
+	}
+	ptr = (void *)fw->data;
+	len = fw->size;
+	/* bts_header to remove out magic number and
+	 * version
+	 */
+	ptr += sizeof(struct bts_header);
+	len -= sizeof(struct bts_header);
+
+	while (len > 0 && ptr) {
+		pr_debug(" action size %d, type %d ",
+			   ((struct bts_action *)ptr)->size,
+			   ((struct bts_action *)ptr)->type);
+
+		action_ptr = &(((struct bts_action *)ptr)->data[0]);
+
+		switch (((struct bts_action *)ptr)->type) {
+		case ACTION_SEND_COMMAND:	/* action send */
+			pr_debug("S");
+			cmd = (struct hci_command *)action_ptr;
+			if (cmd->opcode == 0xff36) {
+				/* ignore remote change
+				 * baud rate HCI VS command */
+				pr_warn("change remote baud"
+				    " rate command in firmware");
+				break;
+			}
+			if (cmd->prefix != 1)
+				printk("command type %d\n", cmd->prefix);
+
+			skb = __hci_cmd_sync(lldev->hu.hdev, cmd->opcode, cmd->plen, &cmd->speed, HCI_INIT_TIMEOUT);
+			if (IS_ERR(skb)) {
+				printk("send command failed\n");
+				goto out_rel_fw;
+			}
+			kfree_skb(skb);
+			break;
+		case ACTION_WAIT_EVENT:  /* wait */
+			/* no need to wait as command was synchronous */
+			pr_debug("W");
+			break;
+		case ACTION_DELAY:	/* sleep */
+			pr_info("sleep command in scr");
+			mdelay(((struct bts_action_delay *)action_ptr)->msec);
+			break;
+		}
+		len -= (sizeof(struct bts_action) +
+			((struct bts_action *)ptr)->size);
+		ptr += sizeof(struct bts_action) +
+			((struct bts_action *)ptr)->size;
+	}
+
+out_rel_fw:
+	/* fw download complete */
+	release_firmware(fw);
+	return err;
+}
+
+static int ll_setup(struct hci_uart *hu)
+{
+	int err, retry = 3;
+	struct ll_device *lldev;
+	u32 speed;
+
+	if (!hu->serdev)
+		return 0;
+
+	lldev = serdev_device_get_drvdata(hu->serdev);
+
+	serdev_device_set_flow_control(hu->serdev, true);
+
+	do {
+		/* Configure BT nShutdown to HIGH state */
+		gpiod_set_value_cansleep(lldev->nshutdown, 1);
+		msleep(5);	/* FIXME: a proper toggle */
+		gpiod_set_value_cansleep(lldev->nshutdown, 0);
+		msleep(100);
+
+		err = download_firmware(lldev);
+		if (err != 0) {
+			/* ldisc installed but fw download failed,
+			 * flush uart & power cycle BT_EN */
+			pr_err("download firmware failed");
+			continue;
+		} else {	/* on success don't retry */
+			break;
+		}
+	} while (retry--);
+
+	if (err)
+		return err;
+
+	/* Operational speed if any */
+	if (hu->oper_speed)
+		speed = hu->oper_speed;
+	else if (hu->proto->oper_speed)
+		speed = hu->proto->oper_speed;
+	else
+		speed = 0;
+
+	if (speed) {
+		struct sk_buff *skb = __hci_cmd_sync(hu->hdev, 0xff36, sizeof(speed), &speed, HCI_INIT_TIMEOUT);
+		if (!IS_ERR(skb)) {
+			kfree_skb(skb);
+			serdev_device_set_baudrate(hu->serdev, speed);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * internal function, which does common work of the device wake up process:
  * 1. places all pending packets (waiting in tx_wait_q list) in txq list.
@@ -508,6 +700,7 @@ static struct sk_buff *ll_dequeue(struct hci_uart *hu)
 static const struct hci_uart_proto llp = {
 	.id		= HCI_UART_LL,
 	.name		= "LL",
+	.setup		= ll_setup,
 	.open		= ll_open,
 	.close		= ll_close,
 	.recv		= ll_recv,
@@ -525,3 +718,56 @@ int __exit ll_deinit(void)
 {
 	return hci_uart_unregister_proto(&llp);
 }
+
+static int hci_ti_probe(struct serdev_device *serdev)
+{
+	struct hci_uart *hu;
+	struct ll_device *lldev;
+	u32 max_speed = 3000000;
+
+	lldev = devm_kzalloc(&serdev->dev, sizeof(struct ll_device), GFP_KERNEL);
+	if (!lldev)
+		return -ENOMEM;
+	hu = &lldev->hu;
+
+	serdev_device_set_drvdata(serdev, lldev);
+	lldev->serdev = hu->serdev = serdev;
+
+	lldev->nshutdown = devm_gpiod_get(&serdev->dev, "shutdown", GPIOD_OUT_HIGH);
+	if (IS_ERR(lldev->nshutdown))
+		return PTR_ERR(lldev->nshutdown);
+
+	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
+	hci_uart_set_speeds(hu, 115200, max_speed);
+
+	return hci_uart_register_device(hu, &llp);
+}
+
+static void hci_ti_remove(struct serdev_device *serdev)
+{
+	struct ll_device *lldev = serdev_device_get_drvdata(serdev);
+	struct hci_uart *hu = &lldev->hu;
+	struct hci_dev *hdev = hu->hdev;
+
+	cancel_work_sync(&hu->write_work);
+
+	hci_unregister_dev(hdev);
+	hci_free_dev(hdev);
+	hu->proto->close(hu);
+}
+
+static const struct of_device_id hci_ti_of_match[] = {
+	{ .compatible = "ti,wl1835-st" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hci_ti_of_match);
+
+static struct serdev_device_driver hci_ti_drv = {
+	.driver		= {
+		.name	= "hci-ti",
+		.of_match_table = of_match_ptr(hci_ti_of_match),
+	},
+	.probe	= hci_ti_probe,
+	.remove	= hci_ti_remove,
+};
+module_serdev_device_driver(hci_ti_drv);
-- 
2.10.1
