Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F81FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CE361205
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhKDNbI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:31:08 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53759 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231586AbhKDNbH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Nov 2021 09:31:07 -0400
Received: (qmail 1557484 invoked by uid 1000); 4 Nov 2021 09:28:28 -0400
Date:   Thu, 4 Nov 2021 09:28:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: Userspace enumeration hang while btusb tries to load firmware of
 removed device
Message-ID: <20211104132828.GA1557201@rowland.harvard.edu>
References: <df021873788acdb64e1311289e9ca6dc3f169616.camel@sipsolutions.net>
 <20211103182303.GB1529362@rowland.harvard.edu>
 <BCD95F43-3C6E-4B50-9228-9F2AD93BBBA4@holtmann.org>
 <fae44c06e8e8d24b21b60a096e7294bc37444b12.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fae44c06e8e8d24b21b60a096e7294bc37444b12.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Nov 04, 2021 at 10:34:22AM +0100, Benjamin Berg wrote:
> Hi Marcel and Alan,
> 
> On Wed, 2021-11-03 at 20:31 +0100, Marcel Holtmann wrote:
> > > I'm not familiar with the btusb driver, so someone on the 
> > > linux-bluetooth mailing list would have a better idea about this. 
> > > However, it does look as though btusb keeps the device locked during the 
> > > entire 10-second period while it tries to send over the firmware, and it 
> > > doesn't abort the procedure when it starts getting disconnection errors 
> > > but instead persists until a timeout expires.  Keeping the device locked 
> > > would certainly block lsusb.
> > > 
> > > In general, locking the device during a firmware upload seems like
> > > the right thing to do -- you don't want extraneous transfers from
> > > other processes messing up the firmware!  So overall, it appears that
> > > the whole problem would be solved if the firmware transfer were
> > > aborted as soon as the -ENODEV errors start appearing.
> > 
> > the problem seems to be that we hitting HCI command timeout. So the
> > firmware download is done via HCI commands. These commands are send
> > to the transport driver btusb.c via hdev->send (as btusb_send_frame).
> > This triggers the usb_submit_urb or queues them via data->deferred
> > anchor. All this reports back the error properly except that nobody
> > does anything with it.
> > 
> > See hci_send_frame() last portion:
> > 
> >         err = hdev->send(hdev, skb);                                             
> >         if (err < 0) {                                                           
> >                 bt_dev_err(hdev, "sending frame failed (%d)", err);              
> >                 kfree_skb(skb);                                                  
> >         }
> > 
> > And that is it. We are not checking for ENODEV or any error here.
> > That means the failure of the HCI command gets only caught via the
> > HCI command timeout. I don’t know how to do this yet, but you would
> > have to look there to fail HCI command right away instead of waiting
> > for the timeout.
> 
> Hmm, true, I don't see a "sending frame failed" error message during
> the firmware download though.

It is in the log you posted:

[Mi Nov 3 11:55:23 2021] Bluetooth: hci0: Failed to send firmware data (-110)
[Mi Nov 3 11:55:23 2021] Bluetooth: hci0: sending frame failed (-19)

But this occurred after the timeout, so maybe you had in mind something 
occurring earlier.

>  You are right that this codepath is
> loosing the error, but this does not seem to be the scenario we are
> running into while loading the firmware. This error only happens later
> on from the btintel_reset_to_bootloader function.
> 
> What seems to happen in the posted log is that the URB is initially
> submitted just fine and the transfer errors out afterwards.
> Unfortunately, the btusb_tx_complete is only used for statistics
> (stat.err_tx is increased) and has no further error handling that could
> abort the firmware upload.

While detecting the errors during URB completion would be nice, it isn't 
necessary.  Things would work just as well if the disconnect error were 
detected during submission of the following URB.

Alan Stern
