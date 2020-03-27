Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EE9C2D0E8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 20:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE122072F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 20:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYcHfAIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgC0Uzm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:55:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32946 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgC0Uzm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 16:55:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id m14so10082657oic.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fo3EUWHJT1j3yLuNTbHIXcTfIN9vSPE887EDP3zLYe0=;
        b=kYcHfAInHHKIf1i98mn3uB03/rGIJzwgBGtTm+OOf8s8lnzyElYDh/ErhrKQxv/0ps
         ci6gpmRXRMdkyzGn7wPISUbGfUvnZ2iJEf15aQoMSyPCetsZlptGmGwNA1wwtw2W+Df0
         LdCLnclA2VJf9rjhb1iynBQfqsHzMkYboWm9BLpdKN0Ucj1lJe5i+xyKXEystjgTwJ5x
         4W0J0tXMPMVGzr4WMW1QY+fIZBRGsI798kTLASAE5q6w5kKYOcCbJfszyYu9ZOqf3Tkr
         Ywvc5pkFiMean4Y3XknRkuI/DycMvUngM4RgB955qEmUUk6tpqNR5Zu4lZM077/hMNIJ
         x19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fo3EUWHJT1j3yLuNTbHIXcTfIN9vSPE887EDP3zLYe0=;
        b=IcackBMu4KoJdBJKJTIVtGs8Xgz7iMVHRds2ammnX7xoqDTfQ1f+z1ybwfqhEO7nX8
         WVpcmkH1S3/OdW5PqWYZn5X+RSmhV57VbhUD4+auRWosJCX38NrTy5eLEBWSz/VzCdxg
         kQwsa8JVV6nWwUFz2DxGReXfiTxPCCNSXe+HK7T4vWI6NlbGMrZcGH35nzMWnkfy5CQw
         +hUmgzjGDNT/9+5rat/t3178ESk+s3ltQI5L+9RewNj4oTSEHxmXGvxqKihQW8zfTs3s
         59/OuB6BXOrfKeZIlp+rGdCzfUqCcE6VLy2TUGHhz2GM5dWoGM6qvprUjvAd1SJT1pX4
         owYw==
X-Gm-Message-State: ANhLgQ07+uR5Y3pfdD7ITX2Of3ds0zfUgZMmsf1lAf/LVX3dKwtSO756
        DpzD6pYe+viCfZGHdS5GFYSSsX4GbQjWpe+2u277ag==
X-Google-Smtp-Source: ADFU+vvdP8DeaDHhhNTUlAURat0VubfdSIKY17+F8tKiEC9kq2wnZamaBZWxVTQMJXX15q9j095pJy9gc5aNm1++ejc=
X-Received: by 2002:aca:5345:: with SMTP id h66mr622078oib.110.1585342541082;
 Fri, 27 Mar 2020 13:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131356.Bluez.v1.1.Ia3d21e293d18f903fa6e54918856e1dd5ffc904f@changeid>
 <CAJQfnxENfZnXq4e-kaeKF2ByhJ089JXZumWc9ydBJBWGQgTiGw@mail.gmail.com>
In-Reply-To: <CAJQfnxENfZnXq4e-kaeKF2ByhJ089JXZumWc9ydBJBWGQgTiGw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Mar 2020 13:55:28 -0700
Message-ID: <CABBYNZKpa96qiHbTgTEZr-pyTNO+G4mdYtj7wyshdJfaZ4_-5Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] avdtp: fix delay report valid states
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Thu, Mar 26, 2020 at 7:14 PM Archie Pusaka <apusaka@google.com> wrote:
>
> [re-sending as plain text]
> Hi Bluez Maintainers,
>
> Could you take a look at this proposal?
>
> Thank you!
>
>
> On Fri, 20 Mar 2020 at 13:14, Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > According to AVDTP specification section 6.19,
> > avdtp_delayreport_cmd could also be received when the state of SEP
> > is open.
> >
> > Therefore, updating to accommodate such condition.
> > ---
> >
> >  profiles/audio/avdtp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index 0e075f9ff..4b0e63384 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -1936,6 +1936,7 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
> >         stream = sep->stream;
> >
> >         if (sep->state != AVDTP_STATE_CONFIGURED &&
> > +                                       sep->state != AVDTP_STATE_OPEN &&
> >                                         sep->state != AVDTP_STATE_STREAMING) {
> >                 err = AVDTP_BAD_STATE;
> >                 goto failed;
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz
