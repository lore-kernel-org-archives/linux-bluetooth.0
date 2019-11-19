Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7BCC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 05:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D350F2231A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 05:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKSFRf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:17:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33642 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKSFRf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 00:17:35 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 28E48CECED;
        Tue, 19 Nov 2019 06:26:40 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] bluetooth: bcm: Set HCI_QUIRK_USE_BDADDR_PROPERTY for
 default addresses
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191118124930.2138112-1-a.heider@gmail.com>
Date:   Tue, 19 Nov 2019 06:17:33 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <C93EA7BC-7CCF-48B1-80DA-FD8DF8F5AF53@holtmann.org>
References: <20191118124930.2138112-1-a.heider@gmail.com>
To:     Andre Heider <a.heider@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andre,

> Some devices ship with the controller default address, like the
> Orange Pi 3 (BCM4345C5).
> 
> Allow the bootloader to set a valid address through the device tree.
> 
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
> drivers/bluetooth/btbcm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 2d2e6d862068..e1471777486e 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -79,7 +79,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
> 	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
> 		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
> 			    &bda->bdaddr);
> -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> 	}

I am not sure the change is this simple. What happens if you run on a boot-loader that doesn’t provide the address and has an invalid address.

When I allowed HCI_QUIRK_USE_BDADDR_PROPERTY to be added, I stated clearly that the intent was that userspace can handle the address setup and this was pretty much just for the existing hardware where we have some magic boot-loader to do this.

Anyhow, I am fine allowing this here as well. However the HCI_QUIRK_USE_BDADDR_PROPERTY needs to be set unconditionally in the hdev->setup routine. And in case there still is an invalid address we need to stick with invalid address. Right now the code in hci_dev_do_open() operates differently.

Regards

Marcel

