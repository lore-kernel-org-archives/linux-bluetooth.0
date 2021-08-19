Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39BDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8812261053
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 14:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhHSOq5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:46:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47809 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbhHSOq5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 10:46:57 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 61698CED16;
        Thu, 19 Aug 2021 16:46:17 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: btusb: add a reject table to disable msft
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210819135927.49715-1-koba.ko@canonical.com>
Date:   Thu, 19 Aug 2021 16:46:16 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5ACE5105-138E-4972-A2FC-6CF029D8F729@holtmann.org>
References: <20210819135927.49715-1-koba.ko@canonical.com>
To:     Koba Ko <koba.ko@canonical.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Koba,

> With Intel AC9560, follow this scenario and can't turn on bt since.
> 1. turn off BT
> 2. then suspend&resume multiple times
> 3. turn on BT
> 
> Get this error message after turn on bt.
> [ 877.194032] Bluetooth: hci0: urb 0000000061b9a002 failed to resubmit (113)
> [ 886.941327] Bluetooth: hci0: Failed to read MSFT supported features (-110)
> 
> Remove msft from compilation would be helpful.
> Turn off msft would be also helpful.
> 
> As per Intel's comment, For AC9560, in JSL the hw_variant is 0x13.
> In GLK, the hw_variant is 0x11. can't use hw_variant to filter for
> AC9560.
> Only AC9560 encounter this issue, so add a reject table to
> disable msft for AC9560.
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9855a2dd561..3c131fd40869 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -479,6 +479,11 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ }	/* Terminating entry */
> };
> 
> +static const struct usb_device_id msft_rej_table[] = {
> +	{ USB_DEVICE(0x8087, 0x0aaa) },
> +	{ }	/* Terminating entry */
> +};
> +
> /* The Bluetooth USB module build into some devices needs to be reset on resume,
>  * this is a problem with the platform (likely shutting off all power) not with
>  * the module itself. So we use a DMI list to match known broken platforms.
> @@ -2851,6 +2856,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	char ddcname[64];
> 	int err;
> 	struct intel_debug_features features;
> +	struct usb_device_id *match;
> 
> 	BT_DBG("%s", hdev->name);
> 
> @@ -2928,7 +2934,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	case 0x12:	/* ThP */
> 	case 0x13:	/* HrP */
> 	case 0x14:	/* CcP */
> -		hci_set_msft_opcode(hdev, 0xFC1E);
> +		match = usb_match_id(data->intf, msft_rej_table);
> +		if (!match)
> +			hci_set_msft_opcode(hdev, 0xFC1E);
> 		break;
> 	}

actually _no_, we are not doing this either.

We just got rid of the per USB VID:PID mess around Intel hardware and I don’t want to add it back. The Intel guys need to figure this out, otherwise, we remove 0x14 /* CcP */ from the list of MSFT extension support.

Regards

Marcel

