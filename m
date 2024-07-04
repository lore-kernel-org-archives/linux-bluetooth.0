Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB481A08CC;
	Thu,  4 Jul 2024 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072891; cv=none; b=G591ehLMwH/Cx3Ze8zHNEQ8C6BgCbvFEOH7gfG+cH0IUXWnbRvSdyG0NEJUjdnmMQ4VxqxONU3QWYq/ZfQXcOEtPZpvOxWi/XfGNg4JVTgP9tkzGgpcrwiBL1PER1fej04yzUndG4d94w7T9dTjmXTygD65Eq+bpd0eIsUHcFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072891; c=relaxed/simple;
	bh=mEPWzw4yeyrgrnjwUoKYpmR/87v3ur7SdeJXqgyqMhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdFix+BpUY8+AAJZh4MJmsvmTjfSlFGqkg37dVrfxSGO1E+Oz06hsZWNQxYm7nVBsvL2jmg/1QuKngrNCfkmxoKwEmjakzSZtxJJTydJxHcNfekJbiCGWAmVQMM39wmfpAjwfUglIiX6ClJ+Nc14yjZuwKj8P7NdyzNW/siHlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CGvBQFM8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CGvBQFM8"
X-UUID: d65900e439ca11ef8b8f29950b90a568-20240704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gwfz0aNwpxSPpAceY/2hXqe/zMvSDsnLdjeWG04idtY=;
	b=CGvBQFM8OhsmlEB91JHIiME3jVwrhD4x7M1XKms7ou+NM+Kf9yehMP+e1G2AoBqs7e2959Kq3f4pWNbgpfwYrIaanRfQmrhCMirdDt0nFPOzoe9eBLp+d8t1f980lfGAmcP7ptm2cLeGX6LbAJkK5YZ69jWOTvwTP719qsu6L7c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:424e6893-9438-44af-b1f8-046c7184b53f,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:ba885a6,CLOUDID:ccd1e444-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d65900e439ca11ef8b8f29950b90a568-20240704
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1233652559; Thu, 04 Jul 2024 14:01:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jul 2024 23:01:19 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jul 2024 14:01:19 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v7 6/8] Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
Date: Thu, 4 Jul 2024 14:01:14 +0800
Message-ID: <20240704060116.16600-7-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240704060116.16600-1-chris.lu@mediatek.com>
References: <20240704060116.16600-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Move btusb_mtk_[setup, shutdown] and related function from
btusb.c to btmtk.c which holds vendor specific stuff and
would make btusb.c clean.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 454 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h |  23 +-
 drivers/bluetooth/btusb.c | 452 ++-----------------------------------
 3 files changed, 484 insertions(+), 445 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 3443a0837a86..f5ecb8227d3b 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -5,6 +5,8 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/usb.h>
+#include <linux/iopoll.h>
+#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -567,8 +569,8 @@ static int btmtk_usb_submit_wmt_recv_urb(struct hci_dev *hdev)
 	return err;
 }
 
-int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
-			   struct btmtk_hci_wmt_params *wmt_params)
+static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
+				  struct btmtk_hci_wmt_params *wmt_params)
 {
 	struct btmtk_data *data = hci_get_priv(hdev);
 	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
@@ -694,7 +696,453 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	kfree(wc);
 	return err;
 }
