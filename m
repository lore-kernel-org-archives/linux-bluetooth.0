Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9D3C55179
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 01:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DAA206E9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 01:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgJ2By0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:54:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:14628 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbgJ1V45 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:56:57 -0400
IronPort-SDR: KWVnsAKbknKgls36eXbo/y333QyPZAmYYCCm29yyQtD/EotLEGr3mWn/cMHnE3F/BbDAqAkV8m
 o52zIoBsoh4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="156109122"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="156109122"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 13:53:42 -0700
IronPort-SDR: zs4ofXDxmzf+PIACNTAeVfIdJ/u0mXupUDiLHRV5kTv0wj1fQUfkvv6mG5Vq8JLLDZe0i91myX
 GRJT0yUapIpA==
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="304211743"
Received: from unknown (HELO han1-XPS-13-9350.jf.intel.com) ([10.54.74.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 13:53:42 -0700
Message-ID: <bfffd8d6aa12279163bec589994d03c091434ec1.camel@linux.intel.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 0cb5:c547 Realtek
 8822CE device
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     David Zakarias <david.zakarias@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 28 Oct 2020 13:53:29 -0700
In-Reply-To: <CAC_SeizxoD1PkNHWYg1FcV9x6tote2JyJNX3Kwu3XtHkCF+FPQ@mail.gmail.com>
References: <CAC_SeizxoD1PkNHWYg1FcV9x6tote2JyJNX3Kwu3XtHkCF+FPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Tue, 2020-10-27 at 21:52 +0100, David Zakarias wrote:
> My Redmibook 16 AMD laptop contains the RTL8822CE chip having the USB
> identifier 0cb5:c547. This patch adds this Id to btusb.c's blacklist
> table, enabling the loading of the Realtek firmware.
> This, together with another patch by Edward Vear (hci_core: Fix
> attempting to set RPA timeout when unsupported, see
> https://marc.info/?l=linux-bluetooth&m=160378222632366&w=2) makes my
> bluetooth mouse work.
> 
> Signed-off-by: David Zakarias <david.zakarias@gmail.com>
> ---
> --- bluetooth/drivers/bluetooth/btusb.c.orig 2020-10-27 21:24:51.331035974
> +0100
> +++ bluetooth/drivers/bluetooth/btusb.c 2020-10-27 21:21:46.000000000 +0100
> @@ -386,6 +386,7 @@ static const struct usb_device_id blackl
> 
>   /* Additional Realtek 8822CE Bluetooth devices */
>   { USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
> + { USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK },
> 
>   /* Silicon Wave based devices */
>   { USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },

Please include the content of /sys/kernel/debug/usb/devices for this device in
the commit message.

Regards,

Tedd Ho-Jeong An

