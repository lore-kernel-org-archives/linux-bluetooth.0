Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23FAC10F03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8B2148D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 17:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfDWRBV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:01:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45486 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfDWRBU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 13:01:20 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1E753CF2DA;
        Tue, 23 Apr 2019 19:09:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Fix cups backend location
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6339c67c82a7e425a3c3cee415626cf32e080144.camel@hadess.net>
Date:   Tue, 23 Apr 2019 19:01:19 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ludwig Nussel <ludwig.nussel@suse.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <83F26638-10CC-42D2-8305-958F1960596E@holtmann.org>
References: <20190412140803.28622-1-ludwig.nussel@suse.de>
 <CABBYNZ+4Mgp0h2YusoEVK64a-uTXdarANc+Tm-KKpjR1=9h2cg@mail.gmail.com>
 <6339c67c82a7e425a3c3cee415626cf32e080144.camel@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

>>> ---
>>> Makefile.tools | 5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/Makefile.tools b/Makefile.tools
>>> index 7d5361bcd..9f8a0b87b 100644
>>> --- a/Makefile.tools
>>> +++ b/Makefile.tools
>>> @@ -436,7 +436,10 @@ endif
>>> endif
>>> 
>>> if CUPS
>>> -cupsdir = $(libdir)/cups/backend
>>> +# need to use upstream location here which is
>>> $exec_prefix/lib/cups/backend, see
>>> +# 
>>> https://github.com/apple/cups/blob/master/config-scripts/cups-directories.m4
>>> +# https://github.com/apple/cups/blob/master/backend/Makefile
>>> +cupsdir = $(exec_prefix)/lib/cups/backend
>>> 
>>> cups_PROGRAMS = profiles/cups/bluetooth
>> 
>> Any feedback on these changes?
> 
> The Fedora package has been doing that manually for 11 years, so, yes
> that looks correct.
> 
> It should probably be using the output of
> "cups-config --serverbin" instead, but given how hard that is with
> autotools, this is probably fine. I'd mention it in the commend instead
> of linking at the code though.

can someone add pkg-config support to CUPS. Then we can just get the directory from there. We are doing it this way for D-Bus and systemd.

Regards

Marcel


