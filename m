Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42495C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7820684
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Q6mYo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfCFTzX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:55:23 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41302 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfCFTzX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 14:55:23 -0500
Received: by mail-wr1-f48.google.com with SMTP id n2so14814535wrw.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2019 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w+yZuNgBUM40muWDxfraUcNa3Kzj0k2KB5GTP7aHex4=;
        b=I8Q6mYo5U5AhlNZTInQc9ltBe2VBfAWrpflJjPFC9zpTc3D889kXiC5uazmYWp9+Br
         uMmDalvwk94NtGEL1lVpdUGPU/xlfndLrS7LCeK9/P21fNISHHRXUJ+RBHF3GFS69lw/
         c/LNQsmkKUha3aaEck7gWkzzh/8PG3mdKmKBe1Pu/allmwv7uVFLk2oCad4cgrhvOvae
         Rf6/0LAFSonwrHF34FgLgHFA2XEABKgQSmig64A+QWQTJD0gvLEOsWM/jH35H8AySrAN
         OSYU8RidtlvR3kteK0oXDaq+TfT6o3ILQ9RnWJKxD3qVhsqza7F1pV8Yumk3cYHDntY8
         lFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w+yZuNgBUM40muWDxfraUcNa3Kzj0k2KB5GTP7aHex4=;
        b=uX4TKa3Ho6X4WDnqSycx2IoPTMk8pcCEZMZcRiZ+4VsUO2pNsjU46/lz8K7LTIPt/P
         fuXBpPKj/iSaytiY8cBsFKcPd+/eLRjs2oL2E3ORfJLJlFhsklMkOQQP956CiQVYbJzw
         ZJJi7JkT+F9TC25CAXpa1w6fWwwA4ZgxQCCN+MaFmKL54InbmWiJwo8lXmzQUWzwueej
         //9+B+Z5OtQIzYQ7FaoSXTZgYJ5Gigz0q4WhbLEgthal6Vylr1QJKUizVTQPMtd+GzA5
         4UXzlvQbCrVcR2o4dabxijACtSpCZo7tKV34WJSrGZoVfjFkz+BJ1SnztzhQwsGa9kIX
         rlDw==
X-Gm-Message-State: APjAAAUHKmrbq9CyylwBMn+CSif4SFui60Co/QxZeORTEDfHwGq4Gq+c
        CIb9a6zaj8+7MADl10ZUpdpGEOLOthkp8Ou2/tc=
X-Google-Smtp-Source: APXvYqwI92nZ4OnGzZfyQM9OkwmPwy98WWNixNCPolJX2/9TMNhunC/Q1/sVuRxQ27hKYa5s4bIIODRQmyQZKnDWVA8=
X-Received: by 2002:adf:ec07:: with SMTP id x7mr4069987wrn.174.1551902121646;
 Wed, 06 Mar 2019 11:55:21 -0800 (PST)
MIME-Version: 1.0
References: <CADS+iDUDv=Keo6661q3dY8C5=f+fZtfCe5gdPutO-psc9Pe0UQ@mail.gmail.com>
 <CAOVXEJ+bEQ=jmqwPEZygzaP7ChtKk2GwLc7183VyiRe5tbOzUQ@mail.gmail.com>
In-Reply-To: <CAOVXEJ+bEQ=jmqwPEZygzaP7ChtKk2GwLc7183VyiRe5tbOzUQ@mail.gmail.com>
From:   Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date:   Wed, 6 Mar 2019 20:55:10 +0100
Message-ID: <CADS+iDWWxbYkQ=+J8LvOYPZOyuDDxKxf=wxSm1QY_YvGyPD5LQ@mail.gmail.com>
Subject: Re: Strange SCO problem
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

=D1=81=D1=80, 6 =D0=BC=D0=B0=D1=80. 2019 =D0=B3. =D0=B2 09:28, Sathish Nara=
simman <nsathish41@gmail.com>:
>
> Hi,
>
Hello, Sathish
> Intel adapter 9260 and 9265(with the latest Firmware - from
> Bluetooth-next) supports USB ALT 6 settings and was verified.
>
I have only 8260 and 8265. How I can check if they supports ALT 6
setting? I've checked via lsusb
lsusb -d 8087:0a2b -v | grep bAlt
      bAlternateSetting       0
      bAlternateSetting       0
      bAlternateSetting       1
      bAlternateSetting       2
      bAlternateSetting       3
      bAlternateSetting       4
      bAlternateSetting       5
can't get device qualifier: Resource temporarily unavailable
can't get debug descriptor: Resource temporarily unavailable
> Along with backend ofono
> https://patchwork.freedesktop.org/patch/245272/
>
I've based my patches for native backend on your work. Unfortunately,
I cannot use ofono, as it needs phonesim which is not working on my
system (and is abandoned long ago...)

> https://www.spinics.net/lists/linux-bluetooth/msg76982.html
>
> Regards,
> Sathish N
>
>
> On Wed, Mar 6, 2019 at 5:15 AM Yaroslav Isakov
> <yaroslav.isakov@gmail.com> wrote:
> >
> > Hello! I'm currently trying to modify pulseaudio to be able to use HFP
> > profile with mSBC codec on native backend, but found that, while
> > working de-jure, real sound is completely ruined, so I can barely hear
> > what is sent over SCO link. I've tried two different Intel adapters
> > (included in 8260 and 8265 chipset) and KillerWifi (ath10k driver), on
> > two different PCs with two different headsets, results are mostly the
> > same, the only difference is that on ath10k words are more or less
> > distinguishable.
> >
> > I've even tested with pulse just for profile setup, and SCO is sent
> > via modified scotest from bluez, which sends some test sound, manually
> > encoded via sbcenc (with added h2, of course). I've tried also msbc
> > branch from bluez-alsa, same result.
> >
> > I'm sure that every time socket is connected with setsockopt(fd,
> > SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice));
> >
> > I've also tried with this patch
> > https://www.spinics.net/lists/linux-bluetooth/msg76982.html, with no
> > luck.
> >
> > Any ideas?
