Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8C8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 03:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18E960230
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 03:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhKLDOC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 22:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhKLDOC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 22:14:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F46C061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 19:11:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so8838096wme.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 19:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1MQKeJ12sHwcgqynCrrYJ0Es1EP2UxULU1A37BycF7k=;
        b=Tw7Ct+6aFZRkFf+hkWM05ld/lqjQxrr4bX+6AZ/31GpoJiTZ8QJzITtZMGM2hqoU4f
         hptBZX4a5QTlXOtVmZOUYDKN1mV+W0KvHGJxsPeOrT3Tth/VhKn7KbBo0biPtLrxCys2
         A119Y1C0qFeX5U9xWmc2QEdMFaDW6Jpjxg2DF11D8geg7EGX+QWGuz7xzveipbMq0gen
         1PXaPYWGnNas9Xl2nRS7X5ag6EvSD/+euLcx17XEW5nuD/6ccQAfXfTdvkLYPdlg6Ey0
         VIbxbXjER8q9wZ4NHUI0j/hdddcdldyZnEe4crz+Qw+w8RahNCh7N6qTZ/bchoWWyzCs
         23IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1MQKeJ12sHwcgqynCrrYJ0Es1EP2UxULU1A37BycF7k=;
        b=nW2IVkqcv6QUqNEhBHWdLZxqphFk4Yiunu+Gxvqw+6UdDUoEWcY8MFgVrj7tY/AMMz
         Lr9ws3SESda5r0UIvOp9OttT/ZG29zpsEWdYE1/6QMrTUaE5GAlgnNf64HLohwXFFYsv
         URmcmkEeNM03nrBwxj8o32ngjWYYAIkRjRAulNbKi1AuPCnZHwGIgqPe3VPqRevDLpqV
         3xqthrqQdB/R1YeJCP1LIa08oKMbhfOX7+TWkaDXgasLzw09SVVfaruyAgRnqGbNQ/6V
         gFOOYRLUKWw4cArXMqmvbuXi5QX1WNOr3oMoSQrrTMh2bCwERjfRP9VHuq0pCcIjo5al
         kyXw==
X-Gm-Message-State: AOAM5306Rj7chnPr7bRb5pidNGrFfKzlnrKsZlPsaWkKytH5uRhgfybV
        Up0cdHpR3dybgRaWWVs1qUIvNhnADW1dcut4v14kNg==
X-Google-Smtp-Source: ABdhPJxox7weAhTzs6LeDbtUVi7hG6ebCHz/tpBFbVyh2dzYNSbaceMqtEDs2HfTAlUaJOvkJZsKCU2/8Uf9NJ8O86g=
X-Received: by 2002:a05:600c:2f01:: with SMTP id r1mr13712055wmn.153.1636686670013;
 Thu, 11 Nov 2021 19:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20211111195423.Bluez.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
 <20211111195423.Bluez.3.I29367ca288fc8f4fcc3b4063425b791501c6534c@changeid> <AD8BC81A-9D68-459D-921A-C764DC4216AA@holtmann.org>
In-Reply-To: <AD8BC81A-9D68-459D-921A-C764DC4216AA@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 12 Nov 2021 11:10:59 +0800
Message-ID: <CAJQfnxFbJJ=zSG40w+obdOS7ojKS3=9D-PQkQ1hh2VtGetoe3A@mail.gmail.com>
Subject: Re: [Bluez PATCH 3/3] doc: Add Name Resolve Fail flag in device found event
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, 12 Nov 2021 at 00:35, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > Userspace should use this new flag to decide whether to do the remote
> > name resolving or not, by sending Confirm Name MGMT command and set
> > the appropriate flag.
> >
> > This patch also extends the Confirm Name command by allowing userspace
> > to send 0x02 to show it doesn't care about the peer devices names.
> > ---
> >
> > doc/mgmt-api.txt | 18 +++++++++++++-----
> > 1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 97d33e30a1..e4c8de39f0 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -1493,7 +1493,7 @@ Confirm Name Command
> >       Controller Index:       <controller id>
> >       Command Parameters:     Address (6 Octets)
> >                               Address_Type (1 Octet)
> > -                             Name_Known (1 Octet)
> > +                             Name_State (1 Octet)
> >       Return Parameters:      Address (6 Octets)
> >                               Address_Type (1 Octet)
> >
> > @@ -1506,10 +1506,11 @@ Confirm Name Command
> >               1       LE Public
> >               2       LE Random
> >
> > -     The Name_Known parameter should be set to 0x01 if user space
> > -     knows the name for the device and 0x00 if it doesn't. If set to
> > -     0x00 the kernel will perform a name resolving procedure for the
> > -     device in question.
> > +     The Name_State parameter should be set to 0x00 if user space
> > +     doesn't know the name for the device to make the kernel
> > +     perform a name resolving procedure for the device in question.
> > +     Otherwise, set to 0x01 if user space already knew the device's
> > +     name, or 0x02 if it doesn't care.
>
> I am a bit worried about userspace sending a 0x02 for a kernel that doesn=
=E2=80=99t understand it. Do you think the kernel can make use of this =E2=
=80=9Cdon=E2=80=99t care=E2=80=9D information? Or should we just keep it to=
 userspace to send 0x01 / 0x00 based on its policy.
>
On the current kernel, 0x02 would be casted to True, and the kernel
would treat this as "name is known".
Indeed, this "don't care" information is of no use to the Kernel (at
least for now).

If this is concerning, I'd propose to just express the "don't care" by
not sending a Confirm Name command in the first place, similar to what
we do when we receive a Device Found event for a device which is
already discovered before.

> >
> >       This command can only be used when the controller is powered.
> >
> > @@ -4089,6 +4090,7 @@ Device Connected Event
> >               1       Legacy Pairing
> >               2       Reserved (not in use)
> >               3       Initiated Connection
> > +             4       Reserved (not in use)
> >
> >
> > Device Disconnected Event
> > @@ -4263,6 +4265,7 @@ Device Found Event
> >               1       Legacy Pairing
> >               2       Not Connectable
> >               3       Reserved (not in use)
> > +             4       Name Resolve Fail
>
> I would do =E2=80=9CName Request Failed=E2=80=9D here. Just to be a bit i=
nline what the spec term is.
>
Ack, will update.

> >
> >       For the RSSI field a value of 127 indicates that the RSSI is
> >       not available. That can happen with Bluetooth 1.1 and earlier
> > @@ -4285,6 +4288,11 @@ Device Found Event
> >       accept any connections. This can be indicated by Low Energy
> >       devices that are in broadcaster role.
> >
> > +     The Name Resolve Fail flag indicates that name resolving
> > +     procedure has ended with failure for this device. The user space
> > +     should use this information to determine when is a good time to
> > +     retry the name resolving procedure.
> > +
> >
>
> Regards
>
> Marcel
>

Thanks,
Archie
