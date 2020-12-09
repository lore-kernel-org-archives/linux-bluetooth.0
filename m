Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA623C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 11:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D56225AC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 11:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgLILB3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:01:29 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:58835 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbgLILB3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 06:01:29 -0500
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0CBD8100014;
        Wed,  9 Dec 2020 11:00:46 +0000 (UTC)
Message-ID: <e885258a0b9a3ba15640553e9f002cdfc89f4b79.camel@hadess.net>
Subject: Re: Bluetooth printer connection error
From:   Bastien Nocera <hadess@hadess.net>
To:     Laurent Vivier <laurent@vivier.eu>, linux-bluetooth@vger.kernel.org
Date:   Wed, 09 Dec 2020 12:00:45 +0100
In-Reply-To: <3a6fa942-bec5-5e5f-391d-197d1c1eafa6@vivier.eu>
References: <3a6fa942-bec5-5e5f-391d-197d1c1eafa6@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2020-12-08 at 22:25 +0100, Laurent Vivier wrote:
> Hi,
> 
> TL;DR:
> 
> I can pair my bluetooth printer but it fails to connect:
> 
>   $ bluetoothctl connect DC:0D:30:90:23:C7
> 
>   Attempting to connect to DC:0D:30:90:23:C7
>   [CHG] Device DC:0D:30:90:23:C7 Connected: yes
>   [CHG] Device DC:0D:30:90:23:C7 ServicesResolved: yes
>   Failed to connect: org.bluez.Error.NotAvailable
> 
> What do I need to add to my system to have this working?

As I mentioned in the original bug:
https://bugzilla.redhat.com/show_bug.cgi?id=1904686

I don't expect the "connect" command to do anything. There's nothing to
"connect" to, as bluez doesn't create rfcomm device nodes automatically
when "connecting" to devices with serial profiles (otherwise one
couldn't connect to them with other applications without going through
the device node...).

If the printer has uses the SPP or HCRP printing profiles, you should
see it when using:
/usr/lib/cups/backend/bluetooth
without any arguments.

Otherwise any apps or driver that supports the printer should be able
to create a serial link directly to the device without creating a
device node in /dev.

FWIW, looks like the printer uses a proprietary protocol between their
own app and the printer, and that they don't provide Linux support.
Short of reverse engineering that protocol, the printer is unlikely to
work with Linux.

Cheers

