Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB0AC4360C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F7260E09
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 20:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbhELUNu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 16:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350993AbhELSKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 14:10:38 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D6C061761
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 11:09:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g38so31822897ybi.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7O27ZRXoWUgUUwYIdC4/h4PFgCKQfrQValYMPqWjhY=;
        b=g3CzqtPDAst47QszWheMpjATlH5P6VSgkOoRUrDpd32feIfnMHnWDTC79yM81wtb5u
         zVnOAQV7Iiyw7IqPFzVfvtcRWUSRKNWaYjz1x8IoVuCMfjFXYtzFpdnzxhrs+NtIP3df
         G2F+qIfepKUMc66iVEIXKz2w9uqYszYwRrm9FnHUbEaLXkdnyvQxTcFdPQW/94BCZw8k
         NW1apGYm927Vy9llkcRMZDZxUMOEWKUswTDuNyuoN/RmHaR5gaORUOp5ZgSIACeXhirL
         buXW/BHz14JQdBI9BOdA0dCPYFdEHDMaKnlagoU6rXew9vsHygtmx9PIkr7R9xQ7nOCv
         qaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7O27ZRXoWUgUUwYIdC4/h4PFgCKQfrQValYMPqWjhY=;
        b=gXB0wJYl14dA2iYjG7/g8m3EZw5O25NEI/9uO2jj76RYrGv4rOkYSUoSOhRxHLkkot
         SIn7ybFPB/LwyixLC+onWzYGRlF6IbykpagYzM0teMnM5L4wCiOjmaNR1/L58moj/ctl
         DwLOg2issFI4d6ommi7iIiM6Bf0XfYpd1DZygeWTQAa5W4H4GMzZecBxr5VdWXC6H9Q8
         pNmXYtLsIpoN7vWDGhqshqlK9XVgxPxhHnBKIMh6+UeEKZMB2vkvz/QBN4U2oeuT/7vl
         aaMO3jt9ypmfPWtXfQM5AlkcpgJC/tpgr/yV9ATj42kFq2a3DUstg26Vhg4e+2H4SCY3
         R7Qw==
X-Gm-Message-State: AOAM531v06lsQdIe+6WrHhcTDK4MJPeOtSgLEzDqJCO1qlyKHSS9I316
        kMGujdQikfLPnmgmHVt1MIwczDyp6FUK4NbE7Dk=
X-Google-Smtp-Source: ABdhPJzxscfVg2UWDRZvGEJPuaQ7DNiTluGHkqURpr+VjhmqnvvhaeheFlePoV6qUOJGUG2s4LgqipbX8nGsPVvOQlM=
X-Received: by 2002:a25:a466:: with SMTP id f93mr50561965ybi.264.1620842968876;
 Wed, 12 May 2021 11:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_JV5OCS78ZoG6MtAdQCp39oQemzUvQk1DwduGy_LhDuNv9DA@mail.gmail.com>
 <CABBYNZKtAf=i=au+pF4Kkf_X3oAm_WZBXCwQWchUVSoTdUCU=g@mail.gmail.com> <CAA_JV5NH2z6ywTHi15rrasdgORiarniUqZX3UBzbSGfHc=eVsQ@mail.gmail.com>
In-Reply-To: <CAA_JV5NH2z6ywTHi15rrasdgORiarniUqZX3UBzbSGfHc=eVsQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 May 2021 11:09:18 -0700
Message-ID: <CABBYNZKFbdk1QHQ4JsEXSbXfOATZt9-dO3MRmYq_nCHViZB_5w@mail.gmail.com>
Subject: Re: Unable to establish ble connection between Raspberrypi4B and Laptop
To:     nagesh shamnur <nagesh.shamnur@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nagesh,

On Wed, May 12, 2021 at 11:03 AM nagesh shamnur
<nagesh.shamnur@gmail.com> wrote:
>
> Thanks for the reply. Is there any way i can avoid this problem and make the connection successful?


Yes you can register a profile, what were you planning on doing with
the connection? Even a serial port profiles would do but one of the
side would have to register it.

>
> On Wed, 12 May 2021 at 23:31, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Nagesh,
>>
>> On Wed, May 12, 2021 at 6:46 AM nagesh shamnur <nagesh.shamnur@gmail.com> wrote:
>> >
>> > Hi All,
>> >  I am unable to establish a ble connection between my Raspberrypi4B
>> > and Laptop. Configuration is as below:
>> >
>> > Laptop: Ubuntu-20.04.2 LTS, bluez version: 5.53 Raspberrypi4B:
>> > Ubuntu-21.04 bluez version: 5.56
>> >
>> > Bluetoothctl logs @Raspberrypi4B: as attached
>> >
>> > btmon logs @Raspberrypi4B: as attached
>> >
>> > I see in the btmon output, always connection is terminated but no
>> > reason is present which specifies the cause for it.
>> >
>> > Initially I was using Ubuntu 20.04.2 LTS on my Raspberrypi4b which I
>> > later upgraded to 21.04 but still no luck. Couple of posts pointed to
>> > bug in bluez which was pretty old and i am assuming would have already
>> > fixed in the bluez 5.56 version.
>> >
>> > Can someone help me in resolving this issue?
>>
>> There doesn't seem to be any L2CAP channels left which means no
>> profile was able to connect which causes the ACL Link to drop since
>> there is no use for it.
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