-EXPORT_SYMBOL_GPL(btmtk_usb_hci_wmt_sync);
+
+static int btmtk_usb_func_query(struct hci_dev *hdev)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	int status, err;
+	u8 param = 0;
+
+	/* Query whether the function is enabled */
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 4;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = &status;
+
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to query function status (%d)", err);
+		return err;
+	}
+
+	return status;
+}
+
+static int btmtk_usb_uhw_reg_write(struct hci_dev *hdev, u32 reg, u32 val)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	int pipe, err;
+	void *buf;
+
+	buf = kzalloc(4, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	put_unaligned_le32(val, buf);
+
+	pipe = usb_sndctrlpipe(data->udev, 0);
+	err = usb_control_msg(data->udev, pipe, 0x02,
+			      0x5E,
+			      reg >> 16, reg & 0xffff,
+			      buf, 4, USB_CTRL_SET_TIMEOUT);
+	if (err < 0)
+		bt_dev_err(hdev, "Failed to write uhw reg(%d)", err);
+
+	kfree(buf);
+
+	return err;
+}
+
+static int btmtk_usb_uhw_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	int pipe, err;
+	void *buf;
+
+	buf = kzalloc(4, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvctrlpipe(data->udev, 0);
+	err = usb_control_msg(data->udev, pipe, 0x01,
+			      0xDE,
+			      reg >> 16, reg & 0xffff,
+			      buf, 4, USB_CTRL_GET_TIMEOUT);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to read uhw reg(%d)", err);
+		goto err_free_buf;
+	}
+
+	*val = get_unaligned_le32(buf);
+	bt_dev_dbg(hdev, "reg=%x, value=0x%08x", reg, *val);
+
+err_free_buf:
+	kfree(buf);
+
+	return err;
+}
+
+static int btmtk_usb_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	int pipe, err, size = sizeof(u32);
+	void *buf;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvctrlpipe(data->udev, 0);
+	err = usb_control_msg(data->udev, pipe, 0x63,
+			      USB_TYPE_VENDOR | USB_DIR_IN,
+			      reg >> 16, reg & 0xffff,
+			      buf, size, USB_CTRL_GET_TIMEOUT);
+	if (err < 0)
+		goto err_free_buf;
+
+	*val = get_unaligned_le32(buf);
+
+err_free_buf:
+	kfree(buf);
+
+	return err;
+}
+
+static int btmtk_usb_id_get(struct hci_dev *hdev, u32 reg, u32 *id)
+{
+	return btmtk_usb_reg_read(hdev, reg, id);
+}
+
+static u32 btmtk_usb_reset_done(struct hci_dev *hdev)
+{
+	u32 val = 0;
+
+	btmtk_usb_uhw_reg_read(hdev, MTK_BT_MISC, &val);
+
+	return val & MTK_BT_RST_DONE;
+}
+
+int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
+{
+	u32 val;
+	int err;
+
+	if (dev_id == 0x7922) {
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
+		val |= 0x00002020;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT, 0x00010001);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
+		val |= BIT(0);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, val);
+		if (err < 0)
+			return err;
+		msleep(100);
+	} else if (dev_id == 0x7925) {
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
+		val |= (1 << 5);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
+		val &= 0xFFFF00FF;
+		val |= (1 << 13);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT, 0x00010001);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
+		val |= (1 << 0);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT, &val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT1, &val);
+		if (err < 0)
+			return err;
+		msleep(100);
+	} else {
+		/* It's Device EndPoint Reset Option Register */
+		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_WDT_STATUS, &val);
+		if (err < 0)
+			return err;
+		/* Reset the bluetooth chip via USB interface. */
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, 1);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT, &val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT1, &val);
+		if (err < 0)
+			return err;
+		/* MT7921 need to delay 20ms between toggle reset bit */
+		msleep(20);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, 0);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
+	}
+
+	err = readx_poll_timeout(btmtk_usb_reset_done, hdev, val,
+				 val & MTK_BT_RST_DONE, 20000, 1000000);
+	if (err < 0)
+		bt_dev_err(hdev, "Reset timeout");
+
+	if (dev_id == 0x7922) {
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+	}
+
+	err = btmtk_usb_id_get(hdev, 0x70010200, &val);
+	if (err < 0 || !val)
+		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_subsys_reset);
+
+int btmtk_usb_setup(struct hci_dev *hdev)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	struct btmtk_hci_wmt_params wmt_params;
+	ktime_t calltime, delta, rettime;
+	struct btmtk_tci_sleep tci_sleep;
+	unsigned long long duration;
+	struct sk_buff *skb;
+	const char *fwname;
+	int err, status;
+	u32 dev_id = 0;
+	char fw_bin_name[64];
+	u32 fw_version = 0, fw_flavor = 0;
+	u8 param;
+
+	calltime = ktime_get();
+
+	err = btmtk_usb_id_get(hdev, 0x80000008, &dev_id);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to get device id (%d)", err);
+		return err;
+	}
+
+	if (!dev_id || dev_id != 0x7663) {
+		err = btmtk_usb_id_get(hdev, 0x70010200, &dev_id);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get device id (%d)", err);
+			return err;
+		}
+		err = btmtk_usb_id_get(hdev, 0x80021004, &fw_version);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
+			return err;
+		}
+		err = btmtk_usb_id_get(hdev, 0x70010020, &fw_flavor);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get fw flavor (%d)", err);
+			return err;
+		}
+		fw_flavor = (fw_flavor & 0x00000080) >> 7;
+	}
+
+	btmtk_data->dev_id = dev_id;
+
+	err = btmtk_register_coredump(hdev, btmtk_data->drv_name, fw_version);
+	if (err < 0)
+		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
+
+	switch (dev_id) {
+	case 0x7663:
+		fwname = FIRMWARE_MT7663;
+		break;
+	case 0x7668:
+		fwname = FIRMWARE_MT7668;
+		break;
+	case 0x7922:
+	case 0x7961:
+	case 0x7925:
+		/* Reset the device to ensure it's in the initial state before
+		 * downloading the firmware to ensure.
+		 */
+
+		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
+			btmtk_usb_subsys_reset(hdev, dev_id);
+
+		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
+				      fw_version, fw_flavor);
+
+		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
+						btmtk_usb_hci_wmt_sync);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
+			clear_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
+			return err;
+		}
+
+		set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
+
+		/* It's Device EndPoint Reset Option Register */
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
+					      MTK_EP_RST_IN_OUT_OPT);
+		if (err < 0)
+			return err;
+
+		/* Enable Bluetooth protocol */
+		param = 1;
+		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+		wmt_params.flag = 0;
+		wmt_params.dlen = sizeof(param);
+		wmt_params.data = &param;
+		wmt_params.status = NULL;
+
+		err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+			return err;
+		}
+
+		hci_set_msft_opcode(hdev, 0xFD30);
+		hci_set_aosp_capable(hdev);
+
+		goto done;
+	default:
+		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
+			   dev_id);
+		return -ENODEV;
+	}
+
+	/* Query whether the firmware is already download */
+	wmt_params.op = BTMTK_WMT_SEMAPHORE;
+	wmt_params.flag = 1;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = &status;
+
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
+		return err;
+	}
+
+	if (status == BTMTK_WMT_PATCH_DONE) {
+		bt_dev_info(hdev, "firmware already downloaded");
+		goto ignore_setup_fw;
+	}
+
+	/* Setup a firmware which the device definitely requires */
+	err = btmtk_setup_firmware(hdev, fwname,
+				   btmtk_usb_hci_wmt_sync);
+	if (err < 0)
+		return err;
+
+ignore_setup_fw:
+	err = readx_poll_timeout(btmtk_usb_func_query, hdev, status,
+				 status < 0 || status != BTMTK_WMT_ON_PROGRESS,
+				 2000, 5000000);
+	/* -ETIMEDOUT happens */
+	if (err < 0)
+		return err;
+
+	/* The other errors happen in btmtk_usb_func_query */
+	if (status < 0)
+		return status;
+
+	if (status == BTMTK_WMT_ON_DONE) {
+		bt_dev_info(hdev, "function already on");
+		goto ignore_func_on;
+	}
+
+	/* Enable Bluetooth protocol */
+	param = 1;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		return err;
+	}
+
+ignore_func_on:
+	/* Apply the low power environment setup */
+	tci_sleep.mode = 0x5;
+	tci_sleep.duration = cpu_to_le16(0x640);
+	tci_sleep.host_duration = cpu_to_le16(0x640);
+	tci_sleep.host_wakeup_pin = 0;
+	tci_sleep.time_compensation = 0;
+
+	skb = __hci_cmd_sync(hdev, 0xfc7a, sizeof(tci_sleep), &tci_sleep,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Failed to apply low power setting (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+done:
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_setup);
+
+int btmtk_usb_shutdown(struct hci_dev *hdev)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	u8 param = 0;
+	int err;
+
+	/* Disable the device */
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
 
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 3055b9728ae2..fe41528ae509 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -140,6 +140,8 @@ struct btmtk_hci_wmt_params {
 
 enum {
 	BTMTK_TX_WAIT_VND_EVT,
+	BTMTK_FIRMWARE_LOADED,
+	BTMTK_HW_RESET_ACTIVE,
 };
 
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
@@ -152,6 +154,7 @@ struct btmtk_coredump_info {
 };
 
 struct btmtk_data {
+	const char *drv_name;
 	unsigned long flags;
 	u32 dev_id;
 	btmtk_reset_sync_func_t reset_sync;
@@ -186,8 +189,11 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor);
 
-int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
-			   struct btmtk_hci_wmt_params *wmt_params);
+int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
+
+int btmtk_usb_setup(struct hci_dev *hdev);
+
+int btmtk_usb_shutdown(struct hci_dev *hdev);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -228,8 +234,17 @@ static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,
 {
 }
 
-static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
-				  struct btmtk_hci_wmt_params *wmt_params)
+static int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_usb_setup(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_usb_shutdown(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 660e528fdd94..d61a1d02e3e3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2641,241 +2641,6 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
-static int btusb_mtk_func_query(struct hci_dev *hdev)
-{
-	struct btmtk_hci_wmt_params wmt_params;
-	int status, err;
-	u8 param = 0;
-
-	/* Query whether the function is enabled */
-	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-	wmt_params.flag = 4;
-	wmt_params.dlen = sizeof(param);
-	wmt_params.data = &param;
-	wmt_params.status = &status;
-
-	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to query function status (%d)", err);
-		return err;
-	}
-
-	return status;
-}
-
-static int btusb_mtk_uhw_reg_write(struct btusb_data *data, u32 reg, u32 val)
-{
-	struct hci_dev *hdev = data->hdev;
-	int pipe, err;
-	void *buf;
-
-	buf = kzalloc(4, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	put_unaligned_le32(val, buf);
-
-	pipe = usb_sndctrlpipe(data->udev, 0);
-	err = usb_control_msg(data->udev, pipe, 0x02,
-			      0x5E,
-			      reg >> 16, reg & 0xffff,
-			      buf, 4, USB_CTRL_SET_TIMEOUT);
-	if (err < 0)
-		bt_dev_err(hdev, "Failed to write uhw reg(%d)", err);
-
-	kfree(buf);
-
-	return err;
-}
-
-static int btusb_mtk_uhw_reg_read(struct btusb_data *data, u32 reg, u32 *val)
-{
-	struct hci_dev *hdev = data->hdev;
-	int pipe, err;
-	void *buf;
-
-	buf = kzalloc(4, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pipe = usb_rcvctrlpipe(data->udev, 0);
-	err = usb_control_msg(data->udev, pipe, 0x01,
-			      0xDE,
-			      reg >> 16, reg & 0xffff,
-			      buf, 4, USB_CTRL_GET_TIMEOUT);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to read uhw reg(%d)", err);
-		goto err_free_buf;
-	}
-
-	*val = get_unaligned_le32(buf);
-	bt_dev_dbg(hdev, "reg=%x, value=0x%08x", reg, *val);
-
-err_free_buf:
-	kfree(buf);
-
-	return err;
-}
-
-static int btusb_mtk_reg_read(struct btusb_data *data, u32 reg, u32 *val)
-{
-	int pipe, err, size = sizeof(u32);
-	void *buf;
-
-	buf = kzalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pipe = usb_rcvctrlpipe(data->udev, 0);
-	err = usb_control_msg(data->udev, pipe, 0x63,
-			      USB_TYPE_VENDOR | USB_DIR_IN,
-			      reg >> 16, reg & 0xffff,
-			      buf, size, USB_CTRL_GET_TIMEOUT);
-	if (err < 0)
-		goto err_free_buf;
-
-	*val = get_unaligned_le32(buf);
-
-err_free_buf:
-	kfree(buf);
-
-	return err;
-}
-
-static int btusb_mtk_id_get(struct btusb_data *data, u32 reg, u32 *id)
-{
-	return btusb_mtk_reg_read(data, reg, id);
-}
-
-static u32 btusb_mtk_reset_done(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	u32 val = 0;
-
-	btusb_mtk_uhw_reg_read(data, MTK_BT_MISC, &val);
-
-	return val & MTK_BT_RST_DONE;
-}
-
-static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	u32 val;
-	int err;
-
-	if (dev_id == 0x7922) {
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
-			return err;
-		val |= 0x00002020;
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
-			return err;
-		val |= BIT(0);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
-		if (err < 0)
-			return err;
-		msleep(100);
-	} else if (dev_id == 0x7925) {
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
-			return err;
-		val |= (1 << 5);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
-			return err;
-		val &= 0xFFFF00FF;
-		if (err < 0)
-			return err;
-		val |= (1 << 13);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
-			return err;
-		val |= (1 << 0);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
-		if (err < 0)
-			return err;
-		msleep(100);
-	} else {
-		/* It's Device EndPoint Reset Option Register */
-		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
-		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
-		if (err < 0)
-			return err;
-		/* Reset the bluetooth chip via USB interface. */
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
-		if (err < 0)
-			return err;
-		/* MT7921 need to delay 20ms between toggle reset bit */
-		msleep(20);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
-			return err;
-	}
-
-	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
-				 val & MTK_BT_RST_DONE, 20000, 1000000);
-	if (err < 0)
-		bt_dev_err(hdev, "Reset timeout");
-
-	if (dev_id == 0x7922) {
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		if (err < 0)
-			return err;
-	}
-
-	err = btusb_mtk_id_get(data, 0x70010200, &val);
-	if (err < 0 || !val)
-		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
-
-	return err;
-}
-
 static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2883,7 +2648,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	int err;
 
 	/* It's MediaTek specific bluetooth reset mechanism via USB */
