Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE379C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE2920725
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="af2/oRs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGJRui (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJRui (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 13:50:38 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E6C08C5DC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 10:50:37 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a17so3430630vsq.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2020 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4rzocPAk8ZjAvLrdFpel7D1BLIGZFyXCyq25N8W6QTc=;
        b=af2/oRs1dUTONsRkDgibkWKjUlmBXuzOVfP0iIqcwQZRwwsT7GJURaRfW5tfIrVeMM
         GlUNJ6HqrtqLyH3UMDrtsEiJjXwRxTPbdjLy9925t9XcZhdUHnWxRJWBPdQGyR68lyz9
         72qG8aDWiFlnQ5JoLd61PyXs/oNv64jPPmXhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4rzocPAk8ZjAvLrdFpel7D1BLIGZFyXCyq25N8W6QTc=;
        b=Qc7Gj/oAtF+HwO/Iw03T/TfBumXublX3aqAAsCwMP29W1+4a4YkARr5hnV5Ccn251P
         5SYcyK10Kx9eGDH9eFBgX0nmTsGqw3RyXZo1DdBOXNBsFbXW4lhx9B6LfqfkvlpqRTLE
         tzeOdAlbrzgAcrWe8viOQ6r0nmqzebnCdoL37qNxIbLK14oEjImSulwYJh/RQFO1nkTM
         i6sqUDND/aRAH5ppkRC4UvpTb/GRt75QpYinhBFQwmRA9zjblZ60hc41RtN2lCe5GOVB
         XdMZSpi+ZZ1OH8CNYKGWYR2OzDZPDcMXNXt2z9UEgNERE3abOyfi9GygmBcV/p8UIvma
         elNQ==
X-Gm-Message-State: AOAM531RcEd8fC9TSOtQ8gTibjjRVOzUB7lmiTDcNLzM6kNRZPlj5LPB
        uTcwy8Z8Ge+hm18Mw/NUtRafUb4n5H1cS1bv0ku+qg==
X-Google-Smtp-Source: ABdhPJyKGKy71roZteV3huBY9UQjAPpitJCambFzQ4Joq33T5VS2hYF6ZJd3PXQXOBnIfvN1WjxleWSNyTNUfbZcSyo=
X-Received: by 2002:a67:fd0b:: with SMTP id f11mr49031013vsr.93.1594403437055;
 Fri, 10 Jul 2020 10:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200709140928.Bluez.1.I9181af521cf0fba8f4315c9b89975848d437d6dd@changeid>
 <22D4931F-A15D-4ECE-9EBC-D080EF6430E2@holtmann.org>
In-Reply-To: <22D4931F-A15D-4ECE-9EBC-D080EF6430E2@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 10 Jul 2020 10:50:25 -0700
Message-ID: <CANFp7mWzCnW9YFpWeMGOyh62nsQZ9YmEV29Xg_rDMHEo9A24wg@mail.gmail.com>
Subject: Re: [Bluez PATCH] doc: Add Suspend and Resume events
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Jul 10, 2020 at 10:20 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Abhishek,
>
> > Add Controller Suspend Event and Controller Resume Event to identify
> > suspend or resume of the Bluetooth stack has occurred.
> >
> > Also update Device Disconnected Event to indicate a new disconnect
> > reason: "Connection terminated by local host for suspend"
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> > doc/mgmt-api.txt | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 53 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index ca0d38469..f79c0222c 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3834,6 +3834,7 @@ Device Disconnected Event
> >               2       Connection terminated by local host
> >               3       Connection terminated by remote host
> >               4       Connection terminated due to authentication failu=
re
> > +             5       Connection terminated by local host for suspend
> >
> >       Note that the local/remote distinction just determines which side
> >       terminated the low-level connection, regardless of the
> > @@ -4577,3 +4578,55 @@ Advertisement Monitor Removed Event
> >
> >       The event will only be sent to management sockets other than the
> >       one through which the command was sent.
> > +
> > +
> > +Controller Suspend Event
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +     Event code:             0x002d
> > +     Controller Index:       <controller_id>
> > +     Event Parameters:       Suspend_State (1 octet)
> > +
> > +     This event indicates that the controller is suspended for host su=
spend.
> > +
> > +     Possible values for the Suspend_State parameter:
> > +             0       Running (not disconnected)
> > +             1       Disconnected and not scanning
> > +             2       Page scanning and/or passive scanning.
> > +
> > +     The value 0 is used for the running state and may be sent if the
> > +     controller could not be configured to suspend properly.
>
> does it make sense to send a suspend event with state suspend not succeed=
ed. That doesn=E2=80=99t really fit well.

We don't block suspend if preparing for suspend fails so it's useful
to know when a suspend was attempted. Also, having the suspend event
emitted acts as an anchor that lets us search through the HCI trace
quickly and observe what happened around it to cause an unexpected
state.

>
> > +
> > +     This event will be sent to all management sockets.
> > +
> > +
> > +Controller Resume Event
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Event code:             0x002e
> > +     Controller Index:       <controller_id>
> > +     Event Parameters:       Address (6 octets)
> > +                             Address_Type (1 octet)
> > +                             Wake_Reason (1 octet)
> > +
> > +     This event indicates that the controller has resumed from suspend=
.
> > +
> > +     Possible values for the Wake_Reason parameter:
> > +             0       Unexpected Event
> > +             1       Resume from non-Bluetooth wake source
> > +             2       Connection Request (BR/EDR)
> > +             3       Connection Complete (BR/EDR)
> > +             4       LE Advertisement
> > +             5       LE Direct Advertisement
> > +             6       LE Extended Advertisement
> > +
> > +     We expect that only peer reconnections should wake us from the su=
spended
> > +     state. Any other events that cause a wakeup will be marked as Une=
xpected
> > +     Event.
> > +
> > +     If the Wake_Reason was any of the expected wake reasons (values 2=
-6),
> > +     the address of the peer device that caused the event will be shar=
ed in
> > +     Address and Address_Type. Otherwise, Address and Address_Type wil=
l both
> > +     be zero.
>
> So I would be using Wake_Reason as first argument. However do you need al=
l this distinction. For example the Device Connected event could gain an ex=
tra Flags bit for wakeup. I would especially not make any distinction betwe=
en the advertising types.
>
> I am in principal fine telling bluetoothd when suspend / resume happened,=
 but letting HCI event specifics bleed into the mgmt API is not really help=
ful.

Sure, we can reduce the wake_reason to 0 =3D Unexpected, 1 =3D Non
bluetooth source, 2 =3D Device Connection.

I think a distinct event is preferable to adding another bit to Device
Connected.
a) It acts as an anchor point for searching an HCI trace for suspend occurr=
ing.
b) It is resilient to failures in any of the connection events (since
the Device Connected event sometimes requires subsequent calls to the
controller before the connection completes).
c) Properly captures wake from unexpected events. This is really nice
to understand what events came BEFORE the PM_SUSPEND_DONE event was
sent by the kernel and would help identify suspend bugs and
regressions.

>
> Regards
>
> Marcel
>
