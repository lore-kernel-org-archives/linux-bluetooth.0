Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E92C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Feb 2021 23:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2888664DD8
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Feb 2021 23:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBGXC2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Feb 2021 18:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGXC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Feb 2021 18:02:28 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8D2C06174A
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Feb 2021 15:01:48 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id f1so183107oou.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Feb 2021 15:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anjpz/Vnvrbav6pLH7NBUnIh8nN23GLILjVYByAoaUY=;
        b=pICZ6xk7quOjjHq0ibXfEPxaa4QkSzaRe/+KHMBAPZV6pkKt3BhI74UXCYei3cL66v
         F+IEj4UeJgkBP5bqRKGrwmwzDmP5W7scSOftnY3sA6sWyMYYHcwpaWiZqIL/Dpx0YvK2
         7iG2tCUTS3XgYjSUIDXcW8Ri0t/CfNy86TOShqJuNyGXtf8JP/GUUkPD9o2S9P8+P6Bs
         Dn0uGE5NomJIooOEAf5M959VyZ7O7U7fxlOH911CCZvPenfvPWjFF8/Nks6vi3xM4J/4
         pgdqyyW+uLulH+iF6zSpdNrU8ffFu2IMy0qbEBzZzbqko1N9RrBLWoCWhUEIUiPUEWuQ
         Fvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anjpz/Vnvrbav6pLH7NBUnIh8nN23GLILjVYByAoaUY=;
        b=QEtusxReixy7W2FTQdJRWTYby7yGOKYiI0XIeM07etOekO0HilSudJVWcJd7vYIdBt
         bmF6l7r4kLoYEiTll1N4AGvJVaaila71xo3eKPmwGWAMkxsGapXTSCV8bnc4j+Ilw5/I
         Hz1s/xtBpASM+YR5l/mTolpkcCv1mqhaTRKQn2kmG0BNJpV/UOGAo5+JkmJoj05Wholn
         Sd2cRXPIxBWD2e3er7NKLXTMwDlQvS1ZcMbbzISiN03h6oMRk4+RC1YgDH9sWb2Elyou
         hP9ykcnIFYvzKqkQRaQEmnYr/F4itsoJKPnCloqZer5c5R9PBQ95gbQOPjNqUoNLCK8E
         w/sA==
X-Gm-Message-State: AOAM5320I/ArDqfkoaAXs3DYHV2Lm0KP+ZzYfT0c4rMxsmCcxSmNwg45
        cgOSGsALh4NXGVn3NnPRseZEZEbdIOSM/izYB6w=
X-Google-Smtp-Source: ABdhPJxE3F48mEcPwFMGfW3BmWYPHPPB8dhsXLOCUeYXTechbU/jDHkScfQxenx3RzDqyva8tfE0Z5/zurhktyQwsQM=
X-Received: by 2002:a4a:9d0e:: with SMTP id w14mr10606901ooj.7.1612738907381;
 Sun, 07 Feb 2021 15:01:47 -0800 (PST)
MIME-Version: 1.0
References: <CAG17S_Nhp2DtP0jqHkdq51ZXOgGmLwRhzvqH0wmj2jSao7pZLQ@mail.gmail.com>
 <CAHdu5-69z1S0YcOmRMn7MnfvSAWt5H5oZzkZNCtj5tVp-MfOfg@mail.gmail.com>
In-Reply-To: <CAHdu5-69z1S0YcOmRMn7MnfvSAWt5H5oZzkZNCtj5tVp-MfOfg@mail.gmail.com>
From:   KeithG <ys3al35l@gmail.com>
Date:   Sun, 7 Feb 2021 17:01:36 -0600
Message-ID: <CAG17S_Pik_ThMqPGyvu6mviy1Htr+Yhs_AAAxpXFOJ3Q9E0g3A@mail.gmail.com>
Subject: Re: keyboard pairing railures
To:     "mathieu.stephan@gmail.com" <mathieu.stephan@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Feb 7, 2021 at 3:12 PM mathieu.stephan@gmail.com
<mathieu.stephan@gmail.com> wrote:
>
> Hello,
>
> The Mooltipass team has indeed seen this quite often recently.
> https://github.com/mooltipass/minible/issues/205
> https://github.com/bluez/bluez/issues/55

Trace posted to github issue 55.
