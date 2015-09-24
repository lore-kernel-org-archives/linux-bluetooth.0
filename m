Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: broonie@kernel.org,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] regmap: Add HCI support
Date: Thu, 24 Sep 2015 17:13:04 +0200
Message-Id: <1443107584-31026-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add HCI support to the regmap API.
Some HCI/BT devices provide register access via their HCI interface.
(e.g. FM registers access for Intel BT/FM combo chip)

Read/Write operations are performed via a HCI transaction composed of
a HCI command (host->controller) followed by a HCI command complete
event (controller->host). Read/Write Command opcodes can be specified
to the regmap init function.
We define data formats which are vendor specific. However, regmap-hci
can be extended with any other implementation.

Register Read/Write HCI command payload (Host):
Field: | REG ADDR | MODE | DATA_LEN | DATA... |
size:  |   32b    |  8b  |    8b    |  8b*    |

Register Read HCI command complete event payload (Controller):
Field: | CMD STATUS | REG ADDR | DATA... |
size:  |     8b     |   32b    |  8b*    |

Register Write HCI command complete event payload (Controller):
Field: | CMD_STATUS |
size:  |     8b     |

Since this payload is HCI encapsulated, Little Endian byte order
is used.

Example:

If we want to write 0x32001122 in the register 0x00001142,
with opcode_write 0xfc58, the resulting HCI transaction will be:
  ________ ___________ __ __ ___________
> 58 fc 0a 42 11 00 00 02 04 22 11 00 32
   CMD HDR   REG ADDR  MD SZ    DATA
  ______________ __
< 0E 04 01 58 fc 00
    CC EVT HDR   ST

If we want to read the 32bit value stored in same register with
opcode_read 0xfc59:
  ________ ___________ __ __
> 59 fc 06 42 11 00 00 02 04
  CMD HDR    REG ADDR  MD SZ
  ______________ __ ___________ ___________
< 0E 0c 01 59 fc 00 04 8c 00 00 22 11 00 32
    CC EVT HDR   ST   REG ADDR     DATA

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/base/regmap/Kconfig      |   6 +-
 drivers/base/regmap/Makefile     |   1 +
 drivers/base/regmap/regmap-hci.c | 282 +++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h           |   7 +
 4 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-hci.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index db9d00c3..b692b96 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -3,7 +3,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_HCI)
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 	select IRQ_DOMAIN if REGMAP_IRQ
@@ -29,3 +29,7 @@ config REGMAP_MMIO
 
 config REGMAP_IRQ
 	bool
