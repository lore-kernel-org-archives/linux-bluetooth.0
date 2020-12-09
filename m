Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C63EC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 11:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F415323B40
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 11:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgLILex (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:34:53 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40663 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgLILex (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 06:34:53 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3FB6620004;
        Wed,  9 Dec 2020 11:34:10 +0000 (UTC)
Message-ID: <0eeb1a4a1254d00b2d1a8f77133af4d16857b266.camel@hadess.net>
Subject: Re: Bluetooth printer connection error
From:   Bastien Nocera <hadess@hadess.net>
To:     Laurent Vivier <laurent@vivier.eu>, linux-bluetooth@vger.kernel.org
Date:   Wed, 09 Dec 2020 12:34:10 +0100
In-Reply-To: <73236e71-781f-1dea-13d5-61fdc45d5e13@vivier.eu>
References: <3a6fa942-bec5-5e5f-391d-197d1c1eafa6@vivier.eu>
         <e885258a0b9a3ba15640553e9f002cdfc89f4b79.camel@hadess.net>
         <73236e71-781f-1dea-13d5-61fdc45d5e13@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2020-12-09 at 12:14 +0100, Laurent Vivier wrote:
> Le 09/12/2020 à 12:00, Bastien Nocera a écrit :
> > On Tue, 2020-12-08 at 22:25 +0100, Laurent Vivier wrote:
> > > Hi,
> > > 
> > > TL;DR:
> > > 
> > > I can pair my bluetooth printer but it fails to connect:
> > > 
> > >   $ bluetoothctl connect DC:0D:30:90:23:C7
> > > 
> > >   Attempting to connect to DC:0D:30:90:23:C7
> > >   [CHG] Device DC:0D:30:90:23:C7 Connected: yes
> > >   [CHG] Device DC:0D:30:90:23:C7 ServicesResolved: yes
> > >   Failed to connect: org.bluez.Error.NotAvailable
> > > 
> > > What do I need to add to my system to have this working?
> > 
> > As I mentioned in the original bug:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1904686
> > 
> > I don't expect the "connect" command to do anything. There's
> > nothing to
> > "connect" to, as bluez doesn't create rfcomm device nodes
> > automatically
> > when "connecting" to devices with serial profiles (otherwise one
> > couldn't connect to them with other applications without going
> > through
> > the device node...).
> 
> Yes, I didn't understand what you meant...
> 
> My question is: what piece of code I need to write or modify to have
> the
> "connect" operation working?

Again, it's bluez' prerogative that serial profiles don't automatically
get a serial device node attached.

Either you need to create the rfcomm device node manually, or you need
to jump through the same hoops many apps do, using SDP to find the
RFCOMM port on the remote device, and connecting to that port using an
AF_BLUETOOTH socket.

The cups backend in the bluez sources does both of those things.

> 
> > If the printer has uses the SPP or HCRP printing profiles, you
> > should
> > see it when using:
> > /usr/lib/cups/backend/bluetooth
> > without any arguments.
> 
> As I don't see it once it is paired, I guess it is not using one of
> these profiles.

I don't remember how this used to work, but you'll probably only see
something if the printer is visible.

You might be able to get the printer to work by adding:
bluetooth://DC0D309023C7
as a printer in the printer settings of your favourite desktop
environment, if it actually uses SPP.

running the cups backend with:
/usr/lib/cups/backend/bluetooth --get-deviceid bluetooth://DC0D309023C7

should show you whether it can get autoconfigured for CUPS use.

> 
> > Otherwise any apps or driver that supports the printer should be
> > able
> > to create a serial link directly to the device without creating a
> > device node in /dev.
> > 
> > FWIW, looks like the printer uses a proprietary protocol between
> > their
> > own app and the printer, and that they don't provide Linux support.
> > Short of reverse engineering that protocol, the printer is unlikely
> > to
> > work with Linux.
> 
> I've written the CUPS driver that works fine with the rfcomm device.
> In fact, it's not proprietary, it's ESC/POS protocol.
> 
> https://github.com/vivier/phomemo-tools
> 
> I'm working on my code to use python-escpos rather than my hack and
> I'd
> like to integrate smoothly the printer in the bluetooth stack.
> 
> It works also with USB, but it's a shame not to use bluetooth with a
> printer that has an internal battery.


