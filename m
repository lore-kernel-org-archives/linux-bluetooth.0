Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CD7C4363D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48434206DD
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 08:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJCI1I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 04:27:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38952 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJCI1I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 04:27:08 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0002FCECFA;
        Sat,  3 Oct 2020 10:34:06 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v5 1/2] Bluetooth: btusb: use usb vid/pid for initializing
 hal callbacks
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1601712179-13540-1-git-send-email-kiran.k@intel.com>
Date:   Sat, 3 Oct 2020 10:27:06 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Kiran K <kiran.k@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5B30E5BC-6631-40C3-8EDE-C69E62064D35@holtmann.org>
References: <1601712179-13540-1-git-send-email-kiran.k@intel.com>
To:     Kiran K <kiraank@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> For Intel controllers, use vid/pid for initalizing hardware abstraction
> layer callbacks to avoid defining new quirk flags for new products.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> Changes in v5:
> * Use usb vid/pid combination to identify controller type istead of using flags
> 
> Changes in previous versions:
> None. This is a new patch created part of v5
> 
> drivers/bluetooth/btusb.c | 79 ++++++++++++++++++++++++++++-------------------
> 1 file changed, 48 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1005b6e..e2cd78d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3969,13 +3969,21 @@ static int btusb_probe(struct usb_interface *intf,
> 	init_usb_anchor(&data->ctrl_anchor);
> 	spin_lock_init(&data->rxlock);
> 
> -	if (id->driver_info & BTUSB_INTEL_NEW) {
> -		data->recv_event = btusb_recv_event_intel;
> -		data->recv_bulk = btusb_recv_bulk_intel;
> -		set_bit(BTUSB_BOOTLOADER, &data->flags);
> -	} else {
> -		data->recv_event = hci_recv_frame;
> -		data->recv_bulk = btusb_recv_bulk;
> +	data->recv_event = hci_recv_frame;
> +	data->recv_bulk = btusb_recv_bulk;
> +
> +	if (id->idVendor == 0x8087) {
> +		switch (id->idProduct) {
> +		case 0x0025:
> +		case 0x0026:
> +		case 0x0029:
> +		case 0x0a2b:
> +		case 0x0aaa:
> +			data->recv_event = btusb_recv_event_intel;
> +			data->recv_bulk = btusb_recv_bulk_intel;
> +			set_bit(BTUSB_BOOTLOADER, &data->flags);
> +			break;
> +		}
> 	}

please don’t do this. This is exactly what I didn’t want. Listing PID in the device table and then also again in the probe callback is bound to be error prone.

Regards

Marcel