+
+config REGMAP_HCI
+	tristate
+	depends on BT
\ No newline at end of file
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 609e4c8..8cf31ea 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
+obj-$(CONFIG_REGMAP_HCI) += regmap-hci.o
diff --git a/drivers/base/regmap/regmap-hci.c b/drivers/base/regmap/regmap-hci.c
new file mode 100644
index 0000000..bcb91a8
--- /dev/null
+++ b/drivers/base/regmap/regmap-hci.c
@@ -0,0 +1,282 @@
+/*
+ * Register map access API - HCI support
+ *
+ * Copyright 2015 Intel Corporation
+ *
+ * Author: Loic Poulain <loic.poulain@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "internal.h"
+
+#define DEFAULT_OP_WRITE 0xfc58
+#define DEFAULT_OP_READ  0xfc59
+
+#define HCI_REG_MODE_8BIT  0x00
+#define HCI_REG_MODE_16BIT 0x01
+#define HCI_REG_MODE_32BIT 0x02
+
+struct regmap_hci_context {
+	struct hci_dev *hdev;
+	__u16 op_write;
+	__u16 op_read;
+};
+
+/**
+ * HCI Command payload for register read/write
+ *
+ * @reg: Register address (32bit only)
+ * @mode: Value access mode (8bit, 16bit, 32bit)
+ * @data_len: data len to read/write
+ * @data: data to write
+ */
+struct hci_command_reg_hdr {
+	__le32  reg;
+	__u8    mode;
+	__u8    data_len;
+	__u8    data[0];
+} __packed;
+
+/**
+ * HCI Command Complete Event payload for register read
+ *
+ * @reg: cmd read status
+ * @mode: Register address (32bit only)
+ * @data: Register value
+ */
+struct hci_cc_reg_hdr {
+	__u8    status;
+	__le32  reg;
+	__u8    data[0];
+} __packed;
+
+static int regmap_hci_read(void *context, const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	struct regmap_hci_context *ctx = context;
+	struct hci_dev *hdev = ctx->hdev;
+	struct sk_buff *skb;
+	struct hci_command_reg_hdr hdr;
+	struct hci_cc_reg_hdr *cc;
+
+	if (reg_size != sizeof(__le32))
+		return -EINVAL;
+
+	switch (val_size) {
+	case 1:
+		hdr.mode = HCI_REG_MODE_8BIT;
+		break;
+	case 2:
+		hdr.mode = HCI_REG_MODE_16BIT;
+		break;
+	case 4:
+		hdr.mode = HCI_REG_MODE_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hdr.reg = *(__le32 *)reg;
+	hdr.data_len = val_size;
+
+	bt_dev_dbg(hdev, "regmap: Read register 0x%x", hdr.reg);
+
+	skb = __hci_cmd_sync(hdev, ctx->op_read, sizeof(hdr), &hdr,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "regmap: Read error, command failure");
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*cc) + val_size) {
+		bt_dev_err(hdev, "regmap: Read error, unexpected pkt len");
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	cc = (struct hci_cc_reg_hdr *)skb->data;
+
+	if (cc->reg != hdr.reg) {
+		bt_dev_err(hdev, "regmap: Read error, Invalid register 0x%x",
+			   le32_to_cpu(cc->reg));
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	memcpy(val, cc->data, val_size);
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int regmap_hci_gather_write(void *context,
+				   const void *reg, size_t reg_size,
+				   const void *val, size_t val_size)
+{
+	struct regmap_hci_context *ctx = context;
+	struct hci_dev *hdev = ctx->hdev;
+	struct sk_buff *skb;
+	struct hci_command_reg_hdr *hdr;
+	int plen = sizeof(*hdr) + val_size;
+	u8 mode;
+
+	if (reg_size != sizeof(__le32))
+		return -EINVAL;
+
+	switch (val_size) {
+	case 1:
+		mode = HCI_REG_MODE_8BIT;
+		break;
+	case 2:
+		mode = HCI_REG_MODE_16BIT;
+		break;
+	case 4:
+		mode = HCI_REG_MODE_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hdr = kmalloc(plen, GFP_KERNEL);
+	if (!hdr)
+		return -ENOMEM;
+
+	hdr->reg = *(__le32 *)reg;
+	hdr->mode = mode;
+	hdr->data_len = val_size;
+	memcpy(&hdr->data, val, val_size);
+
+	bt_dev_dbg(hdev, "regmap: Write register 0x%x", hdr->reg);
+
+	skb = __hci_cmd_sync(hdev, ctx->op_write, plen, hdr, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "regmap: Write error, command failure");
+		kfree(hdr);
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	kfree(hdr);
+
+	return 0;
+}
+
+static int regmap_hci_write(void *context, const void *data, size_t count)
+{
+	BUG_ON(count < 4);
+	return regmap_hci_gather_write(context, data, 4, data + 4, count - 4);
+}
+
+void regmap_hci_free_context(void *context)
+{
+	kfree(context);
+}
+
+static struct regmap_bus regmap_hci_default = {
+	.read = regmap_hci_read,
+	.write = regmap_hci_write,
+	.gather_write = regmap_hci_gather_write,
+	.free_context = regmap_hci_free_context,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+
+/**
+ * regmap_init_hci(): Initialise register map
+ *
+ * @hdev: HCI Device that will be interacted with
+ * @config: Configuration for register map
+ * @opcode_read: HCI opcode command for register-read operation
+ * @opcode_write: HCI opcode command for register-write operation
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+static struct regmap *__regmap_init_hci(struct hci_dev *hdev,
+					u16 opcode_read, u16 opcode_write,
+					const struct regmap_config *config,
+					bool devm)
+{
+	struct regmap_hci_context *ctx;
+
+	if (!config)
+		return ERR_PTR(-EINVAL);
+
+	bt_dev_info(hdev, "regmap: Init %s-R%x-W%x region", config->name,
+		    opcode_read, opcode_write);
+
+	if (config->reg_bits != 32) {
+		bt_dev_err(hdev, "regmap: Unsupported address size: %d",
+			   config->reg_bits);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->op_read = opcode_read ? opcode_read : DEFAULT_OP_READ;
+	ctx->op_write = opcode_write ? opcode_write : DEFAULT_OP_WRITE;
+	ctx->hdev = hdev;
+
+	if (devm)
+		return devm_regmap_init(&hdev->dev, &regmap_hci_default, ctx,
+					config);
+	else
+		return regmap_init(&hdev->dev, &regmap_hci_default, ctx,
+				   config);
+}
+
+/**
+ * regmap_init_hci(): Initialise register map
+ *
+ * @hdev: HCI Device that will be interacted with
+ * @config: Configuration for register map
+ * @opcode_read: HCI opcode command for register-read operation
+ * @opcode_write: HCI opcode command for register-write operation
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+struct regmap *regmap_init_hci(struct hci_dev *hdev,
+			       u16 opcode_read, u16 opcode_write,
+			       const struct regmap_config *config)
+{
+	return __regmap_init_hci(hdev, opcode_read, opcode_write, config,
+				 false);
+}
+EXPORT_SYMBOL_GPL(regmap_init_hci);
+
+/**
+ * devm_regmap_init_hci(): Initialise register map
+ *
+ * @hdev: HCI Device that will be interacted with
+ * @config: Configuration for register map
+ * @opcode_read: HCI opcode command for register-read operation
+ * @opcode_write: HCI opcode command for register-write operation
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap. The regmap will be automatically freed by the
+ * device management code.
+ */
+struct regmap *devm_regmap_init_hci(struct hci_dev *hdev,
+				    u16 opcode_read, u16 opcode_write,
+				    const struct regmap_config *config)
+{
+	return __regmap_init_hci(hdev, opcode_read, opcode_write, config,
+				 true);
+}
+EXPORT_SYMBOL_GPL(devm_regmap_init_hci);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 59c55ea..8a2823b 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -28,6 +28,7 @@ struct regmap;
 struct regmap_range_cfg;
 struct regmap_field;
 struct snd_ac97;
+struct hci_dev;
 
 /* An enum of all the supported cache types */
 enum regcache_type {
@@ -343,6 +344,9 @@ struct regmap *regmap_init_mmio_clk(struct device *dev, const char *clk_id,
 				    const struct regmap_config *config);
 struct regmap *regmap_init_ac97(struct snd_ac97 *ac97,
 				const struct regmap_config *config);
+struct regmap *regmap_init_hci(struct hci_dev *hdev,
+			       u16 opcode_read, u16 opcode_write,
+			       const struct regmap_config *config);
 
 struct regmap *devm_regmap_init(struct device *dev,
 				const struct regmap_bus *bus,
@@ -361,6 +365,9 @@ struct regmap *devm_regmap_init_mmio_clk(struct device *dev, const char *clk_id,
 					 const struct regmap_config *config);
 struct regmap *devm_regmap_init_ac97(struct snd_ac97 *ac97,
 				     const struct regmap_config *config);
+struct regmap *devm_regmap_init_hci(struct hci_dev *hdev,
+				    u16 opcode_read, u16 opcode_write,
+				    const struct regmap_config *config);
 
 bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 
-- 
1.9.1
