Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE9AC48BCD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 19:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F9E613F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 19:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhFITXk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:23:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39483 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFITXk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 15:23:40 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 74F9FCECD6;
        Wed,  9 Jun 2021 21:29:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Support Bluetooth Reset for
 Mediatek Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210609190734.30088-2-mark-yw.chen@mediatek.com>
Date:   Wed, 9 Jun 2021 21:21:43 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, sean.wang@mediatek.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <64F8C06F-B2E7-4FA3-9FA4-D19F566BA06F@holtmann.org>
References: <20210609190734.30088-1-mark-yw.chen@mediatek.com>
 <20210609190734.30088-2-mark-yw.chen@mediatek.com>
To:     mark-yw.chen@mediatek.com
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
> drivers/bluetooth/btusb.c | 145 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 145 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2a55ae0a5f8c..acc23afbfe0f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3075,6 +3075,18 @@ static int btusb_shutdown_intel_new(struct hci_dev *hdev)
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
> @@ -3649,6 +3661,59 @@ static int btusb_mtk_func_query(struct hci_dev *hdev)
> 	return status;
> }
> 
> +static int btusb_mtk_uhw_reg_write(struct btusb_data *data, u32 reg, u32 val)
> +{
> +	int pipe, err, size = sizeof(u32);
> +	u8 buf[4];
> +
> +	buf[0] = (val & 0x00ff);
> +	buf[1] = ((val >> 8) & 0x00ff);
> +	buf[2] = ((val >> 16) & 0x00ff);
> +	buf[3] = ((val >> 24) & 0x00ff);

can we not just just put_unalined_le32 in these cases.

> +
> +	pipe = usb_sndctrlpipe(data->udev, 0);
> +	err = usb_control_msg(data->udev, pipe, 0x02,
> +			      0x5E,
> +			      reg >> 16, reg & 0xffff,
> +			      buf, size, USB_CTRL_SET_TIMEOUT);

The extra size variable is pointless.

> +	if (err < 0) {
> +		BT_ERR("Failed to write uhw reg(%d)", err);

Please use bt_dev_err.

> +		goto err_free_buf;
> +	}
> +
> +err_free_buf:
> +
> +	return err;
> +}
> +
> +static int btusb_mtk_uhw_reg_read(struct btusb_data *data, u32 reg, u32 *val)
> +{
> +	int pipe, err, size = sizeof(u32);
> +	void *buf;
> +
> +	buf = kzalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;

Pointless size variable. Just use the value 4.

> +
> +	pipe = usb_rcvctrlpipe(data->udev, 0);
> +	err = usb_control_msg(data->udev, pipe, 0x01,
> +			      0xDE,
> +			      reg >> 16, reg & 0xffff,
> +			      buf, size, USB_CTRL_SET_TIMEOUT);
> +	if (err < 0) {
> +		BT_ERR("Failed to read uhw reg(%d)", err);
> +		goto err_free_buf;
> +	}
> +
> +	*val = get_unaligned_le32(buf);
> +	BT_INFO("%s: reg=%x, value=0x%08x", __func__, reg, *val);
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
> @@ -3728,6 +3793,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
> 			 dev_id & 0xffff, (fw_version & 0xff) + 1);
> 		err = btusb_mtk_setup_firmware_79xx(hdev, fw_bin_name);
> 
> +		btusb_mtk_uhw_reg_write(data, EP_RST_OPT, EP_RST_IN_OUT_OPT);

Extra line below and comment above on what this is doing.

> 		/* Enable Bluetooth protocol */
> 		param = 1;
> 		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
> @@ -3851,6 +3917,84 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	u32 val;
> +	int err, retry = 0;
> +
> +	/*
> +	 * Toggle the bluetooth reset via usb. It's mediatek spicific reset
> +	 * mechanism, and the reset flow won't replug the USB. Thus, it must
> +	 * handle the urb transaction, such as stop_traffic and submit_urb.
> +	 * After bluetooth reset completed, we will re-download the firmware
> +	 * and send hw_err to host.
> +	 */

Wrong comment style.

> +	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> +		bt_dev_err(hdev, "last reset failed? Not resetting again");
> +		return;
> +	}
> +
> +	if (enable_autosuspend)
> +		usb_disable_autosuspend(data->udev);
> +
> +	data->sco_num = 0;
> +
> +	btusb_stop_traffic(data);
> +	usb_kill_anchored_urbs(&data->tx_anchor);
> +
> +	/* For reset */
> +	bt_dev_info(hdev, "Initiating reset mechanism via uhw");

Extra empty line.

> +	/*
> +	 * Todo - add error handling for usb no response case and uhw
> +	 * something worng.
> +	 */

Wrong comment style.

> +	btusb_mtk_uhw_reg_write(data, EP_RST_OPT, EP_RST_IN_OUT_OPT);
> +	btusb_mtk_uhw_reg_read(data, BT_WDT_STATUS, &val);
> +
> +	/* Write Reset CR to 1 */
> +	btusb_mtk_uhw_reg_write(data, BT_SUBSYS_RST, 1);
> +
> +	btusb_mtk_uhw_reg_write(data, UDMA_INT_STA_BT, 0x000000FF);
> +	btusb_mtk_uhw_reg_read(data, UDMA_INT_STA_BT, &val);
> +	btusb_mtk_uhw_reg_write(data, UDMA_INT_STA_BT1, 0x000000FF);
> +	btusb_mtk_uhw_reg_read(data, UDMA_INT_STA_BT1, &val);
> +	msleep(1);
> +
> +	/* Write Reset CR to 0 */
> +	btusb_mtk_uhw_reg_write(data, BT_SUBSYS_RST, 0);
> +
> +	/* Read reset CR */
> +	btusb_mtk_uhw_reg_read(data, BT_SUBSYS_RST, &val);
> +
> +	do {
> +		btusb_mtk_uhw_reg_read(data, BT_MISC, &val);
> +		if ((val & 0x00000100) == BT_RST_DONE) {
> +			bt_dev_info(hdev, "Bluetooth Reset Sucessfully");
> +			break;
> +		} else
> +			bt_dev_dbg(hdev, "Polling Bluetooth Reset CR");

Close here as well with { }.

> +
> +		retry++;
> +		msleep(BT_RESET_WAIT_MS);
> +	} while (retry < BT_RESET_NUM_TRIES);
> +
> +	btusb_mtk_id_get(data, 0x70010200, &val);
> +	bt_dev_info(hdev, "device id (%x)", val);
> +
> +	err = btusb_mtk_setup(hdev);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "mtk_setup failed, err = %d", err);
> +		return;
> +	}
> +	hci_reset_dev(hdev);
> +
> +	if (enable_autosuspend)
> +		usb_enable_autosuspend(data->udev);
> +
> +	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
> +}
> +
> static int btusb_recv_bulk_mtk(struct btusb_data *data, void *buffer, int count)
> {
> 	struct sk_buff *skb;
> @@ -4736,6 +4880,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->shutdown = btusb_mtk_shutdown;
> 		hdev->manufacturer = 70;
> 		data->recv_bulk = btusb_recv_bulk_mtk;
> +		hdev->cmd_timeout = btusb_mtk_cmd_timeout;
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> 	}

Regards

Marcel

