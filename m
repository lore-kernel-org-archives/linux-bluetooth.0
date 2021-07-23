Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0507EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 12:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE3560720
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 12:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhGWLih convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:38:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38078 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhGWLih (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 07:38:37 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id 88606CECE3;
        Fri, 23 Jul 2021 14:19:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] Bluetooth: btusb: check conditions before enabling USB
 ALT 3 for WBS
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <b86543908684cc6cd9afaf4de10fac7af1a49665.camel@iki.fi>
Date:   Fri, 23 Jul 2021 14:19:09 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Content-Transfer-Encoding: 8BIT
Message-Id: <872F0B33-594E-4BD7-8B75-EA96DE8DBA8F@holtmann.org>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
 <b86543908684cc6cd9afaf4de10fac7af1a49665.camel@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

> Some USB BT adapters don't satisfy the MTU requirement mentioned in
> commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> and have ALT 3 setting that produces no/garbled audio. Some adapters
> with larger MTU were also reported to have problems with ALT 3.
> 
> Add a flag and check it and MTU before selecting ALT 3, falling back to
> ALT 1. Enable the flag for Realtek, restoring the previous behavior for
> non-Realtek devices.
> 
> Tested with USB adapters (mtu<72, no/garbled sound with ALT3, ALT1
> works) BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3
> works) RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling
> ALT6). Also got reports for (mtu>=72, ALT 3 reported to produce bad
> audio) Intel 8087:0a2b.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> Fixes: e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")

before I will apply this, I need Tested-by or Ack-by people that confirm that this fixes their issues now.

> ---
> 
> Changes in v2:
> - Explain magic number 72 in a comment; didn't add the table for them,
>  because it's not used elsewhere and we need just one number from it.
> - Add flag for ALT3 support, restoring the behavior
>  for non-Realtek devices the same as before e848dbd364ac, due to
>  the problems reported on an Intel adapter. Don't have the device
>  myself.
> 
> drivers/bluetooth/btusb.c | 22 ++++++++++++++--------
> 1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 6d23308119d1..5cec719f6cba 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -516,6 +516,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
> #define BTUSB_HW_RESET_ACTIVE	12
> #define BTUSB_TX_WAIT_VND_EVT	13
> #define BTUSB_WAKEUP_DISABLE	14
> +#define BTUSB_ALT3_OK_FOR_WBS	15

Rename this to BTUSB_USE_ALT3_FOR_WBS.

> 
> struct btusb_data {
> 	struct hci_dev       *hdev;
> @@ -1748,16 +1749,20 @@ static void btusb_work(struct work_struct *work)
> 			/* Bluetooth USB spec recommends alt 6 (63 bytes), but
> 			 * many adapters do not support it.  Alt 1 appears to
> 			 * work for all adapters that do not have alt 6, and
> -			 * which work with WBS at all.
> +			 * which work with WBS at all.  Some devices prefer
> +			 * alt 3 (HCI payload >= 60 Bytes let air packet
> +			 * data satisfy 60 bytes), requiring
> +			 * MTU >= 3 (packets) * 25 (size) - 3 (headers) = 72
> +			 * see also Core spec 5, vol 4, B 2.1.1 & Table 2.1.
> 			 */
> -			new_alts = btusb_find_altsetting(data, 6) ? 6 : 1;
> -			/* Because mSBC frames do not need to be aligned to the
> -			 * SCO packet boundary. If support the Alt 3, use the
> -			 * Alt 3 for HCI payload >= 60 Bytes let air packet
> -			 * data satisfy 60 bytes.
> -			 */
> -			if (new_alts == 1 && btusb_find_altsetting(data, 3))
> +			if (btusb_find_altsetting(data, 6))
> +				new_alts = 6;
> +			else if (test_bit(BTUSB_ALT3_OK_FOR_WBS, &data->flags) &&
> +				 hdev->sco_mtu >= 72 &&
> +				 btusb_find_altsetting(data, 3))

This is whitespace damaged.

> 				new_alts = 3;
> +			else
> +				new_alts = 1;
> 		}
> 
> 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
> @@ -4733,6 +4738,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		 * (DEVICE_REMOTE_WAKEUP)
> 		 */
> 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
> +		set_bit(BTUSB_ALT3_OK_FOR_WBS, &data->flags);
> 	}

Regards

Marcel

