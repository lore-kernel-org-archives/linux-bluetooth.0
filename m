Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84C384CD6
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611980; cv=none; b=tAPpfH47igVCnnUT90wNAlBMxckD4onnXgLElZT7VXmpmgx7CVdXV5hYN1gBnOT7sm97GIHtYD4BRRbkdj+WRh/vun/NqE6I0K97a1xBXUWz8iMhYF6FFx1VUO0o8JaWjP5LTKNrIsHzyBghBnLZ+NSE5UQUUYxFHJ4x473B1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611980; c=relaxed/simple;
	bh=egsRZwbXaHhh3VGqxvbdQR/MztXU8jMt8/yAZO1ljHk=;
	h=To:In-Reply-To:Cc:Subject:Date:Content-Type:Mime-Version:
	 References:From:Message-Id; b=Td9RuLRDN+AOfbeUUSQBEJGMVFlu7ZEoV6yc/Ha/LkYl1OPNvp+xh49W2csMc7ggUvy3WA9F5it7Tk3F5muYNe3Rk3el0EtQ5EEk72y7srkwkENzXZS8IldX8dIpGG6s6OBdAqKb/WK6ofr6GTZ5wGSqCqiPSlM7/NRYx627F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=v0xOLzSs; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="v0xOLzSs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789611967;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=b3heL+YTOmXz36HamfaqQAdf1/JV88/4DMgOgSQVP0Y=;
 b=v0xOLzSswY5u5TcPOWm2InD2NH2We5Mnvdg9GYQWtH2N2SiixtRuAVUkEfI0Mo3oaongGL
 5x68qgjSjLeT0xtaFp2eai5c6OQdoHFXKdVoMwm8exmJk7WWqqqA+WbYQQOCNYHR+ws6oN
 DrQhtFzsZ2ngW4mn5lpqSq+d/A0ScwlXrPAd0m1AWg3japOjauxWKlFTs1StwWSgLdRKgU
 xu7WAQhf4P8ncOi+HrrMS+OfOra/xwokgbJXuohkp/HRz5dp28R3Lv7K5NFBsEkPOagRvu
 32LHvsrOC69PlINpIHhw9VVMB7kiscaT9527ro9MTkQUue2FETrO3ZOtSL1Rwg==
To: <linux-bluetooth@vger.kernel.org>
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
In-Reply-To: <178954773705.2.3446471521233620446@bedmex.com>
Cc: <marcel@holtmann.org>, <luiz.dentz@gmail.com>, 
	<devicetree@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>, 
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<zhirunliu@aicsemi.com>, <dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, 
	<liheng.wei@bedmex.com>, <yanli.yang@bedmex.com>
Subject: [RFC PATCH bluetooth-next 3/3] Bluetooth: btaic: Add AIC8800D80 SDIO loader and UART transport
Date: Wed, 16 Sep 2026 16:35:40 +0800
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aab4fbd+a5a684+vger.kernel.org+yanli.yang@bedmex.com>
Received: from [127.0.1.1] ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Thu, 17 Sep 2026 10:26:03 +0800
References: <178954773705.2.3446471521233620446@bedmex.com>
Content-Transfer-Encoding: 7bit
From: "Yanli Yang" <yanli.yang@bedmex.com>
Message-Id: <178954773705.2.3606741563381453586@bedmex.com>

Add a driver for the AIC8800D80 combination chip, using SDIO function 1
for Bluetooth firmware loading and a serdev UART for H4 HCI traffic.

Load the ADID image, patch image and patch table through
request_firmware(), validate the patch-table layout, and transfer firmware
using the vendor SDIO command protocol. Recognize the U02 and U03 chip
revisions.

Coordinate the SDIO firmware provider and UART consumer through a
reference-counted boot state and a device link. Wait for firmware readiness
before opening the UART, and use hardware flow control at 1500000 baud.

Add CONFIG_BT_AIC, build integration and a MAINTAINERS entry.

The vendor has confirmed SDIO firmware loading only. UART HCI operation
and other Bluetooth functionality have not yet been validated. Submit
this implementation as RFC for review before further functional testing.

Signed-off-by: Zhirun Liu <zhirunliu@aicsemi.com>
Signed-off-by: Dijia Xu <dijiaxu@aicsemi.com>
Signed-off-by: Chunqiu Liu <chunqiuliu@aicsemi.com>
Signed-off-by: Liheng Wei <liheng.wei@bedmex.com>
Signed-off-by: Yanli Yang <yanli.yang@bedmex.com>
---
 MAINTAINERS                    |  11 +
 drivers/bluetooth/Kconfig      |  16 +
 drivers/bluetooth/Makefile     |   3 +
 drivers/bluetooth/btaic.h      |  26 +
 drivers/bluetooth/btaic_core.c | 180 +++++++
 drivers/bluetooth/btaic_sdio.c | 886 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btaic_uart.c | 331 ++++++++++++
 7 files changed, 1453 insertions(+)
 create mode 100644 drivers/bluetooth/btaic.h
 create mode 100644 drivers/bluetooth/btaic_core.c
 create mode 100644 drivers/bluetooth/btaic_sdio.c
 create mode 100644 drivers/bluetooth/btaic_uart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 891c064a881b..83b618662d86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -730,6 +730,17 @@ S:	Maintained
 F:	drivers/scsi/aha152x*
 F:	drivers/scsi/pcmcia/aha152x*
 
+AIC BLUETOOTH DRIVER
+M:	Zhirun Liu <zhirunliu@aicsemi.com>
+M:	Dijia Xu <dijiaxu@aicsemi.com>
+M:	Chunqiu Liu <chunqiuliu@aicsemi.com>
+M:	Liheng Wei <liheng.wei@bedmex.com>
+M:	Yanli Yang <yanli.yang@bedmex.com>
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
+F:	drivers/bluetooth/btaic*
+
 AIC7XXX / AIC79XX SCSI DRIVER
 M:	Hannes Reinecke <hare@suse.com>
 L:	linux-scsi@vger.kernel.org
diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4e8c24d757e9..c8f66742f98b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -472,4 +472,20 @@ config BT_INTEL_PCIE
 
 	  Say Y here to compiler support for Intel Bluetooth PCIe device into
 	  the kernel or say M to compile it as module (btintel_pcie)
+
+config BT_AIC
+	tristate "AIC8800D80 Bluetooth support"
+	depends on MMC
+	depends on SERIAL_DEV_BUS
+	depends on BT_HCIUART
+	select BT_HCIUART_H4
+	select FW_LOADER
+	help
+	  Bluetooth support for the AIC8800D80 combination chip, using an
+	  SDIO function for firmware loading and a UART interface for the
+	  HCI transport.
+
+	  Say Y here to compile support into the kernel or M to build it as
+	  a module named btaic.
+
 endmenu
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index e6b1c1180d1d..d9569d6563f1 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_MTKSDIO)	+= btmtksdio.o
 obj-$(CONFIG_BT_MTKUART)	+= btmtkuart.o
