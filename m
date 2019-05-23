Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A590AC282DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0B020881
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 12:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfEWMHG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 08:07:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729430AbfEWMHF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 08:07:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFC55AD3E;
        Thu, 23 May 2019 12:07:04 +0000 (UTC)
Subject: Re: [PATCH] Fix cups backend location
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20190412140803.28622-1-ludwig.nussel@suse.de>
 <CABBYNZ+4Mgp0h2YusoEVK64a-uTXdarANc+Tm-KKpjR1=9h2cg@mail.gmail.com>
 <6339c67c82a7e425a3c3cee415626cf32e080144.camel@hadess.net>
From:   Ludwig Nussel <ludwig.nussel@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <afc28fae-b1ef-24f6-4878-33205bccb947@suse.de>
Date:   Thu, 23 May 2019 14:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6339c67c82a7e425a3c3cee415626cf32e080144.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bastien Nocera schrieb:
> On Mon, 2019-04-15 at 10:52 +0300, Luiz Augusto von Dentz wrote:
>> Hi Bastien,
>>
>> On Fri, Apr 12, 2019 at 5:11 PM Ludwig Nussel <ludwig.nussel@suse.de>
>> wrote:
>>> ---
>>>   Makefile.tools | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile.tools b/Makefile.tools
>>> index 7d5361bcd..9f8a0b87b 100644
>>> --- a/Makefile.tools
>>> +++ b/Makefile.tools
>>> @@ -436,7 +436,10 @@ endif
>>>   endif
>>>
>>>   if CUPS
>>> -cupsdir = $(libdir)/cups/backend
>>> +# need to use upstream location here which is
>>> $exec_prefix/lib/cups/backend, see
>>> +#
>>> https://github.com/apple/cups/blob/master/config-scripts/cups-directories.m4
>>> +# https://github.com/apple/cups/blob/master/backend/Makefile
>>> +cupsdir = $(exec_prefix)/lib/cups/backend
>>>
>>>   cups_PROGRAMS = profiles/cups/bluetooth
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

The output of cups-config doesn't give a hint about exec_prefix vs
libdir though. Since reading through those files I linked was what I
did to understand what the correct value was, I thought mentioning
them would help the text person.
So what comment should I put to get this patch accepted? Looks like none
like before was ok for years after all :-)

I'm not really up to spending a day crafting M4 macros for the perfect
cups special arrangement.

cu
Ludwig

-- 
  (o_   Ludwig Nussel
  //\
  V_/_  http://www.suse.com/
SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah,
HRB 21284 (AG Nürnberg)
