Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD1DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Nov 2022 10:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKEKob (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Nov 2022 06:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKEKo2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Nov 2022 06:44:28 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E42DABD
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Nov 2022 03:44:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D2F2B5C0158;
        Sat,  5 Nov 2022 06:44:24 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 05 Nov 2022 06:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667645064; x=1667731464; bh=svqRhy053y
        ZEkTZj6Ytmk3ysvtseyhP5dPlEhdxeIN8=; b=U/Z0DByHiLUjby+n2/EKrPiacz
        OwpbjiDZDfEISrViZwQNQMeYYCxAVN+q1zbHlpZj4aFiccpqFFHOXei5WnkorB2U
        TVdSvHuyV7JICf5OzffFSzmUGHl0aarY/hKnSjIGfHQ4DH1pd+lsrxDPM3R8hhRS
        oDR9ye94Z0bxgszrAoHaMwEVF27wkOhHlPVJuvPJ/WxZ0OoZaukoe3zDEPnOrRpM
        SNQxn8KswTo16F+ghsFCUF+KYkCqwxdyKXRAnHJEAbpLxQ9E0XPwm9NIoxZ87n31
        RnsuUFrepQ4yIdsl6RCrBBquag4Pr0BvHwAAs7+nhWSU81VpLhne3/lpRL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667645064; x=1667731464; bh=svqRhy053yZEkTZj6Ytmk3ysvtse
        yhP5dPlEhdxeIN8=; b=Opdn0ALAFS7kq3d1QDDbn7JU1jKqQoOLAUeh09liYzuu
        Hd7qcnjh4IBxbRomsm6THXbpFcFw13oFe5IYBMUz5vl5KJVLDPuqr3RRBCKCUMK+
        s9UvQOeLDc7XGZCMDVrLq8BKj4yskfQ279xzfbT2zuYgjLmgQys9hXTmikT5GSw6
        hS5cg76F9Aw1iFyKKGbnqLGbFcoJKY1mQwbH0b/La8FxSRvMbFvdnGIejQnWCIgR
        Cc4YwnDaH7FzdmeNgbmjZB7dEoPdwoREp2bGtNutHpHbKBInGUNKgSEqlx4x+Wjj
        GXnLTvKi5ukxm7v9UHMM5ZQGyLm+F7p2a5fOSoQmRA==
X-ME-Sender: <xms:iD5mY9VkrMMzhz69aIY2vb_wxzS-Jhpu4NWASaNczhiAm0M0qr3M4w>
    <xme:iD5mY9loUCWzkvWsskuGKaJTfO7a0pBiCWQSYrVnsIRUjmEToNBkHYunRfY4UzZOU
    Y6quqXYhdygCZi8OKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdefgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepvedvgeevuddvvedvgfelfeegiedvgeehieeutdelvedvieevveeljeefvedt
    leehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vh
X-ME-Proxy: <xmx:iD5mY5by2-6vsV3syfVvMJkhah-s6nph1Y5799mPkXZ0kXIx7OnAxw>
    <xmx:iD5mYwV6xEpv1npTLO5IJstyeSuCG58sY3P6PlbHzYKDEnJX8vo_eg>
    <xmx:iD5mY3k2KGqXg-t2XnJxzmrOjF-F0-JmoUrm0lY7HN0P-pdMZ2wDug>
    <xmx:iD5mY9R9nR6oslj34rb7lqHj8Q8T0OLr5sIGUpWJ8L8ebFeoOQn5hA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A9E8DA6007C; Sat,  5 Nov 2022 06:44:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <69ac6612-0153-4428-b0ff-fe950ffd6448@app.fastmail.com>
In-Reply-To: <CABBYNZJ20Uw8_++2d1HyND-1UZcn5UzzuBcSqhk0W5VhszLutQ@mail.gmail.com>
References: <20221104211303.70222-2-sven@svenpeter.dev>
 <63658c5b.050a0220.abbe1.14c5@mx.google.com>
 <CABBYNZJ20Uw8_++2d1HyND-1UZcn5UzzuBcSqhk0W5VhszLutQ@mail.gmail.com>
Date:   Sat, 05 Nov 2022 11:44:04 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: Broadcom/Apple Bluetooth driver for Apple Silicon
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, Nov 4, 2022, at 23:37, Luiz Augusto von Dentz wrote:
> Hi Sven,
>
> On Fri, Nov 4, 2022 at 3:15 PM <bluez.test.bot@gmail.com> wrote:
>>
>> This is automated email and please do not reply to this email!
>>
>> Dear submitter,
>>
>> Thank you for submitting the patches to the linux bluetooth mailing list.
>> This is a CI test results with your patch series:
>> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=692274
>>
>> ---Test result---
>>
>> Test Summary:
>> CheckPatch                    FAIL      7.46 seconds
>> GitLint                       FAIL      2.01 seconds
>> SubjectPrefix                 FAIL      2.61 seconds
>> BuildKernel                   PASS      34.62 seconds
>> BuildKernel32                 PASS      31.22 seconds
>> Incremental Build with patchesPASS      151.12 seconds
>> TestRunner: Setup             PASS      513.16 seconds
>> TestRunner: l2cap-tester      PASS      17.36 seconds
>> TestRunner: iso-tester        PASS      16.95 seconds
>> TestRunner: bnep-tester       PASS      6.66 seconds
>> TestRunner: mgmt-tester       PASS      107.82 seconds
>> TestRunner: rfcomm-tester     PASS      10.55 seconds
>> TestRunner: sco-tester        PASS      9.93 seconds
>> TestRunner: ioctl-tester      PASS      11.21 seconds
>> TestRunner: mesh-tester       PASS      8.08 seconds
>> TestRunner: smp-tester        PASS      9.90 seconds
>> TestRunner: userchan-tester   PASS      6.88 seconds
>>
>> Details
>> ##############################
>> Test: CheckPatch - FAIL - 7.46 seconds
>> Run checkpatch.pl script with rule in .checkpatch.conf
>> [v5,1/7] dt-bindings: net: Add generic Bluetooth controller\WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
>> #115:
>>  .../{ => bluetooth}/qualcomm-bluetooth.yaml   |  6 ++--
>>
>> WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>>
>> WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>>
>> total: 0 errors, 3 warnings, 71 lines checked
>
> The other errors you can probably ignore but this one above got my
> attention, it seems we are doing the right by having the documentation
> changes as a separate patch but checkpatch is still complaining?

I think that one happens because I replace bluetooth.txt with the yml binding
and replace all references to bluetooth.txt in the same commit. So technically
it looks like I introduce a generic binding and a more specific binding
that includes the generic one in a single commit.

I could split that into multiple commits but the DT maintainers seems to be
fine with the single commit. They also have their own CI and usually complain
if it generates warnings.


Best,


Sven