+obj-$(CONFIG_BT_AIC)		+= btaic.o
 obj-$(CONFIG_BT_QCOMSMD)	+= btqcomsmd.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
 obj-$(CONFIG_BT_RTL)		+= btrtl.o
@@ -51,4 +52,6 @@ hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
 hci_uart-$(CONFIG_BT_HCIUART_AML)	+= hci_aml.o
 hci_uart-objs				:= $(hci_uart-y)
 
+btaic-y				:= btaic_core.o btaic_sdio.o btaic_uart.o
+
 CONTEXT_ANALYSIS := y
diff --git a/drivers/bluetooth/btaic.h b/drivers/bluetooth/btaic.h
new file mode 100644
index 000000000000..dc631b495697
--- /dev/null
+++ b/drivers/bluetooth/btaic.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __BTAIC_H
+#define __BTAIC_H
+
+#include <linux/types.h>
+
+struct device;
+struct fwnode_handle;
+
+struct aic_bt_boot;
+
+struct aic_bt_boot *aic_bt_boot_register(struct device *dev);
+void aic_bt_boot_ready(struct aic_bt_boot *boot, int status);
+void aic_bt_boot_unregister(struct aic_bt_boot *boot);
+
+struct aic_bt_boot *aic_bt_boot_get(const struct fwnode_handle *fwnode);
+void aic_bt_boot_put(struct aic_bt_boot *boot);
+int aic_bt_boot_wait(struct aic_bt_boot *boot, unsigned long timeout);
+struct device *aic_bt_boot_device(struct aic_bt_boot *boot);
+
+int aic_bt_sdio_register(void);
+void aic_bt_sdio_unregister(void);
+int aic_bt_uart_register(void);
+void aic_bt_uart_unregister(void);
+
+#endif
diff --git a/drivers/bluetooth/btaic_core.c b/drivers/bluetooth/btaic_core.c
new file mode 100644
index 000000000000..35644b9b1209
--- /dev/null
+++ b/drivers/bluetooth/btaic_core.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ ******************************************************************************
+ *
+ * Copyright (C) 2020 AIC semiconductor.
+ *
+ * @brief AIC8800D80 Bluetooth driver core
+ *
+ ******************************************************************************
+ */
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include "btaic.h"
+
+struct aic_bt_boot {
+	struct kref ref;
+	struct list_head node;
+	struct completion ready;
+	struct device *dev;
+	int status;
+	bool present;
+};
+
+static DEFINE_MUTEX(aic_bt_boot_lock);
+static LIST_HEAD(aic_bt_boot_list);
+
+static void aic_bt_boot_release(struct kref *ref)
+{
+	struct aic_bt_boot *boot = container_of(ref, struct aic_bt_boot, ref);
+
+	put_device(boot->dev);
+	kfree(boot);
+}
+
+struct aic_bt_boot *aic_bt_boot_register(struct device *dev)
+{
+	struct aic_bt_boot *boot;
+
+	boot = kzalloc_obj(*boot);
+	if (!boot)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&boot->ref);
+	INIT_LIST_HEAD(&boot->node);
+	init_completion(&boot->ready);
+	boot->dev = get_device(dev);
+	boot->status = -EINPROGRESS;
+	boot->present = true;
+
+	mutex_lock(&aic_bt_boot_lock);
+	list_add_tail(&boot->node, &aic_bt_boot_list);
+	mutex_unlock(&aic_bt_boot_lock);
+
+	return boot;
+}
+
+void aic_bt_boot_ready(struct aic_bt_boot *boot, int status)
+{
+	mutex_lock(&aic_bt_boot_lock);
+	if (boot->present)
+		boot->status = status;
+	mutex_unlock(&aic_bt_boot_lock);
+
+	complete_all(&boot->ready);
+}
+
+void aic_bt_boot_unregister(struct aic_bt_boot *boot)
+{
+	if (!boot)
+		return;
+
+	mutex_lock(&aic_bt_boot_lock);
+	if (boot->present) {
+		list_del_init(&boot->node);
+		boot->present = false;
+		boot->status = -ENODEV;
+	}
+	mutex_unlock(&aic_bt_boot_lock);
+
+	complete_all(&boot->ready);
+	kref_put(&boot->ref, aic_bt_boot_release);
+}
+
+struct aic_bt_boot *aic_bt_boot_get(const struct fwnode_handle *fwnode)
+{
+	struct aic_bt_boot *boot;
+	struct aic_bt_boot *found = NULL;
+	unsigned int count = 0;
+
+	mutex_lock(&aic_bt_boot_lock);
+	list_for_each_entry(boot, &aic_bt_boot_list, node) {
+		if (!boot->present)
+			continue;
+
+		if (fwnode) {
+			if (dev_fwnode(boot->dev) == fwnode) {
+				found = boot;
+				break;
+			}
+			continue;
+		}
+
+		found = boot;
+		count++;
+	}
+
+	if (found && (fwnode || count == 1))
+		kref_get(&found->ref);
+	else if (count > 1)
+		found = ERR_PTR(-EINVAL);
+	else
+		found = ERR_PTR(-EPROBE_DEFER);
+	mutex_unlock(&aic_bt_boot_lock);
+
+	return found;
+}
+
+void aic_bt_boot_put(struct aic_bt_boot *boot)
+{
+	if (!IS_ERR_OR_NULL(boot))
+		kref_put(&boot->ref, aic_bt_boot_release);
+}
+
+int aic_bt_boot_wait(struct aic_bt_boot *boot, unsigned long timeout)
+{
+	int status;
+
+	if (!wait_for_completion_timeout(&boot->ready, timeout))
+		return -ETIMEDOUT;
+
+	mutex_lock(&aic_bt_boot_lock);
+	status = boot->present ? boot->status : -ENODEV;
+	mutex_unlock(&aic_bt_boot_lock);
+
+	return status;
+}
+
+struct device *aic_bt_boot_device(struct aic_bt_boot *boot)
+{
+	return boot->dev;
+}
+
+static int __init aic_bt_init(void)
+{
+	int err;
+
+	err = aic_bt_sdio_register();
+	if (err)
+		return err;
+
+	err = aic_bt_uart_register();
+	if (err) {
+		aic_bt_sdio_unregister();
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit aic_bt_exit(void)
+{
+	aic_bt_uart_unregister();
+	aic_bt_sdio_unregister();
+}
+
+module_init(aic_bt_init);
+module_exit(aic_bt_exit);
+
+MODULE_AUTHOR("AIC Semiconductor");
+MODULE_DESCRIPTION("AIC8800D80 Bluetooth driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btaic_sdio.c b/drivers/bluetooth/btaic_sdio.c
new file mode 100644
index 000000000000..87b6b1c03a6e
--- /dev/null
+++ b/drivers/bluetooth/btaic_sdio.c
@@ -0,0 +1,886 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ ******************************************************************************
+ *
+ * Copyright (C) 2020 AIC semiconductor.
+ *
+ * @brief AIC8800D80 Bluetooth SDIO firmware loader
+ *
+ ******************************************************************************
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/minmax.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#include "btaic.h"
+
+#define AIC_SDIO_VENDOR_ID			0xc8a1
+#define AIC_SDIO_DEVICE_ID_8800D80		0x0082
+
+#define AIC_SDIO_BLOCK_SIZE			512
+#define AIC_SDIO_BUFFER_SIZE			1536
+#define AIC_SDIO_TX_BUFFER_SIZE			1536
+#define AIC_SDIO_RX_MAX_SIZE			(127 * AIC_SDIO_BLOCK_SIZE)
+
+#define AIC_SDIO_INTR_ENABLE			0x00
+#define AIC_SDIO_INTR_PENDING			0x01
+#define AIC_SDIO_FLOW_CTRL_Q1			0x03
+#define AIC_SDIO_MISC_INT_STATUS		0x04
+#define AIC_SDIO_BYTEMODE_LEN			0x05
+#define AIC_SDIO_BYTEMODE_ENABLE		0x07
+#define AIC_SDIO_RD_FIFO			0x0f
+#define AIC_SDIO_WR_FIFO			0x10
+
+#define AIC_SDIO_OTHER_INTERRUPT		BIT(7)
+#define AIC_SDIO_BYTE_MODE_BLOCKS		120
+#define AIC_SDIO_FLOW_RETRIES			50
+#define AIC_SDIO_FRAME_TAIL_LEN			4
+
+#define AIC_CMD_TIMEOUT_MS			6000
+#define AIC_CMD_TYPE				0x11
+#define AIC_TASK_DBG				1
+#define AIC_DRIVER_TASK				100
+#define AIC_FIRST_MSG(task)			((u16)(task) << 10)
+
+#define AIC_DBG_MEM_READ_REQ			(AIC_FIRST_MSG(AIC_TASK_DBG) + 0)
+#define AIC_DBG_MEM_READ_CFM			(AIC_FIRST_MSG(AIC_TASK_DBG) + 1)
+#define AIC_DBG_MEM_WRITE_REQ			(AIC_FIRST_MSG(AIC_TASK_DBG) + 2)
+#define AIC_DBG_MEM_WRITE_CFM			(AIC_FIRST_MSG(AIC_TASK_DBG) + 3)
+#define AIC_DBG_MEM_BLOCK_WRITE_REQ		(AIC_FIRST_MSG(AIC_TASK_DBG) + 11)
+#define AIC_DBG_MEM_BLOCK_WRITE_CFM		(AIC_FIRST_MSG(AIC_TASK_DBG) + 12)
+
+#define AIC_BT_CHIP_ID_ADDR			0x40500000
+#define AIC_BT_CHIP_REV_U02			3
+#define AIC_BT_CHIP_REV_U03			7
+
+#define AIC_BT_FW_ADID				"aic/aic8800d80/fw_adid_8800d80_u02.bin"
+#define AIC_BT_FW_PATCH				"aic/aic8800d80/fw_patch_8800d80_u02.bin"
+#define AIC_BT_FW_TABLE				"aic/aic8800d80/fw_patch_table_8800d80_u02.bin"
+
+#define AIC_BT_PATCH_TAG			"AICBT_PT_TAG"
+#define AIC_BT_PATCH_TAG_SIZE			16
+#define AIC_BT_PATCH_RECORD_HEADER_SIZE		24
+#define AIC_BT_PATCH_PAIR_SIZE			8
+#define AIC_BT_PATCH_BLOCK_SIZE			1024
+
+#define AIC_BT_MODE_ONLY_COANT			5
+#define AIC_BT_PORT_UART			2
+#define AIC_BT_UART_BAUD			1500000
+#define AIC_BT_UART_FLOW_CTRL			1
+#define AIC_BT_LOW_POWER_ENABLE			1
+#define AIC_BT_TX_POWER_LEVEL			0x00006f2f
+
+enum aic_bt_patch_type {
+	AIC_BT_PATCH_INFO,
+	AIC_BT_PATCH_TRAP,
+	AIC_BT_PATCH_B4,
+	AIC_BT_PATCH_MODE,
+	AIC_BT_PATCH_POWER_ON,
+	AIC_BT_PATCH_AF,
+	AIC_BT_PATCH_VERSION,
+};
+
+struct aic_bt_e2a_header {
+	__le16 id;
+	__le16 dest_id;
+	__le16 src_id;
+	__le16 param_len;
+	__le32 pattern;
+	u8 param[];
+} __packed;
+
+struct aic_bt_mem_read_cfm {
+	__le32 address;
+	__le32 value;
+} __packed;
+
+struct aic_bt_sdio {
+	struct sdio_func *func;
+	struct aic_bt_boot *boot;
+
+	/* Serializes commands because the firmware accepts one at a time. */
+	struct mutex command_mutex;
+	/* Protects response state shared with the SDIO IRQ handler. */
+	spinlock_t response_lock;
+	struct completion command_done;
+	u16 expected_response;
+	void *response;
+	size_t response_size;
+	int command_result;
+	bool waiting_response;
+
+	u8 *tx_buf;
+	bool function_enabled;
+	bool irq_claimed;
+};
+
+static u8 aic_bt_crc8(const u8 *buffer, size_t len)
+{
+	u8 crc = 0;
+	size_t byte;
+	int bit;
+
+	for (byte = 0; byte < len; byte++) {
+		for (bit = 0x80; bit; bit >>= 1) {
+			if (crc & 0x80)
+				crc = (crc << 1) ^ 0x07;
+			else
+				crc <<= 1;
+
+			if (buffer[byte] & bit)
+				crc ^= 0x07;
+		}
+	}
+
+	return crc;
+}
+
+static void aic_bt_complete_response(struct aic_bt_sdio *btdev,
+				     const struct aic_bt_e2a_header *message,
+				     size_t message_len)
+{
+	unsigned long flags;
+	size_t param_len;
+	u16 id;
+	bool complete_command = false;
+
+	if (message_len < sizeof(*message))
+		return;
+
+	id = get_unaligned_le16(&message->id);
+	param_len = get_unaligned_le16(&message->param_len);
+	if (param_len > message_len - sizeof(*message))
+		return;
+
+	spin_lock_irqsave(&btdev->response_lock, flags);
+	if (!btdev->waiting_response || id != btdev->expected_response)
+		goto unlock;
+
+	if (btdev->response && param_len < btdev->response_size) {
+		btdev->command_result = -EMSGSIZE;
+	} else {
+		if (btdev->response)
+			memcpy(btdev->response, message->param,
+			       btdev->response_size);
+		btdev->command_result = 0;
+	}
+
+	btdev->waiting_response = false;
+	complete_command = true;
+
+unlock:
+	spin_unlock_irqrestore(&btdev->response_lock, flags);
+
+	if (complete_command)
+		complete(&btdev->command_done);
+}
+
+static void aic_bt_parse_rx(struct aic_bt_sdio *btdev, const u8 *data,
+			    size_t data_len)
+{
+	size_t offset = 0;
+
+	while (data_len - offset >= 4) {
+		const struct aic_bt_e2a_header *message;
+		size_t frame_len;
+		size_t frame_size;
+
+		frame_len = get_unaligned_le16(data + offset);
+		if (!frame_len)
+			break;
+
+		if (check_add_overflow(frame_len, (size_t)4, &frame_size) ||
+		    frame_size > data_len - offset)
+			break;
+
+		if ((data[offset + 2] & 0x7f) == AIC_CMD_TYPE) {
+			message = (const void *)(data + offset + 4);
+			aic_bt_complete_response(btdev, message, frame_len);
+		}
+
+		frame_size = roundup(frame_len, 4) + 4;
+		if (frame_size > data_len - offset)
+			break;
+		offset += frame_size;
+	}
+}
+
+static void aic_bt_sdio_irq(struct sdio_func *func)
+{
+	struct aic_bt_sdio *btdev = sdio_get_drvdata(func);
+	u8 *data;
+	u8 blocks;
+	u8 status;
+	size_t data_len;
+	int err;
+
+	status = sdio_readb(func, AIC_SDIO_MISC_INT_STATUS, &err);
+	if (err) {
+		dev_err_ratelimited(&func->dev,
+				    "failed to read interrupt status: %d\n", err);
+		return;
+	}
+
+	if (status & AIC_SDIO_OTHER_INTERRUPT) {
+		u8 pending;
+
+		pending = sdio_readb(func, AIC_SDIO_INTR_PENDING, &err);
+		if (!err) {
+			pending &= ~BIT(0);
+			sdio_writeb(func, pending, AIC_SDIO_INTR_PENDING, &err);
+		}
+		if (err)
+			dev_err_ratelimited(&func->dev,
+					    "failed to clear soft interrupt: %d\n",
+					    err);
+	}
+
+	blocks = status & 0x7f;
+	if (!blocks)
+		return;
+
+	if (blocks == AIC_SDIO_BYTE_MODE_BLOCKS) {
+		u8 words;
+
+		words = sdio_readb(func, AIC_SDIO_BYTEMODE_LEN, &err);
+		if (err)
+			return;
+		data_len = (size_t)words * 4;
+	} else {
+		data_len = (size_t)blocks * AIC_SDIO_BLOCK_SIZE;
+	}
+
+	if (!data_len || data_len > AIC_SDIO_RX_MAX_SIZE) {
+		dev_err_ratelimited(&func->dev,
+				    "invalid SDIO response length %zu\n", data_len);
+		return;
+	}
+
+	data = kmalloc(data_len, GFP_KERNEL);
+	if (!data)
+		return;
+
+	err = sdio_readsb(func, data, AIC_SDIO_RD_FIFO, data_len);
+	if (err)
+		dev_err_ratelimited(&func->dev,
+				    "failed to read response: %d\n", err);
+	else
+		aic_bt_parse_rx(btdev, data, data_len);
+
+	kfree(data);
+}
+
+static int aic_bt_wait_for_credits(struct aic_bt_sdio *btdev, size_t tx_len)
+{
+	unsigned int retry;
+	int err;
+
+	for (retry = 0; retry < AIC_SDIO_FLOW_RETRIES; retry++) {
+		u8 credits;
+
+		credits = sdio_readb(btdev->func, AIC_SDIO_FLOW_CTRL_Q1, &err);
+		if (err)
+			return err;
+
+		if (credits && tx_len < (size_t)credits * AIC_SDIO_BUFFER_SIZE)
+			return 0;
+
+		if (retry < 30)
+			usleep_range(30, 50);
+		else if (retry < 40)
+			usleep_range(1000, 1500);
+		else
+			usleep_range(10000, 12000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int aic_bt_command(struct aic_bt_sdio *btdev, u16 request_id,
+			  const void *param, size_t param_len, u16 response_id,
+			  void *response, size_t response_size)
+{
+	unsigned long flags;
+	size_t frame_len;
+	size_t message_len;
+	size_t tx_len;
+	long timeout;
+	int err;
+
+	if (param_len > U16_MAX)
+		return -EMSGSIZE;
+
+	message_len = 8 + param_len;
+	frame_len = 8 + message_len;
+	if (frame_len > AIC_SDIO_TX_BUFFER_SIZE)
+		return -EMSGSIZE;
+
+	if (IS_ALIGNED(frame_len, AIC_SDIO_BLOCK_SIZE))
+		tx_len = frame_len;
+	else
+		tx_len = roundup(frame_len + AIC_SDIO_FRAME_TAIL_LEN,
+				 AIC_SDIO_BLOCK_SIZE);
+
+	if (tx_len > AIC_SDIO_TX_BUFFER_SIZE)
+		return -EMSGSIZE;
+
+	mutex_lock(&btdev->command_mutex);
+
+	memset(btdev->tx_buf, 0, tx_len);
+	put_unaligned_le16(message_len + 4, btdev->tx_buf);
+	btdev->tx_buf[2] = AIC_CMD_TYPE;
+	btdev->tx_buf[3] = aic_bt_crc8(btdev->tx_buf, 3);
+
+	put_unaligned_le16(request_id, btdev->tx_buf + 8);
+	put_unaligned_le16(AIC_TASK_DBG, btdev->tx_buf + 10);
+	put_unaligned_le16(AIC_DRIVER_TASK, btdev->tx_buf + 12);
+	put_unaligned_le16(param_len, btdev->tx_buf + 14);
+	if (param_len)
+		memcpy(btdev->tx_buf + 16, param, param_len);
+
+	reinit_completion(&btdev->command_done);
+	spin_lock_irqsave(&btdev->response_lock, flags);
+	btdev->expected_response = response_id;
+	btdev->response = response;
+	btdev->response_size = response_size;
+	btdev->command_result = -EINPROGRESS;
+	btdev->waiting_response = true;
+	spin_unlock_irqrestore(&btdev->response_lock, flags);
+
+	sdio_claim_host(btdev->func);
+	err = aic_bt_wait_for_credits(btdev, tx_len);
+	if (!err)
+		err = sdio_writesb(btdev->func, AIC_SDIO_WR_FIFO,
+				   btdev->tx_buf, tx_len);
+	sdio_release_host(btdev->func);
+	if (err)
+		goto clear_response;
+
+	timeout = wait_for_completion_timeout(&btdev->command_done,
+					      msecs_to_jiffies(AIC_CMD_TIMEOUT_MS));
+	if (!timeout) {
+		dev_err(&btdev->func->dev,
+			"command 0x%04x timed out waiting for 0x%04x\n",
+			request_id, response_id);
+		err = -ETIMEDOUT;
+		goto clear_response;
+	}
+
+	spin_lock_irqsave(&btdev->response_lock, flags);
+	err = btdev->command_result;
+	btdev->response = NULL;
+	btdev->response_size = 0;
+	spin_unlock_irqrestore(&btdev->response_lock, flags);
+	mutex_unlock(&btdev->command_mutex);
+
+	return err;
+
+clear_response:
+	spin_lock_irqsave(&btdev->response_lock, flags);
+	btdev->waiting_response = false;
+	btdev->response = NULL;
+	btdev->response_size = 0;
+	spin_unlock_irqrestore(&btdev->response_lock, flags);
+	mutex_unlock(&btdev->command_mutex);
+
+	return err;
+}
+
+static int aic_bt_mem_read(struct aic_bt_sdio *btdev, u32 address, u32 *value)
+{
+	struct aic_bt_mem_read_cfm cfm;
+	__le32 request = cpu_to_le32(address);
+	int err;
+
+	err = aic_bt_command(btdev, AIC_DBG_MEM_READ_REQ,
+			     &request, sizeof(request), AIC_DBG_MEM_READ_CFM,
+			     &cfm, sizeof(cfm));
+	if (!err)
+		*value = le32_to_cpu(cfm.value);
+
+	return err;
+}
+
+static int aic_bt_mem_write(struct aic_bt_sdio *btdev, u32 address, u32 value)
+{
+	__le32 request[2] = {
+		cpu_to_le32(address),
+		cpu_to_le32(value),
+	};
+
+	return aic_bt_command(btdev, AIC_DBG_MEM_WRITE_REQ,
+			      request, sizeof(request), AIC_DBG_MEM_WRITE_CFM,
+			      NULL, 0);
+}
+
+static int aic_bt_mem_block_write(struct aic_bt_sdio *btdev, u32 address,
+				  const u8 *data, size_t data_len)
+{
+	__le32 status;
+	u8 *request;
+	int err;
+
+	if (data_len > AIC_BT_PATCH_BLOCK_SIZE)
+		return -EINVAL;
+
+	request = kzalloc(8 + AIC_BT_PATCH_BLOCK_SIZE, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+
+	put_unaligned_le32(address, request);
+	put_unaligned_le32(data_len, request + 4);
+	memcpy(request + 8, data, data_len);
+
+	err = aic_bt_command(btdev, AIC_DBG_MEM_BLOCK_WRITE_REQ,
+			     request, 8 + AIC_BT_PATCH_BLOCK_SIZE,
+			     AIC_DBG_MEM_BLOCK_WRITE_CFM,
+			     &status, sizeof(status));
+	kfree(request);
+	if (err)
+		return err;
+
+	if (le32_to_cpu(status)) {
+		dev_err(&btdev->func->dev,
+			"firmware rejected block write at 0x%08x\n", address);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int aic_bt_upload_firmware(struct aic_bt_sdio *btdev, const char *name,
+				  u32 address)
+{
+	const struct firmware *firmware;
+	size_t offset = 0;
+	int err;
+
+	err = request_firmware(&firmware, name, &btdev->func->dev);
+	if (err)
+		return dev_err_probe(&btdev->func->dev, err,
+				     "failed to load %s\n", name);
+
+	if (firmware->size > U32_MAX - address) {
+		err = -EFBIG;
+		goto release;
+	}
+
+	while (offset < firmware->size) {
+		size_t len = min_t(size_t, AIC_BT_PATCH_BLOCK_SIZE,
+				   firmware->size - offset);
+
+		err = aic_bt_mem_block_write(btdev, address + offset,
+					     firmware->data + offset, len);
+		if (err)
+			goto release;
+		offset += len;
+	}
+
+	dev_dbg(&btdev->func->dev, "loaded %s (%zu bytes) at 0x%08x\n",
+		name, firmware->size, address);
+
+release:
+	release_firmware(firmware);
+	return err;
+}
+
+static u32 aic_bt_mode_value(unsigned int pair, u32 firmware_value)
+{
+	switch (pair) {
+	case 0:
+		return 1;
+	case 1:
+		return U32_MAX;
+	case 2:
+		return 0;
+	case 3:
+		return AIC_BT_MODE_ONLY_COANT;
+	case 4:
+		return AIC_BT_PORT_UART;
+	case 5:
+		return AIC_BT_UART_BAUD;
+	case 6:
+		return AIC_BT_UART_FLOW_CTRL;
+	case 7:
+		return AIC_BT_LOW_POWER_ENABLE;
+	case 8:
+		return AIC_BT_TX_POWER_LEVEL;
+	default:
+		return firmware_value;
+	}
+}
+
+static int aic_bt_process_patch_table(struct aic_bt_sdio *btdev,
+				      const struct firmware *firmware,
+				      bool apply, u32 *adid_addr,
+				      u32 *patch_addr)
+{
+	const u8 *data = firmware->data;
+	size_t offset = AIC_BT_PATCH_TAG_SIZE;
+	bool have_record = false;
+	bool have_info = false;
+
+	if (firmware->size < AIC_BT_PATCH_TAG_SIZE ||
+	    memcmp(data, AIC_BT_PATCH_TAG, sizeof(AIC_BT_PATCH_TAG)))
+		return -EBADMSG;
+
+	while (offset < firmware->size) {
+		const u8 *record;
+		const u8 *pairs_data;
+		size_t pairs_size;
+		unsigned int pair;
+		u32 pair_count;
+		u32 type;
+		int err;
+
+		if (firmware->size - offset <
+		    AIC_BT_PATCH_RECORD_HEADER_SIZE)
+			return -EBADMSG;
+
+		record = data + offset;
+		type = get_unaligned_le32(record + 16);
+		pair_count = get_unaligned_le32(record + 20);
+		offset += AIC_BT_PATCH_RECORD_HEADER_SIZE;
+
+		if (type >= 1000) {
+			pairs_size = 0;
+			pair_count = 0;
+		} else if (check_mul_overflow((size_t)pair_count,
+					      (size_t)AIC_BT_PATCH_PAIR_SIZE,
+					      &pairs_size)) {
+			return -EOVERFLOW;
+		}
+
+		if (pairs_size > firmware->size - offset)
+			return -EBADMSG;
+
+		pairs_data = data + offset;
+		have_record = true;
+
+		if (type == AIC_BT_PATCH_INFO) {
+			if (pair_count < 2)
+				return -EBADMSG;
+
+			if (!have_info) {
+				if (adid_addr)
+					*adid_addr = get_unaligned_le32(pairs_data + 4);
+				if (patch_addr)
+					*patch_addr = get_unaligned_le32(pairs_data + 12);
+				have_info = true;
+			}
+		}
+
+		if (!apply)
+			goto next_record;
+
+		if (type == AIC_BT_PATCH_VERSION) {
+			dev_info(&btdev->func->dev, "BT patch version: %.*s\n",
+				 (int)min_t(size_t, pairs_size, 80),
+				 pairs_data);
+			goto next_record;
+		}
+
+		if (type == AIC_BT_PATCH_MODE && pair_count < 9)
+			return -EBADMSG;
+
+		for (pair = 0; pair < pair_count; pair++) {
+			u32 address;
+			u32 value;
+
+			address = get_unaligned_le32(pairs_data +
+						    pair * AIC_BT_PATCH_PAIR_SIZE);
+			value = get_unaligned_le32(pairs_data +
+						  pair * AIC_BT_PATCH_PAIR_SIZE + 4);
+			if (type == AIC_BT_PATCH_MODE)
+				value = aic_bt_mode_value(pair, value);
+
+			err = aic_bt_mem_write(btdev, address, value);
+			if (err)
+				return err;
+		}
+
+		if (type == AIC_BT_PATCH_POWER_ON)
+			usleep_range(50, 100);
+
+next_record:
+		offset += pairs_size;
+	}
+
+	if (!have_record || ((adid_addr || patch_addr) && !have_info))
+		return -EBADMSG;
+
+	return 0;
+}
+
+static int aic_bt_download_firmware(struct aic_bt_sdio *btdev)
+{
+	const struct firmware *table;
+	u32 chip_id;
+	u32 adid_addr;
+	u32 patch_addr;
+	u8 revision;
+	int err;
+
+	err = aic_bt_mem_read(btdev, AIC_BT_CHIP_ID_ADDR, &chip_id);
+	if (err)
+		return err;
+
+	revision = (chip_id >> 16) & 0x3f;
+	if (revision != AIC_BT_CHIP_REV_U02 &&
+	    revision != AIC_BT_CHIP_REV_U03) {
+		dev_err(&btdev->func->dev,
+			"unsupported AIC8800D80 revision %u\n", revision);
+		return -ENODEV;
+	}
+
+	err = request_firmware(&table, AIC_BT_FW_TABLE, &btdev->func->dev);
+	if (err)
+		return dev_err_probe(&btdev->func->dev, err,
+				     "failed to load %s\n", AIC_BT_FW_TABLE);
+
+	err = aic_bt_process_patch_table(btdev, table, false,
+					 &adid_addr, &patch_addr);
+	if (err) {
+		dev_err(&btdev->func->dev, "invalid BT patch table: %d\n", err);
+		goto release_table;
+	}
+
+	err = aic_bt_upload_firmware(btdev, AIC_BT_FW_ADID, adid_addr);
+	if (err)
+		goto release_table;
+
+	err = aic_bt_upload_firmware(btdev, AIC_BT_FW_PATCH, patch_addr);
+	if (err)
+		goto release_table;
+
+	err = aic_bt_process_patch_table(btdev, table, true, NULL, NULL);
+	if (!err)
+		dev_info(&btdev->func->dev,
+			 "AIC8800D80 revision %u Bluetooth firmware ready\n",
+			 revision);
+
+release_table:
+	release_firmware(table);
+	return err;
+}
+
+static int aic_bt_sdio_hw_init(struct aic_bt_sdio *btdev)
+{
+	struct sdio_func *func = btdev->func;
+	struct mmc_host *host = func->card->host;
+	u8 io_control;
+	int err;
+
+	sdio_claim_host(func);
+	func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
+
+	err = sdio_set_block_size(func, AIC_SDIO_BLOCK_SIZE);
+	if (err)
+		goto release_host;
+
+	err = sdio_enable_func(func);
+	if (err)
+		goto release_host;
+	btdev->function_enabled = true;
+
+	sdio_f0_writeb(func, 0x7f, 0xf2, &err);
+	if (err)
+		goto disable_func;
+
+	io_control = host->ios.timing == MMC_TIMING_UHS_DDR50 ? 0x20 : 0x00;
+	io_control |= BIT(6);
+	sdio_f0_writeb(func, io_control, 0xf0, &err);
+	if (err)
+		goto disable_func;
+
+	sdio_f0_writeb(func, 0x00, 0xf8, &err);
+	if (err)
+		goto disable_func;
+
+	sdio_f0_writeb(func, 0x00, 0xf1, &err);
+	if (err)
+		goto disable_func;
+
+	sdio_writeb(func, 1, AIC_SDIO_BYTEMODE_ENABLE, &err);
+	if (err)
+		goto disable_func;
+
+	err = sdio_claim_irq(func, aic_bt_sdio_irq);
+	if (err)
+		goto disable_func;
+	btdev->irq_claimed = true;
+
+	sdio_f0_writeb(func, 0x07, 0x04, &err);
+	if (err)
+		goto release_irq;
+
+	sdio_writeb(func, 0x07, AIC_SDIO_INTR_ENABLE, &err);
+	if (err)
+		goto release_irq;
+
+	sdio_release_host(func);
+	return 0;
+
+release_irq:
+	sdio_release_irq(func);
+	btdev->irq_claimed = false;
+disable_func:
+	sdio_disable_func(func);
+	btdev->function_enabled = false;
+release_host:
+	sdio_release_host(func);
+	return err;
+}
+
+static void aic_bt_sdio_hw_deinit(struct aic_bt_sdio *btdev)
+{
+	sdio_claim_host(btdev->func);
+
+	if (btdev->irq_claimed) {
+		int err;
+
+		sdio_writeb(btdev->func, 0, AIC_SDIO_INTR_ENABLE, &err);
+		sdio_release_irq(btdev->func);
+		btdev->irq_claimed = false;
+	}
+
+	if (btdev->function_enabled) {
+		sdio_disable_func(btdev->func);
+		btdev->function_enabled = false;
+	}
+
+	sdio_release_host(btdev->func);
+}
+
+static int aic_bt_sdio_probe(struct sdio_func *func,
+			     const struct sdio_device_id *id)
+{
+	struct aic_bt_sdio *btdev;
+	int err;
+
+	if (func->num != 1)
+		return -ENODEV;
+
+	btdev = devm_kzalloc(&func->dev, sizeof(*btdev), GFP_KERNEL);
+	if (!btdev)
+		return -ENOMEM;
+
+	btdev->tx_buf = devm_kmalloc(&func->dev, AIC_SDIO_TX_BUFFER_SIZE,
+				     GFP_KERNEL);
+	if (!btdev->tx_buf)
+		return -ENOMEM;
+
+	btdev->func = func;
+	mutex_init(&btdev->command_mutex);
+	spin_lock_init(&btdev->response_lock);
+	init_completion(&btdev->command_done);
+	sdio_set_drvdata(func, btdev);
+
+	err = aic_bt_sdio_hw_init(btdev);
+	if (err)
+		goto clear_drvdata;
+
+	btdev->boot = aic_bt_boot_register(&func->dev);
+	if (IS_ERR(btdev->boot)) {
+		err = PTR_ERR(btdev->boot);
+		btdev->boot = NULL;
+		goto deinit_hw;
+	}
+
+	err = aic_bt_download_firmware(btdev);
+	aic_bt_boot_ready(btdev->boot, err);
+	if (err)
+		goto unregister_boot;
+
+	return 0;
+
+unregister_boot:
+	aic_bt_boot_unregister(btdev->boot);
+	btdev->boot = NULL;
+deinit_hw:
+	aic_bt_sdio_hw_deinit(btdev);
+clear_drvdata:
+	sdio_set_drvdata(func, NULL);
+	return err;
+}
+
+static void aic_bt_sdio_remove(struct sdio_func *func)
+{
+	struct aic_bt_sdio *btdev = sdio_get_drvdata(func);
+
+	aic_bt_boot_unregister(btdev->boot);
+	btdev->boot = NULL;
+	aic_bt_sdio_hw_deinit(btdev);
+	sdio_set_drvdata(func, NULL);
+}
+
+static int aic_bt_sdio_suspend(struct device *dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	mmc_pm_flag_t caps;
+
+	caps = sdio_get_host_pm_caps(func);
+	if (!(caps & MMC_PM_KEEP_POWER))
+		return -EOPNOTSUPP;
+
+	return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
+}
+
+static int aic_bt_sdio_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops aic_bt_sdio_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(aic_bt_sdio_suspend, aic_bt_sdio_resume)
+};
+
+static const struct sdio_device_id aic_bt_sdio_ids[] = {
+	{ SDIO_DEVICE(AIC_SDIO_VENDOR_ID, AIC_SDIO_DEVICE_ID_8800D80) },
+	{ }
+};
+MODULE_DEVICE_TABLE(sdio, aic_bt_sdio_ids);
+
+static const struct of_device_id aic_bt_sdio_of_match[] = {
+	{ .compatible = "aic,aic8800d80-bt-sdio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aic_bt_sdio_of_match);
+
+static struct sdio_driver aic_bt_sdio_driver = {
+	.name = "aic_bt_sdio",
+	.id_table = aic_bt_sdio_ids,
+	.probe = aic_bt_sdio_probe,
+	.remove = aic_bt_sdio_remove,
+	.drv = {
+		.of_match_table = aic_bt_sdio_of_match,
+		.pm = &aic_bt_sdio_pm_ops,
+	},
+};
+
+int aic_bt_sdio_register(void)
+{
+	return sdio_register_driver(&aic_bt_sdio_driver);
+}
+
+void aic_bt_sdio_unregister(void)
+{
+	sdio_unregister_driver(&aic_bt_sdio_driver);
+}
+
+MODULE_FIRMWARE(AIC_BT_FW_ADID);
+MODULE_FIRMWARE(AIC_BT_FW_PATCH);
+MODULE_FIRMWARE(AIC_BT_FW_TABLE);
diff --git a/drivers/bluetooth/btaic_uart.c b/drivers/bluetooth/btaic_uart.c
new file mode 100644
index 000000000000..4a38fccfe7af
--- /dev/null
+++ b/drivers/bluetooth/btaic_uart.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ ******************************************************************************
+ *
+ * Copyright (C) 2020 AIC semiconductor.
+ *
+ * @brief AIC8800D80 Bluetooth UART transport
+ *
+ ******************************************************************************
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/serdev.h>
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btaic.h"
+#include "hci_uart.h"
+
+#define AIC_BT_UART_DEFAULT_SPEED	1500000
+#define AIC_BT_BOOT_TIMEOUT_MS		10000
+
+#define AIC_BT_TX_ACTIVE		0
+#define AIC_BT_TX_WAKEUP		1
+
+struct aic_bt_uart {
+	struct serdev_device *serdev;
+	struct hci_dev *hdev;
+	struct hci_uart hu;
+	struct aic_bt_boot *boot;
+
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+	struct work_struct tx_work;
+	unsigned long tx_state;
+
+	u32 speed;
+};
+
+static const struct h4_recv_pkt aic_bt_recv_pkts[] = {
+	{ H4_RECV_ACL,   .recv = hci_recv_frame },
+	{ H4_RECV_SCO,   .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+	{ H4_RECV_ISO,   .recv = hci_recv_frame },
+};
+
+static void aic_bt_tx_work(struct work_struct *work)
+{
+	struct aic_bt_uart *uart = container_of(work, struct aic_bt_uart,
+						 tx_work);
+
+	for (;;) {
+		struct sk_buff *skb;
+
+		clear_bit(AIC_BT_TX_WAKEUP, &uart->tx_state);
+
+		while ((skb = skb_dequeue(&uart->txq))) {
+			int len;
+
+			len = serdev_device_write_buf(uart->serdev, skb->data,
+						      skb->len);
+			if (len <= 0) {
+				skb_queue_head(&uart->txq, skb);
+				if (len < 0)
+					bt_dev_err(uart->hdev,
+						   "UART transmit failed (%d)", len);
+				break;
+			}
+
+			uart->hdev->stat.byte_tx += len;
+			skb_pull(skb, len);
+			if (skb->len) {
+				skb_queue_head(&uart->txq, skb);
+				break;
+			}
+
+			switch (hci_skb_pkt_type(skb)) {
+			case HCI_COMMAND_PKT:
+				uart->hdev->stat.cmd_tx++;
+				break;
+			case HCI_ACLDATA_PKT:
+				uart->hdev->stat.acl_tx++;
+				break;
+			case HCI_SCODATA_PKT:
+				uart->hdev->stat.sco_tx++;
+				break;
+			}
+
+			kfree_skb(skb);
+		}
+
+		if (!test_bit(AIC_BT_TX_WAKEUP, &uart->tx_state))
+			break;
+	}
+
+	clear_bit(AIC_BT_TX_ACTIVE, &uart->tx_state);
+}
+
+static void aic_bt_tx_wakeup(struct aic_bt_uart *uart)
+{
+	if (test_and_set_bit(AIC_BT_TX_ACTIVE, &uart->tx_state))
+		set_bit(AIC_BT_TX_WAKEUP, &uart->tx_state);
+
+	schedule_work(&uart->tx_work);
+}
+
+static size_t aic_bt_receive_buf(struct serdev_device *serdev,
+				 const u8 *data, size_t count)
+{
+	struct aic_bt_uart *uart = serdev_device_get_drvdata(serdev);
+
+	uart->rx_skb = h4_recv_buf(&uart->hu, uart->rx_skb, data, count,
+				   aic_bt_recv_pkts,
+				   ARRAY_SIZE(aic_bt_recv_pkts));
+	if (IS_ERR(uart->rx_skb)) {
+		bt_dev_err(uart->hdev, "Frame reassembly failed (%ld)",
+			   PTR_ERR(uart->rx_skb));
+		uart->rx_skb = NULL;
+	}
+
+	uart->hdev->stat.byte_rx += count;
+	return count;
+}
+
+static void aic_bt_write_wakeup(struct serdev_device *serdev)
+{
+	struct aic_bt_uart *uart = serdev_device_get_drvdata(serdev);
+
+	aic_bt_tx_wakeup(uart);
+}
+
+static const struct serdev_device_ops aic_bt_serdev_ops = {
+	.receive_buf = aic_bt_receive_buf,
+	.write_wakeup = aic_bt_write_wakeup,
+};
+
+static int aic_bt_open(struct hci_dev *hdev)
+{
+	struct aic_bt_uart *uart = hci_get_drvdata(hdev);
+	unsigned int actual_speed;
+	int err;
+
+	err = aic_bt_boot_wait(uart->boot,
+			       msecs_to_jiffies(AIC_BT_BOOT_TIMEOUT_MS));
+	if (err) {
+		bt_dev_err(hdev, "Bluetooth firmware is not ready (%d)", err);
+		return err;
+	}
+
+	err = serdev_device_open(uart->serdev);
+	if (err)
+		return err;
+
+	actual_speed = serdev_device_set_baudrate(uart->serdev, uart->speed);
+	if (!actual_speed) {
+		serdev_device_close(uart->serdev);
+		return -EIO;
+	}
+
+	serdev_device_set_flow_control(uart->serdev, true);
+	return 0;
+}
+
+static int aic_bt_close(struct hci_dev *hdev)
+{
+	struct aic_bt_uart *uart = hci_get_drvdata(hdev);
+
+	serdev_device_close(uart->serdev);
+	return 0;
+}
+
+static int aic_bt_flush(struct hci_dev *hdev)
+{
+	struct aic_bt_uart *uart = hci_get_drvdata(hdev);
+
+	serdev_device_write_flush(uart->serdev);
+	cancel_work_sync(&uart->tx_work);
+	skb_queue_purge(&uart->txq);
+	kfree_skb(uart->rx_skb);
+	uart->rx_skb = NULL;
+	clear_bit(AIC_BT_TX_ACTIVE, &uart->tx_state);
+	clear_bit(AIC_BT_TX_WAKEUP, &uart->tx_state);
+
+	return 0;
+}
+
+static int aic_bt_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct aic_bt_uart *uart = hci_get_drvdata(hdev);
+	u8 pkt_type = hci_skb_pkt_type(skb);
+	int err;
+
+	err = skb_cow_head(skb, 1);
+	if (err)
+		return err;
+
+	memcpy(skb_push(skb, 1), &pkt_type, sizeof(pkt_type));
+	skb_queue_tail(&uart->txq, skb);
+	aic_bt_tx_wakeup(uart);
+
+	return 0;
+}
+
+static void aic_bt_boot_put_action(void *data)
+{
+	aic_bt_boot_put(data);
+}
+
+static int aic_bt_find_boot_provider(struct device *dev,
+				     struct aic_bt_uart *uart)
+{
+	struct fwnode_handle *fwnode = NULL;
+	int err;
+
+	if (device_property_present(dev, "aic,firmware-sdio")) {
+		fwnode = fwnode_find_reference(dev_fwnode(dev),
+					       "aic,firmware-sdio", 0);
+		if (IS_ERR(fwnode))
+			return PTR_ERR(fwnode);
+	}
+
+	uart->boot = aic_bt_boot_get(fwnode);
+	fwnode_handle_put(fwnode);
+	if (IS_ERR(uart->boot))
+		return dev_err_probe(dev, PTR_ERR(uart->boot),
+				     "failed to find Bluetooth SDIO firmware loader\n");
+
+	err = devm_add_action_or_reset(dev, aic_bt_boot_put_action,
+				       uart->boot);
+	if (err)
+		return err;
+
+	if (!device_link_add(dev, aic_bt_boot_device(uart->boot),
+			     DL_FLAG_AUTOREMOVE_CONSUMER))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int aic_bt_uart_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct aic_bt_uart *uart;
+	struct hci_dev *hdev;
+	int err;
+
+	uart = devm_kzalloc(dev, sizeof(*uart), GFP_KERNEL);
+	if (!uart)
+		return -ENOMEM;
+
+	uart->serdev = serdev;
+	uart->speed = AIC_BT_UART_DEFAULT_SPEED;
+	device_property_read_u32(dev, "max-speed", &uart->speed);
+	serdev_device_set_drvdata(serdev, uart);
+	serdev_device_set_client_ops(serdev, &aic_bt_serdev_ops);
+
+	err = aic_bt_find_boot_provider(dev, uart);
+	if (err)
+		return err;
+
+	INIT_WORK(&uart->tx_work, aic_bt_tx_work);
+	skb_queue_head_init(&uart->txq);
+
+	hdev = hci_alloc_dev();
+	if (!hdev)
+		return -ENOMEM;
+
+	uart->hdev = hdev;
+	uart->hu.hdev = hdev;
+	hdev->bus = HCI_UART;
+	hci_set_drvdata(hdev, uart);
+	SET_HCIDEV_DEV(hdev, dev);
+
+	hdev->open = aic_bt_open;
+	hdev->close = aic_bt_close;
+	hdev->flush = aic_bt_flush;
+	hdev->send = aic_bt_send_frame;
+
+	err = hci_register_dev(hdev);
+	if (err) {
+		hci_free_dev(hdev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void aic_bt_uart_remove(struct serdev_device *serdev)
+{
+	struct aic_bt_uart *uart = serdev_device_get_drvdata(serdev);
+
+	hci_unregister_dev(uart->hdev);
+	cancel_work_sync(&uart->tx_work);
+	skb_queue_purge(&uart->txq);
+	kfree_skb(uart->rx_skb);
+	uart->rx_skb = NULL;
+	hci_free_dev(uart->hdev);
+}
+
+static const struct of_device_id aic_bt_uart_of_match[] = {
+	{ .compatible = "aic,aic8800d80-bt" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aic_bt_uart_of_match);
+
+static struct serdev_device_driver aic_bt_uart_driver = {
+	.probe = aic_bt_uart_probe,
+	.remove = aic_bt_uart_remove,
+	.driver = {
+		.name = "bt_aic_uart",
+		.of_match_table = aic_bt_uart_of_match,
+	},
+};
+
+int aic_bt_uart_register(void)
+{
+	return serdev_device_driver_register(&aic_bt_uart_driver);
+}
+
+void aic_bt_uart_unregister(void)
+{
+	serdev_device_driver_unregister(&aic_bt_uart_driver);
+}
-- 
2.34.1
