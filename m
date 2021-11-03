Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BA1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 20:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35704610A8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 20:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKCUOR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 16:14:17 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49937 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230172AbhKCUOQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 16:14:16 -0400
Received: (qmail 1535365 invoked by uid 1000); 3 Nov 2021 16:11:38 -0400
Date:   Wed, 3 Nov 2021 16:11:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: Userspace enumeration hang while btusb tries to load firmware of
 removed device
Message-ID: <20211103201138.GC1529362@rowland.harvard.edu>
References: <df021873788acdb64e1311289e9ca6dc3f169616.camel@sipsolutions.net>
 <20211103182303.GB1529362@rowland.harvard.edu>
 <BCD95F43-3C6E-4B50-9228-9F2AD93BBBA4@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BCD95F43-3C6E-4B50-9228-9F2AD93BBBA4@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 03, 2021 at 08:31:03PM +0100, Marcel Holtmann wrote:
> Hi Alan,
> 
> >> a user is seeing a hang in fprintd while enumerating devices which
> >> appears to be caused by an interaction of:
> >> 
> >> * system is resuming from S3
> >> * btusb starts loading firmware
> >> * bluetooth device disappears (probably thinkpad_acpi rfkill)
> >> * libusb enumerates USB devices (fprintd in this case)
> >> 
> >> When this happens, the firmware load fails after a timeout of 10s. It
> >> appears that if userspace queries information about the root hub in
> >> question during this time, it will hang until the btusb firmware load
> >> has timed out.
> >> 
> >> Attaching the full kernel log, below an excerpt, you can see:
> >> * At :12 device removal: "usb 5-4: USB disconnect, device number 33"
> >> * libusb enumeration retrieves information about the usb5 root hub,
> >>   and blocks on this
> >> * At :14 there is a tx timeout on hci0
> >> * At :23 the firmware load finally fails
> >> * Then usb_disable_device happens
> >> * libusb/fprintd gets the usb5 HUB information and continues its
> >>   enumeration
> >> 
> >> As I see it, there may be two issues:
> >> 1. userspace should not block due to the firmware load hanging
> >> 2. btusb should give up more quickly when the device disappears
> >> 
> >> Does anyone have a good idea about the possible cause or how we can fix
> >> the problem?
> >> 
> >> Downstream issue: https://bugzilla.redhat.com/show_bug.cgi?id=2019857
> > 
> > I'm not familiar with the btusb driver, so someone on the 
> > linux-bluetooth mailing list would have a better idea about this. 
> > However, it does look as though btusb keeps the device locked during the 
> > entire 10-second period while it tries to send over the firmware, and it 
> > doesn't abort the procedure when it starts getting disconnection errors 
> > but instead persists until a timeout expires.  Keeping the device locked 
> > would certainly block lsusb.
> > 
> > In general, locking the device during a firmware upload seems like
> > the right thing to do -- you don't want extraneous transfers from
> > other processes messing up the firmware!  So overall, it appears that
> > the whole problem would be solved if the firmware transfer were
> > aborted as soon as the -ENODEV errors start appearing.
> 
> the problem seems to be that we hitting HCI command timeout. So the 
> firmware download is done via HCI commands. These commands are send to 
> the transport driver btusb.c via hdev->send (as btusb_send_frame). 
> This triggers the usb_submit_urb or queues them via data->deferred 
> anchor. All this reports back the error properly except that nobody 
> does anything with it.
> 
> See hci_send_frame() last portion:
> 
>         err = hdev->send(hdev, skb);
>         if (err < 0) {
>                 bt_dev_err(hdev, "sending frame failed (%d)", err);
>                 kfree_skb(skb);
>         }
> 
> And that is it. We are not checking for ENODEV or any error here. That 
> means the failure of the HCI command gets only caught via the HCI 
> command timeout. I don’t know how to do this yet, but you would have 
> to look there to fail HCI command right away instead of waiting for 
> the timeout.

I have no idea how all the different layers work here.  Clearly 
something has to signal hdev->req_wait_q after setting hdev->req_status 
to some appropriate value.  Can this be done in btusb.c, either when the 
URB is submitted or when it completes?  Or in hci_send_frame?

Alan Stern
