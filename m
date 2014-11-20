Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RESEND PATCH v3] Bluetooth: btmrvl add firmware dump support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416498414-9583-1-git-send-email-akarwar@marvell.com>
Date: Fri, 21 Nov 2014 00:06:52 +0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Xinming Hu <huxm@marvell.com>, Cathy Luo <cluo@marvell.com>,
	Avinash Patil <patila@marvell.com>
Message-Id: <1596A22A-E632-4C05-9233-3907AE41EBCE@holtmann.org>
References: <1416498414-9583-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This patch adds firmware dump support for marvell
> bluetooth chipset. Currently only SD8897 is supported.
> This is implemented based on dev_coredump, a new mechnism
> introduced in kernel 3.18rc3
> 
> Firmware dump can be trigger by
> echo 1 > /sys/kernel/debug/bluetooth/hci*/config/fw_dump
> and when the dump operation is completed, data can be read by
> cat /sys/class/devcoredump/devcd*/data
> 
> We have prepared following script to divide fw memory
> dump data into multiple files based on memory type.
> 
> [root]# cat btmrvl_split_dump_data.sh
> #!/bin/bash
> # usage: ./btmrvl_split_dump_data.sh dump_data
> 
> fw_dump_data=$1
> 
> mem_type="ITCM DTCM SQRAM APU CIU ICU MAC EXT7 EXT8 EXT9 EXT10 EXT11 EXT12 EXT13 EXTLAST"
> 
> for name in ${mem_type[@]}
> do
>         sed -n "/Start dump $name/,/End dump/p" $fw_dump_data  > tmp.$name.log
>         if [ ! -s tmp.$name.log ]
>                 then
>                         rm -rf tmp.$name.log
>                 else
>                         # Remove the describle info "Start dump" and "End dump"
>                         sed '1d' tmp.$name.log | sed '$d' > /data/$name.log
>                         if [ -s /data/$name.log ]
>                         then
>                                 echo "generate /data/$name.log"
>                         else
>                                 sed '1d' tmp.$name.log | sed '$d' > /var/$name.log
>                                 echo "generate /var/$name.log"
>                         fi
>                         rm -rf tmp.$name.log
>         fi
> done
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Cathy Luo <cluo@marvell.com>
> Signed-off-by: Avinash Patil <patila@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> v2: Add "select WANT_DEV_COREDUMP" in Kconfig
>    Use write debugfs command instead of read to trigger dump operation.
> v3: Change fw_dump debugfs file permissions to write only
>    Replace kstrtol with strtobool
> ---
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/Kconfig          |   1 +
> drivers/bluetooth/btmrvl_debugfs.c |  31 ++++
> drivers/bluetooth/btmrvl_drv.h     |  21 +++
> drivers/bluetooth/btmrvl_main.c    |   9 ++
> drivers/bluetooth/btmrvl_sdio.c    | 299 +++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btmrvl_sdio.h    |   5 +
> 6 files changed, 366 insertions(+)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4547dc2..364f080 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -210,6 +210,7 @@ config BT_MRVL_SDIO
> 	tristate "Marvell BT-over-SDIO driver"
> 	depends on BT_MRVL && MMC
> 	select FW_LOADER
> +	select WANT_DEV_COREDUMP
> 	help
> 	  The driver for Marvell Bluetooth chipsets with SDIO interface.
> 
> diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
> index 023d35e..0118913 100644
> --- a/drivers/bluetooth/btmrvl_debugfs.c
> +++ b/drivers/bluetooth/btmrvl_debugfs.c
> @@ -167,6 +167,35 @@ static const struct file_operations btmrvl_hscmd_fops = {
> 	.llseek = default_llseek,
> };
> 
> +static ssize_t btmrvl_fwdump_write(struct file *file, const char __user *ubuf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct btmrvl_private *priv = file->private_data;
> +	char buf[16];
> +	bool result;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (strtobool(buf, &result))
> +		return -EINVAL;
> +
> +	if (result)
> +		btmrvl_firmware_dump(priv);
> +	else
> +		return -EINVAL;

lets turn this around.

	if (!result)
		return -EINVAL;

	btmrvl_firmware_dump(priv);

Doing it this way makes it a lot easier to read.

> +
> +	return count;
> +}
> +
> +static const struct file_operations btmrvl_fwdump_fops = {
> +	.write	= btmrvl_fwdump_write,
> +	.open	= simple_open,
> +	.llseek = default_llseek,
> +};
> +
> void btmrvl_debugfs_init(struct hci_dev *hdev)
> {
> 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
> @@ -197,6 +226,8 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
> 			    priv, &btmrvl_hscmd_fops);
> 	debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
> 			    priv, &btmrvl_hscfgcmd_fops);
> +	debugfs_create_file("fw_dump", 0200, dbg->config_dir,
> +			    priv, &btmrvl_fwdump_fops);
> 
> 	dbg->status_dir = debugfs_create_dir("status", hdev->debugfs);
> 	debugfs_create_u8("curpsmode", 0444, dbg->status_dir,
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
> index 38ad662..389e6f1 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -22,6 +22,7 @@
> #include <linux/kthread.h>
> #include <linux/bitops.h>
> #include <linux/slab.h>
> +#include <linux/devcoredump.h>

I overlooked this before. Why does this include need to be in the header file?

> #include <net/bluetooth/bluetooth.h>
> 
> #define BTM_HEADER_LEN			4
> @@ -32,6 +33,24 @@
> /* Time to wait for command response in millisecond */
> #define WAIT_UNTIL_CMD_RESP		5000
> 
> +enum rdwr_status {
> +	RDWR_STATUS_SUCCESS = 0,
> +	RDWR_STATUS_FAILURE = 1,
> +	RDWR_STATUS_DONE = 2
> +};
> +
> +#define FW_DUMP_MAX_NAME_LEN    8
> +#define FW_DUMP_HOST_READY      0xEE
> +#define FW_DUMP_DONE            0xFF
> +#define FW_DUMP_READ_DONE       0xFE
> +
> +struct memory_type_mapping {
> +	u8 mem_name[FW_DUMP_MAX_NAME_LEN];
> +	u8 *mem_ptr;
> +	u32 mem_size;
> +	u8 done_flag;
> +};
> +
> struct btmrvl_thread {
> 	struct task_struct *task;
> 	wait_queue_head_t wait_q;
> @@ -81,6 +100,7 @@ struct btmrvl_private {
> 				u8 *payload, u16 nb);
> 	int (*hw_wakeup_firmware) (struct btmrvl_private *priv);
> 	int (*hw_process_int_status) (struct btmrvl_private *priv);
> +	void (*firmware_dump)(struct btmrvl_private *priv);
> 	spinlock_t driver_lock;		/* spinlock used by driver */
> #ifdef CONFIG_DEBUG_FS
> 	void *debugfs_data;
> @@ -151,6 +171,7 @@ int btmrvl_send_hscfg_cmd(struct btmrvl_private *priv);
> int btmrvl_enable_ps(struct btmrvl_private *priv);
> int btmrvl_prepare_command(struct btmrvl_private *priv);
> int btmrvl_enable_hs(struct btmrvl_private *priv);
> +void btmrvl_firmware_dump(struct btmrvl_private *priv);
> 
> #ifdef CONFIG_DEBUG_FS
> void btmrvl_debugfs_init(struct hci_dev *hdev);
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index bb0d2c2..90b1b44 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -22,6 +22,7 @@
> #include <linux/of.h>
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> +#include <linux/mmc/sdio_func.h>
> 
> #include "btmrvl_drv.h"
> #include "btmrvl_sdio.h"
> @@ -335,6 +336,14 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
> 	return ret;
> }
> 
> +void btmrvl_firmware_dump(struct btmrvl_private *priv)
> +{
> +	if (priv->firmware_dump)
> +		priv->firmware_dump(priv);
> +	else
> +		BT_ERR("firmware dump error : not defined!\n");
> +}

Actually coming to think about it, it would be better to not expose the debugfs entry if the firmware_dump callback is not defined. Is it possible to change that code that way?

> +
> static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
> {
> 	int ret = 0;
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 550bce0..c76d8c8 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -33,6 +33,24 @@
> 
> #define VERSION "1.0"
> 
> +static struct memory_type_mapping mem_type_mapping_tbl[] = {
> +	{"ITCM", NULL, 0, 0xF0},
> +	{"DTCM", NULL, 0, 0xF1},
> +	{"SQRAM", NULL, 0, 0xF2},
> +	{"APU", NULL, 0, 0xF3},
> +	{"CIU", NULL, 0, 0xF4},
> +	{"ICU", NULL, 0, 0xF5},
> +	{"MAC", NULL, 0, 0xF6},
> +	{"EXT7", NULL, 0, 0xF7},
> +	{"EXT8", NULL, 0, 0xF8},
> +	{"EXT9", NULL, 0, 0xF9},
> +	{"EXT10", NULL, 0, 0xFA},
> +	{"EXT11", NULL, 0, 0xFB},
> +	{"EXT12", NULL, 0, 0xFC},
> +	{"EXT13", NULL, 0, 0xFD},
> +	{"EXTLAST", NULL, 0, 0xFE},
> +};
> +
> /* The btmrvl_sdio_remove() callback function is called
>  * when user removes this module from kernel space or ejects
>  * the card from the slot. The driver handles these 2 cases
> @@ -122,6 +140,9 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_8897 = {
> 	.int_read_to_clear = true,
> 	.host_int_rsr = 0x01,
> 	.card_misc_cfg = 0xcc,
> +	.fw_dump_ctrl = 0xe2,
> +	.fw_dump_start = 0xe3,
> +	.fw_dump_end = 0xea,
> };
> 
> static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
> @@ -130,6 +151,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
> 	.reg		= &btmrvl_reg_8688,
> 	.support_pscan_win_report = false,
> 	.sd_blksz_fw_dl	= 64,
> +	.supports_fw_dump = false,
> };
> 
> static const struct btmrvl_sdio_device btmrvl_sdio_sd8787 = {
> @@ -138,6 +160,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8787 = {
> 	.reg		= &btmrvl_reg_87xx,
> 	.support_pscan_win_report = false,
> 	.sd_blksz_fw_dl	= 256,
> +	.supports_fw_dump = false,
> };
> 
> static const struct btmrvl_sdio_device btmrvl_sdio_sd8797 = {
> @@ -146,6 +169,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8797 = {
> 	.reg		= &btmrvl_reg_87xx,
> 	.support_pscan_win_report = false,
> 	.sd_blksz_fw_dl	= 256,
> +	.supports_fw_dump = false,
> };
> 
> static const struct btmrvl_sdio_device btmrvl_sdio_sd8887 = {
> @@ -154,6 +178,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8887 = {
> 	.reg		= &btmrvl_reg_8887,
> 	.support_pscan_win_report = true,
> 	.sd_blksz_fw_dl	= 256,
> +	.supports_fw_dump = false,
> };
> 
> static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
> @@ -162,6 +187,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
> 	.reg		= &btmrvl_reg_8897,
> 	.support_pscan_win_report = true,
> 	.sd_blksz_fw_dl	= 256,
> +	.supports_fw_dump = true,
> };
> 
> static const struct sdio_device_id btmrvl_sdio_ids[] = {
> @@ -1080,6 +1106,277 @@ static int btmrvl_sdio_wakeup_fw(struct btmrvl_private *priv)
> 	return ret;
> }
> 
> +static void btmrvl_sdio_dump_regs(struct btmrvl_private *priv)
> +{
> +	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
> +	int ret = 0;
> +	unsigned int reg, reg_start, reg_end;
> +	char buf[256], *ptr;
> +	u8 loop, func, data;
> +	int MAX_LOOP = 2;
> +
> +	btmrvl_sdio_wakeup_fw(priv);
> +	sdio_claim_host(card->func);
> +
> +	for (loop = 0; loop < MAX_LOOP; loop++) {
> +		memset(buf, 0, sizeof(buf));
> +		ptr = buf;
> +
> +		if (loop == 0) {
> +			/* Read the registers of SDIO function0 */
> +			func = loop;
> +			reg_start = 0;
> +			reg_end = 9;
> +		} else {
> +			func = 2;
> +			reg_start = 0;
> +			reg_end = 0x09;
> +		}
> +
> +		ptr += sprintf(ptr, "SDIO Func%d (%#x-%#x): ",
> +			       func, reg_start, reg_end);
> +		for (reg = reg_start; reg <= reg_end; reg++) {
> +			if (func == 0)
> +				data = sdio_f0_readb(card->func, reg, &ret);
> +			else
> +				data = sdio_readb(card->func, reg, &ret);
> +
> +			if (!ret) {
> +				ptr += sprintf(ptr, "%02x ", data);
> +			} else {
> +				ptr += sprintf(ptr, "ERR");
> +				break;
> +			}
> +		}
> +
> +		BT_INFO("%s\n", buf);

I do not think that BT_INFO etc. functions need the \n at the end. You might want to fix that in the code for all places.

Regards

Marcel

