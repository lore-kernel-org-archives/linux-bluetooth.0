Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6281CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3563064F6F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhCDTNX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhCDTNA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 14:13:00 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10220C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 11:12:20 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id a17so3691872oto.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ROB+e94PZYF5HfrdwspdymB3hHAj58GLqoaaRUOBRO0=;
        b=DSA6MTtZLeOaDoHESMipBaYBptys63afAd3BAP+bPTH5QQOKnxSdW+7Q9iYgR2eET2
         H9qmw804MmRAc/FAkNctWCdC1hK8zRmjiekdgNyUgS0VXYi1USkOurJmlgD32jwTaLUH
         agHEwUKZiR7fvFN8uMDryFUkpBxzMnqC3Lz9u5xjPFtD9pPfRM16++pMUKq3WdWimb1D
         3/3z+4TpI3XfqFdUUMRH+uHiSLblh1myRsOr2Rj0Pbr2skjJaEkV2i0Ogl8H0r0wnFNM
         cXGDtHGYgcLLdYM2oa0qhU7uEAXLFfg9jkjFKV0DykbiVOC3VVA/LgZ2l2Df9p7+wgGx
         lUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ROB+e94PZYF5HfrdwspdymB3hHAj58GLqoaaRUOBRO0=;
        b=Ye/ePXXE0b4QGQ8EahKdyUYD9FEe+hsFc8/U7SPmaRfT5qArHPtytllGusxf4DtP+Z
         PusC+MHJC/sXmxl3MZ8FNvXbqLUGpmuxvEpiP/btwsJe1rZfa8YsyzCZTuTLnN1eUrmQ
         G67/+0o8986hkZnUBmHU2f9d+M6akY4MdQ4UJFituBOkoOtZELl9ra9agio4MtGu2pyf
         4bCXJ3IXeBZADFhQhqz7n3qx/94Tk+SzXvF5SwDhYCIUPxwKyO+iSF8znPUAhy6Ie1XE
         cql1KdeMREJIlOVVf6CcSNIZIrq3N8UhZ0qWASMSR5q9/fbayZ05bEf+x52vNgGUIg4k
         ENgg==
X-Gm-Message-State: AOAM531BtZ6fZWL26T+Ut0wsZaCDcG0WUQVI1ZxqNjvTsNtE8olJy74g
        WNMA3xs7uLXWe5UNTKAHvA1D2G2LbV8gue+REss=
X-Google-Smtp-Source: ABdhPJxCJMNwX/ybxDBOH1LE+HUiBF21rhEr8tw8sD1X7obUVGm8SXrRni1I3qR3SRTK8qA664fUF+fEhPsoN7hpfho=
X-Received: by 2002:a9d:69c6:: with SMTP id v6mr4693620oto.371.1614885139474;
 Thu, 04 Mar 2021 11:12:19 -0800 (PST)
MIME-Version: 1.0
References: <f6764fe94d45ff9211674c5799b193d15385a056.camel@collabora.com>
 <CABBYNZLp9pOopbEfONc=oOh=ODFi55YzA6BKoN4ABuSzuZdPbw@mail.gmail.com> <8ede2f3e7593cbbd78e5aa4d3b28257a75e17b63.camel@collabora.com>
In-Reply-To: <8ede2f3e7593cbbd78e5aa4d3b28257a75e17b63.camel@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 11:12:08 -0800
Message-ID: <CABBYNZ+hEgLHitH4zF6M2Qh2Rm29E8D3Qgkh5EQ27Sa91Wr=Tg@mail.gmail.com>
Subject: Re: Bug caused by moving to BlueZ 5.56 (bytes stripped from HoG reports)
To:     =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ricardo,

On Thu, Mar 4, 2021 at 10:57 AM Ricardo Ca=C3=B1uelo
<ricardo.canuelo@collabora.com> wrote:
>
> Hi Luiz
>
> On Thu, 2021-03-04 at 10:44 -0800, Luiz Augusto von Dentz wrote:
> > Nope, you are the first one to report a problem with this change, so
> > chances are that what Dean stated probably still holds since the vast
> > majority of devices didn't care about the report ID. So I suppose the
> > following code shall take care of it or does it not?
> >
> >
> https://github.com/fwupd/fwupd/blob/master/plugins/pixart-rf/fu-pxi-devic=
e.c#L170
> >
>
> Yes, that's how we're dealing with it for now. It's a quick fix, a more g=
eneral
> solution would be to detect the BlueZ version and parse the reports accor=
dingly.
> By the way, is there a way to query the version of the running daemon oth=
er than
> running it with '-v' and parsing the result?

Not really, we could possibly add a version over D-Bus but that
wouldn't help for 5.56 anyway.

> I just wanted to let you know that this can actually happen so you're rea=
dy for
> it, as there might be more code like this in other projects, although I d=
on't
> know how frequent it is for a device to use vendor-specific report IDs.
>
> Cheers,
> Ricardo
>


--=20
Luiz Augusto von Dentz
