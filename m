Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9116C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jan 2021 04:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7583722573
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jan 2021 04:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbhAXElt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Jan 2021 23:41:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50277 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726223AbhAXElX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Jan 2021 23:41:23 -0500
X-UUID: 61c554167e974425a402af959a2cfca7-20210124
X-UUID: 61c554167e974425a402af959a2cfca7-20210124
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2066013021; Sun, 24 Jan 2021 12:40:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 24 Jan 2021 12:40:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 24 Jan 2021 12:40:31 +0800
From:   <sean.wang@mediatek.com>
To:     <Mark-YW.Chen@mediatek.com>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <Sean.Wang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: =?UTF-8?q?Re=3A=5BPATCH=201/1=5D=20=5BAdd=20support=20Mediatek=20mt7921U=5D?=
Date:   Sun, 24 Jan 2021 12:40:29 +0800
Message-ID: <1611463229-25895-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20210118162900.6090-1-mark-yw.chen@mediatek.com>
References: <20210118162900.6090-1-mark-yw.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Hi Mark

>From: "mark-yw.chen" <mark-yw.chen@mediatek.com>
>

Please use the appropirate version and prefix for the subject such as
[PATCH v4] Bluetooth: btusb: Add protocol support for MediaTek MT7921U USB devices

>
>This patch adds the support of enableing MT7921U, it's USB-based Bluetooth function.
>
>There is mt7921 firmware download mechanism
>
>1. Read Chip id from MT7921.
>
>2. Download firmware by endpoint 2. (it’s medaitek specific header format for downloading firmware.)
>
>3. Enabling Bluetooth function.

Should attach the usb descriptor and endpoints information shown in /sys/kernel/debug/usb/devices
about the Bluetooth controller.

Signed-off-by tag cannot be dropped and good to have the brief revsion history put here.

>---
> drivers/bluetooth/btusb.c | 329 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 315 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index 03b83aa91277..fefbbf467aea 100644
>--- a/drivers/bluetooth/btusb.c
>+++ b/drivers/bluetooth/btusb.c
>@@ -3123,10 +3123,14 @@ static int btusb_shutdown_intel_new(struct hci_dev *hdev)
>	return 0;
> }
>
>-#define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
>-#define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"

Move to a separate patch and then state why you have to do it.

>-
> #define HCI_WMT_MAX_EVENT_SIZE		64
>+/* It is for mt79xx download rom patch*/
>+#define FW_ROM_PATCH_HEADER_SIZE	32
>+#define FW_ROM_PATCH_GD_SIZE	64
>+#define FW_ROM_PATCH_SEC_MAP_SIZE	64
>+#define SEC_MAP_COMMON_SIZE	12
>+#define SEC_MAP_NEED_SEND_SIZE	52
>+#define PATCH_STATUS	7

Drop the unused macro and have the specific vendor prefix for those macros.

