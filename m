Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	broonie@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v2] regmap: Add HCI iBT support
Date: Mon, 28 Sep 2015 18:30:33 +0200
Message-Id: <1443457833-5135-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for Intel Bluetooth silicon register access over HCI.
Intel BT/FM combo chip allows to read/write some registers (e.g. FM
registers) via its HCI interface.

Read/Write operations are performed via a HCI transaction composed of
a HCI command (host->controller) followed by a HCI command complete
event (controller->host). Read/Write Command opcodes can be specified
to the regmap init function.
We define data formats which are intel/vendor specific.

Register Read/Write HCI command payload (Host):
Field: | REG ADDR | MODE | DATA_LEN | DATA... |
size:  |   32b    |  8b  |    8b    |  8b*    |

Register Read HCI command complete event payload (Controller):
Field: | CMD STATUS | REG ADDR | DATA... |
size:  |     8b     |   32b    |  8b*    |

Register Write HCI command complete event payload (Controller):
Field: | CMD_STATUS |
size:  |     8b     |

Since this payload is HCI encapsulated, Little Endian byte order is
used.

Write/Read Example:

If we write 0x0000002a at address 0x00008c04, with opcode_write 0xfc5d,
The resulting transaction is (btmon trace):

< HCI Command (0x3f|0x005d) plen 10 [hci0]
        04 8c 00 00 02 04 2a 00 00 00
> HCI Event (0x0e) plen 4
      Unknown (0x3f|0x005d) ncmd 1
        00

Then, if we read the same register with opcode_read 0xfc5e:

< HCI Command (0x3f|0x005e) plen 6 [hci0]
        04 8c 00 00 02 04
> HCI Event (0x0e) plen 12 [hci0]
      Unknown (0x3f|0x005e) ncmd 1
        00 04 8c 00 00 2a 00 00 00

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: Change "hci" to "ibt" since it's intel specific
     Add comments for clarification
     Remove unjustified default opcodes
     Protect __hci_cmd_sync call with hdev req_lock
     Replace BUG_ON with WARN_ONCE

 drivers/base/regmap/Kconfig      |   6 +-
 drivers/base/regmap/Makefile     |   1 +
 drivers/base/regmap/regmap-ibt.c | 283 +++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h           |   7 +
 4 files changed, 296 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-ibt.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index db9d00c3..e34675f 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -3,7 +3,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_IBT)
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 	select IRQ_DOMAIN if REGMAP_IRQ
@@ -29,3 +29,7 @@ config REGMAP_MMIO
 
 config REGMAP_IRQ
 	bool
