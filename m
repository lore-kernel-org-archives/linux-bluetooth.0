Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57022C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 20:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353521AbiBKUv4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:51:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353353AbiBKUvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 15:51:50 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC35CCFA
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 12:51:32 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee34.dynamic.kabel-deutschland.de [95.90.238.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A6B4E61E6478B;
        Fri, 11 Feb 2022 21:51:29 +0100 (CET)
Message-ID: <bab2d1fa-8c40-fa4d-ad72-5fa28e1651df@molgen.mpg.de>
Date:   Fri, 11 Feb 2022 21:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [BlueZ PATCH 1/4] adapter: Fix the reusing gerror without
 re-initialization
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20220211001840.22566-1-hj.tedd.an@gmail.com>
 <fdaaf4ca-934f-c0ff-63f8-2feda6a106ef@molgen.mpg.de>
 <CABBYNZJ4ZByGjHFmXwzC6UYJNGBQ4GfOLP56BVT6jdyaHA6qKg@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CABBYNZJ4ZByGjHFmXwzC6UYJNGBQ4GfOLP56BVT6jdyaHA6qKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,


Am 11.02.22 um 21:30 schrieb Luiz Augusto von Dentz:

> On Fri, Feb 11, 2022 at 8:41 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> Am 11.02.22 um 01:18 schrieb Tedd Ho-Jeong An:
>>> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>>
>> I had a hard time to understand, what the git commit message summary
>> meant. Maybe:
>>
>>> adapter: Use g_clear_error() to set gerr to NULL to fix segfault
>>
>>
>>> When the GError variable is freeed with g_error_free(), it is not set to
>>> NULL and reusing the same variable again can cause the seg_fault because
>>> it is still pointing the old memory address which is freed.
>>
>> Could you please include an example stack-/backtrace?
> 
> That is part of issue if you open the link:
> 
> https://github.com/bluez/bluez/issues/276#issue-1111278644

Yes, I know. I prefer commit messages to be self-contained, as it’s 
never known if you are online or the Web service has problems or is shut 
down. But of course, if BlueZ does it differently, that is fine.

>>> This patch relaces the g_error_free() to g_clear_error() which frees the
>>> variable and set it to NULL if the variable is used in the function
>>
>> set*s*
>>
>>> again.
>>>
>>> Fixes: 2287c517ca1bd ("adapter: Fix unchecked return value")
>>> Fixes: https://github.com/bluez/bluez/issues/276
>>
>> To make the tags unambiguous, at least in the Linux kernel world,
>> *Resolves* or *Closes* are used to refer to issues.
> 
> But this is on kernel space, and afaik github uses *Fixes* instead to
> auto close the issues, so I don't really follow what you are trying to
> suggest here, or do you want github to start following Linux kernel
> tags?

GitHub already does. ;-) Resolves, Closes, Fixes all automatically close 
the referenced issue.

[…]


Kind regards,

Paul
