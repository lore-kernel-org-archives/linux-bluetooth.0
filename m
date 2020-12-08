Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E9C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 09:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC502396F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 09:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgLHJyM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 04:54:12 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38405 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgLHJyM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 04:54:12 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id DC68E60026;
        Tue,  8 Dec 2020 09:53:29 +0000 (UTC)
Message-ID: <699f55a2f9d574943af0b5cc80c47d08d48953f7.camel@hadess.net>
Subject: Re: sixaxis patch proposal
From:   Bastien Nocera <hadess@hadess.net>
To:     Lionel Jeanson <lionel.jeanson@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Tue, 08 Dec 2020 10:53:29 +0100
In-Reply-To: <CAMxp8948=LGwO6NE_oij2WgXxzXCY7nByj_XmmhPZFMiookseA@mail.gmail.com>
References: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
         <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
         <CAMxp8948=LGwO6NE_oij2WgXxzXCY7nByj_XmmhPZFMiookseA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2020-12-08 at 10:45 +0100, Lionel Jeanson wrote:
> Hi;
> 
> yes, I've seen your commit, and actually I don't get it, since it was
> integrated, and bluez updated, sixaxis pads are not working as well
> as
> they used to, I need to repair the device again and again.
> 
> I tried to do it with the pairing agent using bluetoothctl but
> couldn't get it to work as expected, any hint? I can't find anything
> on google or anywhere else.

1. Start bluetoothctl
2. Plug in the device
3. Answer yes when bluetoothctl asks to pair

The same should work using GNOME's Bluetooth Settings.

If it doesn't work, send the bluetoothd logs when reproducing the
problem.

