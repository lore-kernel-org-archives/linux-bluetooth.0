Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] regmap: Add HCI support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443107584-31026-1-git-send-email-loic.poulain@intel.com>
Date: Fri, 25 Sep 2015 21:34:03 +0200
Cc: broonie@kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <21E96BB5-A2FB-4C87-BDE5-56DBFC660FDB@holtmann.org>
References: <1443107584-31026-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add HCI support to the regmap API.
> Some HCI/BT devices provide register access via their HCI interface.
> (e.g. FM registers access for Intel BT/FM combo chip)
> 
> Read/Write operations are performed via a HCI transaction composed of
> a HCI command (host->controller) followed by a HCI command complete
> event (controller->host). Read/Write Command opcodes can be specified
> to the regmap init function.
> We define data formats which are vendor specific. However, regmap-hci
> can be extended with any other implementation.
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
> Since this payload is HCI encapsulated, Little Endian byte order
> is used.
> 
> Example:
> 
> If we want to write 0x32001122 in the register 0x00001142,
> with opcode_write 0xfc58, the resulting HCI transaction will be:
>  ________ ___________ __ __ ___________
>> 58 fc 0a 42 11 00 00 02 04 22 11 00 32
>   CMD HDR   REG ADDR  MD SZ    DATA
>  ______________ __
> < 0E 04 01 58 fc 00
>    CC EVT HDR   ST
> 
> If we want to read the 32bit value stored in same register with
> opcode_read 0xfc59:
>  ________ ___________ __ __
>> 59 fc 06 42 11 00 00 02 04
>  CMD HDR    REG ADDR  MD SZ
>  ______________ __ ___________ ___________
> < 0E 0c 01 59 fc 00 04 8c 00 00 22 11 00 32
>    CC EVT HDR   ST   REG ADDR     DATA

I wonder if an augmented btmon trace would be easier to read.

> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/base/regmap/Kconfig      |   6 +-
> drivers/base/regmap/Makefile     |   1 +
> drivers/base/regmap/regmap-hci.c | 282 +++++++++++++++++++++++++++++++++++++++
> include/linux/regmap.h           |   7 +
> 4 files changed, 295 insertions(+), 1 deletion(-)
> create mode 100644 drivers/base/regmap/regmap-hci.c
> 
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index db9d00c3..b692b96 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -3,7 +3,7 @@
> # subsystems should select the appropriate symbols.
> 
> config REGMAP
> -	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
> +	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_HCI)
> 	select LZO_COMPRESS
> 	select LZO_DECOMPRESS
> 	select IRQ_DOMAIN if REGMAP_IRQ
> @@ -29,3 +29,7 @@ config REGMAP_MMIO
> 
> config REGMAP_IRQ
> 	bool
> +
> +config REGMAP_HCI
> +	tristate
> +	depends on BT
> \ No newline at end of file
> diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
> index 609e4c8..8cf31ea 100644
> --- a/drivers/base/regmap/Makefile
> +++ b/drivers/base/regmap/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
> obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
> obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
> obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
> +obj-$(CONFIG_REGMAP_HCI) += regmap-hci.o
> diff --git a/drivers/base/regmap/regmap-hci.c b/drivers/base/regmap/regmap-hci.c
> new file mode 100644
> index 0000000..bcb91a8
> --- /dev/null
> +++ b/drivers/base/regmap/regmap-hci.c
> @@ -0,0 +1,282 @@
> +/*
> + * Register map access API - HCI support

I do not think we can consider this generic HCI since at the moment I do not have enough information on what other manufactures are actually doing with their FM radio support. So lets call this regmap-ibt.c since we are actually using iBT as designation for Intel Bluetooth silicon.

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
> +#include "internal.h"
> +
> +#define DEFAULT_OP_WRITE 0xfc58
> +#define DEFAULT_OP_READ  0xfc59
> +
> +#define HCI_REG_MODE_8BIT  0x00
> +#define HCI_REG_MODE_16BIT 0x01
> +#define HCI_REG_MODE_32BIT 0x02
> +

Start here and name these IBT_REG_MODE_

> +struct regmap_hci_context {

Same here, start naming it regmap_ibt_context.

> +	struct hci_dev *hdev;
> +	__u16 op_write;
> +	__u16 op_read;
> +};
> +
> +/**
> + * HCI Command payload for register read/write
> + *
> + * @reg: Register address (32bit only)
> + * @mode: Value access mode (8bit, 16bit, 32bit)
> + * @data_len: data len to read/write
> + * @data: data to write
> + */
> +struct hci_command_reg_hdr {

Lets name this ibt_cp_reg_access.

> +	__le32  reg;

This should be addr and not reg.

> +	__u8    mode;
> +	__u8    data_len;

Just name this len and not data_len.

> +	__u8    data[0];
> +} __packed;
> +
> +/**
> + * HCI Command Complete Event payload for register read
> + *
> + * @reg: cmd read status
> + * @mode: Register address (32bit only)
> + * @data: Register value
> + */
> +struct hci_cc_reg_hdr {

And lets name this ibt_rp_reg_access.

> +	__u8    status;
> +	__le32  reg;

Also addr instead of reg here please.

> +	__u8    data[0];
> +} __packed;
> +
> +static int regmap_hci_read(void *context, const void *reg, size_t reg_size,
> +			   void *val, size_t val_size)
> +{
> +	struct regmap_hci_context *ctx = context;
> +	struct hci_dev *hdev = ctx->hdev;

Don't bother with this. Keep calling ctx->hdev for the functions that need it.

> +	struct sk_buff *skb;
> +	struct hci_command_reg_hdr hdr;

Lets name this cp instead of hdr.

> +	struct hci_cc_reg_hdr *cc;

And this would be rp.

> +
> +	if (reg_size != sizeof(__le32))
> +		return -EINVAL;
> +
> +	switch (val_size) {
> +	case 1:
> +		hdr.mode = HCI_REG_MODE_8BIT;
> +		break;
> +	case 2:
> +		hdr.mode = HCI_REG_MODE_16BIT;
> +		break;
> +	case 4:
> +		hdr.mode = HCI_REG_MODE_32BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	hdr.reg = *(__le32 *)reg;

How is this correct? You are missing an endian conversion here. Unless there is some regmap magic I am missing.

> +	hdr.data_len = val_size;
> +
> +	bt_dev_dbg(hdev, "regmap: Read register 0x%x", hdr.reg);

bt_dev_dbg uses dynamic debug and can include the function name. So the regmap: seems a bit pointless here.

> +
> +	skb = __hci_cmd_sync(hdev, ctx->op_read, sizeof(hdr), &hdr,
> +			     HCI_CMD_TIMEOUT);

The __hci_cmd_sync call requires the HCI request lock to be hold. For things like hdev->setup, the core does that for you. However since I assume this is used from outside the HCI driver, this should grab the lock.

> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "regmap: Read error, command failure");

Rephrase this to say something like register read error and give the register number and error code.

> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*cc) + val_size) {
> +		bt_dev_err(hdev, "regmap: Read error, unexpected pkt len");
> +		kfree_skb(skb);
> +		return -EINVAL;

Instead of repeating kfree_skb, I would use an error variable and a goto label.

> +	}
> +
> +	cc = (struct hci_cc_reg_hdr *)skb->data;
> +
> +	if (cc->reg != hdr.reg) {
> +		bt_dev_err(hdev, "regmap: Read error, Invalid register 0x%x",
> +			   le32_to_cpu(cc->reg));
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(val, cc->data, val_size);
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +static int regmap_hci_gather_write(void *context,
> +				   const void *reg, size_t reg_size,
> +				   const void *val, size_t val_size)
> +{
> +	struct regmap_hci_context *ctx = context;
> +	struct hci_dev *hdev = ctx->hdev;
> +	struct sk_buff *skb;
> +	struct hci_command_reg_hdr *hdr;
> +	int plen = sizeof(*hdr) + val_size;
> +	u8 mode;
> +
> +	if (reg_size != sizeof(__le32))
> +		return -EINVAL;
> +
> +	switch (val_size) {
> +	case 1:
> +		mode = HCI_REG_MODE_8BIT;
> +		break;
> +	case 2:
> +		mode = HCI_REG_MODE_16BIT;
> +		break;
> +	case 4:
> +		mode = HCI_REG_MODE_32BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	hdr = kmalloc(plen, GFP_KERNEL);
> +	if (!hdr)
> +		return -ENOMEM;
> +
> +	hdr->reg = *(__le32 *)reg;

Same as above, I think this needs to be converted from host endian. So the cast should be into __u32 and then converted into little endian.

> +	hdr->mode = mode;
> +	hdr->data_len = val_size;
> +	memcpy(&hdr->data, val, val_size);
> +
> +	bt_dev_dbg(hdev, "regmap: Write register 0x%x", hdr->reg);
> +
> +	skb = __hci_cmd_sync(hdev, ctx->op_write, plen, hdr, HCI_CMD_TIMEOUT);

Why not kfree(hdr) here.

> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "regmap: Write error, command failure");
> +		kfree(hdr);
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	kfree(hdr);
> +
> +	return 0;
> +}
> +
> +static int regmap_hci_write(void *context, const void *data, size_t count)
> +{
> +	BUG_ON(count < 4);

Can we add a comment here on why this is a BUG_ON? Wouldn't be a WARN_ONCE and returning an error be better? BUG_ON is a huge hammer approach here.

> +	return regmap_hci_gather_write(context, data, 4, data + 4, count - 4);
> +}
> +
> +void regmap_hci_free_context(void *context)
> +{
> +	kfree(context);
> +}

Why is this not static?

> +
> +static struct regmap_bus regmap_hci_default = {
> +	.read = regmap_hci_read,
> +	.write = regmap_hci_write,
> +	.gather_write = regmap_hci_gather_write,
> +	.free_context = regmap_hci_free_context,
> +	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
> +};

Maybe you have to scrap my two comments about endianess above if regmap does that for us. However, then I prefer we add a small comment above *(__le32*) cast to not keep stumbling over it.

> +
> +/**
> + * regmap_init_hci(): Initialise register map
> + *
> + * @hdev: HCI Device that will be interacted with
> + * @config: Configuration for register map
> + * @opcode_read: HCI opcode command for register-read operation
> + * @opcode_write: HCI opcode command for register-write operation
> + *
> + * The return value will be an ERR_PTR() on error or a valid pointer to
> + * a struct regmap.
> + */
> +static struct regmap *__regmap_init_hci(struct hci_dev *hdev,
> +					u16 opcode_read, u16 opcode_write,
> +					const struct regmap_config *config,
> +					bool devm)
> +{
> +	struct regmap_hci_context *ctx;
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
> +	ctx->op_read = opcode_read ? opcode_read : DEFAULT_OP_READ;
> +	ctx->op_write = opcode_write ? opcode_write : DEFAULT_OP_WRITE;

I do not like this actually. Right now we always have read and write operations defined for core and top register sets. So if any of these is not specified, just return EINVAL and not try to use defaults.

> +	ctx->hdev = hdev;
> +
> +	if (devm)
> +		return devm_regmap_init(&hdev->dev, &regmap_hci_default, ctx,
> +					config);
> +	else
> +		return regmap_init(&hdev->dev, &regmap_hci_default, ctx,
> +				   config);
> +}
> +
> +/**
> + * regmap_init_hci(): Initialise register map

I prefer if you use the american english initialize.

> + *
> + * @hdev: HCI Device that will be interacted with
> + * @config: Configuration for register map
> + * @opcode_read: HCI opcode command for register-read operation
> + * @opcode_write: HCI opcode command for register-write operation
> + *
> + * The return value will be an ERR_PTR() on error or a valid pointer to
> + * a struct regmap.
> + */
> +struct regmap *regmap_init_hci(struct hci_dev *hdev,
> +			       u16 opcode_read, u16 opcode_write,
> +			       const struct regmap_config *config)
> +{
> +	return __regmap_init_hci(hdev, opcode_read, opcode_write, config,
> +				 false);
> +}
> +EXPORT_SYMBOL_GPL(regmap_init_hci);
> +
> +/**
> + * devm_regmap_init_hci(): Initialise register map
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
> +struct regmap *devm_regmap_init_hci(struct hci_dev *hdev,
> +				    u16 opcode_read, u16 opcode_write,
> +				    const struct regmap_config *config)
> +{
> +	return __regmap_init_hci(hdev, opcode_read, opcode_write, config,
> +				 true);
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_init_hci);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 59c55ea..8a2823b 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -28,6 +28,7 @@ struct regmap;
> struct regmap_range_cfg;
> struct regmap_field;
> struct snd_ac97;
> +struct hci_dev;
> 
> /* An enum of all the supported cache types */
> enum regcache_type {
> @@ -343,6 +344,9 @@ struct regmap *regmap_init_mmio_clk(struct device *dev, const char *clk_id,
> 				    const struct regmap_config *config);
> struct regmap *regmap_init_ac97(struct snd_ac97 *ac97,
> 				const struct regmap_config *config);
> +struct regmap *regmap_init_hci(struct hci_dev *hdev,
> +			       u16 opcode_read, u16 opcode_write,
> +			       const struct regmap_config *config);

So here it should be regmap_init_ibt to make it to an Intel specific register mapping.

> 
> struct regmap *devm_regmap_init(struct device *dev,
> 				const struct regmap_bus *bus,
> @@ -361,6 +365,9 @@ struct regmap *devm_regmap_init_mmio_clk(struct device *dev, const char *clk_id,
> 					 const struct regmap_config *config);
> struct regmap *devm_regmap_init_ac97(struct snd_ac97 *ac97,
> 				     const struct regmap_config *config);
> +struct regmap *devm_regmap_init_hci(struct hci_dev *hdev,
> +				    u16 opcode_read, u16 opcode_write,
> +				    const struct regmap_config *config);

Same as above, use ibt instead of hci.

> 
> bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);

Regards

Marcel

