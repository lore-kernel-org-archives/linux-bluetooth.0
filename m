Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE53C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 09:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4C323A82
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 09:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgLHJBq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 04:01:46 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59087 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHJBq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 04:01:46 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EB304E000D;
        Tue,  8 Dec 2020 09:01:03 +0000 (UTC)
Message-ID: <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
Subject: Re: sixaxis patch proposal
From:   Bastien Nocera <hadess@hadess.net>
To:     Lionel Jeanson <lionel.jeanson@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 08 Dec 2020 10:01:03 +0100
In-Reply-To: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
References: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2020-12-07 at 18:04 +0100, Lionel Jeanson wrote:
> Hi;
> 
> I'd like to propose the following patch to fix the following issue :
> 
>  - if an already paired PS3 DualShock is plugged to USB, while it is
> turned off (PS button wasn't pushed or no more battery for instance),
> then it's connection will be reset and it will have to be paired
> again
> 
>  - to fix this, I removed the device connection check
> 
>  - tested on Ubuntu 20.x (bluez-5.53 and bluez-5.55) and works fine
> in
> all cases.

It doesn't have to be paired again if the pairing agent doesn't accept
the pairing.

Also, see 7bb73f092a.

