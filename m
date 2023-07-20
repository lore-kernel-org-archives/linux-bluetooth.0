Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AF8EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 18:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGTSu6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGTSu4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 14:50:56 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B921734
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 11:50:49 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-563531a3ad2so782338eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879049; x=1690483849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIftydGUg1EFQwSJ2eN9pyxntaUW3R9pVea2a/5D2UA=;
        b=c0+Fs90u5BCBaXHjHgrhu+E5Ti17U9l1mhgmrC794Gcy59xUk3jzOisg80iXWMqtp4
         3BAeU92xwLelcBm5xiIaN3Qv/4RZeaR0W4wU13SejHicnXx78MfmtDq24m9s9902WLIW
         F7IQkzIcgYuSd2NM9143I42+BvGNQ7PqJ3+Ss3JohvDRVCzdG7XX34bmhp3E2Oh6Km4e
         nYXRqs+ymxQW3eoW6KTr9LHQX1GxprGgp+/4hoQlyArfiHxAH4CnpKwCM4evab3Z7wuH
         9mDG79RcaXMPZ6x1xa2QX20fDgwLk8Ovliq86aKxcex1S5kFR7RjTQVN3Igb+ffafFaw
         LSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879049; x=1690483849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIftydGUg1EFQwSJ2eN9pyxntaUW3R9pVea2a/5D2UA=;
        b=TCwSoOATmKYsRJYRDVd+RSqF22eJFoOkYToEl+8J2VsOqaYb9gkJCaJlwiqhZospR7
         f7PNdChFhNQNUUVew7FJ4p8rn7uOJ+tKtvgnSkkAdBMaCSdTNTj/ayfIumRZLjMMl+az
         TiYdpYgk5S/6EdjskjRC4GpoTSgzia85FKw4j2t6nK8FImf3F3G/agbIW8nCJslpRUjU
         twaVBZRsY2cMpN5q2bm9huV++EwClM7Yi+ylVUpbyZU4dAyGLGBMdphWT6QiOxKRlV5Q
         gaDBAGnzCCU9ycCVbf+RoJcTt/lCtTfYIpdcMYy48PXPXaTsyVYU6p/wbdHNX3JJBBkj
         NSDA==
X-Gm-Message-State: ABy/qLaAfdElCXj5a3Zw3XqPSdR2CQ4xaGZO5QK0YYk1q2s37/ZBKwKE
        Cq2XyjPD2ohS9tGnic9yahRpe6xef5mfFUMv6gbDbNii
X-Google-Smtp-Source: APBJJlEI1GwcuKvV+szG0TSY4ZiB5WicrbmxMOz3AHbYOTMRL3MA896r5UGNY65tqQW69qYrQ0dgD8me+ebLcGtBWoQ=
X-Received: by 2002:a05:6808:1496:b0:3a0:cc9a:820c with SMTP id
 e22-20020a056808149600b003a0cc9a820cmr333709oiw.59.1689879048982; Thu, 20 Jul
 2023 11:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEU5HDZD-U7vrQrusZxYW7L4wPiZL5m2kZw0nDz401oJjiVs=w@mail.gmail.com>
 <CABBYNZ+c1CfDDQ7GbO5wdQvF-ef=jaVKDcGGnVxHhJN84Edm5Q@mail.gmail.com>
 <CAEU5HDZVY7hYAK=1FhzSabg9n5Oogq81GqvsuHHJYU7Mr2TXUA@mail.gmail.com> <CABBYNZLLTfu33iU2Z+hE7R3sDyb+nnGSsmf1tiRva5A2TS1+8A@mail.gmail.com>
In-Reply-To: <CABBYNZLLTfu33iU2Z+hE7R3sDyb+nnGSsmf1tiRva5A2TS1+8A@mail.gmail.com>
From:   Dynastic Space <dynasticspace@gmail.com>
Date:   Thu, 20 Jul 2023 21:50:37 +0300
Message-ID: <CAEU5HDbRGW5-i2o=39p_Jfr5ET8ShkPtOsOjR2LyVa7Rn3gknw@mail.gmail.com>
Subject: Re: Daemonizing bluetoothd
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The bluez version that I am using is 5.56.
It's not that I had a problem: I just expected to see a daemon call,
and when I hadn't I was surprised. Then I started suspecting that
procd forks the process by itself, but I wasn't sure.
Your answer clarifies things for me. Thanks!

On Thu, Jul 20, 2023 at 9:33=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> Can't recall when we made the change to stop forking, but it has been
> a while bluetoothd has this behavior, doesn't procd handle processes
> that don't fork by themselves? How old is bluetoothd in OpenWRT that
> this is only showing up now?
>
> On Thu, Jul 20, 2023 at 11:15=E2=80=AFAM Dynastic Space <dynasticspace@gm=
ail.com> wrote:
> >
> > Thank you for your reply.
> > So you are saying that you are relying on whatever service manager to
> > daemonize the process? I am compiling for OpenWRT which uses procd,
> > not systemd.
> >
> > On Thu, Jul 20, 2023 at 9:04=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Jul 20, 2023 at 10:42=E2=80=AFAM Dynastic Space <dynasticspac=
e@gmail.com> wrote:
> > > >
> > > > I am reading through the bluetoothd code for version 5.56, but I
> > > > cannot find the call that makes it into a daemon. I don't see a for=
k
> > > > or a daemon call. How is it turned to one?
> > > > I am compiling the code on an OpenWRT system.
> > >
> > > We don't call fork anymore, since most likely bluetoothd would be run
> > > as a systemd service I don't think it matters though.
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
