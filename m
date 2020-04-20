Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA34C3815B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AB320B1F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfKCxO+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgDTQ6M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTQ6L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 12:58:11 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA8C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 09:58:11 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k133so9389085oih.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X7zmAyKifgt7GNY01plBjIFAKN+iTDEaWmp+iQtBxro=;
        b=XfKCxO+C+05iEP0i6Z9TsvgeY0lHf6R2kmsnNSTi59ADaKwTiOCju72JlnXGDgI2Ef
         Y0iqEoFaQghmLc5Ss2+noNXi5FPMvgiYbe1A1Udk6iiQBeAVZFo/FXGY2NLYAnCCK6KF
         r/Vn/dsjM+yKF+nCmNyGg2ulx5uJKylSEqSOdkJVO/Pq9r7wJbdYUe1dAlvGAREOC6km
         8ovoyFteI5Otm/mOFajdbvrIdCraHZT0tQGB6cJgZJxtFFVN35sggngMRPNKgaWYwoXN
         FysjDxsehz2Kb/I00L46AByzjSSpEkRfH8zSrhzot30GyvqQ2rQthFvw5QG67VweO1SK
         /r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X7zmAyKifgt7GNY01plBjIFAKN+iTDEaWmp+iQtBxro=;
        b=XaPSP35z46MSJbuhLw5yvAsV90fh/o7FS3ge85HsTfVyIy50y2qNL38nHK4oEXPGaG
         /BRKg9NIzi3VaAjNDdD/zYPUP7E5cXJ85TPefR6vg4eJl5R22Ry96NSQWFGA5cuFQzgn
         Uy94e/1uLZf1T/b90JXbLRkga+ZOR/DFwktNIWPjteD8hGdt8HoXHpNa2Uxw+Tp/5V22
         q2HRj/NfS90WdppW0L7CmKGXWfhXDCd8qwUIs6eHztsdpKlLr+DvhfoncLihCJHX3zrR
         kaFeklKhSD746g56RZrbwCeZii5VUuUnBPJOOlWNJP41J29IJsoKLa18w9aOyiDLx+cq
         8CgQ==
X-Gm-Message-State: AGi0PuYgeDwjTjvlZq3go0h4MZ+tv1hlb+QT8aEMSgjyGxzn+Me7cchy
        hfC32XjN7yeQAOw2jZdKI6ohE9VPYO+cCGlPOs8=
X-Google-Smtp-Source: APiQypLmlO1hcgCd5r18ZxWf40vnRV8CtuCenXGMMN6LVlWwVR+a/lNMSm+XtGPuxXyaVadIR8/C9FY3IFA31QP3XgU=
X-Received: by 2002:aca:db8a:: with SMTP id s132mr265372oig.110.1587401890738;
 Mon, 20 Apr 2020 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200420120705.89691-1-szymon.janc@codecoup.pl>
 <20200420120705.89691-3-szymon.janc@codecoup.pl> <a1e5a35a5073bda33d7f36c08bd776397f8c36da.camel@intel.com>
In-Reply-To: <a1e5a35a5073bda33d7f36c08bd776397f8c36da.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Apr 2020 09:57:59 -0700
Message-ID: <CABBYNZ+R1r66mFCNHtgu=RgD_gAeeXuYhk20a0jewmFBa523VA@mail.gmail.com>
Subject: Re: [PATCH 3/4] avctp: Fix compilation with GCC 10
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "szymon.janc@codecoup.pl" <szymon.janc@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Mon, Apr 20, 2020 at 9:44 AM Gix, Brian <brian.gix@intel.com> wrote:
>
> On Mon, 2020-04-20 at 14:07 +0200, Szymon Janc wrote:
> > This one is a false positive but since we never use more than
> > UINPUT_MAX_NAME_SIZE bytes of name we can silence GCC by reducing
> > size of source string.
> >
> >   CC       profiles/audio/bluetoothd-avctp.o
> > In function =E2=80=98uinput_create=E2=80=99,
> >     inlined from =E2=80=98init_uinput=E2=80=99 at profiles/audio/avctp.=
c:1259:20:
> > profiles/audio/avctp.c:1188:3: error: =E2=80=98strncpy=E2=80=99 output =
may be truncated copying 79 bytes from a string of
> > length 248 [-Werror=3Dstringop-truncation]
> >  1188 |   strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE);
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > ---
> >  profiles/audio/avctp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> > index 37ffde9e7..058b44a8b 100644
> > --- a/profiles/audio/avctp.c
> > +++ b/profiles/audio/avctp.c
> > @@ -1246,7 +1246,7 @@ static int uinput_create(struct btd_device *devic=
e, const char *name,
> >
> >  static void init_uinput(struct avctp *session)
> >  {
> > -     char name[248 + 1];
> > +     char name[UINPUT_MAX_NAME_SIZE];
>
> Should this be nul terminated?  (UINPUT_MAX_NAME_SIZE + 1)  ?

I guess not since that is send over to the kernel which accepts up to
UINPUT_MAX_NAME_SIZE so if the name is exactly 248 then the kernel
should be the one adding the NULL termination, if it doesn't then we
need to truncate by doing name[247] =3D '\0'.

> >
> >       device_get_name(session->device, name, sizeof(name));
> >       if (g_str_equal(name, "Nokia CK-20W")) {



--=20
Luiz Augusto von Dentz
