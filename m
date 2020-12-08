Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F972C47434
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 20:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C39B23A53
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 20:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgLHUQM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:16:12 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34346 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbgLHUMu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 15:12:50 -0500
Received: by mail-ot1-f47.google.com with SMTP id a109so1394571otc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VS4bztVO9Q6HyqZ0Bty9RN6srIW+1eE+z8XoORtfkRg=;
        b=RRXA3+6EimiPunGCxMNxoPph8I3Kw2JKefKoltZLwQMv8J1r+qcWhxj/xFhIolRH44
         HuQS43T36CN9SR3qmMEerghzuQ5IHNe0T7LZOXrxiMkhN/gvHd9VopiGrRQwGXweV6xv
         dmOxhkCioFcNbgxB+srAXyKi3RtAR9QmR/8NHkSQAgr+f9OXXBG+tirBhw1iskoRdkSN
         wONTO6hm+idW9SGqrILrVHfSom45GmBzQBqS/9ay9w4jCFDWMIoMa5UQvegoogfNl4no
         ATXGt0LugDLAQicIG/zFCnSGR1+n68ebqAeCK6wBGPK1MFC6AEBVGKoyHEKxTHJFl7Yc
         5nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VS4bztVO9Q6HyqZ0Bty9RN6srIW+1eE+z8XoORtfkRg=;
        b=UYPeTKAm1rPHcskRi3OktnAfTdN9Tx8V+vVI8CwIAK4OFQ/nA+UWl/r3Xy3ZRL4F0W
         VyZSXspE1qGhlUO+gyLDI4pQRS15lKQrME0yhOVKuL7hcpFdVYvDEExTHvCPwFoTeSSq
         kzX1VUB7wAeVZm6L/p+TATTzz7rzFD6YimKrcGQRuhkVyuIhrFAdIW33zdUBsk138KQM
         BtKPfNbgFVJTqTu4iuzbUfXv0WyAxW6q0Y88Rh5ObmPYwu9zvOj4dLRrSULVwg5ZC+mZ
         hPd95WrbxKXrBPh9SFiTvz0Ms9AAL5wwYlJ0vTFmJvXyZop79ykBA6dAqrsE2vPXs98J
         JYsQ==
X-Gm-Message-State: AOAM532r2xdYg3B04efmnZQDuLH3yx8h+bd0E3cyry6YlZO4VAT/bTJN
        jAZXkkQ3K3mLdDzt1yDIAHCU0J0k+YAzOCK1d+V4vveGoLc=
X-Google-Smtp-Source: ABdhPJy4U0gMP4wwUDoi2yF80NTancrIHwxoAAgDLQaFfrTGe64KDRZwnCUYSXV4+RVj70Kbu7z0BvipKeLxX9uXj24=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr18395605otq.240.1607453331125;
 Tue, 08 Dec 2020 10:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20201208172912.4352-1-hadess@hadess.net> <CABBYNZJNTDek+kKS5wtrr67Xx8DmFGvcV13cLSxULgJRa5N+3g@mail.gmail.com>
 <3fcd56e8b875fb3d4ed6d58ad150e4b054d875ca.camel@hadess.net>
In-Reply-To: <3fcd56e8b875fb3d4ed6d58ad150e4b054d875ca.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Dec 2020 10:48:39 -0800
Message-ID: <CABBYNZKyndk8SG-xW=HYA7UZug==KtZfSmU=WHbgN1MC+DeM5A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not knowing options
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        "An, Tedd" <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Dec 8, 2020 at 10:27 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2020-12-08 at 10:09 -0800, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Tue, Dec 8, 2020 at 9:36 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > >
> > > The current implementation of L2CAP options negotiation will
> > > continue
> > > the negotiation when a device responds with L2CAP_CONF_UNACCEPT
> > > ("unaccepted
> > > options"), but not when the device replies with L2CAP_CONF_UNKNOWN
> > > ("unknown
> > > options").
> > >
> > > Trying to continue the negotiation without ERTM support will allow
> > > Bluetooth-capable XBox One controllers (notably models 1708 and
> > > 1797)
> > > to connect.
> >
> > While the bellow traces looks fine we need to confirm that it doesn't
> > break the qualification tests e.g:
> >
> > L2CAP/COS/CFD/BV-14-C [Unknown Mandatory Options Request]
> >
> > =E2=80=A2 Test Purpose Verify that the IUT can give the appropriate err=
or
> > code
> > when the Lower Tester proposes any number of unknown options where at
> > least one is mandatory.
> >
> > Afaik it should be fine to continue with another round of
> > configuration given that it only expects the error 0x0003, but we
> > better confirm PTS doesn't expect a L2CAP Disconnect after it.
>
> I have a Windows machine, and the PTS dongle. How do I set up the
> qualification test and run it against the Linux machine before and
> after the patch?

@Tedd: Do we happen to autopts working with BlueZ for L2CAP tests? Or
perhaps anything that Bastien can use as a reference to test his
changes.
@Batien: We would like to have autopts
(https://github.com/intel/auto-pts) to handle the qualification but
there is still some work pending in order to enable it to work with
L2CAP. Ultimately we could even attempt to integrate autopts on CI to
run it automatically, but in order to do that we need:

1. We need to emulate the PTS dongle (USB emulator?)
2. Run a Windows VM on CI, attach the emulated dongle to it and run
PTS on top (not sure if github actions do allow this)
3. Identify what tests need to run e.g. L2CAP changes should trigger
only L2CAP tests

--=20
Luiz Augusto von Dentz
