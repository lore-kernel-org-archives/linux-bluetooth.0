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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88313C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8EC64F69
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhCDSqM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhCDSpn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 13:45:43 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5A4C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 10:45:03 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h22so28266717otr.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=grhB78IL0+DgPEpS6M2BSpCFrfDCXBeoHLIxKvlQunA=;
        b=TLw93h57Jj4fH347wpdyIM85M83gIZag4zWFsR+MElQXEdXxgg+NSoss9lgNwl94tg
         3rlKx6E+VGGl+wn6KW2sZNgVnjM4Vjtd/xnoxeqWCxstuwWuImVgsH+djLW+9XemxBGe
         S49i6qx97TIlgqccN93NMsF3wuYFC7fZD4v0zoOfry/xIT1n5P8vy+s1OeMehAh9I5gb
         ruOXXz10AS2dI6trJXolJotEMqZkp1DQM8JndBovbX+p3szFvvXVOqz0KfR+oLSZSNmZ
         Gw+gmZDLRt5XA9lp9b9S8lZWM6OkZ7n/MpMQdo4L+bL/aATYb5gefQYr+fsu3l8CjGez
         1k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=grhB78IL0+DgPEpS6M2BSpCFrfDCXBeoHLIxKvlQunA=;
        b=I73LwBUku7WFQMzOoswXhigw1Yek9zfptuSVVvRuNS8o9atarNENT1ah700QEkbzyM
         pY9WMS1WcenZagfpLhUA/60CdKuI4QYnMAWNjSxVehNtRV+omwIo249ggDBnnP8MrjZV
         gNvb4G5vXanVPQtloOuMTKNTYk94XYURGv8Hcj3i+pqqBWe3d4z1VH4EbPAu5oZn7L2q
         BbhoI9k72m1ww1NUsoNR2o/ePOuj4VEX9nnuyLKHBzYA3nTgGyPTUZLLvuVF9YeydIAl
         H/OboDR1MwAh2ycGmyUd28RSqt3vW0vtPUJRdApNqII1PX2NnxwCWt7DajQj0GfiKMPC
         +6+Q==
X-Gm-Message-State: AOAM5336Pxy4zlnorh2QN97LIxViPZ3aL7JiP/8L9TSWOq7hh/yN2CJF
        YSv79djU2tVC2tu6IlTc4xKBHn7TvL0BfmoaVFA=
X-Google-Smtp-Source: ABdhPJxkl2Jn/V5FfGC6dL3HEcxpD4sKGysaXdso/ie41WKTk/fcqWEKxcAi6D3SPiyI5owPjww+s+XXRRK8JQYr524=
X-Received: by 2002:a9d:69c6:: with SMTP id v6mr4598606oto.371.1614883502914;
 Thu, 04 Mar 2021 10:45:02 -0800 (PST)
MIME-Version: 1.0
References: <f6764fe94d45ff9211674c5799b193d15385a056.camel@collabora.com>
In-Reply-To: <f6764fe94d45ff9211674c5799b193d15385a056.camel@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 10:44:52 -0800
Message-ID: <CABBYNZLp9pOopbEfONc=oOh=ODFi55YzA6BKoN4ABuSzuZdPbw@mail.gmail.com>
Subject: Re: Bug caused by moving to BlueZ 5.56 (bytes stripped from HoG reports)
To:     =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ricardo,

On Thu, Mar 4, 2021 at 9:40 AM Ricardo Ca=C3=B1uelo
<ricardo.canuelo@collabora.com> wrote:
>
> Hi all,
>
> I discovered this fix https://github.com/bluez/bluez/commit/35a2c50 while
> debugging a fwupd plugin for a HoG device that implements its FW upgrade
> mechanism using vendor-specific HID reports (
> https://github.com/fwupd/fwupd/blob/master/plugins/pixart-rf/fu-pxi-devic=
e.c).
>
> Initially, the developers were using BlueZ versions prior to 5.56, which =
is the
> first release that includes that fix, so their code was written with that
> behavior in mind. After moving to 5.56 we found out it crashed and we nee=
ded to
> adapt the code to the proper report format. I think this is the kind of i=
ssues
> that Dean mentioned here
> https://marc.info/?l=3Dlinux-bluetooth&m=3D160590969013204&w=3D2
>
> Have there been any more reports like this? Is this expected to have a gr=
eater
> impact than initially thought?

Nope, you are the first one to report a problem with this change, so
chances are that what Dean stated probably still holds since the vast
majority of devices didn't care about the report ID. So I suppose the
following code shall take care of it or does it not?

https://github.com/fwupd/fwupd/blob/master/plugins/pixart-rf/fu-pxi-device.=
c#L170

--=20
Luiz Augusto von Dentz
