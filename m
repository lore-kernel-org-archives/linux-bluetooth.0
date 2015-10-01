Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: btintel: Add iBT register access over HCI support
Date: Thu,  1 Oct 2015 18:16:21 +0200
Message-Id: <1443716181-19050-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add regmap ibt to support Intel Bluetooth silicon register access
over HCI. Intel BT/FM combo chip allows to read/write some registers
(e.g. FM registers) via its HCI interface.

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
 drivers/bluetooth/Kconfig   |   1 +
 drivers/bluetooth/btintel.c | 195 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |   9 ++
 3 files changed, 205 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 0bd88c9..1c6a300 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -4,6 +4,7 @@ menu "Bluetooth device drivers"
 
 config BT_INTEL
 	tristate
+	select REGMAP
 
 config BT_BCM
 	tristate
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9e18988..d82c49f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -23,6 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/regmap.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -215,6 +216,200 @@ int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
 }
 EXPORT_SYMBOL_GPL(btintel_load_ddc_config);
 
+/* ------- REGMAP IBT SUPPORT ------- */
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
+struct ibt_cp_reg_access {
+	__le32  addr;
+	__u8    mode;
+	__u8    len;
+	__u8    data[0];
+} __packed;
+
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
+	skb = hci_cmd_sync(ctx->hdev, ctx->op_read, sizeof(cp), &cp,
+			   HCI_CMD_TIMEOUT);
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
+	skb = hci_cmd_sync(ctx->hdev, ctx->op_write, plen, cp, HCI_CMD_TIMEOUT);
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
+/* Config is the same for all register regions */
+static const struct regmap_config regmap_ibt_cfg = {
+	.name      = "btintel_regmap",
+	.reg_bits  = 32,
+	.val_bits  = 32,
+};
+
+struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
+				   u16 opcode_write)
+{
+	struct regmap_ibt_context *ctx;
+
+	bt_dev_info(hdev, "regmap: Init R%x-W%x region", opcode_read,
+		    opcode_write);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->op_read = opcode_read;
+	ctx->op_write = opcode_write;
+	ctx->hdev = hdev;
+
+	return regmap_init(&hdev->dev, &regmap_ibt, ctx, &regmap_ibt_cfg);
+}
+EXPORT_SYMBOL_GPL(btintel_regmap_init);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 52deaf2..f0655c4 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -80,6 +80,9 @@ int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
 
+struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
+				   u16 opcode_write);
+
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -113,4 +116,10 @@ static inline int btintel_load_ddc_config(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
+						 u16 opcode_read,
+						 u16 opcode_write)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif
-- 
1.9.1
