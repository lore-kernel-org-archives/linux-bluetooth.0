Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4959DCDB474
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 17:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377965AbjJTRtm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377970AbjJTRtk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 13:49:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF6D6C
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 10:49:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso17613171fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697824175; x=1698428975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j9qMD28THVBw7Rt3wRPu9PaqR5X3vJDrYmEbo8hLfk=;
        b=TX6rytggrGgd6GZLA1eOq9oQi6bb61L1z2zq/SDB71wC5EKyjwuK0nM/MbrlVEe/bO
         erEzhIPccZUQ19CeqlzQ1VWo9jSbcwr4HPvC6DWN3/Kw3GXJYOK7F+D7j9u4Fl5y4fOV
         JXeNAwQwzf3oEi5ARRDeX8ic1plJuMtOdSUOu54OcXWHi8UQNtCpab99zwo44pBbkSmN
         DRlqw8EEMIobAmVcsIPvKvlbzSJSTp/GXVfSCFcvjM6AhwYCUaT/m3ve+vU0nXlScoeM
         gQC8rBmP4AY1I/liCcLyKPIX4+dM/HAmC3vfQiqy6ciEmfGDdFR9lvk4DkF/JbNYsvdS
         Qq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824175; x=1698428975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3j9qMD28THVBw7Rt3wRPu9PaqR5X3vJDrYmEbo8hLfk=;
        b=fB6uaYN1NlnYoh3V//eCpXis3uFVwDTDhcXHlp14R0nnTcKtbDpXAlcrArL7D3cGDl
         GsgJBRlwXF5U0CvflgFQAMmMWTc9ppaipWZICKCeQNV5dNBjL/7+wBbsrNNnN8gj2PX8
         fxS7dm0rTdIf6MY4ITjkmFF8TlIuIYbaS/kq4E/9Wt4DN7Gj0y/620R6bXrLSpclUw8y
         LEuSaYfnNAJyxAONkRxGJh+sPSss+0Nc0iWNHDaE/FbObWu1Tm4U1ucNrWyoheCyIb/J
         H4z4jsW8jIu4IwLJIOXxGGHiKknTEXEt1pSb1Hhu/rH3ASbEm+h4uefD9KhxU/wAqFox
         CEXA==
X-Gm-Message-State: AOJu0YzwpOYoJ7OC2aYuKGep0iLdS1eXiok8s+N4nZy8jYnpB5HTvLUs
        iKeS7/WDCnzCbL2Y96cXTYcyLh8VvjStNUfIMdBVFbpapperMtO+
X-Google-Smtp-Source: AGHT+IEKIf504gMdVj8ZR8wd7Q5Jm2AFzOaPVnr3UwGnlFBAAz901TSgG3bqFvPPa9sh7rQiKYsyxHHYr+9nwvfJ2UE=
X-Received: by 2002:a2e:b5b7:0:b0:2bf:fae2:f97 with SMTP id
 f23-20020a2eb5b7000000b002bffae20f97mr1851344ljn.12.1697824174828; Fri, 20
 Oct 2023 10:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231020093716.9654-1-purendra.singh@nxp.com> <20231020093716.9654-2-purendra.singh@nxp.com>
 <4cf2cb28-b334-487b-96d6-6318961035e1@molgen.mpg.de>
In-Reply-To: <4cf2cb28-b334-487b-96d6-6318961035e1@molgen.mpg.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 20 Oct 2023 10:49:22 -0700
Message-ID: <CABBYNZKhBp=qw9aB+0CVLu0U1YeYwt2qC80+2fqgwH-sgbWf3A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] gobex/gobex.c : Increase default obex
 timeout from 10 sec to 500 sec
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Purendra Singh <purendra.singh@nxp.com>,
        linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Oct 20, 2023 at 2:44=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Purendra,
>
>
> Thank you for sending version 2. (No space is necessary in the prefix
> before the colon.)
>
>
> Am 20.10.23 um 11:37 schrieb Purendra Singh:
> > This issue is observed when multiple profiles are active from
> > multiple connected devices: A2DP + HID + OBex File transfer
> >
> > File received status of some reference devices is delayed,
> > that causes timeout and file transfer status error (Variation
> > of timeout is between ~100 seconds to ~450 seconds).
> >
> > We tested with Motorola Edge, Samsung M33, OnePlus 6T.
> >
> > Experimentaly we increased the timeout and at 500 seconds no issue was
>
> Experimentally
>
> > observed.
>
> Oh, it=E2=80=99s really seconds. Isn=E2=80=99t greater than 8 minute time=
out *not* very
> user friendly?

Yeah, something like that would probably cause the user to  assume the
operation didn't work.

> > ---
> >   gobex/gobex.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/gobex/gobex.c b/gobex/gobex.c
> > index e9b89cead..f0e1c2c83 100644
> > --- a/gobex/gobex.c
> > +++ b/gobex/gobex.c
> > @@ -22,7 +22,7 @@
> >   #define G_OBEX_MINIMUM_MTU  255
> >   #define G_OBEX_MAXIMUM_MTU  65535
> >
> > -#define G_OBEX_DEFAULT_TIMEOUT       10
> > +#define G_OBEX_DEFAULT_TIMEOUT       500
> >   #define G_OBEX_ABORT_TIMEOUT        5
> >
> >   #define G_OBEX_OP_NONE              0xff
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
