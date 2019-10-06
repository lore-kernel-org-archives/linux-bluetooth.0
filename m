Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA86C10F14
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 10:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4F42087E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 10:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxOmT/4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfJFKxv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:53:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39230 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfJFKxv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 06:53:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id s22so8717215otr.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Oct 2019 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GkOuYiZegoF1GLsrbYYege1NodSLg+9ZSOw8NOlNozg=;
        b=RxOmT/4u73w/Bg9sYeT8ARSW06kqncVI6Ym8PTQ2ImDc4X33fLq3KeTsAxlFoYpmOS
         4dm6e5mI+0c5WkNvfVRcA9G+7BrbJDuCMrkm7ffXWsnAKylDbzuatBHeDrbvg/tB/4Un
         sRd7+v3fJJKsk4cwAorOaXI4AVkFFPZM7XU1VGlQg/qlMGXO3yy0J+WTO6+2m+Vie5a9
         4PSmyPPfDo4QyShrVyTjdoHcKsaHseU7sod/zcNRmCq4f9UG+fRp6G08KOwjJkBcyXN1
         YyZAZXS37+c+mZirKH2aRO7xY34v6qsV8J9ATz93wpBdD6VoMOa3g/bH/mEpgN8O73wN
         no5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GkOuYiZegoF1GLsrbYYege1NodSLg+9ZSOw8NOlNozg=;
        b=tbqyUa+vUaNG/MkmsF+B0R/CsmM96Jc0pHkyO2QlZMLAF8reWmBNgJpn8Jbe9ZQ1xU
         hNA9zMnY7FW7ZKJ+7z61HEfGpQYRrY1UR32bubZt3W89xsEcs34NFENGQPS3T/1LOpAT
         pZlLD8ra2/NBaeWW7B02p726HFnFHtwo/j0H9cAvnnOvqpcyg9hEMtSEN3sm327RIGn2
         9bxKotmmwZlVl3XnC/N9Bn1I+iJM+ySgUTi4n9LNK9MZTORDp336iv33FMDr8q+lAdFl
         YvHbQbkzwu7TLDTfkRWgJBk1IlmRs/iiy6SIH83vp5C28I0emdzBIgSwxRmxwd69+dRs
         q/bQ==
X-Gm-Message-State: APjAAAWjRRGRx89iz8BJogQkIZVHOMF1rheZlq7YWIMNzG72NfA+OLYn
        WljeYEA5mOEn62EC6PQQCEJH7z/ePnS2Up5XGps=
X-Google-Smtp-Source: APXvYqztoxS6YWDULD2zGicygGgawTLrz3C+Cb9TsVvuyJ9TMdyTbvJSKgR1J9cQaGt8Mv70BRd5pH+douIMTDDa0TI=
X-Received: by 2002:a05:6830:14d2:: with SMTP id t18mr16007646otq.146.1570359229833;
 Sun, 06 Oct 2019 03:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190712151329.11333-1-luiz.dentz@gmail.com> <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali> <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net> <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net> <20191006100503.fsbttcschr6wgsdq@pali>
In-Reply-To: <20191006100503.fsbttcschr6wgsdq@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 6 Oct 2019 13:53:37 +0300
Message-ID: <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Oct 6, 2019 at 1:05 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Thursday 03 October 2019 21:18:55 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > Hi,
> >
> > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Roh=C3=A1r wrote:
> > > On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > > > Pali: How does it look with porting the PA patches to use the new i=
nterfaces?
> > >
> > > Hello, I have not had a time yet to play with these pulseaudio patche=
s
> > > and porting to the new interface. I guess that I could have more free
> > > time in the last week of next month.
> > >
> >
> > It seems BlueZ 5.51 has been released meanwhile (http://www.bluez.org/r=
elease-of-bluez-5-51/)
> > So now at least the new interfaces are in a released bluez version.
>
> Ok! Today I have looked at this new Bluez API, but seems that there is
> not only missing some examples or usages with libdbus-1, but also
> documentation. I have tried to find something how to register endpoints
> throw GetManagedObjects() via libdbus-1, but seems that there is no
> usage of it and also unusable documentation for it in libdbus-1. So
> currently I'm stuck how to use this exotic API in pulseaudio...

It is just another D-Bus method, the only difference is that it
carries the entire object tree, btw I did add an example of how to
register Endpoints in python:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-endpoi=
nt

You can also have a look at how our gdbus internal library (uses
libdbus) utilize it:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.c#n126=
9

--=20
Luiz Augusto von Dentz
