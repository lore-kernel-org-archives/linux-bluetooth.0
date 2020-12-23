Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D03C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 15:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D014B22210
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 15:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgLWP5I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgLWP5H (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Dec 2020 10:57:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4163622210;
        Wed, 23 Dec 2020 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608738987;
        bh=Qaj+dB13pm1mXyOK5JT7nDDWvncGVryx8u69imJZ/iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zfw3iErk+M4qW+9iQpe0QU5Lafifxxt6qeQBCPeR2ZQ6uljodV/FoKGMOfvTzUmd8
         h/YwIR6XjfPgPWV2UFfHWOIqNLfz68wCYB8Op+3T6AB+Xn3FArnbqyHeiAAMB62Yz4
         fN7cXggI5YmQpxRGJWQQZCSlewSzDZP6UR93U+rAccg5/VAwHxtFgqtW4+WG0DlWB2
         D9cdhUcTYywUY4ByngCAb6v55kBQhTYi7apK73ORs8k+tn2S073SwEuQPzw4Rgrhps
         SH9H3CaIw++w+farM+rGjJsEwoXJHuhkz9nafJFcIbylD5O/pwDiN2MZxjobODL+HG
         s1b/yk65Ye0uQ==
Received: by pali.im (Postfix)
        id 1FFFF7F0; Wed, 23 Dec 2020 16:56:25 +0100 (CET)
Date:   Wed, 23 Dec 2020 16:56:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201223155624.uzbxfxtowenjrwm2@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <20201221210707.evrdeyiki45pivux@pali>
 <26db80417b43d919b6e33a4ee56c0e44a2f42a5c.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26db80417b43d919b6e33a4ee56c0e44a2f42a5c.camel@infinera.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 23 December 2020 15:41:01 Joakim Tjernlund wrote:
> On Mon, 2020-12-21 at 22:07 +0100, Pali Rohár wrote:
> > On Friday 18 December 2020 13:32:29 Joakim Tjernlund wrote:
> > > There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC
> > 
> > No, it does not mean mSBC.
> > 
> 
> I forgot, if BTUSB_WIDEBAND_SPEECH does not mean capable of HW mSBC, what does it mean?

BTUSB_WIDEBAND_SPEECH flag is just for usb bluetooth adapters. Not for
UART or SDIO bluetooth adapters.

It is a hint set for some bluetooth adapters which are on kernel
whitelist that wideband speech support is possible for them.

mSBC is not the only one codec which has wideband support.

Based on current "whitelist" implementation it does not mean adapters
without this hint are not mSBC capable (e.g. new adapters could not be
on this list) and also there is a theoretical chance that some with this
flag are not capable of mSBC. But this is only theoretical and I think
you can say that BTUSB_WIDEBAND_SPEECH is sufficient for mSBC. But it is
not necessary condition for mSBC (e.g. because of UART or SDIO adapters
or adapters which are not whitelist yet).

I hope to see AuriStream support which is also wideband speech codec but
should work also with some adapters which are not able to provide enough
bandwidth for mSBC.
