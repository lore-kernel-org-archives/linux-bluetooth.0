Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7F4C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290EA2072E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgFJRbu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:31:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47430 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJRbt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:31:49 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 59225CECE9;
        Wed, 10 Jun 2020 19:41:37 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Install avinfo utility
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200610093306.zt3q3s2wmwp3almw@pali>
Date:   Wed, 10 Jun 2020 19:31:47 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 8BIT
Message-Id: <7672C0A0-AF6A-41B2-B50F-7836B3E5CC73@holtmann.org>
References: <20200506193435.3746-1-pali@kernel.org>
 <CECA6D9A-0F26-40E8-BFDF-A24CD972307D@holtmann.org>
 <20200610093306.zt3q3s2wmwp3almw@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>> This utility is very useful for determining which A2DP codecs are supported
>>> by remote side. So install it to system as part of bluez package.
>>> ---
>>> Makefile.tools | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/Makefile.tools b/Makefile.tools
>>> index 9b9236609..d52721612 100644
>>> --- a/Makefile.tools
>>> +++ b/Makefile.tools
>>> @@ -176,9 +176,9 @@ endif
>>> if TOOLS
>>> bin_PROGRAMS += tools/rctest tools/l2test tools/l2ping tools/bccmd \
>>> 			tools/bluemoon tools/hex2hcd tools/mpris-proxy \
>>> -			tools/btattach
>>> +			tools/btattach tools/avinfo
>>> 
>>> -noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
>>> +noinst_PROGRAMS += tools/bdaddr tools/avtest \
>>> 			tools/scotest tools/amptest tools/hwdb \
>>> 			tools/hcieventmask tools/hcisecfilter \
>>> 			tools/btinfo tools/btconfig \
>> 
>> I had no intention to install that tool since it is too limited
> 
> Sorry, but I have not seen any limitations with this tool yet. I'm using
> it very often. And also other people who use it have not mentioned any
> limitations or problems.
> 
> So could you be more specific what are those limitations?
> 
> Also it is the first thing which I'm saying people that should run and
> send me output of it if something related to A2DP does not work.
> 
> And because linux distributions do not package this utility and bluez
> developers (for me for unknown reasons) decided to not install it,
> result is that people have to always compile bluez from source to run
> this utility if their A2DP audio does not work or "remote" debugging of
> A2DP is needed.
> 
> So result is that who want to know why A2DP audio does not work is
> forced to compile & install bluez from sources and not to use from
> distribution package. And this probably not the expected state.
> 
> In any case, nobody reported to me any limitation with one exception
> that it cannot decode capabilities of some custom vendor codecs. But
> most of them are already supported as I sent needed patches in past.
> 
>> and makes too many assumption.
> 
> For example which assumptions?

that nothing else is happening right now. It backstabs the actual AVDTP and A2DP implementation.

>> In addition it has a bad name with no Bluetooth prefix.
> 
> So, lets rename it. What about "btavinfo"?

Lets extend btinfo with all sort of capabilities. Make the av portion just one of. I want to remove the multitudes of test utilities anyway. We have to many tiny utilities that are just scattered around and avinfo is just one of them.

> 
>> If we think it is useful to have such a test utility, then we need to clean this up first
> 
> What exactly to clean up first?
> 
> Note that I have already done cleanup of this utility.
> 
>> and put this into a larger btinfo work to gather appropriate information from a remote device for debug purposes.
> 
> I do not see how btinfo can be used for A2DP purposes. Seems this is
> utility for local controller info and not for remove A2DP.

This needs a bit thinking, but pretty much simple things like this:

	btinfo local
	btinfo avdtp <remote_bdaddr>

We can create a module handling system so that you can easily links existing tiny utilities into one.

Regards

Marcel

