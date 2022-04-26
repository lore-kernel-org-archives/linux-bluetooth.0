Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DA7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 18:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbiDZSMW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242749AbiDZSMV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 14:12:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D8C67D26
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 11:09:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y14so17898474pfe.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XzizTH6GBsEeHjXrvTZrINTmP5RyDa3so6MzG/iZbA=;
        b=g0X2PHRlRr+G8Rwz3IIO8jpBuv6U8cprL3RqY77B+7bOcQYqaVQnCkzXIpWw+B2Mu6
         VcGfoYvH2Sj/ecCktmxPQhzWmmPfCVFZuTHBqwRcNtS9dcwa+cJBscq0edbE40LPwoH/
         Co9SIz4o6nxIb/RgSeSx9TaULmzCDllcUE2kxIQlTbrPXkRX+1D89wEVSqy+AmR6NNJf
         +Xe54PUsN6eLBChBSRYEuzMC2T44UHzt6gvbNIGUYMJ8Yl15Y7BeRnGPbY3ChuxlmMXL
         yl4f48OYr9Ex9umrTsb1oTo6Vfrj35IK2LCh02bOdIqux5NYAMFhRlt8Gjx/70nTeg/y
         5P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XzizTH6GBsEeHjXrvTZrINTmP5RyDa3so6MzG/iZbA=;
        b=bMEqvWnAqVWGu/Kc7D912WQsl8dsnC+q9UeuceaNtjDaIz9pliLXik+AfB2xZKpEZu
         0LwsS0SHApZ2+j/jb55OwKYFqCDVFJ8kJiVTLqWCecrtPEX8Se0/+Rdbo3rt77pr3697
         tNxYNwk8XusnUZJGv9yy8DTdhqp4nDALTZdQqwB2OA02e0p6rw0dQMf6lhaOeMLyOpLp
         9PKpUWTXof33v2Uod5OCcbonCjbFO0VfURiMqk/ePMnLAtsynBRZkNDvG07B38sJ7s9e
         MeoN9KwOfcLgCV8j+K1hWXaJ/YSqUZO61ZtbGrYmu7oJINs9adydBQmtpC9spUjKNDic
         KVEQ==
X-Gm-Message-State: AOAM531geaMG5kL8aRiPA235DdQj5avWOnJQg4ieTDQQqp7x7AOCnI+k
        iFGT6fdJPE1Ha/Cr7qXzCWfNHEGuWDQCCyXU8vt2uZzj
X-Google-Smtp-Source: ABdhPJzcLk7f1pQQiu3SDbn8SNqG//FAWJBpnKYmkkMlaXjwBnCByqwQ+d7O7x3FVD7Nmk8ebFbrLnKP0MVjRarb8us=
X-Received: by 2002:a63:d57:0:b0:39e:11d0:ca1f with SMTP id
 23-20020a630d57000000b0039e11d0ca1fmr20283353pgn.182.1650996552952; Tue, 26
 Apr 2022 11:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <RO2P152MB4617632DBD67266CE4D1D3DE9BFB9@RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM>
In-Reply-To: <RO2P152MB4617632DBD67266CE4D1D3DE9BFB9@RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 26 Apr 2022 11:09:01 -0700
Message-ID: <CABBYNZJ9MygU4nDU+L+BbExAwnD_qAhM_3SKpPX=twvN6N2GLw@mail.gmail.com>
Subject: Re: LE Audio and LC3 support?
To:     Arthur Fragoso <arthur@life.net.br>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arthur,

On Tue, Apr 26, 2022 at 1:50 AM Arthur Fragoso <arthur@life.net.br> wrote:
>
> Hello,
>
> I was gathering information about LE Audio & LC3 supported systems and including it in the wikipedia article https://en.wikipedia.org/wiki/LC3_(codec)
>
> I saw Android 13 added support for it, but I was wondering if the Linux kernel had support for it. (and at what version)
>
> I tried to look at the source code and commits description and I'm unsure.
>
> In the pipewire gitlab, there is a good discussion about it with good information and links about implementation.
>
> https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/1211
>
> And if this is currently not implemented, are there plans to implement it?

We are working on it, I should be able to send the kernel changes
later this week.

-- 
Luiz Augusto von Dentz
