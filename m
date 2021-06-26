Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA026C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF72861948
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFZFxF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 01:53:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52989 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhFZFxE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 01:53:04 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id 57624CED1E;
        Sat, 26 Jun 2021 07:50:41 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Support Bluetooth Reset for
 Mediatek Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210622160255.14906-1-mark-yw.chen@mediatek.com>
Date:   Sat, 26 Jun 2021 07:50:40 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <24BB7F3A-340A-454A-B20C-B75BDACCDB68@holtmann.org>
References: <20210622160255.14906-1-mark-yw.chen@mediatek.com>
To:     Mark-YW.Chen@mediatek.com
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> This change enable Mediatek reset mechanism via USB, it's a specific
> reset mechanism with Mediatek chips. To handle error recovery, it use
> the cmd_timoeut to reset Mediatek Bluetooth.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 138 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 138 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0a86713f496b..e8ad8ca4d346 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3076,6 +3076,18 @@ static int btusb_shutdown_intel_new(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +/* UHW CR mapping */
> +#define BT_MISC			0x70002510
> +#define BT_SUBSYS_RST		0x70002610
> +#define UDMA_INT_STA_BT		0x74000024
> +#define UDMA_INT_STA_BT1	0x74000308
> +#define BT_WDT_STATUS		0x740003A0
> +#define EP_RST_OPT		0x74011890
> +#define EP_RST_IN_OUT_OPT	0x00010001
> +#define BT_RST_DONE		0x00000100
> +#define BT_RESET_WAIT_MS	100
> +#define BT_RESET_NUM_TRIES	10
> +
> #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
> #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
> 
> @@ -3650,6 +3662,63 @@ static int btusb_mtk_func_query(struct hci_dev *hdev)
> 	return status;
> }
> 
> +static int btusb_mtk_uhw_reg_write(struct btusb_data *data, u32 reg, u32 val)
> +{
> +	struct hci_dev *hdev = data->hdev;
> +	int pipe, err;
> +	void *buf;
> +
> +	buf = kzalloc(4, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	put_unaligned_le32(val, buf);
> +
> +	pipe = usb_sndctrlpipe(data->udev, 0);
> +	err = usb_control_msg(data->udev, pipe, 0x02,
> +			      0x5E,
> +			      reg >> 16, reg & 0xffff,
> +			      buf, 4, USB_CTRL_SET_TIMEOUT);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to write uhw reg(%d)", err);
> +		goto err_free_buf;
> +	}
> +
> +err_free_buf:
> +	kfree(buf);
> +
> +	return err;
> +}
> +
> +static int btusb_mtk_uhw_reg_read(struct btusb_data *data, u32 reg, u32 *val)
> +{
> +	struct hci_dev *hdev = data->hdev;
> +	int pipe, err;
> +	void *buf;
> +
> +	buf = kzalloc(4, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	pipe = usb_rcvctrlpipe(data->udev, 0);
> +	err = usb_control_msg(data->udev, pipe, 0x01,
> +			      0xDE,
> +			      reg >> 16, reg & 0xffff,
> +			      buf, 4, USB_CTRL_SET_TIMEOUT);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to read uhw reg(%d)", err);
> +		goto err_free_buf;
> +	}
> +
> +	*val = get_unaligned_le32(buf);
> +	bt_dev_info(hdev, "%s: reg=%x, value=0x%08x", __func__, reg, *val);

these are a) no _info messages and b) we are not adding __func__ anywhere. Please turn them into bt_dev_dbg or remove them.

