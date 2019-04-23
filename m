Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C524EC10F03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFCD20645
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfDWROH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:14:07 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59167 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWROG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 13:14:06 -0400
Received: from [192.168.1.23] (unknown [90.114.240.10])
        (Authenticated sender: hadess@hadess.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B08C7100002;
        Tue, 23 Apr 2019 17:14:03 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fix cups backend location
From:   Bastien Nocera <hadess@hadess.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <83F26638-10CC-42D2-8305-958F1960596E@holtmann.org>
Date:   Tue, 23 Apr 2019 19:14:01 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ludwig Nussel <ludwig.nussel@suse.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <33C38EDB-C55B-498C-B74F-6416524F01C7@hadess.net>
References: <20190412140803.28622-1-ludwig.nussel@suse.de> <CABBYNZ+4Mgp0h2YusoEVK64a-uTXdarANc+Tm-KKpjR1=9h2cg@mail.gmail.com> <6339c67c82a7e425a3c3cee415626cf32e080144.camel@hadess.net> <83F26638-10CC-42D2-8305-958F1960596E@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On 23 Apr 2019, at 19:01, Marcel Holtmann <marcel@holtmann.org> wrote:
> 
> Hi Bastien,
> 
>>>> ---
>>>> Makefile.tools | 5 ++++-
>>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/Makefile.tools b/Makefile.tools
>>>> index 7d5361bcd..9f8a0b87b 100644
>>>> --- a/Makefile.tools
>>>> +++ b/Makefile.tools
>>>> @@ -436,7 +436,10 @@ endif
>>>> endif
>>>> 
>>>> if CUPS
>>>> -cupsdir = $(libdir)/cups/backend
>>>> +# need to use upstream location here which is
>>>> $exec_prefix/lib/cups/backend, see
>>>> +# 
>>>> https://github.com/apple/cups/blob/master/config-scripts/cups-directories.m4
>>>> +# https://github.com/apple/cups/blob/master/backend/Makefile
>>>> +cupsdir = $(exec_prefix)/lib/cups/backend
>>>> 
>>>> cups_PROGRAMS = profiles/cups/bluetooth
>>> 
>>> Any feedback on these changes?
>> 
>> The Fedora package has been doing that manually for 11 years, so, yes
>> that looks correct.
>> 
>> It should probably be using the output of
>> "cups-config --serverbin" instead, but given how hard that is with
>> autotools, this is probably fine. I'd mention it in the commend instead
>> of linking at the code though.
> 
> can someone add pkg-config support to CUPS. Then we can just get the directory from there. We are doing it this way for D-Bus and systemd.

IIRC, Apple, the maintainer of CUPS, has refused pkg-config support in the past. So best not wait for that.

> 
> Regards
> 
> Marcel
> 
> 