>
> enum {
>	BTMTK_WMT_PATCH_DWNLD = 0x1,
>@@ -3138,6 +3142,7 @@ enum {
> enum {
>	BTMTK_WMT_INVALID,
>	BTMTK_WMT_PATCH_UNDONE,
>+	BTMTK_WMT_PATCH_PROGRESS,
>	BTMTK_WMT_PATCH_DONE,
>	BTMTK_WMT_ON_UNDONE,
>	BTMTK_WMT_ON_DONE,
>@@ -3153,7 +3158,7 @@ struct btmtk_wmt_hdr {
>
> struct btmtk_hci_wmt_cmd {
>	struct btmtk_wmt_hdr hdr;
>-	u8 data[256];
>+	u8 data[1000];

That seems to break mt7663 as wmt cmd is sent in a form of hci cmd.

> } __packed;
>
> struct btmtk_hci_wmt_evt {
>@@ -3182,6 +3187,82 @@ struct btmtk_hci_wmt_params {
>	u32 *status;
> };
>
>+struct btmtk_patch_header {
>+	u8 datetime[16];
>+	u8 platform[4];
>+	u16 hwver;
>+	u16 swver;

__le16

>+	u32 magicnum;

__le32

>+} __packed;
>+
>+struct btmtk_global_desc {
>+	u32 patch_ver;
>+	u32 sub_sys;
>+	u32 feature_opt;
>+	u32 section_num;

__le32

>+} __packed;
>+
>+struct btmtk_section_map {
>+	u32 sectype;
>+	u32 secoffset;
>+	u32 secsize;

__le32

>+	union {
>+		u32 secspec[13];
>+		struct {
>+			u32 dladdr;
>+			u32 dlsize;
>+			u32 seckeyidx;
>+			u32 alignlen;
>+			u32 sectype;
>+			u32 dlmodecrctype;
>+			u32 crc;
>+			u32 reserved[6];

__le32

>+		} bin_info_spec;
>+	};
>+} __packed;
>+
>+struct sk_buff *hci_prepare_acl(struct hci_dev *hdev, u16 opcode, u32 plen,
>+				const void *param)
>+{
>+	int len = HCI_ACL_HDR_SIZE + plen;
>+	struct hci_acl_hdr *hdr;
>+	struct sk_buff *skb;
>+
>+	skb = bt_skb_alloc(len, GFP_ATOMIC);
>+	if (!skb)
>+		return NULL;
>+
>+	hdr = skb_put(skb, HCI_ACL_HDR_SIZE);
>+	hdr->handle = cpu_to_le16(opcode);
>+	hdr->dlen   = cpu_to_le16(plen);
>+
>+	if (plen)
>+		skb_put_data(skb, param, plen);
>+
>+	hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
>+	hci_skb_opcode(skb) = opcode;
>+
>+	return skb;
>+}
>+
>+int __hci_acl_send(struct hci_dev *hdev, u16 opcode, u32 plen,
>+		   const void *param)
>+{
>+	struct sk_buff *skb;
>+
>+	skb = hci_prepare_acl(hdev, opcode, plen, param);
>+
>+	if (!skb) {
>+		bt_dev_err(hdev, "no memory for command (opcode 0x%4.4x)",
>+			   opcode);
>+		return -ENOMEM;
>+	}
>+
>+	btusb_send_frame(hdev, skb);
>+
>+	return 0;
>+}

Move to a separate patch for the two new functions and then discuss with
Mercel further if it is worth moving up to the core layer.

>+
> static void btusb_mtk_wmt_recv(struct urb *urb)  {
>	struct hci_dev *hdev = urb->context;
>@@ -3252,7 +3333,7 @@ static void btusb_mtk_wmt_recv(struct urb *urb)
>	 * to generate the event. Otherwise, the WMT event cannot return from
>	 * the device successfully.
>	 */
>-	udelay(100);
>+	mdelay(10);

It should break. If i remember correctly that should be in amotic context.

>
>	usb_anchor_urb(urb, &data->ctrl_anchor);
>	err = usb_submit_urb(urb, GFP_ATOMIC); @@ -3320,6 +3401,70 @@ static int btusb_mtk_submit_wmt_recv_urb(struct hci_dev *hdev)
>	return err;
> }
>
>+static int btusb_mtk_hci_wmt_acl_sync(struct hci_dev *hdev,
>+				      struct btmtk_hci_wmt_params *wmt_params) {
>+	struct btusb_data *data = hci_get_drvdata(hdev);
>+	u32 hlen;
>+	struct btmtk_hci_wmt_cmd wc;
>+	struct btmtk_wmt_hdr *hdr;
>+	int err;
>+
>+	/* Send the WMT command and wait until the WMT event returns */
>+	hlen = sizeof(*hdr) + wmt_params->dlen;
>+	if (hlen > 1021)
>+		return -EINVAL;
>+
>+	hdr = (struct btmtk_wmt_hdr *)&wc;
>+	hdr->dir = 1;
>+	hdr->op = wmt_params->op;
>+	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
>+	hdr->flag = wmt_params->flag;
>+	memcpy(wc.data, wmt_params->data, wmt_params->dlen);
>+
>+	set_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
>+
>+	err = __hci_acl_send(hdev, 0xfc6f, hlen, &wc);
>+
>+	if (err < 0) {
>+		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
>+		return err;
>+	}
>+
>+	/* Submit control IN URB on demand to process the WMT event */
>+	err = btusb_mtk_submit_wmt_recv_urb(hdev);
>+	if (err < 0)
>+		return err;
>+
>+	/* The vendor specific WMT commands are all answered by a vendor
>+	 * specific event and will have the Command Status or Command
>+	 * Complete as with usual HCI command flow control.
>+	 *
>+	 * After sending the command, wait for BTUSB_TX_WAIT_VND_EVT
>+	 * state to be cleared. The driver specific event receive routine
>+	 * will clear that state and with that indicate completion of the
>+	 * WMT command.
>+	 */
>+	err = wait_on_bit_timeout(&data->flags, BTUSB_TX_WAIT_VND_EVT,
>+				  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
>+	if (err == -EINTR) {
>+		bt_dev_err(hdev, "Execution of wmt command interrupted");
>+		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
>+		return err;
>+	}
>+
>+	if (err) {
>+		bt_dev_err(hdev, "Execution of wmt command timed out");
>+		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
>+		return -ETIMEDOUT;
>+	}
>+
>+	kfree_skb(data->evt_skb);
>+	data->evt_skb = NULL;
>+
>+	return err;
>+}
>+
> static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
>				  struct btmtk_hci_wmt_params *wmt_params)  { @@ -3405,6 +3550,14 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
>		else
>			status = BTMTK_WMT_ON_UNDONE;
>		break;
>+	case BTMTK_WMT_PATCH_DWNLD:
>+		if (wmt_evt->whdr.flag == 2)
>+			status = BTMTK_WMT_PATCH_DONE;
>+		else if (wmt_evt->whdr.flag == 1)
>+			status = BTMTK_WMT_PATCH_PROGRESS;
>+		else
>+			status = BTMTK_WMT_PATCH_UNDONE;
>+		break;
>	}
>
>	if (wmt_params->status)
>@@ -3417,6 +3570,121 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
>	return err;
> }
>

Is it possible to have wmt transmission via hci cmd form first?
with which it doesn't rely on the new acl send functions and be able to reuse
most of the same code with mt7663.

>+static int btusb_mtk_setup_firmware_79xx(struct hci_dev *hdev, const
>+char *fwname) {
>+	struct btmtk_hci_wmt_params wmt_params;
>+	struct btmtk_patch_header *patchhdr = NULL;
>+	struct btmtk_global_desc *globaldesc = NULL;
>+	struct btmtk_section_map *sectionmap;
>+	const struct firmware *fw;
>+	const u8 *fw_ptr;
>+	const u8 *fw_bin_ptr;
>+	size_t fw_size;
>+	int err, dlen, i, status;
>+	u8 flag, first_block, retry;
>+	u32 section_num, dl_size, section_offset;
>+	u8 cmd[64];
>+
>+	err = request_firmware(&fw, fwname, &hdev->dev);
>+	if (err < 0) {
>+		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
>+		return err;
>+	}
>+
>+	fw_ptr = fw->data;
>+	fw_bin_ptr = fw_ptr;
>+	fw_size = fw->size;
>+	patchhdr = (struct btmtk_patch_header *)fw_ptr;
>+	globaldesc = (struct btmtk_global_desc *)(fw_ptr + FW_ROM_PATCH_HEADER_SIZE);
>+	section_num = globaldesc->section_num;
>+
>+	for (i = 0; i < section_num; i++) {
>+		first_block = 1;
>+		fw_ptr = fw_bin_ptr;
>+		sectionmap = (struct btmtk_section_map *)(fw_ptr + FW_ROM_PATCH_HEADER_SIZE +
>+			      FW_ROM_PATCH_GD_SIZE + FW_ROM_PATCH_SEC_MAP_SIZE * i);
>+
>+		section_offset = sectionmap->secoffset;
>+		dl_size = sectionmap->bin_info_spec.dlsize;
>+
>+		if (dl_size > 0) {
>+			retry = 20;
>+			while (retry > 0) {
>+				cmd[0] = 0; /* 0 means legacy dl mode. */
>+				memcpy(cmd + 1,
>+				       fw_ptr + FW_ROM_PATCH_HEADER_SIZE +
>+				       FW_ROM_PATCH_GD_SIZE + FW_ROM_PATCH_SEC_MAP_SIZE * i +
>+				       SEC_MAP_COMMON_SIZE,
>+				       SEC_MAP_NEED_SEND_SIZE + 1);
>+				wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
>+				wmt_params.status = &status;
>+				wmt_params.flag = 0;
>+				wmt_params.dlen = SEC_MAP_NEED_SEND_SIZE + 1;
>+				wmt_params.data = &cmd;
>+
>+				err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
>+				if (err < 0) {
>+					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
>+						   err);
>+					goto err_release_fw;
>+				}
>+
>+				if (status == BTMTK_WMT_PATCH_UNDONE) {
>+					break;
>+				} else if (status == BTMTK_WMT_PATCH_PROGRESS) {
>+					msleep(100);
>+					retry--;
>+				} else if (status == BTMTK_WMT_PATCH_DONE) {
>+					goto next_section;
>+				} else {
>+					bt_dev_err(hdev, "Failed wmt patch dwnld status (%d)",
>+						   status);
>+					goto err_release_fw;
>+				}
>+			}
>+
>+			fw_ptr += section_offset;
>+			wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
>+			wmt_params.status = NULL;
>+
>+			while (dl_size > 0) {
>+				dlen = min_t(int, 1000, dl_size);
>+				if (first_block == 1) {
>+					flag = 1;
>+					first_block = 0;
>+				} else if (dl_size - dlen <= 0) {
>+					flag = 3;
>+				} else {
>+					flag = 2;
>+				}
>+
>+				wmt_params.flag = flag;
>+				wmt_params.dlen = dlen;
>+				wmt_params.data = fw_ptr;
>+
>+				err = btusb_mtk_hci_wmt_acl_sync(hdev, &wmt_params);
>+				if (err < 0) {
>+					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
>+						   err);
>+					goto err_release_fw;
>+				}
>+
>+				dl_size -= dlen;
>+				fw_ptr += dlen;
>+			}
>+		}
>+next_section:
>+		continue;

The continue seems to be redundant.

>+	}
>+	/* Wait a few moments for firmware activation done */
>+	usleep_range(100000, 120000);
>+
>+err_release_fw:
>+	release_firmware(fw);
>+
>+	return err;
>+}
>+
> static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)  {
>	struct btmtk_hci_wmt_params wmt_params; @@ -3555,9 +3823,9 @@ static int btusb_mtk_reg_read(struct btusb_data *data, u32 reg, u32 *val)
>	return err;
> }
>
>-static int btusb_mtk_id_get(struct btusb_data *data, u32 *id)
>+static int btusb_mtk_id_get(struct btusb_data *data, u32 reg, u32 *id)
> {
>-	return btusb_mtk_reg_read(data, 0x80000008, id);
>+	return btusb_mtk_reg_read(data, reg, id);

Move to a separate patch.

> }
>
> static int btusb_mtk_setup(struct hci_dev *hdev) @@ -3568,26 +3836,61 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>	struct btmtk_tci_sleep tci_sleep;
>	unsigned long long duration;
>	struct sk_buff *skb;
>-	const char *fwname;
>+	char fwname[64];
>	int err, status;
>	u32 dev_id;
>+	u32 fw_version;
>	u8 param;
>
>	calltime = ktime_get();
>
>-	err = btusb_mtk_id_get(data, &dev_id);
>+	err = btusb_mtk_id_get(data, 0x80000008, &dev_id);
>	if (err < 0) {
>		bt_dev_err(hdev, "Failed to get device id (%d)", err);
>		return err;
>	}
>
>+	if (dev_id == 0) {

if (!dev_id)

>+		err = btusb_mtk_id_get(data, 0x70010200, &dev_id);
>+		if (err < 0) {
>+			bt_dev_err(hdev, "Failed to get device id (%d)", err);
>+			return err;
>+		}
>+		err = btusb_mtk_id_get(data, 0x80021004, &fw_version);
>+		if (err < 0) {
>+			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
>+			return err;
>+		}
>+	}
>+
>	switch (dev_id) {
>	case 0x7663:
>-		fwname = FIRMWARE_MT7663;
>+		snprintf(fwname, sizeof(fwname), "mediatek/mt%04xpr2h.bin",
>+			 dev_id & 0xffff);
>		break;
>	case 0x7668:
>-		fwname = FIRMWARE_MT7668;
>+		snprintf(fwname, sizeof(fwname), "mediatek/mt%04xpr2h.bin",
>+			 dev_id & 0xffff);
>		break;
>+	case 0x7961:
>+		snprintf(fwname, sizeof(fwname), "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
>+			 dev_id & 0xffff, (fw_version & 0xff) + 1);
>+		err = btusb_mtk_setup_firmware_79xx(hdev, fwname);
>+
>+		/* Enable Bluetooth protocol */
>+		param = 1;
>+		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
>+		wmt_params.flag = 0;
>+		wmt_params.dlen = sizeof(param);
>+		wmt_params.data = &param;
>+		wmt_params.status = NULL;
>+
>+		err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
>+		if (err < 0) {
>+			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
>+			return err;
>+		}
>+		goto done;
>	default:
>		bt_dev_err(hdev, "Unsupported support hardware variant (%08x)",
>			   dev_id);
>@@ -3665,6 +3968,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>	}
>	kfree_skb(skb);
>
>+done:
>	rettime = ktime_get();
>	delta = ktime_sub(rettime, calltime);
>	duration = (unsigned long long)ktime_to_ns(delta) >> 10; @@ -3696,9 +4000,6 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
>	return 0;
> }
>
>-MODULE_FIRMWARE(FIRMWARE_MT7663);
>-MODULE_FIRMWARE(FIRMWARE_MT7668);

Move to a separate patch.

You should have the separate patches listed in the following order suggested to be
1. the common patch for mt7663 and mt7921
2. the specific patch for mt7663 driver
3. the patch for hci_prepare_acl and __hci_acl_send
4. the specific patch for mt7921 driver

>-
> #ifdef CONFIG_PM
> /* Configure an out-of-band gpio as wake-up pin, if specified in device tree */  static int marvell_config_oob_wake(struct hci_dev *hdev)
>--
>2.18.0
>
>