> +
> +err_free_buf:
> +	kfree(buf);
> +
> +	return err;
> +}
> +
> static int btusb_mtk_reg_read(struct btusb_data *data, u32 reg, u32 *val)
> {
> 	int pipe, err, size = sizeof(u32);
> @@ -3729,6 +3798,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
> 			 dev_id & 0xffff, (fw_version & 0xff) + 1);
> 		err = btusb_mtk_setup_firmware_79xx(hdev, fw_bin_name);
> 
> +		/* It's Device EndPoint Reset Option Register */
> +		btusb_mtk_uhw_reg_write(data, EP_RST_OPT, EP_RST_IN_OUT_OPT);
> +
> 		/* Enable Bluetooth protocol */
> 		param = 1;
> 		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
> @@ -3852,6 +3924,71 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	u32 val;
> +	int err, retry = 0;
> +
> +	/* It's MediaTek specific bluetooth reset mechanism via USB */
> +	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> +		bt_dev_err(hdev, "last reset failed? Not resetting again");
> +		return;
> +	}
> +
> +	if (enable_autosuspend)
> +		usb_disable_autosuspend(data->udev);
> +
> +	data->sco_num = 0;

don’t touch this one. If you have to, then something in the core is wrong.

> +
> +	btusb_stop_traffic(data);
> +	usb_kill_anchored_urbs(&data->tx_anchor);
> +
> +	/* It's Device EndPoint Reset Option Register */
> +	bt_dev_info(hdev, "Initiating reset mechanism via uhw");
> +	btusb_mtk_uhw_reg_write(data, EP_RST_OPT, EP_RST_IN_OUT_OPT);
> +	btusb_mtk_uhw_reg_read(data, BT_WDT_STATUS, &val);
> +
> +	/* MediaTek Bluetooht Reset */
> +	btusb_mtk_uhw_reg_write(data, BT_SUBSYS_RST, 1);
> +	btusb_mtk_uhw_reg_write(data, UDMA_INT_STA_BT, 0x000000FF);
> +	btusb_mtk_uhw_reg_read(data, UDMA_INT_STA_BT, &val);
> +	btusb_mtk_uhw_reg_write(data, UDMA_INT_STA_BT1, 0x000000FF);
> +	btusb_mtk_uhw_reg_read(data, UDMA_INT_STA_BT1, &val);
> +	msleep(20);
> +	btusb_mtk_uhw_reg_write(data, BT_SUBSYS_RST, 0);
> +	btusb_mtk_uhw_reg_read(data, BT_SUBSYS_RST, &val);
> +
> +	/* Poll the register until reset is completed */
> +	do {
> +		btusb_mtk_uhw_reg_read(data, BT_MISC, &val);
> +		if ((val & 0x00000100) == BT_RST_DONE) {
> +			bt_dev_info(hdev, "Bluetooth Reset Successfully");
> +			break;
> +		}
> +
> +		bt_dev_dbg(hdev, "Polling Bluetooth Reset CR");
> +		retry++;
> +		msleep(BT_RESET_WAIT_MS);
> +	} while (retry < BT_RESET_NUM_TRIES);
> +
> +	btusb_mtk_id_get(data, 0x70010200, &val);
> +	bt_dev_info(hdev, "device id (%x)", val);
> +
> +	/* Re-Setup Mediatek device */
> +	err = btusb_mtk_setup(hdev);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "mtk_setup failed, err = %d", err);
> +		return;
> +	}

And we are not going to do that. You need to indicate somehow to the core that the device has to re-run hdev->setup. This is not the way.

Please stop hacking this together. I would advise to actually describe how your hardware works and what are the steps needed to bring it back to life. It looks like you could that in the commit message or in a comment, but this is not going to work. And you put all the work on me to untangle it.

> +	hci_reset_dev(hdev);
> +
> +	if (enable_autosuspend)
> +		usb_enable_autosuspend(data->udev);
> +
> +	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
> +}
> +
> static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> @@ -4689,6 +4826,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->setup = btusb_mtk_setup;
> 		hdev->shutdown = btusb_mtk_shutdown;
> 		hdev->manufacturer = 70;
> +		hdev->cmd_timeout = btusb_mtk_cmd_timeout;
> 		data->recv_acl = btusb_recv_acl_mtk;
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> 	}

Regards

Marcel

