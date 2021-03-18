Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B1EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 09:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFF364E98
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 09:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhCRJMZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:12:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59391 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhCRJMF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 05:12:05 -0400
Received: from mac-pro.holtmann.net (p4fefce19.dip0.t-ipconnect.de [79.239.206.25])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9CA06CED2A;
        Thu, 18 Mar 2021 10:19:41 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH BlueZ] build: Fix build with latest tree
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+-VHu-GAb7g6XF15V3fm9XzrvXV6c_V6Uj1-1SgivQ2Q@mail.gmail.com>
Date:   Thu, 18 Mar 2021 10:12:03 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <FB99CA80-BBDB-437B-BDD0-5FA0DF67FD7E@holtmann.org>
References: <20210316205838.2164464-1-luiz.dentz@gmail.com>
 <FD38AD5A-FADA-4EBB-AC7C-BD91F50EE248@holtmann.org>
 <CABBYNZ+zmuN+UKOXvSgh7EMbsoZTp=9gZ7-CCPpr0V3BT+qkbg@mail.gmail.com>
 <CABBYNZ+-VHu-GAb7g6XF15V3fm9XzrvXV6c_V6Uj1-1SgivQ2Q@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>> Latest ell tree has introduced useful.h and main-private.h which are
>>>> required to build:
>>>> 
>>>> ell/cert-crypto.c:35:10: fatal error: useful.h: No such file or
>>>> directory
>>>>  35 | #include "useful.h"
>>>>        |          ^~~~~~~~~~
>>>> ...
>>>> ---
>>>> Makefile.am | 4 +++-
>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/Makefile.am b/Makefile.am
>>>> index ff0df2196..7fce2e7c0 100644
>>>> --- a/Makefile.am
>>>> +++ b/Makefile.am
>>>> @@ -135,7 +135,9 @@ ell_headers = ell/util.h \
>>>>                      ell/asn1-private.h \
>>>>                      ell/cert-private.h \
>>>>                      ell/pem-private.h \
>>>> -                     ell/uuid.h
>>>> +                     ell/uuid.h \
>>>> +                     ell/useful.h \
>>>> +                     ell/main-private.h
>>>> 
>>> 
>>> this is the wrong fix. It will break in the tarballs. ELL will not install ell/useful.h ever. So every tarball needs to ensure that ell/useful.h is included. Which means you need to follow the fix from iwd here.
>> 
>> Are you talking about this:
>> 
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=ed05585063f2e6d8f2fcd5f008b861062ac7a429
>> 
>> Shall we use the same mechanism to link the headers?
> 
> I tried with distcheck to see what would be included in the tarball,
> both useful.h and main-private.h do appear to be included, perhaps you
> are saying that when we use non-built-in/shared ell
> (--enable-external-ell) those headers are not installed, but I guess
> in that case we don't need the private header as we won't be using the
> built-in sources, or I'm missing something. That said perhaps this is
> different in case of iwd as it seems to be using useful.h directly:
> 
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=17cf4da72613e80d08d51401399d02683ba8664b

for the build case --enable-external-ell you need need ell/useful.h linked or provided in the tarball. All other headers are not needed in that case. See my iwd commit that does exactly that.

Regards

Marcel

