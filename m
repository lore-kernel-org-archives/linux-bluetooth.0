Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6207DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 18:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4988861371
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhJESo3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 14:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhJESo2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 14:44:28 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99963C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 11:42:37 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id p18so154839vsu.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsXe+/lvMCbUwt1CJcZHNzbDkIK8HAxD6HMOlo1unVA=;
        b=PgR8I3uQQMS1VVZj2r54R6miTt2ilArMKLTOu5XE9L3lNS1POCCK1DmCzKsHj5uini
         vWDEEUo313NdPfsvj68wXMUKK/g6lu53CPooUWwLIX3ynfEXPlK6jKqza6P31MIL5TC2
         T5/woCiTRf+unaIHlrQwRCkUGOZ6b/fmOhBIDDWYapBls0Yfth37Y1DvKE+9o1wd+nDt
         c/5LXaP6sbelZfpVCy468uKklT7iaj98n+ykzHaVTebk0TcDRypJTqcJTJ95PUpf1CGU
         rjcMM40SxC+8XQfL0iKaGCLxVPkavpMVDYy4dYUKyAGOXqFEq6ftnJlMcGjb3N1OCmrK
         Gq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsXe+/lvMCbUwt1CJcZHNzbDkIK8HAxD6HMOlo1unVA=;
        b=SZbPmEI2Xv42l6d4ZSpYuB47mts6tilI/UaTqSB03HmM2uBE7RcFWnIQ+FmznFC26e
         i9/5WtCHEatuXChjCYwJYK4GYO/lNzU3LJzZmZjj4q9wMDupL8/nrqUwfNk8JFRsbPfK
         Omx34RU2Cgs9ZeemUnEWXSo6HSAQaG0AzmuPLk47QEFwBp8rL7Q7euRUkc1RHjwax7ub
         2wtobtFiWzV2o5oQ7Isu2868JAhiHVhzXzIEuLhOr8hwfD/Kua1AtIxta2YeoKUwaGwp
         /3yX2SOUFxF70UhigHHPRXZHYFIRX8Yb/PjmiOzhhKn+EzEsePcknf0PlKK6HxDILoZW
         MCaQ==
X-Gm-Message-State: AOAM533ClhkHKfsmbZdY/7w9Ff3rvZhI0V0Os3hZq1RT+eh1CZCBAIDl
        o8K5ce0JmeavJ2rjHXS9zWQlTPXHTRwtOwF31jENt5BW
X-Google-Smtp-Source: ABdhPJwLu+8pihe4xRVjE8mPQXYjKUgSW39ZVvrb0UC99pU3BYLxfkZmHBhyHj6t9/pQIl885h+44ysRT/Jex+/IsKs=
X-Received: by 2002:a67:2e16:: with SMTP id u22mr12372866vsu.61.1633459356590;
 Tue, 05 Oct 2021 11:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211004215630.216603-1-hj.tedd.an@gmail.com> <615b81d5.1c69fb81.ebe57.9357@mx.google.com>
In-Reply-To: <615b81d5.1c69fb81.ebe57.9357@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 5 Oct 2021 11:42:26 -0700
Message-ID: <CABBYNZJwOKWCvzGA9+Oe+Bym=aermM0Q2bsyrdHpwbS_LdT-Kw@mail.gmail.com>
Subject: Re: [BlueZ] tools/mgmt-tester: Fix the suspend reason code
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Oct 4, 2021 at 4:54 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=557383
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.48 seconds
> GitLint                       PASS      0.28 seconds
> Prep - Setup ELL              PASS      43.19 seconds
> Build - Prep                  PASS      0.21 seconds
> Build - Configure             PASS      7.72 seconds
> Build - Make                  PASS      184.40 seconds
> Make Check                    PASS      9.19 seconds
> Make Distcheck                PASS      220.77 seconds
> Build w/ext ELL - Configure   PASS      7.74 seconds
> Build w/ext ELL - Make        PASS      179.59 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
