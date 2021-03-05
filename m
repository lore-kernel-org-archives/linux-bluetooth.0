Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C267CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 21:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEDC64F42
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 21:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCEVr4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCEVre (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 16:47:34 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F1C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 13:47:34 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id z126so4113324oiz.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 13:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HphVGj9cM6Dvm397QzT7S5CgmpB11Cpk/6JSpO+FS9s=;
        b=I8QSq8aQtF5M6mG+C6odOF3k7jDFo4NfngLECQAYAxgpgDFts/zJ40qCN3P4ky/58Z
         ugfZowQIBsKsaDHRtMfSCwIYcYQchP1h80ILz68zUi81wNdrcRMjPcR3SBqHe4MdvBWH
         seflLzRK0IQUFwTbu5vlws9Idddc019nAQ/7YKrtmGWGAPZJeoV7ROIi4zdq98U4/Iru
         cRr5KUcyTb6sLKzRtt2OmK0g3eiz0EE7arh9lDG6U3HUuuLW6HXQwKHFGkyd7imQRmg0
         yLMkYlHgNOop68ELp3nCn3vtBmplzU86Hqy5KZBN1cTwR50Fp/o201ny3CCAGt7fpv8h
         Rpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HphVGj9cM6Dvm397QzT7S5CgmpB11Cpk/6JSpO+FS9s=;
        b=j8n02Dvv6gDS73KDbD2kUYXH+FXw4OhseqaUVSsYhgrGFpQsiMIus+ZmwRnJQe5JGc
         gvCvlckQO9wWTpclRJirU9D6TE4z9p72ReN+0ITJ+6ibA2rb/fsKhhujUe3GGpkDbELq
         VmXx+sSgdAWAGcbXhvTIFai60DUl0CzqmGwqAv6Qf/L9hUZzyg0ex0/gs68V8JepRogJ
         h/viLBQj1lY1ev/VO7v6rGFOyTgRM4kXHB/jPeVugmA/H6Eb3hqTEjsA3y6FtIdOUvBk
         lHysd1AJ+fRk79JRq/KzPqbj+ZHP3fq61VXC7P9zo1EH6SjJe1l/gozXLlOmu9dlqfH9
         m0ig==
X-Gm-Message-State: AOAM530JEwF3/dgqHivkWWYX7JdAC9hyV4TjKhxvaVeMpc9hSQAEY3BM
        cJ+A18HkjMMDH3BT4VYTYqY03d0XB1PKYfpQlhBk7tQXNb0n3A==
X-Google-Smtp-Source: ABdhPJwN0WslOcWlMZnRdj3EorrwVWK2lwouf3mR3Q8VMnlgC9/xLiBighXhUlFDe0zqPuApPz0ip3ZpCCuphlwNL3k=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr8736561oiw.161.1614980854005;
 Fri, 05 Mar 2021 13:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20210303081942.GH7348@in.waw.pl> <CABBYNZLYiGwYCQcihs9x-AJ33jS5dmUoY45GM4sk0PbmQW-iLg@mail.gmail.com>
 <20210304185348.GL7348@in.waw.pl> <20210305140224.GM7348@in.waw.pl>
In-Reply-To: <20210305140224.GM7348@in.waw.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Mar 2021 13:47:23 -0800
Message-ID: <CABBYNZLmu7P09_H1xKoHA0e+nrTR5yugA5VPCF1vx-VG7eZwsQ@mail.gmail.com>
Subject: Re: patch to fix conflict with unistd.h
To:     =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zbigniew,

On Fri, Mar 5, 2021 at 6:02 AM Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
>
> On Thu, Mar 04, 2021 at 06:53:48PM +0000, Zbigniew J=C4=99drzejewski-Szme=
k wrote:
> > On Thu, Mar 04, 2021 at 08:37:04AM -0800, Luiz Augusto von Dentz wrote:
> > > Hi Zbigniew,
> > >
> > > On Thu, Mar 4, 2021 at 1:02 AM Zbigniew J=C4=99drzejewski-Szmek
> > > <zbyszek@in.waw.pl> wrote:
> > > >
> > >
> > > Can you send it as a proper patch, look at HACKING if you don't know
> > > how to send it using e.g. git send-patch.
> >
> > Can you be more precise? What was wrong with the first version.
>
> Anyway, the patch is here for anyone who wants to grab it:
> https://src.fedoraproject.org/rpms/bluez/raw/fdda690e478cc1581c12265af16d=
043c757758dd/f/0005-media-rename-local-function-conflicting-with-pause-2.pa=
tch
>
> Zbyszek

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING#n98

We need proper patches so it trigger CI, PW, etc and once that is
validated I can git am directly, attachments and links don't work for
that purpose.


--=20
Luiz Augusto von Dentz
