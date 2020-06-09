Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A9CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 17:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B7F207F9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 17:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DPURd7DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgFIRn2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgFIRn0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 13:43:26 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29955C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 10:43:24 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q2so12536609vsr.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qcfEUjiW7dMJADGYNzo6Tezy1WfS7SP+7CqZdgcOrio=;
        b=DPURd7DH3oiFR9PdsrQ2B0/b1twSlVm9t4B7E2kkZxAi7KsflXYmw7BJ4RXuz9MZa7
         LMMEuQLoGB/cRkT40MJkHU3CzKyW99BkQFgjvDa54BC7thmIKWjQzODgczNFBGEZplm8
         db3EGKo5begdiYwhDtNxq7vLjhBtGuB3ETUu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qcfEUjiW7dMJADGYNzo6Tezy1WfS7SP+7CqZdgcOrio=;
        b=koN2z89kQuahKQ2jBLmnpLuiagcblY5kg6WwfvuaOpnZCHKCuO/I8Pn4nkaYPlDn4c
         vBqeBRg1HZSGF7+JfRCqtjTmr5Ta91XxaYftytTgqKGzPOACUOhE3HM5NZyPZORvlpqa
         O9T0JEOu2lk4me9980zM6AmI4A1MeoA/m/m1BWDg2tt54Z++KP2on5RbTnUAqEBk4dJi
         Tul8Ke6oRS+/P6IcUTJuvzLqD6icWmhJKxKzdY3jGlZ0Sty+ZqsBFCvYcAJ8vnDKULmu
         CCcWeffB0uXF1C0LEE0WPwUV36WuKov+ZXMEGdpR2qx+vNRm+6a/oRu8DYC5yEY0ahbU
         6zCA==
X-Gm-Message-State: AOAM530K8pqoBzkZR0xcCG6pFx+FbCS6hyjbVOYQdMl/kOTLs1i6GQCD
        iNaXG/6I7+fnyahedHCPwgFQq88dKhhoEotgVOwqhbompLU=
X-Google-Smtp-Source: ABdhPJziAof1t7yqUlNV8tRqpbQp1Rgpf+axy0L3ewEDxlQtf4SrG+1qMgjJZRWhYT5q4APbt2cMgbd9+VEHCUwfLuE=
X-Received: by 2002:a67:6583:: with SMTP id z125mr4558134vsb.196.1591724603057;
 Tue, 09 Jun 2020 10:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200406180331.891822-1-marcel@holtmann.org> <CANFp7mXe3QtkKL8+TgTp=jwvpydABhDkiXks=3h4+op20rWhGQ@mail.gmail.com>
 <AC887BAA-95ED-456B-84D2-2D1EF6A8339F@holtmann.org>
In-Reply-To: <AC887BAA-95ED-456B-84D2-2D1EF6A8339F@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 9 Jun 2020 10:43:12 -0700
Message-ID: <CANFp7mU2+Z3f1ZqR8RCsOUu6Crc_xng12gcgn0YCwjzfH9Y-nQ@mail.gmail.com>
Subject: Re: [PATCH] doc: Add commands and event for handling device flags
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey Marcel,

Coming back to this device flags idea, I think I would prefer the
original design over adding new management commands for each flag.
Bluez will just have to maintain the current flags and pending flags
(i.e. mgmt call) to decide when to emit property changed events for
the device WakeAllowed property.

0x0049 and 0x004A are now taken for experimental features but you have
my reviewed-by for the next available values for the original patch.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Thanks
Abhishek

On Mon, Apr 6, 2020 at 11:36 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Abhishek,
>
> >> ---
> >> doc/mgmt-api.txt | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 96 insertions(+)
> >>
> >> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> >> index 39f23c456080..ac5b6c97d64a 100644
> >> --- a/doc/mgmt-api.txt
> >> +++ b/doc/mgmt-api.txt
> >> @@ -3138,6 +3138,74 @@ Read Security Information Command
> >>                                Invalid Index
> >>
> >>
> >> +Get Device Flags Command
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> +
> >> +       Command Code:           0x0049
> >> +       Controller Index:       <controller id>
> >> +       Command Parameters:     Address (6 Octets)
> >> +                               Address_Type (1 Octet)
> >> +       Return Parameters:      Address (6 Octets)
> >> +                               Address_Type (1 Octet)
> >> +                               Supported_Flags (4 Octets)
> >> +                               Current_Flags (4 Octets)
> >> +
> >> +       This command is used to retrieve additional flags and settings
> >> +       for devices that are added via Add Device command.
> >> +
> >> +       Possible values for the Address_Type parameter:
> >> +               0       BR/EDR
> >> +               1       LE Public
> >> +               2       LE Random
> >> +
> >> +       The Flags parameters are a bitmask with currently the followin=
g
> >> +       available bits:
> >> +
> >> +               0       Remote Wakeup enabled
> >> +
> >> +       This command generates a Command Complete event on success
> >> +       or a Command Status event on failure.
> >> +
> >> +        Possible errors:       Invalid Parameters
> >> +                               Invalid Index
> >> +
> >> +
> >
> > Get device flags looks good to me.
> >
> >> +Set Device Flags Command
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> +
> >> +       Command Code:           0x004a
> >> +       Controller Index:       <controller id>
> >> +       Command Parameters:     Address (6 Octets)
> >> +                               Address_Type (1 Octet)
> >> +                               Current_Flags (4 Octets)
> >
> > I would prefer to use a mask and value rather than current_flags here.
> >
> >> +       Return Parameters:      Address (6 Octets)
> >> +                               Address_Type (1 Octet)
> >
> > Prefer to also return an updated_mask and current_flags. This
> > simplifies completion for userspace. Otherwise, we would need to keep
> > a "pending flags" value on the device structure.
>
> I saw your =E2=80=9Cmask=E2=80=9D proposal and I am not a fan of that. I =
want to keep the design of the API somewhat consistent. Hence the Device Fl=
ags Changed event should be send after Add Device completed and also after =
Device Added has been sent out.
>
> One other option is to keep Get Device Flags as is and then instead of ad=
ding Set Device Flags, add one command per flag and rename Device Flags Cha=
nged to New Device Flags.
>
> Set Device Wakeable Command
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
>         Command Code:           0x004a
>         Controller Index:       <controller id>
>         Command Parameters:     Address (6 Octets)
>                                 Address_Type (1 Octet)
>                                 Wakeable (1 Octet)
>         Return Parameters:      Address (6 Octets)
>                                 Address_Type (1 Octet)
>                                 Current_Flags (4 Octets)
>
> Maybe this is not a bad idea either and is similar on how we handle setti=
ngs. I need to sleep about this.
>
> Regards
>
> Marcel
>
