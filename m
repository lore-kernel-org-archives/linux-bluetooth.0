Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB65C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACC7206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 13:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="FzufCbM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLQNl4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:41:56 -0500
Received: from vps.xff.cz ([195.181.215.36]:41352 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfLQNl4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 08:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1576590114; bh=6t8Uyc2t+Hfu7WNUKCMbkr4L5H0F8zqAfk4qlpdk8x0=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=FzufCbM2RGiDa9KFXYh0vsRZPe9nbbhyIHzSdQd52wvGFJkd5ZK0G66OD7aV8hDXi
         qIqLxNfM/QYUQ5tEvNr5Pn7IOWSHGm26DeX5swmUsLYsM1orNDDIYQf7QTuNUtp9Rm
         MjcdSsmiIdOgK8PxdtrqvsdMvmoGQAqwKawP1lo4=
Date:   Tue, 17 Dec 2019 14:41:54 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH V4 01/10] bluetooth: hci_bcm: Fix RTS handling during
 startup
Message-ID: <20191217134154.zrvukziiqe272pq6@core.my.home>
Mail-Followup-To: Stefan Wahren <wahrenst@gmx.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
 <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
 <61789264-a4c2-ac85-9d74-d186213ec70a@gmx.net>
 <20191216132509.ofqcdpwxsd7324ql@core.my.home>
 <6f05f4d8-fa84-ae81-ac4f-00ab12fabeea@gmx.net>
 <5bbda434-d0e4-7162-8634-9900a4fa9148@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bbda434-d0e4-7162-8634-9900a4fa9148@gmx.net>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stefan,

On Tue, Dec 17, 2019 at 01:59:26PM +0100, Stefan Wahren wrote:
> Hi Ondrej,
> 
> Am 16.12.19 um 19:28 schrieb Stefan Wahren:
> > Hi Ondrej,
> >
> > Am 16.12.19 um 14:25 schrieb Ondřej Jirman:
> >>
> >> Meanwhile i will play with modifications of original patch on the
> >> Raspberry Pi 4 and come back to you.
> 
> could you please test this patch [2] on top of current bluetooth-next?
> 
> This is the solution in case we don't find the cause of this issue. I
> don't prefer this one, because this is next stuff and we need to revert
> the offending patch for Linux 5.5.
> 
> [2] - https://gist.github.com/lategoodbye/3d39e4b07d401f07fa9f9c2f11e1f17d

That looks equivalent to the revert and it will obviously avoid the issue,
because Orange Pi 3 has a different bluetooth device compatible.

regards,
	o.

> >
> > Thanks
> > Stefan
> >
> > [1] -
> > http://www.sparklan.com/p2-products-detail.php?PKey=4984FVukjcpylzifQiM-TGFE-IKXD--BCwf4P15KfrU&AP6256
> >
