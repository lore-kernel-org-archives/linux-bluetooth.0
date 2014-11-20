Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] Bluetooth: btmrvl add firmware dump support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416478065-5678-1-git-send-email-akarwar@marvell.com>
Date: Thu, 20 Nov 2014 22:05:49 +0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Xinming Hu <huxm@marvell.com>, Cathy Luo <cluo@marvell.com>,
	Avinash Patil <patila@marvell.com>
Message-Id: <56E9D4AD-8014-4261-BEE8-11A40C206A42@holtmann.org>
References: <1416478065-5678-1-git-send-email-akarwar@marvell.com>
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
> ---
> v2: Addressed below comments from Johannes.
> Add "select WANT_DEV_COREDUMP" in Kconfig
> Use write debugfs command instead of read to trigger dump operation.
> ---
> drivers/bluetooth/Kconfig          |   1 +
> drivers/bluetooth/btmrvl_debugfs.c |  30 ++++
> drivers/bluetooth/btmrvl_drv.h     |  21 +++
> drivers/bluetooth/btmrvl_main.c    |   9 ++
> drivers/bluetooth/btmrvl_sdio.c    | 299 +++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btmrvl_sdio.h    |   5 +
> 6 files changed, 365 insertions(+)
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
> index 023d35e..53c83db 100644
> --- a/drivers/bluetooth/btmrvl_debugfs.c
> +++ b/drivers/bluetooth/btmrvl_debugfs.c
> @@ -167,6 +167,34 @@ static const struct file_operations btmrvl_hscmd_fops = {
> 	.llseek = default_llseek,
> };
> 
> +static ssize_t btmrvl_fwdump_write(struct file *file, const char __user *ubuf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct btmrvl_private *priv = file->private_data;
> +	char buf[16];
> +	long result, ret;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	ret = kstrtol(buf, 10, &result);
> +	if (ret)
> +		return ret;

I wonder why not use strtobool and check for the result being true.

> +
> +	if (result)
> +		btmrvl_firmware_dump(priv);
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
> @@ -197,6 +225,8 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
> 			    priv, &btmrvl_hscmd_fops);
> 	debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
> 			    priv, &btmrvl_hscfgcmd_fops);
> +	debugfs_create_file("fw_dump", 0444, dbg->config_dir,
> +			    priv, &btmrvl_fwdump_fops);

Shouldn't this be 0200 actually? Since you can only write to it, right?

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

While we can do this as a first step to get this merged, but I wonder if we might want to make this generic and just add a hdev->firmware_dump that drivers then can implement.

We could actually add an option to Controller Configuration of the management interface and add a command to trigger the firmware dump. Something to think about. However just starting with a debugfs trigger via Bluetooth core might be a good idea no matter what. That why more drivers could start looking implementing this without having to duplicate the trigger.

Regards

Marcel

