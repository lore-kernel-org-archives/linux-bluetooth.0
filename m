Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3AEC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 23:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4992176D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 23:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKw88kSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLQXrb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:47:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34747 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLQXra (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 18:47:30 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so132792oig.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 15:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QdZql6HN96JYWj0bexaNHJQTogMM/B7Vd5sAJmfIAkQ=;
        b=WKw88kSrztYl0d/loajHuGWhoHjjM7rqDEhySamiaulMG/ZQfTzdb6BGnhK1FfRrhT
         bXJdmCYdoxd0DtQ7DEtwxTWBANtofQaD4oHZCiuxJZW790tRkxzbkGsFaEkxocCKA/57
         XS886S0skqGmXvqybQLuMOx/GrMkBDreillW3VKZ6xj71ZNnfoOFm/lElDKsXeYnDeNt
         oszgZK1duwXmL+tkonX7UqkdrZIbKHp6JvkN98E22tQAyLTEWEGNYp+znV+9bzQZxFun
         vzbQjy+urtKO1aP8jOtTukYa18L1UvKDEEAqV1nYoeQiXyUGlwhndpi014R7kAQFOnMh
         0QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QdZql6HN96JYWj0bexaNHJQTogMM/B7Vd5sAJmfIAkQ=;
        b=SeC0q/xMgl3JftCLSyWqFPRyzUysCHnKjkAPMmDdsipHugstymshQgEgYEk2f3HfXk
         ZduSEonx+5eyTnlUtXI+NizkQNlazLLVb/ymi7wd6ChuOASiVXHuTVlnQwxe/4xmUrLa
         5LjQP6xRYYK7OKg/Pa6UbNeqtNdhJz9zlHi6kR+lE1C/E5M45F96W/3Tmduc71vAZTDt
         1M6gfAfzOHC5plew0yYnMNl7YOSxvd8BxO1eIKlvcVVm/pbB9J3a2PxX9eeL4WbRq75o
         6Q2z0IePiD/yepfhqVvvKO0fl+W0LUUtZ2NbbzWrEYt8H0/d7fcIXK0WQhu0s9OEvfhp
         rwFA==
X-Gm-Message-State: APjAAAUT3rrXrH8exrY3v1geolBZm9uizNYjkP+TfYI3Bv+hINMadTfH
        BdZfl3/x790ROhXul3VJI0zMe0tBvMWTY/rf/iHff8Jy
X-Google-Smtp-Source: APXvYqzcsdieDsz3kk7g7lqpCpF6SrRvQl7emz12SA32wFKRxfxbUpmbO3R+yGF1a3/8AgNz30XN9UC1i03WxtkaeoQ=
X-Received: by 2002:aca:1704:: with SMTP id j4mr3414160oii.21.1576626449835;
 Tue, 17 Dec 2019 15:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20191201185740.uot7zb2s53p5gu7z@pali> <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali> <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com> <20191216091521.reh2urr25husschv@pali>
In-Reply-To: <20191216091521.reh2urr25husschv@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Dec 2019 15:47:16 -0800
Message-ID: <CABBYNZKpKyK0Hj2PwD7OmC1yuJU7uniyLd62t5RyVpP7miYqBg@mail.gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tanu Kaskinen <tanuk@iki.fi>,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Dec 16, 2019 at 1:15 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> Hi!
>
> On Monday 16 December 2019 00:11:04 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Thu, Dec 5, 2019 at 11:32 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > On Monday 02 December 2019 19:45:12 Pali Roh=C3=A1r wrote:
> > > > On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > > > > I think hsphfpd should be part of bluetoothd, but if that's not
> > > > > possible, then that's not possible.
> > > >
> > > > I do not know if bluez developers are interested in having this cod=
e as
> > > > part of bluez project, specially when in bluez4 HFP profile was the=
re
> > > > and in bluez5 was HFP code completely removed.
> > >
> > > Hello, could someone from bluez developers comment this Tanu's point?
> >
> > I would have to say no, we are definitely not interested in yet
> > another daemon for AT parsing, we actually have too many of these
> > around, either in a form of Modem Manager, oFono, etc.
>
> Proposed hsphfpd daemon is not (only) for parsing AT commands, but for
> implementing logic around HSP and HFP profiles and export either native
> interfaces (linux uinput) or DBus interfaces for features provided by
> HSP and HFP specifications and also for current and future vendor
> extensions. And part of this HSP/HFP implementation is of course needed
> parsing and interpreting some of AT commands. Look into my design and
> API proposal. Current daemons which provides AT parsing (like ofono or
> modem manager) are not suitable for for whole HSP and HFP profiles with
> all those extensions (like all possible ways for reporting battery
> level), so for HFP is needed some of custom AT parser.

Not following you on this one, oFono is intended for telephony
functionality and afaik it could parse battery, etc. Also would your
daemon include such functionality or you are to combine that with
oFono? I do appreciate the effort you have put into the SBC modes and
codec support but Im afraid you are going to experience some real pain
to maintain such a system all in your own, there are a lot of features
being exposed via AT commands and we risk to have yet another daemon
that just do parts of them until the next person comes with a
different use case and we are back to square one.

> > That said one
> > simpler way to resolve all of this is to maintain a plugin to
> > bluetoothd that way HSP/HFP becomes native again, that can either be
> > maintained in the tree or out of the tree.
>
> I do not see how could just plain plugin for bluez without AT parser
> could help. This seems to just complicate whole implementation. I
> already implemented prototype implementation of hsphfpd to see how
> complicated it is and what is needed...

Well the exactly the same thing with yet another daemon, we obviously
will need an AT parser, but the nice thing of being a native plugin is
that it can detect if another entity register for HSP/HFP and disable
itself (or have a policy to control that), the implementation can be
exactly what you have but without the extra rounds trips involved to
communicate back and forth with your daemon, so it is pretty straight
forward in terms o implementation.

> So if bluez daemon is not the right place for hsphpfd, it would be
> separate daemon outside of bluez.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
