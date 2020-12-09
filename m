Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAA9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 20:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515E722B39
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 20:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbgLIU2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:28:33 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35295 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387747AbgLIU2d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 15:28:33 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9CD77E0007;
        Wed,  9 Dec 2020 20:27:48 +0000 (UTC)
Message-ID: <50264b155ddf8b677125b87a703a628f76518457.camel@hadess.net>
Subject: Re: Bluetooth printer connection error
From:   Bastien Nocera <hadess@hadess.net>
To:     Laurent Vivier <laurent@vivier.eu>, linux-bluetooth@vger.kernel.org
Date:   Wed, 09 Dec 2020 21:27:48 +0100
In-Reply-To: <ab6ae9d9-9104-5454-d93d-b734c0eb9eba@vivier.eu>
References: <3a6fa942-bec5-5e5f-391d-197d1c1eafa6@vivier.eu>
         <e885258a0b9a3ba15640553e9f002cdfc89f4b79.camel@hadess.net>
         <73236e71-781f-1dea-13d5-61fdc45d5e13@vivier.eu>
         <0eeb1a4a1254d00b2d1a8f77133af4d16857b266.camel@hadess.net>
         <ab6ae9d9-9104-5454-d93d-b734c0eb9eba@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2020-12-09 at 20:04 +0100, Laurent Vivier wrote:
> Le 09/12/2020 à 12:34, Bastien Nocera a écrit :
> > On Wed, 2020-12-09 at 12:14 +0100, Laurent Vivier wrote:
> ...
> > > > If the printer has uses the SPP or HCRP printing profiles, you
> > > > should
> > > > see it when using:
> > > > /usr/lib/cups/backend/bluetooth
> > > > without any arguments.
> > > 
> > > As I don't see it once it is paired, I guess it is not using one
> > > of
> > > these profiles.
> > 
> > I don't remember how this used to work, but you'll probably only
> > see
> > something if the printer is visible.
> > 
> > You might be able to get the printer to work by adding:
> > bluetooth://DC0D309023C7
> > as a printer in the printer settings of your favourite desktop
> > environment, if it actually uses SPP.
> > 
> > running the cups backend with:
> > /usr/lib/cups/backend/bluetooth --get-deviceid
> > bluetooth://DC0D309023C7
> > 
> > should show you whether it can get autoconfigured for CUPS use.
> > 
> 
> Thank you Bastien, it's exactly what I needed to know.
> 
> Correct me if I'm wrong but it seems there is a bug in the
> cups/bluetooth
> command:

Sigh. No, it's not a bug, it's just that the cups tool was never ported
from the bluez 4.x to the current bluez 5.x API...

Until that's ported (if ever, given the low number of Bluetooth
printers around...), you could try to extract the IEEE1284 ID using:
sdptool records DC:0D:30:90:23:C7

But I'm not certain that this working is necessary to actually try a
print. Have you tested that?

