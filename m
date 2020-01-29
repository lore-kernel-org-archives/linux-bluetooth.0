Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AD5C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 17:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F074520716
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 17:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R+ERco5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgA2Ro6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:44:58 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35327 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgA2Ro6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jan 2020 12:44:58 -0500
Received: by mail-vs1-f68.google.com with SMTP id x123so296476vsc.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2020 09:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gNBQo7/fAVJnvsft4+lLo38CwgZoQc9XWH9MjqmimI4=;
        b=R+ERco5kVIv1fe6x/QEYjdkdwGmrOy15OplML1Day5n6julmY3AmVLD2TnVW7ZlzNP
         TMsndb1ZeqHw8WO9VfWmgZyiyUxwpncNKr2DadH8uo/+Gf7SW1BJaN+fmTn39bgQ2Wv5
         vqwWIyBnoVf4m4GA+b/LK85I8bxJHqIY/yCUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gNBQo7/fAVJnvsft4+lLo38CwgZoQc9XWH9MjqmimI4=;
        b=lNuZV+oAKIdyRR8QYoVg8NTnnguRRP30IFcYRNgmXVpuAKB2flNQ/3pija0fWwptO0
         5Ch0Qgs/tSu90DrbfsfZNVMYx40ZqGPDEeAuCK6b0HdQpVohg+dOWMW26Fprx0HWB78e
         RjoVZeYoLMDXgyIE0PdP0Imvyfk/XylJ6C/74muIffoWAS1+rVSVw6LyGLNS3UL9fDoo
         Z4VanYRXpr/q0DN+q5HO5xov8JgjKs2YnNmyGlTvlAny0RRtEE9aci0Mos2NCkt9W+Cw
         2cT/43JozGoC+iJwrYoOURuvsJSu5prynYmHB5X9m/xPzGkdrT8i5gIvIaY1bv9Wj2C4
         /7nQ==
X-Gm-Message-State: APjAAAWCgqynOPiGKZQpLVnKvLOSO7wAmvZL2S5H0/q8oXNr2wKkFJJZ
        SvD3y1n4VsSZyI/U+l8wSeIIh2J8n0KXN0vngUOEmA==
X-Google-Smtp-Source: APXvYqznpDgfim6LBvdk3azctqSmb+eJQ78QSPr8CUChZ8ksh9Z64pp0y8riwP7MUdEHv79f/x3sVkV9WFvtEsnS4kw=
X-Received: by 2002:a67:f641:: with SMTP id u1mr448690vso.86.1580319897199;
 Wed, 29 Jan 2020 09:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
 <20200127180433.BlueZ.v3.1.I999b93b65e613324dbbd16a1cf493be72fa06ad1@changeid>
 <137EB79B-88E6-43E0-894F-A0C8D5F9B710@holtmann.org>
In-Reply-To: <137EB79B-88E6-43E0-894F-A0C8D5F9B710@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 29 Jan 2020 09:44:46 -0800
Message-ID: <CANFp7mUF=1ehF_Kwnf5kdCiypoOL8ph8PPEMbwm53NR-==D-hA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 1/5] mgmt: Add docs for Set Wake Capable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Jan 28, 2020 at 8:33 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Abhishek,
>
> > Add docs for new management operation to mark a device as wake capable.
> >
> > ---
> >
> > Changes in v3: None
> > Changes in v2:
> > * Separated docs/mgmt-api.txt into its own patch
> >
> > doc/mgmt-api.txt | 19 +++++++++++++++++++
> > 1 file changed, 19 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 1e59acc54..8a73a9bb9 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3047,6 +3047,25 @@ Load Blocked Keys Command
> >       Possible errors:        Invalid Parameters
> >                               Invalid Index
> >
> > +Set Wake Capable Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +     Command Code:           0x0047
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Address (6 Octets)
> > +                             Address_Type (1 Octet)
> > +                             Wake Capable (1 Octet)
> > +     Return Parameters:      Address (6 Octets)
> > +                             Address_Type (1 Octet)
> > +                             Wake Capable (1 Octet)
> > +
> > +     This command sets whether a bluetooth device is capable of waking=
 the
> > +     system from suspend. This property is used to set the event filte=
r and
> > +     LE whitelist when the system enters suspend.
> > +
> > +     Possible errors:        Failed
> > +                             Invalid Parameters
> > +                             Invalid Index
> >
>
> my current thinking goes into this API addition:
>
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2003,6 +2003,7 @@ Add Device Command
>                 0       Background scan for device
>                 1       Allow incoming connection
>                 2       Auto-connect remote device
> +               3       Allow incoming connection to wake up the system
>
>         With the Action 0, when the device is found, a new Device Found
>         event will be sent indicating this device is available. This
> @@ -2018,6 +2019,9 @@ Add Device Command
>         and if successful a Device Connected event will be sent. This
>         action is only valid for LE Public and LE Random address types.
>
> +       With the Action 3, the device is allowed to connect the same way
> +       as with Action 1, but allows to wake up the system from suspend.
> +
>         When a device is blocked using Block Device command, then it is
>         valid to add the device here, but all actions will be ignored
>         until the device is unblocked.
>
> Since we are really talking about incoming connections, then the Add Devi=
ce command is the one that handles this. Giving a device the option to wake=
 us up that is not set up for incoming connections makes no sense. We can d=
iscuss if certain LE advertising packets should wake us up, but that is a t=
otal different API in my book.

I originally tried implementing this with the Add Device api as you
suggested in the RFC email back in November (when we first talked
about this). I had trouble figuring out when/where in bluez to
actually send the Add Device command.

Whether a device supports wake-up is a profile level setting (i.e. HID
only so far). As far as I can tell, Add Device is called before the
profile connection is established. Bluez has two apis that call
MGMT_OP_ADD_DEVICE:
* adapter_auto_connect_add (this seems to be LE)
* adapter_whitelist_add (this seems to be BR/EDR)

Both seem to be called BEFORE the registered profiles have a chance to
accept the connection.

>
> Regards
>
> Marcel
>
