Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: Add iBT register access over HCI support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443546153-16405-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 30 Sep 2015 14:03:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1E1C0ED2-8AC2-4F38-881B-6FFBB13BF3E0@holtmann.org>
References: <1443546153-16405-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add regmap-ibt to support Intel Bluetooth silicon register access
> over HCI. Intel BT/FM combo chip allows to read/write some registers
> (e.g. FM registers) via its HCI interface.
> 
> Read/Write operations are performed via a HCI transaction composed of
> a HCI command (host->controller) followed by a HCI command complete
> event (controller->host). Read/Write Command opcodes can be specified
> to the regmap init function.
> We define data formats which are intel/vendor specific.
> 
> Register Read/Write HCI command payload (Host):
> Field: | REG ADDR | MODE | DATA_LEN | DATA... |
> size:  |   32b    |  8b  |    8b    |  8b*    |
> 
> Register Read HCI command complete event payload (Controller):
> Field: | CMD STATUS | REG ADDR | DATA... |
> size:  |     8b     |   32b    |  8b*    |
> 
> Register Write HCI command complete event payload (Controller):
> Field: | CMD_STATUS |
> size:  |     8b     |
> 
> Since this payload is HCI encapsulated, Little Endian byte order is
> used.
> 
> Write/Read Example:
> 
> If we write 0x0000002a at address 0x00008c04, with opcode_write 0xfc5d,
> The resulting transaction is (btmon trace):
> 
> < HCI Command (0x3f|0x005d) plen 10 [hci0]
>        04 8c 00 00 02 04 2a 00 00 00
>> HCI Event (0x0e) plen 4
>      Unknown (0x3f|0x005d) ncmd 1
>        00
> 
> Then, if we read the same register with opcode_read 0xfc5e:
> 
> < HCI Command (0x3f|0x005e) plen 6 [hci0]
>        04 8c 00 00 02 04
>> HCI Event (0x0e) plen 12 [hci0]
>      Unknown (0x3f|0x005e) ncmd 1
>        00 04 8c 00 00 2a 00 00 00
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/Kconfig      |   4 +
> drivers/bluetooth/Makefile     |   2 +
> drivers/bluetooth/regmap-ibt.c | 276 +++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/regmap-ibt.h |  17 +++
> 4 files changed, 299 insertions(+)
> create mode 100644 drivers/bluetooth/regmap-ibt.c
> create mode 100644 drivers/bluetooth/regmap-ibt.h
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 0bd88c9..c05e928 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -5,6 +5,10 @@ menu "Bluetooth device drivers"
> config BT_INTEL
> 	tristate
> 
> +config BT_REGMAP_INTEL
> +	select REGMAP
> +	tristate
> +
> config BT_BCM
> 	tristate
> 	select FW_LOADER
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 07c9cf3..cd399a9 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -24,6 +24,8 @@ obj-$(CONFIG_BT_BCM)		+= btbcm.o
> obj-$(CONFIG_BT_RTL)		+= btrtl.o
> obj-$(CONFIG_BT_QCA)		+= btqca.o
> 
> +obj-$(CONFIG_BT_REGMAP_INTEL)	+= regmap-ibt.o
> +

with the mandate to keep this Bluetooth specific and looking at the btintel module again, I am getting the feeling that we should not introduce yet another module.

Instead we should just trim this down and only provide the pieces that we need for the FM radio driver. I went along when this code was a bit more generic, but since we are making it Intel and Bluetooth specific, lets only expose things we need. And if we need more we add or change it later.

So lets merge this into btintel.c and see how that goes. We can always later take it back out if this becomes to heavy.