+
+config REGMAP_IBT
+	tristate
+	depends on BT
\ No newline at end of file
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 609e4c8..e7fd73f 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
+obj-$(CONFIG_REGMAP_IBT) += regmap-ibt.o
diff --git a/drivers/base/regmap/regmap-ibt.c b/drivers/base/regmap/regmap-ibt.c
new file mode 100644
index 0000000..feb7607
--- /dev/null
+++ b/drivers/base/regmap/regmap-ibt.c
@@ -0,0 +1,283 @@
+/*
+ * Register map access API - iBT support
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
+#define IBT_REG_MODE_8BIT  0x00
+#define IBT_REG_MODE_16BIT 0x01
+#define IBT_REG_MODE_32BIT 0x02
+
+struct regmap_ibt_context {
+	struct hci_dev *hdev;
+	__u16 op_write;
+	__u16 op_read;
+};
+
+/**
+ * HCI Command payload for register read/write
+ *
+ * @raddr: Register address (32bit only)
+ * @mode: Value access mode (8bit, 16bit, 32bit)
+ * @len: Data len to read/write
+ * @data: Data to write
+ */
+struct ibt_cp_reg_access {
+	__le32  addr;
+	__u8    mode;
+	__u8    len;
+	__u8    data[0];
+} __packed;
+
+/**
+ * HCI Command Complete Event payload for register read
+ *
+ * @status: cmd read status
+ * @addr: Register address (32bit only)
+ * @data: Register value
+ */
+struct ibt_rp_reg_access {
+	__u8    status;
+	__le32  addr;
+	__u8    data[0];
+} __packed;
+
+static int regmap_ibt_read(void *context, const void *addr, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	struct regmap_ibt_context *ctx = context;
+	struct ibt_cp_reg_access cp;
+	struct ibt_rp_reg_access *rp;
+	struct sk_buff *skb;
+	int err = 0;
+
+	if (reg_size != sizeof(__le32))
+		return -EINVAL;
+
+	switch (val_size) {
+	case 1:
+		cp.mode = IBT_REG_MODE_8BIT;
+		break;
+	case 2:
+		cp.mode = IBT_REG_MODE_16BIT;
+		break;
+	case 4:
+		cp.mode = IBT_REG_MODE_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* regmap provides a little-endian formatted addr */
+	cp.addr = *(__le32 *)addr;
+	cp.len = val_size;
+
+	bt_dev_dbg(ctx->hdev, "Register (0x%x) read", le32_to_cpu(cp.addr));
+
+	mutex_lock(&ctx->hdev->req_lock);
+	skb = __hci_cmd_sync(ctx->hdev, ctx->op_read, sizeof(cp), &cp,
+			     HCI_CMD_TIMEOUT);
+	mutex_unlock(&ctx->hdev->req_lock);
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(ctx->hdev, "regmap: Register (0x%x) read error (%ld)",
+			   le32_to_cpu(cp.addr), PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*rp) + val_size) {
+		bt_dev_err(ctx->hdev, "regmap: Register (0x%x) read error, bad len",
+			   le32_to_cpu(cp.addr));
+		err = -EINVAL;
+		goto done;
+	}
+
+	rp = (struct ibt_rp_reg_access *)skb->data;
+
+	if (rp->addr != cp.addr) {
+		bt_dev_err(ctx->hdev, "regmap: Register (0x%x) read error, bad addr",
+			   le32_to_cpu(rp->addr));
+		err = -EINVAL;
+		goto done;
+	}
+
+	memcpy(val, rp->data, val_size);
+
+done:
+	kfree_skb(skb);
+	return err;
+}
+
+static int regmap_ibt_gather_write(void *context,
+				   const void *addr, size_t reg_size,
+				   const void *val, size_t val_size)
+{
+	struct regmap_ibt_context *ctx = context;
+	struct ibt_cp_reg_access *cp;
+	struct sk_buff *skb;
+	int plen = sizeof(*cp) + val_size;
+	u8 mode;
+	int err = 0;
+
+	if (reg_size != sizeof(__le32))
+		return -EINVAL;
+
+	switch (val_size) {
+	case 1:
+		mode = IBT_REG_MODE_8BIT;
+		break;
+	case 2:
+		mode = IBT_REG_MODE_16BIT;
+		break;
+	case 4:
+		mode = IBT_REG_MODE_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cp = kmalloc(plen, GFP_KERNEL);
+	if (!cp)
+		return -ENOMEM;
+
+	/* regmap provides a little-endian formatted addr/value */
+	cp->addr = *(__le32 *)addr;
+	cp->mode = mode;
+	cp->len = val_size;
+	memcpy(&cp->data, val, val_size);
+
+	bt_dev_dbg(ctx->hdev, "Register (0x%x) write", le32_to_cpu(cp->addr));
+
+	mutex_lock(&ctx->hdev->req_lock);
+	skb = __hci_cmd_sync(ctx->hdev, ctx->op_write, plen, cp,
+			     HCI_CMD_TIMEOUT);
+	mutex_unlock(&ctx->hdev->req_lock);
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(ctx->hdev, "regmap: Register (0x%x) write error (%ld)",
+			   le32_to_cpu(cp->addr), PTR_ERR(skb));
+		err = PTR_ERR(skb);
+		goto done;
+	}
+	kfree_skb(skb);
+
+done:
+	kfree(cp);
+	return err;
+}
+
+static int regmap_ibt_write(void *context, const void *data, size_t count)
+{
+	/* data contains register+value, since we only support 32bit addr,
+	 * minimum data size is 4 bytes.
+	 */
+	if (WARN_ONCE(count < 4, "Invalid register access"))
+		return -EINVAL;
+
+	return regmap_ibt_gather_write(context, data, 4, data + 4, count - 4);
+}
+
+static void regmap_ibt_free_context(void *context)
+{
+	kfree(context);
+}
+
+static struct regmap_bus regmap_ibt = {
+	.read = regmap_ibt_read,
+	.write = regmap_ibt_write,
+	.gather_write = regmap_ibt_gather_write,
+	.free_context = regmap_ibt_free_context,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+
+static struct regmap *__regmap_init_ibt(struct hci_dev *hdev,
+					u16 opcode_read, u16 opcode_write,
+					const struct regmap_config *config,
+					bool devm)
+{
+	struct regmap_ibt_context *ctx;
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
+	ctx->op_read = opcode_read;
+	ctx->op_write = opcode_write;
+	ctx->hdev = hdev;
+
+	if (devm)
+		return devm_regmap_init(&hdev->dev, &regmap_ibt, ctx, config);
+	else
+		return regmap_init(&hdev->dev, &regmap_ibt, ctx, config);
+}
+
+/**
+ * regmap_init_ibt(): Initialize register map
+ *
+ * @hdev: HCI Device that will be interacted with
+ * @config: Configuration for register map
+ * @opcode_read: HCI opcode command for register-read operation
+ * @opcode_write: HCI opcode command for register-write operation
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+struct regmap *regmap_init_ibt(struct hci_dev *hdev,
+			       u16 opcode_read, u16 opcode_write,
+			       const struct regmap_config *config)
+{
+	return __regmap_init_ibt(hdev, opcode_read, opcode_write, config,
+				 false);
+}
+EXPORT_SYMBOL_GPL(regmap_init_ibt);
+
+/**
+ * devm_regmap_init_ibt(): Initialize register map
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
+struct regmap *devm_regmap_init_ibt(struct hci_dev *hdev,
+				    u16 opcode_read, u16 opcode_write,
+				    const struct regmap_config *config)
+{
+	return __regmap_init_ibt(hdev, opcode_read, opcode_write, config,
+				 true);
+}
+EXPORT_SYMBOL_GPL(devm_regmap_init_ibt);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 59c55ea..af7c146 100644
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
+struct regmap *regmap_init_ibt(struct hci_dev *hdev,
+			       u16 opcode_read, u16 opcode_write,
+			       const struct regmap_config *config);
 
 struct regmap *devm_regmap_init(struct device *dev,
 				const struct regmap_bus *bus,
@@ -361,6 +365,9 @@ struct regmap *devm_regmap_init_mmio_clk(struct device *dev, const char *clk_id,
 					 const struct regmap_config *config);
 struct regmap *devm_regmap_init_ac97(struct snd_ac97 *ac97,
 				     const struct regmap_config *config);
+struct regmap *devm_regmap_init_ibt(struct hci_dev *hdev,
+				    u16 opcode_read, u16 opcode_write,
+				    const struct regmap_config *config);
 
 bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 
-- 
1.9.1
