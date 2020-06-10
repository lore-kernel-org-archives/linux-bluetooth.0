Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEE2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B32A2078C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591781590;
	bh=ztodW+W8T4P1hHh6+v8Vp+ceGuE7dYNh8YnGpl8BHh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P3eUxNsmzKUlU++JXgR5ksk7pG/FA0J7Zb05AaLr0qeJy3t0i1MS+j17GY3PIbJ/m
	 jOPb82xjmpTsPoSwWBHMs8snBZCFrK11LzHTIoX8kRlCKTB9IR0d0UnYsJmdUN6rJA
	 zlVJmXATQ1WRSWPfklEQe3BXa2+iC78i3dWSGqP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgFJJdK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgFJJdJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 05:33:09 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C418920760;
        Wed, 10 Jun 2020 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591781588;
        bh=ztodW+W8T4P1hHh6+v8Vp+ceGuE7dYNh8YnGpl8BHh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzy5ZRY5TR7UcxkWbiLZunSNrogmuPgY7irdeAbX8NEFtLMvE619QWBVNNmzkrDK2
         XaCGXcT9E+lkiU+BjgFKoNYoFJzWbkb8Qo2G97a5hSs4JfbvVHatPmHGd7C5m+1Uoi
         F60Fcz9ZBQdhHne5KI0yRzKQziaF4orB+tQhpa9U=
Received: by pali.im (Postfix)
        id CD866810; Wed, 10 Jun 2020 11:33:06 +0200 (CEST)
Date:   Wed, 10 Jun 2020 11:33:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] Install avinfo utility
Message-ID: <20200610093306.zt3q3s2wmwp3almw@pali>
References: <20200506193435.3746-1-pali@kernel.org>
 <CECA6D9A-0F26-40E8-BFDF-A24CD972307D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CECA6D9A-0F26-40E8-BFDF-A24CD972307D@holtmann.org>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 10 June 2020 10:27:25 Marcel Holtmann wrote:
> Hi Pali,
> 
> > This utility is very useful for determining which A2DP codecs are supported
> > by remote side. So install it to system as part of bluez package.
> > ---
> > Makefile.tools | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Makefile.tools b/Makefile.tools
> > index 9b9236609..d52721612 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -176,9 +176,9 @@ endif
> > if TOOLS
> > bin_PROGRAMS += tools/rctest tools/l2test tools/l2ping tools/bccmd \
> > 			tools/bluemoon tools/hex2hcd tools/mpris-proxy \
> > -			tools/btattach
> > +			tools/btattach tools/avinfo
> > 
> > -noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
> > +noinst_PROGRAMS += tools/bdaddr tools/avtest \
> > 			tools/scotest tools/amptest tools/hwdb \
> > 			tools/hcieventmask tools/hcisecfilter \
> > 			tools/btinfo tools/btconfig \
> 
> I had no intention to install that tool since it is too limited

Sorry, but I have not seen any limitations with this tool yet. I'm using
it very often. And also other people who use it have not mentioned any
limitations or problems.

So could you be more specific what are those limitations?

Also it is the first thing which I'm saying people that should run and
send me output of it if something related to A2DP does not work.

And because linux distributions do not package this utility and bluez
developers (for me for unknown reasons) decided to not install it,
result is that people have to always compile bluez from source to run
this utility if their A2DP audio does not work or "remote" debugging of
A2DP is needed.

So result is that who want to know why A2DP audio does not work is
forced to compile & install bluez from sources and not to use from
distribution package. And this probably not the expected state.

In any case, nobody reported to me any limitation with one exception
that it cannot decode capabilities of some custom vendor codecs. But
most of them are already supported as I sent needed patches in past.

> and makes too many assumption.

For example which assumptions?

> In addition it has a bad name with no Bluetooth prefix.

So, lets rename it. What about "btavinfo"?

> If we think it is useful to have such a test utility, then we need to clean this up first

What exactly to clean up first?

Note that I have already done cleanup of this utility.

> and put this into a larger btinfo work to gather appropriate information from a remote device for debug purposes.

I do not see how btinfo can be used for A2DP purposes. Seems this is
utility for local controller info and not for remove A2DP.
