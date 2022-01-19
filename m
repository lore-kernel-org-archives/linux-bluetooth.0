Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 17:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356289AbiASREb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:04:31 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54704 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354529AbiASREb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 12:04:31 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1BAC2CECDE;
        Wed, 19 Jan 2022 18:04:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: Add support for Realtek 8761BU Bluetooth
 receivers of ID 2550:8761
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c821e1bd-dcee-fa4b-93c3-29279756315d@1045.ca>
Date:   Wed, 19 Jan 2022 18:04:29 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5C1D232A-F174-44F3-897D-5F8A3A50CF8F@holtmann.org>
References: <c821e1bd-dcee-fa4b-93c3-29279756315d@1045.ca>
To:     Bruce Link <bruce@1045.ca>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bruce,

> Add support for Realtek 8761BU Bluetooth receivers of ID 2550:8761 by
> adding the appropriate ID to btusb.c to cause firmware to load.
> e.g.: EDUP EP-B2536, MPOW BH519A, MPOW BH456A
> 
> Signed-off-by: Bruce Link <bruce@1045.ca>
> ---
> N.B. I am able to successfully test this patch on my own system, but
> cannot meet the requirement of 4 other systems due to lack of
> availability. I hope this is acceptable given the small scope of the
> patch.
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c30d131da784..16254681e162 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -482,6 +482,9 @@ static const struct usb_device_id blacklist_table[] = {
>         /* Additional Realtek 8761BU Bluetooth devices */
>         { USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
> BTUSB_WIDEBAND_SPEECH },
> +       { USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
> + BTUSB_WIDEBAND_SPEECH },
> +
> 
>         /* Additional Realtek 8821AE Bluetooth devices */
>         { USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },

please provide a patch that is garbled and include usb/devices info.

Regards

Marcel