-	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+	if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags)) {
 		bt_dev_err(hdev, "last reset failed? Not resetting again");
 		return -EBUSY;
 	}
@@ -2895,10 +2660,10 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
-	err = btusb_mtk_subsys_reset(hdev, btmtk_data->dev_id);
+	err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
 
 	usb_queue_reset_device(data->intf);
-	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
+	clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
 
 	return err;
 }
@@ -2906,212 +2671,23 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct btmtk_hci_wmt_params wmt_params;
-	ktime_t calltime, delta, rettime;
-	struct btmtk_tci_sleep tci_sleep;
-	unsigned long long duration;
-	struct sk_buff *skb;
-	const char *fwname;
-	int err, status;
-	u32 dev_id = 0;
-	char fw_bin_name[64];
-	u32 fw_version = 0, fw_flavor = 0;
-	u8 param;
-	struct btmtk_data *mediatek;
-
-	calltime = ktime_get();
-
-	err = btusb_mtk_id_get(data, 0x80000008, &dev_id);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to get device id (%d)", err);
-		return err;
-	}
-
-	if (!dev_id || dev_id != 0x7663) {
-		err = btusb_mtk_id_get(data, 0x70010200, &dev_id);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to get device id (%d)", err);
-			return err;
-		}
-		err = btusb_mtk_id_get(data, 0x80021004, &fw_version);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
-			return err;
-		}
-		err = btusb_mtk_id_get(data, 0x70010020, &fw_flavor);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to get fw flavor (%d)", err);
-			return err;
-		}
-		fw_flavor = (fw_flavor & 0x00000080) >> 7;
-	}
-
-	mediatek = hci_get_priv(hdev);
-	mediatek->dev_id = dev_id;
-	mediatek->reset_sync = btusb_mtk_reset;
-
-	err = btmtk_register_coredump(hdev, btusb_driver.name, fw_version);
-	if (err < 0)
-		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
-
-	switch (dev_id) {
-	case 0x7663:
-		fwname = FIRMWARE_MT7663;
-		break;
-	case 0x7668:
-		fwname = FIRMWARE_MT7668;
-		break;
-	case 0x7922:
-	case 0x7961:
-	case 0x7925:
-		/* Reset the device to ensure it's in the initial state before
-		 * downloading the firmware to ensure.
-		 */
-
-		if (!test_bit(BTUSB_FIRMWARE_LOADED, &data->flags))
-			btusb_mtk_subsys_reset(hdev, dev_id);
-
-		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
-				      fw_version, fw_flavor);
-
-		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
-						btmtk_usb_hci_wmt_sync);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
-			clear_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-			return err;
-		}
-
-		set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-		/* It's Device EndPoint Reset Option Register */
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
-
-		/* Enable Bluetooth protocol */
-		param = 1;
-		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-		wmt_params.flag = 0;
-		wmt_params.dlen = sizeof(param);
-		wmt_params.data = &param;
-		wmt_params.status = NULL;
-
-		err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-			return err;
-		}
-
-		hci_set_msft_opcode(hdev, 0xFD30);
-		hci_set_aosp_capable(hdev);
-		goto done;
-	default:
-		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
-			   dev_id);
-		return -ENODEV;
-	}
-
-	/* Query whether the firmware is already download */
-	wmt_params.op = BTMTK_WMT_SEMAPHORE;
-	wmt_params.flag = 1;
-	wmt_params.dlen = 0;
-	wmt_params.data = NULL;
-	wmt_params.status = &status;
-
-	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
-		return err;
-	}
-
-	if (status == BTMTK_WMT_PATCH_DONE) {
-		bt_dev_info(hdev, "firmware already downloaded");
-		goto ignore_setup_fw;
-	}
-
-	/* Setup a firmware which the device definitely requires */
-	err = btmtk_setup_firmware(hdev, fwname,
-				   btmtk_usb_hci_wmt_sync);
-	if (err < 0)
-		return err;
-
-ignore_setup_fw:
-	err = readx_poll_timeout(btusb_mtk_func_query, hdev, status,
-				 status < 0 || status != BTMTK_WMT_ON_PROGRESS,
-				 2000, 5000000);
-	/* -ETIMEDOUT happens */
-	if (err < 0)
-		return err;
-
-	/* The other errors happen in btusb_mtk_func_query */
-	if (status < 0)
-		return status;
-
-	if (status == BTMTK_WMT_ON_DONE) {
-		bt_dev_info(hdev, "function already on");
-		goto ignore_func_on;
-	}
-
-	/* Enable Bluetooth protocol */
-	param = 1;
-	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-	wmt_params.flag = 0;
-	wmt_params.dlen = sizeof(param);
-	wmt_params.data = &param;
-	wmt_params.status = NULL;
-
-	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-		return err;
-	}
-
-ignore_func_on:
-	/* Apply the low power environment setup */
-	tci_sleep.mode = 0x5;
-	tci_sleep.duration = cpu_to_le16(0x640);
-	tci_sleep.host_duration = cpu_to_le16(0x640);
-	tci_sleep.host_wakeup_pin = 0;
-	tci_sleep.time_compensation = 0;
-
-	skb = __hci_cmd_sync(hdev, 0xfc7a, sizeof(tci_sleep), &tci_sleep,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		bt_dev_err(hdev, "Failed to apply low power setting (%d)", err);
-		return err;
-	}
-	kfree_skb(skb);
-
-done:
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 
-	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
+	/* MediaTek WMT vendor cmd requiring below USB resources to
+	 * complete the handshake.
+	 */
+	btmtk_data->drv_name = btusb_driver.name;
+	btmtk_data->intf = data->intf;
+	btmtk_data->udev = data->udev;
+	btmtk_data->ctrl_anchor = &data->ctrl_anchor;
+	btmtk_data->reset_sync = btusb_mtk_reset;
 
-	return 0;
+	return btmtk_usb_setup(hdev);
 }
 
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
 {
-	struct btmtk_hci_wmt_params wmt_params;
-	u8 param = 0;
-	int err;
-
-	/* Disable the device */
-	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-	wmt_params.flag = 0;
-	wmt_params.dlen = sizeof(param);
-	wmt_params.data = &param;
-	wmt_params.status = NULL;
-
-	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-		return err;
-	}
-
-	return 0;
+	return btmtk_usb_shutdown(hdev);
 }
 
 static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.18.0

