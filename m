Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, <marcel@holtmann.org>,
        Xinming
 Hu <huxm@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Avinash Patil
	<patila@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v4 2/2] Bluetooth: btmrvl add firmware dump support
Date: Mon, 24 Nov 2014 02:40:53 -0800
Message-ID: <1416825653-32530-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1416825653-32530-1-git-send-email-akarwar@marvell.com>
References: <1416825653-32530-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

This patch adds firmware dump support for marvell
bluetooth chipset. Currently only SD8897 is supported.
This is implemented based on dev_coredump, a new mechnism
introduced in kernel 3.18rc3

Firmware dump can be trigger by
echo 1 > /sys/kernel/debug/bluetooth/hci*/config/fw_dump
and when the dump operation is completed, data can be read by
cat /sys/class/devcoredump/devcd*/data

We have prepared following script to divide fw memory
dump data into multiple files based on memory type.

 [root]# cat btmrvl_split_dump_data.sh
 #!/bin/bash
 # usage: ./btmrvl_split_dump_data.sh dump_data

 fw_dump_data=$1

 mem_type="ITCM DTCM SQRAM APU CIU ICU MAC EXT7 EXT8 EXT9 EXT10 EXT11 EXT12 EXT13 EXTLAST"

 for name in ${mem_type[@]}
 do
         sed -n "/Start dump $name/,/End dump/p" $fw_dump_data  > tmp.$name.log
         if [ ! -s tmp.$name.log ]
                 then
                         rm -rf tmp.$name.log
                 else
                         # Remove the describle info "Start dump" and "End dump"
                         sed '1d' tmp.$name.log | sed '$d' > /data/$name.log
                         if [ -s /data/$name.log ]
                         then
                                 echo "generate /data/$name.log"
                         else
                                 sed '1d' tmp.$name.log | sed '$d' > /var/$name.log
                                 echo "generate /var/$name.log"
                         fi
                         rm -rf tmp.$name.log
         fi
 done

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Avinash Patil <patila@marvell.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
v4: Change if/else check to improve readability
    Move "#include <linux/devcoredump.h>" to btmrvl_sdio.c file.
    Don't expose debugfs entry by showing an error when the callback is
    not defined.
    BT_ERR/BT_INFO already takes care of newline. Remove extra "\n" in
    the message.
v3: Change fw_dump debugfs file permissions to write only
    Replace kstrtol with strtobool
v2: Add "select WANT_DEV_COREDUMP" in Kconfig
    Use write debugfs command instead of read to trigger dump operation.
---
 drivers/bluetooth/Kconfig          |   1 +
 drivers/bluetooth/btmrvl_debugfs.c |  31 ++++
 drivers/bluetooth/btmrvl_drv.h     |  20 +++
 drivers/bluetooth/btmrvl_main.c    |   7 +
 drivers/bluetooth/btmrvl_sdio.c    | 300 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmrvl_sdio.h    |   5 +
 6 files changed, 364 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4547dc2..364f080 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -210,6 +210,7 @@ config BT_MRVL_SDIO
 	tristate "Marvell BT-over-SDIO driver"
 	depends on BT_MRVL && MMC
 	select FW_LOADER
+	select WANT_DEV_COREDUMP
 	help
 	  The driver for Marvell Bluetooth chipsets with SDIO interface.
 
diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 023d35e..1828ed8 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -167,6 +167,35 @@ static const struct file_operations btmrvl_hscmd_fops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t btmrvl_fwdump_write(struct file *file, const char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	struct btmrvl_private *priv = file->private_data;
+	char buf[16];
+	bool result;
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (strtobool(buf, &result))
+		return -EINVAL;
+
+	if (!result)
+		return -EINVAL;
+
+	btmrvl_firmware_dump(priv);
+
+	return count;
+}
+
+static const struct file_operations btmrvl_fwdump_fops = {
+	.write	= btmrvl_fwdump_write,
+	.open	= simple_open,
+	.llseek = default_llseek,
+};
+
 void btmrvl_debugfs_init(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
@@ -197,6 +226,8 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
 			    priv, &btmrvl_hscmd_fops);
 	debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
 			    priv, &btmrvl_hscfgcmd_fops);
+	debugfs_create_file("fw_dump", 0200, dbg->config_dir,
+			    priv, &btmrvl_fwdump_fops);
 
 	dbg->status_dir = debugfs_create_dir("status", hdev->debugfs);
 	debugfs_create_u8("curpsmode", 0444, dbg->status_dir,
diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 38ad662..330f8f8 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -32,6 +32,24 @@
 /* Time to wait for command response in millisecond */
 #define WAIT_UNTIL_CMD_RESP		5000
 
+enum rdwr_status {
+	RDWR_STATUS_SUCCESS = 0,
+	RDWR_STATUS_FAILURE = 1,
+	RDWR_STATUS_DONE = 2
+};
+
+#define FW_DUMP_MAX_NAME_LEN    8
+#define FW_DUMP_HOST_READY      0xEE
+#define FW_DUMP_DONE            0xFF
+#define FW_DUMP_READ_DONE       0xFE
+
+struct memory_type_mapping {
+	u8 mem_name[FW_DUMP_MAX_NAME_LEN];
+	u8 *mem_ptr;
+	u32 mem_size;
+	u8 done_flag;
+};
+
 struct btmrvl_thread {
 	struct task_struct *task;
 	wait_queue_head_t wait_q;
@@ -81,6 +99,7 @@ struct btmrvl_private {
 				u8 *payload, u16 nb);
 	int (*hw_wakeup_firmware) (struct btmrvl_private *priv);
 	int (*hw_process_int_status) (struct btmrvl_private *priv);
+	void (*firmware_dump)(struct btmrvl_private *priv);
 	spinlock_t driver_lock;		/* spinlock used by driver */
 #ifdef CONFIG_DEBUG_FS
 	void *debugfs_data;
@@ -151,6 +170,7 @@ int btmrvl_send_hscfg_cmd(struct btmrvl_private *priv);
 int btmrvl_enable_ps(struct btmrvl_private *priv);
 int btmrvl_prepare_command(struct btmrvl_private *priv);
 int btmrvl_enable_hs(struct btmrvl_private *priv);
+void btmrvl_firmware_dump(struct btmrvl_private *priv);
 
 #ifdef CONFIG_DEBUG_FS
 void btmrvl_debugfs_init(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 10973ac..30939c9 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <linux/mmc/sdio_func.h>
 
 #include "btmrvl_drv.h"
 #include "btmrvl_sdio.h"
@@ -335,6 +336,12 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
 	return ret;
 }
 
+void btmrvl_firmware_dump(struct btmrvl_private *priv)
+{
+	if (priv->firmware_dump)
+		priv->firmware_dump(priv);
+}
+
 static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 {
 	int ret = 0;
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 416d792..0057c0b 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -24,6 +24,7 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 #include <linux/module.h>
+#include <linux/devcoredump.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -33,6 +34,24 @@
 
 #define VERSION "1.0"
 
+static struct memory_type_mapping mem_type_mapping_tbl[] = {
+	{"ITCM", NULL, 0, 0xF0},
+	{"DTCM", NULL, 0, 0xF1},
+	{"SQRAM", NULL, 0, 0xF2},
+	{"APU", NULL, 0, 0xF3},
+	{"CIU", NULL, 0, 0xF4},
+	{"ICU", NULL, 0, 0xF5},
+	{"MAC", NULL, 0, 0xF6},
+	{"EXT7", NULL, 0, 0xF7},
+	{"EXT8", NULL, 0, 0xF8},
+	{"EXT9", NULL, 0, 0xF9},
+	{"EXT10", NULL, 0, 0xFA},
+	{"EXT11", NULL, 0, 0xFB},
+	{"EXT12", NULL, 0, 0xFC},
+	{"EXT13", NULL, 0, 0xFD},
+	{"EXTLAST", NULL, 0, 0xFE},
+};
+
 /* The btmrvl_sdio_remove() callback function is called
  * when user removes this module from kernel space or ejects
  * the card from the slot. The driver handles these 2 cases
@@ -122,6 +141,9 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_8897 = {
 	.int_read_to_clear = true,
 	.host_int_rsr = 0x01,
 	.card_misc_cfg = 0xcc,
+	.fw_dump_ctrl = 0xe2,
+	.fw_dump_start = 0xe3,
+	.fw_dump_end = 0xea,
 };
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
@@ -130,6 +152,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
 	.reg		= &btmrvl_reg_8688,
 	.support_pscan_win_report = false,
 	.sd_blksz_fw_dl	= 64,
+	.supports_fw_dump = false,
 };
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8787 = {
@@ -138,6 +161,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8787 = {
 	.reg		= &btmrvl_reg_87xx,
 	.support_pscan_win_report = false,
 	.sd_blksz_fw_dl	= 256,
+	.supports_fw_dump = false,
 };
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8797 = {
@@ -146,6 +170,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8797 = {
 	.reg		= &btmrvl_reg_87xx,
 	.support_pscan_win_report = false,
 	.sd_blksz_fw_dl	= 256,
+	.supports_fw_dump = false,
 };
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8887 = {
@@ -154,6 +179,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8887 = {
 	.reg		= &btmrvl_reg_8887,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl	= 256,
+	.supports_fw_dump = false,
 };
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
@@ -162,6 +188,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 	.reg		= &btmrvl_reg_8897,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl	= 256,
+	.supports_fw_dump = true,
 };
 
 static const struct sdio_device_id btmrvl_sdio_ids[] = {
@@ -1080,6 +1107,277 @@ static int btmrvl_sdio_wakeup_fw(struct btmrvl_private *priv)
 	return ret;
 }
 
+static void btmrvl_sdio_dump_regs(struct btmrvl_private *priv)
+{
+	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
+	int ret = 0;
+	unsigned int reg, reg_start, reg_end;
+	char buf[256], *ptr;
+	u8 loop, func, data;
+	int MAX_LOOP = 2;
+
+	btmrvl_sdio_wakeup_fw(priv);
+	sdio_claim_host(card->func);
+
+	for (loop = 0; loop < MAX_LOOP; loop++) {
+		memset(buf, 0, sizeof(buf));
+		ptr = buf;
+
+		if (loop == 0) {
+			/* Read the registers of SDIO function0 */
+			func = loop;
+			reg_start = 0;
+			reg_end = 9;
+		} else {
+			func = 2;
+			reg_start = 0;
+			reg_end = 0x09;
+		}
+
+		ptr += sprintf(ptr, "SDIO Func%d (%#x-%#x): ",
+			       func, reg_start, reg_end);
+		for (reg = reg_start; reg <= reg_end; reg++) {
+			if (func == 0)
+				data = sdio_f0_readb(card->func, reg, &ret);
+			else
+				data = sdio_readb(card->func, reg, &ret);
+
+			if (!ret) {
+				ptr += sprintf(ptr, "%02x ", data);
+			} else {
+				ptr += sprintf(ptr, "ERR");
+				break;
+			}
+		}
+
+		BT_INFO("%s", buf);
+	}
+
+	sdio_release_host(card->func);
+}
+
+/* This function read/write firmware */
+static enum
+rdwr_status btmrvl_sdio_rdwr_firmware(struct btmrvl_private *priv,
+				      u8 doneflag)
+{
+	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
+	int ret, tries;
+	u8 ctrl_data = 0;
+
+	sdio_writeb(card->func, FW_DUMP_HOST_READY, card->reg->fw_dump_ctrl,
+		    &ret);
+
+	if (ret) {
+		BT_ERR("SDIO write err");
+		return RDWR_STATUS_FAILURE;
+	}
+
+	for (tries = 0; tries < MAX_POLL_TRIES; tries++) {
+		ctrl_data = sdio_readb(card->func, card->reg->fw_dump_ctrl,
+				       &ret);
+
+		if (ret) {
+			BT_ERR("SDIO read err");
+			return RDWR_STATUS_FAILURE;
+		}
+
+		if (ctrl_data == FW_DUMP_DONE)
+			break;
+		if (doneflag && ctrl_data == doneflag)
+			return RDWR_STATUS_DONE;
+		if (ctrl_data != FW_DUMP_HOST_READY) {
+			BT_INFO("The ctrl reg was changed, re-try again!");
+			sdio_writeb(card->func, FW_DUMP_HOST_READY,
+				    card->reg->fw_dump_ctrl, &ret);
+			if (ret) {
+				BT_ERR("SDIO write err");
+				return RDWR_STATUS_FAILURE;
+			}
+		}
+		usleep_range(100, 200);
+	}
+
+	if (ctrl_data == FW_DUMP_HOST_READY) {
+		BT_ERR("Fail to pull ctrl_data");
+		return RDWR_STATUS_FAILURE;
+	}
+
+	return RDWR_STATUS_SUCCESS;
+}
+
+/* This function dump sdio register and memory data */
+static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
+{
+	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
+	int ret = 0;
+	unsigned int reg, reg_start, reg_end;
+	enum rdwr_status stat;
+	u8 *dbg_ptr, *end_ptr, *fw_dump_data, *fw_dump_ptr;
+	u8 dump_num, idx, i, read_reg, doneflag = 0;
+	u32 memory_size, fw_dump_len = 0;
+
+	/* dump sdio register first */
+	btmrvl_sdio_dump_regs(priv);
+
+	if (!card->supports_fw_dump) {
+		BT_ERR("Firmware dump not supported for this card!");
+		return;
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(mem_type_mapping_tbl); idx++) {
+		struct memory_type_mapping *entry = &mem_type_mapping_tbl[idx];
+
+		if (entry->mem_ptr) {
+			vfree(entry->mem_ptr);
+			entry->mem_ptr = NULL;
+		}
+		entry->mem_size = 0;
+	}
+
+	btmrvl_sdio_wakeup_fw(priv);
+	sdio_claim_host(card->func);
+
+	BT_INFO("== btmrvl firmware dump start ==");
+
+	stat = btmrvl_sdio_rdwr_firmware(priv, doneflag);
+	if (stat == RDWR_STATUS_FAILURE)
+		goto done;
+
+	reg = card->reg->fw_dump_start;
+	/* Read the number of the memories which will dump */
+	dump_num = sdio_readb(card->func, reg, &ret);
+
+	if (ret) {
+		BT_ERR("SDIO read memory length err");
+		goto done;
+	}
+
+	/* Read the length of every memory which will dump */
+	for (idx = 0; idx < dump_num; idx++) {
+		struct memory_type_mapping *entry = &mem_type_mapping_tbl[idx];
+
+		stat = btmrvl_sdio_rdwr_firmware(priv, doneflag);
+		if (stat == RDWR_STATUS_FAILURE)
+			goto done;
+
+		memory_size = 0;
+		reg = card->reg->fw_dump_start;
+		for (i = 0; i < 4; i++) {
+			read_reg = sdio_readb(card->func, reg, &ret);
+			if (ret) {
+				BT_ERR("SDIO read err");
+				goto done;
+			}
+			memory_size |= (read_reg << i*8);
+			reg++;
+		}
+
+		if (memory_size == 0) {
+			BT_INFO("Firmware dump finished!");
+			break;
+		}
+
+		BT_INFO("%s_SIZE=0x%x", entry->mem_name, memory_size);
+		entry->mem_ptr = vzalloc(memory_size + 1);
+		entry->mem_size = memory_size;
+		if (!entry->mem_ptr) {
+			BT_ERR("Vzalloc %s failed", entry->mem_name);
+			goto done;
+		}
+
+		fw_dump_len += (strlen("========Start dump ") +
+				strlen(entry->mem_name) +
+				strlen("========\n") +
+				(memory_size + 1) +
+				strlen("\n========End dump========\n"));
+
+		dbg_ptr = entry->mem_ptr;
+		end_ptr = dbg_ptr + memory_size;
+
+		doneflag = entry->done_flag;
+		BT_INFO("Start %s output, please wait...",
+			entry->mem_name);
+
+		do {
+			stat = btmrvl_sdio_rdwr_firmware(priv, doneflag);
+			if (stat == RDWR_STATUS_FAILURE)
+				goto done;
+
+			reg_start = card->reg->fw_dump_start;
+			reg_end = card->reg->fw_dump_end;
+			for (reg = reg_start; reg <= reg_end; reg++) {
+				*dbg_ptr = sdio_readb(card->func, reg, &ret);
+				if (ret) {
+					BT_ERR("SDIO read err");
+					goto done;
+				}
+				if (dbg_ptr < end_ptr)
+					dbg_ptr++;
+				else
+					BT_ERR("Allocated buffer not enough");
+			}
+
+			if (stat != RDWR_STATUS_DONE) {
+				continue;
+			} else {
+				BT_INFO("%s done: size=0x%tx",
+					entry->mem_name,
+					dbg_ptr - entry->mem_ptr);
+				break;
+			}
+		} while (1);
+	}
+
+	BT_INFO("== btmrvl firmware dump end ==");
+
+done:
+	sdio_release_host(card->func);
+
+	if (fw_dump_len == 0)
+		return;
+
+	fw_dump_data = vzalloc(fw_dump_len+1);
+	if (!fw_dump_data) {
+		BT_ERR("Vzalloc fw_dump_data fail!");
+		return;
+	}
+	fw_dump_ptr = fw_dump_data;
+
+	/* Dump all the memory data into single file, a userspace script will
+	   be used to split all the memory data to multiple files*/
+	BT_INFO("== btmrvl firmware dump to /sys/class/devcoredump start");
+	for (idx = 0; idx < dump_num; idx++) {
+		struct memory_type_mapping *entry = &mem_type_mapping_tbl[idx];
+
+		if (entry->mem_ptr) {
+			strcpy(fw_dump_ptr, "========Start dump ");
+			fw_dump_ptr += strlen("========Start dump ");
+
+			strcpy(fw_dump_ptr, entry->mem_name);
+			fw_dump_ptr += strlen(entry->mem_name);
+
+			strcpy(fw_dump_ptr, "========\n");
+			fw_dump_ptr += strlen("========\n");
+
+			memcpy(fw_dump_ptr, entry->mem_ptr, entry->mem_size);
+			fw_dump_ptr += entry->mem_size;
+
+			strcpy(fw_dump_ptr, "\n========End dump========\n");
+			fw_dump_ptr += strlen("\n========End dump========\n");
+
+			vfree(mem_type_mapping_tbl[idx].mem_ptr);
+			mem_type_mapping_tbl[idx].mem_ptr = NULL;
+		}
+	}
+
+	/* fw_dump_data will be free in device coredump release function
+	   after 5 min*/
+	dev_coredumpv(&priv->btmrvl_dev.hcidev->dev, fw_dump_data,
+		      fw_dump_len, GFP_KERNEL);
+	BT_INFO("== btmrvl firmware dump to /sys/class/devcoredump end");
+}
+
 static int btmrvl_sdio_probe(struct sdio_func *func,
 					const struct sdio_device_id *id)
 {
@@ -1103,6 +1401,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 		card->reg = data->reg;
 		card->sd_blksz_fw_dl = data->sd_blksz_fw_dl;
 		card->support_pscan_win_report = data->support_pscan_win_report;
+		card->supports_fw_dump = data->supports_fw_dump;
 	}
 
 	if (btmrvl_sdio_register_dev(card) < 0) {
@@ -1134,6 +1433,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	priv->hw_host_to_card = btmrvl_sdio_host_to_card;
 	priv->hw_wakeup_firmware = btmrvl_sdio_wakeup_fw;
 	priv->hw_process_int_status = btmrvl_sdio_process_int_status;
+	priv->firmware_dump = btmrvl_sdio_dump_firmware;
 
 	if (btmrvl_register_hdev(priv)) {
 		BT_ERR("Register hdev failed!");
diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_sdio.h
index 453559f..1a3bd06 100644
--- a/drivers/bluetooth/btmrvl_sdio.h
+++ b/drivers/bluetooth/btmrvl_sdio.h
@@ -81,6 +81,9 @@ struct btmrvl_sdio_card_reg {
 	bool int_read_to_clear;
 	u8 host_int_rsr;
 	u8 card_misc_cfg;
+	u8 fw_dump_ctrl;
+	u8 fw_dump_start;
+	u8 fw_dump_end;
 };
 
 struct btmrvl_sdio_card {
@@ -90,6 +93,7 @@ struct btmrvl_sdio_card {
 	const char *firmware;
 	const struct btmrvl_sdio_card_reg *reg;
 	bool support_pscan_win_report;
+	bool supports_fw_dump;
 	u16 sd_blksz_fw_dl;
 	u8 rx_unit;
 	struct btmrvl_private *priv;
@@ -101,6 +105,7 @@ struct btmrvl_sdio_device {
 	const struct btmrvl_sdio_card_reg *reg;
 	const bool support_pscan_win_report;
 	u16 sd_blksz_fw_dl;
+	bool supports_fw_dump;
 };
 
 
-- 
1.8.1.4
