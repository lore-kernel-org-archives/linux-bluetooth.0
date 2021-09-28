Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B848C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 11:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8159960F4A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 11:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbhI1LOD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 07:14:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56312 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbhI1LOD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 07:14:03 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 55A9ECECD9;
        Tue, 28 Sep 2021 13:12:20 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v4 4/4] Bluetooth: btusb: enable Mediatek MT7921 to
 support AOSP extension
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210926150657.v4.4.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
Date:   Tue, 28 Sep 2021 13:12:19 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, josephsih@google.com,
        chromeos-bluetooth-upstreaming@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <192E0207-7D40-4A45-9254-7C103921DDD6@holtmann.org>
References: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
 <20210926150657.v4.4.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> This patch enables Mediatek MT7921 to support the AOSP extension.
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> 
> ---
> 
> Changes in v4:
> - Call hci_set_aosp_capable in the driver.
> - This patch is added in this Series-changes 4.
> 
> drivers/bluetooth/btusb.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index da85cc14f931..de0228e2245b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_VALID_LE_STATES   0x800000
> #define BTUSB_QCA_WCN6855	0x1000000
> #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
> +#define BTUSB_AOSP		0x8000000
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -394,6 +395,7 @@ static const struct usb_device_id blacklist_table[] = {
> 	/* MediaTek Bluetooth devices */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
> 	  .driver_info = BTUSB_MEDIATEK |
> +			 BTUSB_AOSP |
> 			 BTUSB_WIDEBAND_SPEECH |
> 			 BTUSB_VALID_LE_STATES },
> 
> @@ -407,6 +409,7 @@ static const struct usb_device_id blacklist_table[] = {
> 
> 	/* Additional MediaTek MT7921 Bluetooth devices */
> 	{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_AOSP |
> 						     BTUSB_WIDEBAND_SPEECH |
> 						     BTUSB_VALID_LE_STATES },
> 	{ USB_DEVICE(0x13d3, 0x3563), .driver_info = BTUSB_MEDIATEK |
> @@ -3867,6 +3870,9 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->set_bdaddr = btusb_set_bdaddr_mtk;
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> 		data->recv_acl = btusb_recv_acl_mtk;
> +
> +		if (id->driver_info & BTUSB_AOSP)
> +			hci_set_aosp_capable(hdev);
> 	}

so I don’t like this. Do we have Mediatek devices that don’t support the AOSP extensions and can’t we determine via some vendor command what features are supported? I do not want to clutter btusb.c any further. The vendor specific setup should be able to figure out what the hardware supports and what it doesn’t.

Regards

Marcel

