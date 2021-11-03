Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A82C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 18:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A5561053
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 18:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCSZl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:25:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36151 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229999AbhKCSZk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 14:25:40 -0400
Received: (qmail 1532068 invoked by uid 1000); 3 Nov 2021 14:23:03 -0400
Date:   Wed, 3 Nov 2021 14:23:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: Userspace enumeration hang while btusb tries to load firmware of
 removed device
Message-ID: <20211103182303.GB1529362@rowland.harvard.edu>
References: <df021873788acdb64e1311289e9ca6dc3f169616.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df021873788acdb64e1311289e9ca6dc3f169616.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 03, 2021 at 03:55:31PM +0100, Benjamin Berg wrote:
> Hi,
> 
> a user is seeing a hang in fprintd while enumerating devices which
> appears to be caused by an interaction of:
> 
> * system is resuming from S3
> * btusb starts loading firmware
> * bluetooth device disappears (probably thinkpad_acpi rfkill)
> * libusb enumerates USB devices (fprintd in this case)
> 
> When this happens, the firmware load fails after a timeout of 10s. It
> appears that if userspace queries information about the root hub in
> question during this time, it will hang until the btusb firmware load
> has timed out.
> 
> Attaching the full kernel log, below an excerpt, you can see:
>  * At :12 device removal: "usb 5-4: USB disconnect, device number 33"
>  * libusb enumeration retrieves information about the usb5 root hub,
>    and blocks on this
>  * At :14 there is a tx timeout on hci0
>  * At :23 the firmware load finally fails
>  * Then usb_disable_device happens
>  * libusb/fprintd gets the usb5 HUB information and continues its
>    enumeration
> 
> As I see it, there may be two issues:
> 1. userspace should not block due to the firmware load hanging
> 2. btusb should give up more quickly when the device disappears
> 
> Does anyone have a good idea about the possible cause or how we can fix
> the problem?
> 
> Downstream issue: https://bugzilla.redhat.com/show_bug.cgi?id=2019857

I'm not familiar with the btusb driver, so someone on the 
linux-bluetooth mailing list would have a better idea about this. 
However, it does look as though btusb keeps the device locked during the 
entire 10-second period while it tries to send over the firmware, and it 
doesn't abort the procedure when it starts getting disconnection errors 
but instead persists until a timeout expires.  Keeping the device locked 
would certainly block lsusb.

In general, locking the device during a firmware upload seems like
the right thing to do -- you don't want extraneous transfers from
other processes messing up the firmware!  So overall, it appears that
the whole problem would be solved if the firmware transfer were
aborted as soon as the -ENODEV errors start appearing.

Alan Stern
