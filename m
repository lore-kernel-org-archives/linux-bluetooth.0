Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCDAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jan 2022 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379599AbiAXULy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 15:11:54 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:39867 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359386AbiAXT7k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 14:59:40 -0500
Received: from xps-7390.local (ip98-164-213-246.oc.oc.cox.net [98.164.213.246])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JjLRZ3Vh8z3l7M;
        Mon, 24 Jan 2022 14:59:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1643054379; bh=ZFwyVBxFNWzqkyy+Kt9VvR1ApRt4kZ9zmG7uWNPaBmM=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=EixlpbFfS6UbZZZaHTXXteKPcscjywPCTGjco8DDpVSOqXOsFpj0bT42MT8dfhwOa
         cVG1NhKi7cN+cyHznBN881XzLj1T4QoPyFwpQNGl8DmF0FXA1FeNF3PBMZ8cq3jpBu
         qb1qpe8rJ1JiKGnjVT6gzXTFVXDvQ/h8nT9c2QQs=
Date:   Mon, 24 Jan 2022 11:59:37 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
In-Reply-To: <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com>
Message-ID: <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com>
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com> <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On Mon, 24 Jan 2022, Luiz Augusto von Dentz wrote:

> > I'm running Linus' master (as of today, 1c52283265a462a100). With this commit in
> > place I get no bluetooth ("hcitool dev" shows no adapters) and/or I can't see my
> > MS ArcTouch mouse.

> It would be great to have some logs, btmon, dmesg, etc.

That's just it- nothing shows up in any log/dmesg; unlike when a non-MS mouse is
detected and I get the notification from the HID layer.

I even did an s/{bt}_debug/{bt}_info/g over all the files in the commit, and when
that mouse is power-cycled it doesn't even make a peep in the logs- it's like it's
not even being seen (vs. several lines when I use my ordinary mouse).

What params should I use for "btmon" so I can send you the output?

> If the adapter doesn't work this might be related to firmware loading

Turns out this was a red herring; I always have the adapter.

> anymore the LL privacy feature is not
> enabled by default so I wonder if you had it enabled in userspace?

Where would I go to check that?

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
