Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F32C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 10:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7843823AA7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 10:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgLHK7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:59:41 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36417 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgLHK7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 05:59:41 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BE254E0004;
        Tue,  8 Dec 2020 10:58:59 +0000 (UTC)
Message-ID: <42a369804808a2be8012b950a7db9f6ab8f27936.camel@hadess.net>
Subject: Re: sixaxis patch proposal
From:   Bastien Nocera <hadess@hadess.net>
To:     Lionel Jeanson <lionel.jeanson@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Tue, 08 Dec 2020 11:58:59 +0100
In-Reply-To: <CAMxp897-xWxkcBfmjdXYUt6i3jLJ5ZJ67Vs8NZ_6ukBL9v+L6Q@mail.gmail.com>
References: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
         <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
         <CAMxp8948=LGwO6NE_oij2WgXxzXCY7nByj_XmmhPZFMiookseA@mail.gmail.com>
         <699f55a2f9d574943af0b5cc80c47d08d48953f7.camel@hadess.net>
         <CAMxp897-xWxkcBfmjdXYUt6i3jLJ5ZJ67Vs8NZ_6ukBL9v+L6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2020-12-08 at 11:46 +0100, Lionel Jeanson wrote:
> Cleaned known devices.
> Restart bluetooth service.
> déc. 08 11:36:11      Plugged sixaxis on USB, new device, pair, yes.
> Checked that it is working.
>  déc. 08 11:36:47     Plugged back sixaxis on USB while on, all went
> fine.
> Unplugged.
> Turned six axis off (long press on PS button).
> déc. 08 11:37:03      Plugged back in USB -> Authorize service
> etc...,
> in bluetoothctl, didn't answer, request canceled     <--- this
> shouldn't happen
> Unplugged.
> déc. 08 11:39:39      Tried to connect using BT, won't connect
> (normal, it's nor paired anymore)
> 
> 
> déc. 08 11:36:11 lionelux bluetoothd[8616]: sixaxis: compatible
> device
> connected: Sony PLAYSTATION(R)3 Controller (054C:0268
> /sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-
> 1:1.0/0003:054C:0268.0005/hidraw/hidraw0)
> déc. 08 11:36:11 lionelux bluetoothd[8616]: sixaxis: setting up new
> device
> déc. 08 11:36:14 lionelux bluetoothd[8616]: Set device flags return
> status: Unknown Command

Looks like you didn't enable debug, as we can't see the response from
the sixaxis plugin. It's supposed to send either:
"Agent replied negatively, removing temporary device"
or:
"remote %s old_master %s new_master %s"

