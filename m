Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308CBC48BE6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 17:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1865A613BD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 17:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFPRCk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 13:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhFPRCi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 13:02:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B11C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 10:00:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m9so4020892ybo.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1H6CEGaCAf8j8HxYg0SPOcw5HqzDG/Sh23lHhP3nN8=;
        b=nlnYbXRD5YcjVGcRGNqNrbBU3ItDfFeGp/s7zNBLF4xDQYLUR6emVoClC1P/JsB06N
         iHLyugIevrK2yr59xQebdZd3CSA7Sejj5+lnefB2U1g7N7Bqr/hreD7b1X1cOVBaMojC
         fWsnSs6ou0FJWTEY/GiaS4Ks5qAs7ERaeZbTGgMh1tA1PvgozZjy3Wb90Gw7siBmSCew
         5RXD8E4w90XVb48In4MgEFX/kxEY21fqo7jXY6DXEC9rA2jfoeD5+4FQ8zCw5Xw6mpf2
         TJBz54iAwTlw6bQMPXMh3/cTCMacTVH8U0Sls0ZMhlnJMYqYDqlfcHoPlONKQXhJSpq1
         ceAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1H6CEGaCAf8j8HxYg0SPOcw5HqzDG/Sh23lHhP3nN8=;
        b=ffqXJ1UUcjylJkXvZt1AblD3KV/AIPoAIhQmcdBqYAMA747yMgZKYTPmHdNspvYSLz
         TIbS6CS2ak3Ft6Q7U95Up2r0J7FXLyJw6GBhIAObVi6BRTX6Jo+bn2BLa6eP+4bGg46i
         ea7TmTnd+nXaE1trH0uQXRxDWqI3KfJpiFYdEc3NozNYhQ8n1+uDb7iRsAMbwfPyUmiW
         7ig12xck1YnyZag4HafAYpf9BNYW31L5y7fJEGBWSPh21Tmyd+Zs1kG7vE2s88eXuBJ0
         PCyTHKRUQm/qWHiCJ4qIlf6QLRAt/Ar/Kh5NQUxWeEnYAJGjWa6ynRzS5tsWdrQyW6YH
         VqBg==
X-Gm-Message-State: AOAM532fUCDImjodxOlJreP8M0OyH4ptytpYmUtt0VJvT8R0Z0bzqmN+
        2mbXzVvXyzT9zP7p42q3oJIYKunh4lHA1hrsAkP0rrJz5vs=
X-Google-Smtp-Source: ABdhPJzxpxapgUo2IBQpPyzIuTavyS9h8CyiGoYfcVwTnWsGN2bKE1ksv6fw8+jpiZbIshSjqIsJLGe9Co30x2sVdDg=
X-Received: by 2002:a05:6902:102d:: with SMTP id x13mr23713ybt.408.1623862830622;
 Wed, 16 Jun 2021 10:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210611123021.21211-1-surban@surban.net> <60c35cbf.1c69fb81.4ee39.fc1c@mx.google.com>
 <AM9P189MB17301A7C6ADE3457B06BA26DAB0F9@AM9P189MB1730.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P189MB17301A7C6ADE3457B06BA26DAB0F9@AM9P189MB1730.EURP189.PROD.OUTLOOK.COM>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Jun 2021 10:00:19 -0700
Message-ID: <CABBYNZLu0jp2HC+r4Zqd=7cbk24mXnY7GcF799=WNL_Y19iQDg@mail.gmail.com>
Subject: Re: [BlueZ] gatt-client: Check length of notify multiple op
To:     Sebastian Urban <surban@surban.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sebastian,

On Wed, Jun 16, 2021 at 4:25 AM Sebastian Urban <surban@surban.net> wrote:
>
> Hi Luiz,
>
> thanks for applying my other two patches.
>
> Has this one been missed or are there still changes required?
>
> Sebastian
>
> > -----Original Message-----
> > From: bluez.test.bot@gmail.com <bluez.test.bot@gmail.com>
> > Sent: Friday, June 11, 2021 2:53 PM
> > To: linux-bluetooth@vger.kernel.org; Sebastian Urban <surban@surban.net>
> > Subject: RE: [BlueZ] gatt-client: Check length of notify multiple op
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=498859
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      0.62 seconds
> > GitLint                       PASS      0.14 seconds
> > Prep - Setup ELL              PASS      47.26 seconds
> > Build - Prep                  PASS      0.14 seconds
> > Build - Configure             PASS      8.36 seconds
> > Build - Make                  PASS      207.71 seconds
> > Make Check                    PASS      9.15 seconds
> > Make Distcheck                PASS      243.46 seconds
> > Build w/ext ELL - Configure   PASS      8.38 seconds
> > Build w/ext ELL - Make        PASS      195.76 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - PASS
> > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> >
> > ##############################
> > Test: GitLint - PASS
> > Desc: Run gitlint with rule in .gitlint
> >
> > ##############################
> > Test: Prep - Setup ELL - PASS
> > Desc: Clone, build, and install ELL
> >
> > ##############################
> > Test: Build - Prep - PASS
> > Desc: Prepare environment for build
> >
> > ##############################
> > Test: Build - Configure - PASS
> > Desc: Configure the BlueZ source tree
> >
> > ##############################
> > Test: Build - Make - PASS
> > Desc: Build the BlueZ source tree
> >
> > ##############################
> > Test: Make Check - PASS
> > Desc: Run 'make check'
> >
> > ##############################
> > Test: Make Distcheck - PASS
> > Desc: Run distcheck to check the distribution
> >
> > ##############################
> > Test: Build w/ext ELL - Configure - PASS
> > Desc: Configure BlueZ source with '--enable-external-ell' configuration
> >
> > ##############################
> > Test: Build w/ext ELL - Make - PASS
> > Desc: Build BlueZ source with '--enable-external-ell' configuration
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