> btmrvl-y			:= btmrvl_main.o
> btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
> 
> diff --git a/drivers/bluetooth/regmap-ibt.c b/drivers/bluetooth/regmap-ibt.c
> new file mode 100644
> index 0000000..e3682f7
> --- /dev/null
> +++ b/drivers/bluetooth/regmap-ibt.c
> @@ -0,0 +1,276 @@
> +/*
> + * Register map access API - iBT support
> + *
> + * Copyright 2015 Intel Corporation
> + *
> + * Author: Loic Poulain <loic.poulain@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/regmap.h>
> +#include <linux/module.h>
> +#include <linux/skbuff.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "regmap-ibt.h"
> +
> +#define IBT_REG_MODE_8BIT  0x00
> +#define IBT_REG_MODE_16BIT 0x01
> +#define IBT_REG_MODE_32BIT 0x02
> +
> +struct regmap_ibt_context {
> +	struct hci_dev *hdev;
> +	__u16 op_write;
> +	__u16 op_read;
> +};
> +
> +/**
> + * HCI Command payload for register read/write
> + *
> + * @raddr: Register address (32bit only)
> + * @mode: Value access mode (8bit, 16bit, 32bit)
> + * @len: Data len to read/write
> + * @data: Data to write
> + */
> +struct ibt_cp_reg_access {
> +	__le32  addr;
> +	__u8    mode;
> +	__u8    len;
> +	__u8    data[0];
> +} __packed;
> +
> +/**
> + * HCI Command Complete Event payload for register read
> + *
> + * @status: cmd read status
> + * @addr: Register address (32bit only)
> + * @data: Register value
> + */
> +struct ibt_rp_reg_access {
> +	__u8    status;
> +	__le32  addr;
> +	__u8    data[0];
> +} __packed;
> +
> +static int regmap_ibt_read(void *context, const void *addr, size_t reg_size,
> +			   void *val, size_t val_size)
> +{
> +	struct regmap_ibt_context *ctx = context;
> +	struct ibt_cp_reg_access cp;
> +	struct ibt_rp_reg_access *rp;
> +	struct sk_buff *skb;
> +	int err = 0;
> +
> +	if (reg_size != sizeof(__le32))
> +		return -EINVAL;
> +
> +	switch (val_size) {
> +	case 1:
> +		cp.mode = IBT_REG_MODE_8BIT;
> +		break;
> +	case 2:
> +		cp.mode = IBT_REG_MODE_16BIT;
> +		break;
> +	case 4:
> +		cp.mode = IBT_REG_MODE_32BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* regmap provides a little-endian formatted addr */
> +	cp.addr = *(__le32 *)addr;
> +	cp.len = val_size;
> +
> +	bt_dev_dbg(ctx->hdev, "Register (0x%x) read", le32_to_cpu(cp.addr));
> +
> +	skb = hci_cmd_sync(ctx->hdev, ctx->op_read, sizeof(cp), &cp,
> +			   HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(ctx->hdev, "regmap: Register (0x%x) read error (%ld)",
> +			   le32_to_cpu(cp.addr), PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*rp) + val_size) {
> +		bt_dev_err(ctx->hdev, "regmap: Register (0x%x) read error, bad len",
> +			   le32_to_cpu(cp.addr));
> +		err = -EINVAL;
> +		goto done;
> +	}
> +
> +	rp = (struct ibt_rp_reg_access *)skb->data;
> +
> +	if (rp->addr != cp.addr) {
> +		bt_dev_err(ctx->hdev, "regmap: Register (0x%x) read error, bad addr",
> +			   le32_to_cpu(rp->addr));
> +		err = -EINVAL;
> +		goto done;
> +	}
> +
> +	memcpy(val, rp->data, val_size);
> +
> +done:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
> +static int regmap_ibt_gather_write(void *context,
> +				   const void *addr, size_t reg_size,
> +				   const void *val, size_t val_size)
> +{
> +	struct regmap_ibt_context *ctx = context;
> +	struct ibt_cp_reg_access *cp;
> +	struct sk_buff *skb;
> +	int plen = sizeof(*cp) + val_size;
> +	u8 mode;
> +	int err = 0;
> +
> +	if (reg_size != sizeof(__le32))
> +		return -EINVAL;
> +
> +	switch (val_size) {
> +	case 1:
> +		mode = IBT_REG_MODE_8BIT;
> +		break;
> +	case 2:
> +		mode = IBT_REG_MODE_16BIT;
> +		break;
> +	case 4:
> +		mode = IBT_REG_MODE_32BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	cp = kmalloc(plen, GFP_KERNEL);
> +	if (!cp)
> +		return -ENOMEM;
> +
> +	/* regmap provides a little-endian formatted addr/value */
> +	cp->addr = *(__le32 *)addr;
> +	cp->mode = mode;
> +	cp->len = val_size;
> +	memcpy(&cp->data, val, val_size);
> +
> +	bt_dev_dbg(ctx->hdev, "Register (0x%x) write", le32_to_cpu(cp->addr));
> +
> +	skb = hci_cmd_sync(ctx->hdev, ctx->op_write, plen, cp, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(ctx->hdev, "regmap: Register (0x%x) write error (%ld)",
> +			   le32_to_cpu(cp->addr), PTR_ERR(skb));
> +		err = PTR_ERR(skb);
> +		goto done;
> +	}
> +	kfree_skb(skb);
> +
> +done:
> +	kfree(cp);
> +	return err;
> +}
> +
> +static int regmap_ibt_write(void *context, const void *data, size_t count)
> +{
> +	/* data contains register+value, since we only support 32bit addr,
> +	 * minimum data size is 4 bytes.
> +	 */
> +	if (WARN_ONCE(count < 4, "Invalid register access"))
> +		return -EINVAL;
> +
> +	return regmap_ibt_gather_write(context, data, 4, data + 4, count - 4);
> +}
> +
> +static void regmap_ibt_free_context(void *context)
> +{
> +	kfree(context);
> +}
> +
> +static struct regmap_bus regmap_ibt = {
> +	.read = regmap_ibt_read,
> +	.write = regmap_ibt_write,
> +	.gather_write = regmap_ibt_gather_write,
> +	.free_context = regmap_ibt_free_context,
> +	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static struct regmap *__regmap_init_ibt(struct hci_dev *hdev,
> +					u16 opcode_read, u16 opcode_write,
> +					const struct regmap_config *config,
> +					bool devm)
> +{
> +	struct regmap_ibt_context *ctx;
> +
> +	if (!config)
> +		return ERR_PTR(-EINVAL);
> +
> +	bt_dev_info(hdev, "regmap: Init %s-R%x-W%x region", config->name,
> +		    opcode_read, opcode_write);
> +
> +	if (config->reg_bits != 32) {
> +		bt_dev_err(hdev, "regmap: Unsupported address size: %d",
> +			   config->reg_bits);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctx->op_read = opcode_read;
> +	ctx->op_write = opcode_write;
> +	ctx->hdev = hdev;
> +
> +	if (devm)
> +		return devm_regmap_init(&hdev->dev, &regmap_ibt, ctx, config);
> +	else
> +		return regmap_init(&hdev->dev, &regmap_ibt, ctx, config);
> +}
> +
> +/**
> + * regmap_init_ibt(): Initialize register map
> + *
> + * @hdev: HCI Device that will be interacted with
> + * @config: Configuration for register map
> + * @opcode_read: HCI opcode command for register-read operation
> + * @opcode_write: HCI opcode command for register-write operation
> + *
> + * The return value will be an ERR_PTR() on error or a valid pointer to
> + * a struct regmap.
> + */
> +struct regmap *regmap_init_ibt(struct hci_dev *hdev,
> +			       u16 opcode_read, u16 opcode_write,
> +			       const struct regmap_config *config)
> +{
> +	return __regmap_init_ibt(hdev, opcode_read, opcode_write, config,
> +				 false);
> +}
> +EXPORT_SYMBOL_GPL(regmap_init_ibt);
> +
> +/**
> + * devm_regmap_init_ibt(): Initialize register map
> + *
> + * @hdev: HCI Device that will be interacted with
> + * @config: Configuration for register map
> + * @opcode_read: HCI opcode command for register-read operation
> + * @opcode_write: HCI opcode command for register-write operation
> + *
> + * The return value will be an ERR_PTR() on error or a valid pointer
> + * to a struct regmap. The regmap will be automatically freed by the
> + * device management code.
> + */
> +struct regmap *devm_regmap_init_ibt(struct hci_dev *hdev,
> +				    u16 opcode_read, u16 opcode_write,
> +				    const struct regmap_config *config)
> +{
> +	return __regmap_init_ibt(hdev, opcode_read, opcode_write, config,
> +				 true);
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_init_ibt);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/bluetooth/regmap-ibt.h b/drivers/bluetooth/regmap-ibt.h
> new file mode 100644
> index 0000000..afab382
> --- /dev/null
> +++ b/drivers/bluetooth/regmap-ibt.h
> @@ -0,0 +1,17 @@
> +/*
> + * Register map access API - iBT support
> + *
> + * Copyright 2015 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +struct regmap *regmap_init_ibt(struct hci_dev *hdev,
> +			       u16 opcode_read, u16 opcode_write,
> +			       const struct regmap_config *config);
> +
> +struct regmap *devm_regmap_init_ibt(struct hci_dev *hdev,
> +				    u16 opcode_read, u16 opcode_write,
> +				    const struct regmap_config *config);

Which ones of these two do we really need. I would prefer if we simplify this and only expose the one you are planning to use.

And then lets do btintel_regmap_init as name. And provide a dummy wrapper in case CONFIG_BT_INTEL is not selected.

Regards

Marcel

