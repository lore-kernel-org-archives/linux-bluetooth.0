Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B75C64E7B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 17:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2734B2073C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 17:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgK3RGK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 12:06:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48091 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgK3RGK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 12:06:10 -0500
Received: from [172.20.10.2] (tmo-111-84.customers.d1-online.com [80.187.111.84])
        by mail.holtmann.org (Postfix) with ESMTPSA id BFB17CED17;
        Mon, 30 Nov 2020 18:12:41 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] Bluetooth: btusb: Add a parameter to load fw forcibly for
 Intel BT
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201130052753.111742-1-hui.wang@canonical.com>
Date:   Mon, 30 Nov 2020 18:05:28 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <116CA1BC-A38E-4622-99D7-91C7DF6EA463@holtmann.org>
References: <20201130052753.111742-1-hui.wang@canonical.com>
To:     Hui Wang <hui.wang@canonical.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hui,

> On the machines with Intel new BT module, if users run reboot, the BT
> driver will not load the firmware from rootfs during boot since it is
> already in operational mode. This will confuse the users if users
> update the BT firmware and expect the updated firmware to fix some
> problems.
> 
> Let the driver print a message to tell users the firmware is not
> loaded and add a module parameter to let driver forcibly load the
> firmware from rootfs. After users read this message, they could set
> this parameter to load the firmware forcibly.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1005b6e8ff74..d4fceedd354b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -32,6 +32,7 @@ static bool force_scofix;
> static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
> 
> static bool reset = true;
> +static bool force_load_fw;
> 
> static struct usb_driver btusb_driver;
> 
> @@ -2589,8 +2590,15 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 		return err;
> 
> 	/* controller is already having an operational firmware */
> -	if (ver.fw_variant == 0x23)
> +	if (ver.fw_variant == 0x23) {
> +		if (force_load_fw) {
> +			btintel_reset_to_bootloader(hdev);
> +			force_load_fw = false;
> +			return -EAGAIN;
> +		}
> +		bt_dev_info(hdev, "already in operational mode, not load fw. Set force_load_fw=1 to load fw forcibly");
> 		goto finish;
> +	}

I don’t like this approach. I rather do this in a more generic way that resets the controller and puts it into boot loader support if support. We can use the experimental mgmt setting for this.

Regards

Marcel

