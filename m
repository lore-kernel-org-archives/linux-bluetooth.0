Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7658EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Feb 2021 19:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4037E64EA0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Feb 2021 19:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhBATRw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhBATRt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Feb 2021 14:17:49 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE5C061786
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Feb 2021 11:17:05 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d7so17441164otf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Feb 2021 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JpnePyPrTQ3jaYWaP+nyqq/IF8GqCwK7tg40JPYyiEw=;
        b=LcosSVDZDrdGvve4OvEbGePR+h6AuHVIu02uS9zYwA3UydFnh5hHk4PrRKiYJow6jo
         V6F6i8t8WE7KpT+zUsqyFsyg0zYHuQwRIWm5ckAQas1uw3KGTkj1mB123O0UJpZV76xW
         tcHDUY9S/6XoMNVxHMLMZtj3iuV73YyUKOxSHe/UuhJqWkhOFYlqIt0ztYELGrV31K5f
         LR7DPQdkCd3s23KYJFfPMXL8bMN14RWx2Xr48Wx5xh2aCT6Tbg3M35q8MqppWiduQ8l5
         7MyKseMX0ot9GTOywb6yG+sqafRj+FVl2yapTvsI92f1RVLwWkX20Y/Gpo1tXykLLQHE
         7vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JpnePyPrTQ3jaYWaP+nyqq/IF8GqCwK7tg40JPYyiEw=;
        b=lO2S3DaoYmTdA4VYZX4vAAtXSE+TVSW3ycMs4uico9U5IRcQ0xyWLwO//nv5XurcKJ
         S/P+aFvNNK40R8C64uvzYxuZHpJXNKfHiksmAaywU7Uil+gLOLhfeRrgH+5+yXsLwHSH
         zkfaSxnJFkVD+14SEVP/UhQ4ZUDDLb5A3H7vG5gHqefQzTtBXmLnxC2yb+jsebgT2h7C
         PLJMWnxMv9QyhqFwguK7ENUlgfJO+1UFwMjBS76vhHBbz3RhHQWkRDKIq8SGA/4NHBjy
         9JnNiQnE9l4MDSUZetS7FjGRMqS2fzohaAUvgx93i7xk/MZEgCtxNpDWabsaVk6PnMGc
         Q33Q==
X-Gm-Message-State: AOAM530D7r7R8sqhoPSzG6T7iJDBhpl6ZChv1OlBqKILf0PKk4WjhdDW
        VO/vA61zKt8PFx7mQxalklvIRC6W6FMrBqkdtdm5vwR+A4w=
X-Google-Smtp-Source: ABdhPJygrxH+mrdcDENJsv2vCeYtsK9NTLVbvM249lbCcDRSojIvI4EwHseKTQtX8O/JfJOi7oc5HByCS9tvuY4O1FE=
X-Received: by 2002:a9d:6116:: with SMTP id i22mr10149691otj.240.1612207024990;
 Mon, 01 Feb 2021 11:17:04 -0800 (PST)
MIME-Version: 1.0
References: <8b62372c-bb87-5dbe-200d-d32c7c94f50d@sokka.cn> <54ab3327-f14d-fd74-5501-47203a1bd06f@sokka.cn>
In-Reply-To: <54ab3327-f14d-fd74-5501-47203a1bd06f@sokka.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 Feb 2021 11:16:54 -0800
Message-ID: <CABBYNZL4zBz7-b5Cuu5wEsizoT19Dc6j5N1i+hAgvwu+33o4vg@mail.gmail.com>
Subject: Re: Some headsets appear don't work when BlueZ connecting with both
 HSP AG and HFP AG.
To:     Huang-Huang Bao <eh5@sokka.cn>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bao,

On Mon, Feb 1, 2021 at 9:48 AM Huang-Huang Bao <eh5@sokka.cn> wrote:
>
> Hi,
>
> Any comments on this?
>
> We have thought about how to fix it in client side, that is registering
> HFP AG or HSP AG profile with `AutoConnect` disabled and let PipeWire to
> initiate  headset profile connection throw
> `org.bluez.Device1.ConnectProfile(string uuid).
>
> But for headset has no A2DP support, PipeWire is not possible to get
> triggered with device connection event when other application is calling
> `org.bluez.Device1.Connect()` if `AutoConnect` is disabled on HSP AG and
> HFP AG profiles, so that PipeWire don't know when to initiate headset
> profile connection.
>
> Currently we disabled HSP AG by default on PipeWire to work around this
> problem.
> https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/425

I guess we could introduce a some sort of conflict frag but Im afraid
that would complicate things a lot because then we need to have some
sort o priority as well, also HSP is so ancient I would basically
consider it deprecated by now, the only reason to use is if you don't
have a Telephony (e.g. oFono) subsystem to handle the HFP properly.

> Regards,
> Bao.
>
> On 1/23/21 10:14 PM, Huang-Huang Bao wrote:
> > Hi linux-bluetooth,
> >
> >
> > PipeWire recently got HFP AG support,
> >
> > its native headset backend registers both HSP AG profile and HFP AG
> > profile with `AutoConnect` enabled by default.
> >
> > Hence, BlueZ would trying to connect headset with both HSP and HFP.
> > Seems it causes some headsets stop to work with HFP/HSP profile.
> >
> > Discussions on PipeWire:
> > https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/604#note_7735=
90
> >
> > Fr=C3=A9d=C3=A9ric Danis says:
> >  >Currently it seems to me that there are at least 3 behaviours when
> > both native HSP and HFP are enabled, depending on the Headset/Speaker:
> >  >
> >  >    with Sony WH-1000XM3, iiuc:
> >  >        HFP is tried first, starting SLC process
> >  >        then a connection to HSP is rejected by the headset which
> > stops to send AT commands on the HFP RFComm channel
> >  >        Audio is not working
> >  >    with Sony WH-CH710N:
> >  >        HFP is tried first, starting SLC process
> >  >        then a connection to HSP is rejected by the headset, but the
> > headset keeps on sending AT commands on the HFP RFComm channel
> >  >        Audio is working
> >  >    with JBL GO 2 speaker:
> >  >        HFP is tried first, starting SLC process on a RFComm channel
> >  >        then HSP is connected on a second RFComm channel and followin=
g
> > HFP AT commands are sent on this second channel
> >  >        Audio is not working (iirc)
> >
> > Can it be fixed in BlueZ? For example, do not auto-connect HSP or HFP
> > profile if the other one has been connected. Maybe to add an extra
> > option "Conflicts" on "org.bluez.ProfileManager1.RegisterProfile()" to
> > indicate UUIDs which conflict with registered profile.
> >
> > Regards,
> > Bao



--=20
Luiz Augusto von Dentz
