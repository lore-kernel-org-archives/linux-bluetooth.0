Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000B3EE4996
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 11:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjHVLp5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjHVLp4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 07:45:56 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174BBE71
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 04:45:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CB2560009;
        Tue, 22 Aug 2023 11:43:27 +0000 (UTC)
Message-ID: <3c21153996077c50785660213a174f6a21519aa1.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: btusb: Fix quirks table naming
From:   Bastien Nocera <hadess@hadess.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Tue, 22 Aug 2023 13:43:26 +0200
In-Reply-To: <0c05b814-2ec0-4b54-80a3-fc54d753c0d3@molgen.mpg.de>
References: <20230822102033.1169580-1-hadess@hadess.net>
         <0c05b814-2ec0-4b54-80a3-fc54d753c0d3@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2023-08-22 at 12:41 +0200, Paul Menzel wrote:
> Dear Bastian,
> 
> 
> Thank you for the patch.
> 
> Am 22.08.23 um 12:20 schrieb Bastien Nocera:
> > The quirks table was named "blacklist_table" which isn't a good
> > description for that table as devices detected using it weren't
> > ignored
> > by the driver.
> > 
> > Rename the table to match what it actually does.
> 
> Maybe mention the new name also in the summary to be more specific?
> Maybe:
> 
> Bluetooth: btusb: Rename blacklist_table to quirks_table

I think that's clear enough from the commit message itself.

> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >   drivers/bluetooth/btusb.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 764d176e9735..a1be66ef175c 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -175,7 +175,7 @@ static const struct usb_device_id btusb_table[]
> > = {
> >   
> >   MODULE_DEVICE_TABLE(usb, btusb_table);
> >   
> > -static const struct usb_device_id blacklist_table[] = {
> > +static const struct usb_device_id quirks_table[] = {
> >         /* CSR BlueCore devices */
> >         { USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
> >   
> > @@ -4113,7 +4113,7 @@ static int btusb_probe(struct usb_interface
> > *intf,
> >         if (!id->driver_info) {
> >                 const struct usb_device_id *match;
> >   
> > -               match = usb_match_id(intf, blacklist_table);
> > +               match = usb_match_id(intf, quirks_table);
> >                 if (match)
> >                         id = match;
> >         }
> 
> Thank you for doing this.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

