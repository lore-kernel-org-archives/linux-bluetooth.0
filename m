Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EED2C10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 15:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3F206E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZV+i4SFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgCKPBr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 11:01:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32946 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgCKPBr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 11:01:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id c20so2027960lfb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X5vyD6h435rpyrNhf/cU94ANOP8B7PdrrBXJBHttItE=;
        b=ZV+i4SFFpE1PvJX30FvOeHYoBMNgwPRxSlLWjhrADR1MhW00y0T7bH8BavkBQAlGDT
         cBZ8wID7DqRateLtbfEYfL/8uuNBfMeQLred//RNmSLeEwX/wPNSA+aLoKPpPtP3E957
         cgrX8ASQDk+vynLbAK3rOSYxWUJ0vSxFy8HnGseEWAB1lOm+LBeK+13RmDSqOA/4l89S
         xEmjSGn7122+0pf16YTpSo83lxvjF516jZ0BaGhTNJ35E3AAu0rwbihfsVhieHb6x+5o
         IxdKeuWxCOaxJq3ghmP5ycRV16LKnKRonFC9/8aJYnOd7011OKfKnrVyc6ag1F9aKD3L
         vU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X5vyD6h435rpyrNhf/cU94ANOP8B7PdrrBXJBHttItE=;
        b=GI5pg9klbZ1WDAwjKhL23+zwj61YAE0sqx2XcFJo6bd47RRmJYTIrBmFhDoiWOfTYo
         r8PfJIPQGdJu7l4iX64ywboy0Y6djriAYkNZLRFbsguSTC+oeu9tpziH6oGjg4ISAJFM
         crX/hgW25nmpTbOoi1DJWWdywmjPI9ZaKAHdaMu+KxcHFVrSJsxRuYFCDqDyZmeVY1L0
         9557jM/Z8WMUh2aGKkDp1sERnjSNBXFkaJ5JjKbKJ5jnbmoD4msePE3kQkdBEYimAvz2
         k9op2pb68wRyjg2tuKuRHZcVp1eX3E75ET8k3OdEG/CXjEMs8vEE5HPpFiS00vAVXU9f
         uQbA==
X-Gm-Message-State: ANhLgQ1Aq1gECkjz05UYVSUkjhLv2J9jp13Rzz9Obfl9EpMdJb7+k2XJ
        zKfdOBy03n/lZCY9HXTZ8gPkY6c3S75uH6lLdcvRUQ==
X-Google-Smtp-Source: ADFU+vvRxSMMwJwsF/kCTifj74JrOglKMOyFzaM9eU3oNX/p0FNyhBKUGoLKAGZTmqSMPVHa3jStEl127uBBZ+vzRv0=
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr2497052lfa.0.1583938903587;
 Wed, 11 Mar 2020 08:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200310151100.134881-1-alainm@chromium.org> <4C7539C9-2AEB-4B1A-93CD-23B468C49B2F@holtmann.org>
In-Reply-To: <4C7539C9-2AEB-4B1A-93CD-23B468C49B2F@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 11 Mar 2020 11:01:32 -0400
Message-ID: <CALWDO_Xpj8vD=9_KK=P=XWhVV7N5wb80duFw=tsP=0k58ct55A@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth: Enforce classic key size verification.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Wed, Mar 11, 2020 at 10:49 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Alain,
>
> > This change introduces a new configuration to strictly enforce key size
> > checks.  This ensures that systems are in a secured configuration by
> > default while allowing for a compatible posture via a Kconfig option to
> > support controllers who may not support the read encryption key size
> > command.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > net/bluetooth/Kconfig     | 10 ++++++++++
> > net/bluetooth/hci_core.c  | 10 ++++++++++
> > net/bluetooth/hci_event.c |  5 +++++
> > 3 files changed, 25 insertions(+)
> >
> > diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> > index 165148c7c4ce..6a155b7b6fb2 100644
> > --- a/net/bluetooth/Kconfig
> > +++ b/net/bluetooth/Kconfig
> > @@ -128,4 +128,14 @@ config BT_DEBUGFS
> >         Provide extensive information about internal Bluetooth states
> >         in debugfs.
> >
> > +config BT_ENFORCE_CLASSIC_KEY_SIZES
> > +     bool "Enforces security requirements for Bluetooth classic"
> > +     depends on BT
> > +     default y
> > +     help
> > +       Enforces Bluetooth classic security requirements by disallowing=
 use of
> > +       insecure Bluetooth chips, i.e. that doesn't support Read Encryp=
tion
> > +       Key Size command to prevent BT classic connection with very sho=
rt
> > +       encryption key.
> > +
>
> I would drop the CLASSIC part here since it doesn=E2=80=99t really matter=
 that we can enforce this in the host for LE. In general we require the har=
dware to give us all basics. So I would just do
>
>         config BT_ENFORCE_ENC_KEY_SIZE
>
> I addition, I think that I want to put this behind BT_EXPERT option and a=
ctually have this default to n. Distributions or products should be conscio=
us about enabling this. Otherwise I am fine doing this.
ACK.

>
> > source "drivers/bluetooth/Kconfig"
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 4e6d61a95b20..142130d4b66b 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1540,6 +1540,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> >
> >       clear_bit(HCI_INIT, &hdev->flags);
> >
> > +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
> > +     /* Don't allow usage of Bluetooth if the chip doesn't support */
> > +     /* Read Encryption Key Size command */
> > +     if (!ret && !(hdev->commands[20] & 0x10)) {
> > +             bt_dev_err(hdev,
> > +                        "Disabling BT, Read Encryption Key Size !suppo=
rted");
> > +             ret =3D -EIO;
> > +     }
> > +#endif
> > +
>
> I do not need to check if this is best place. So actually I would like to=
 keep the controller in unconfigured state if a command is missing. It woul=
d stay in unconfigured state forever since there is no way to undo it.
I may need some more guidance on how to leave it in an unconfigured
state the right way.


>
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2172,6 +2172,7 @@ Read Controller Configuration Information Command
>
>                 0       External configuration
>                 1       Bluetooth public address configuration
> +               2       Encryption Key Size enforcement
>
>         It is valid to call this command on controllers that do not
>         require any configuration. It is possible that a fully configured
>
> So if the Read Encryption Key Size command is supported, I would like to =
set the Supported_Options bit. And the Missing_Options bit would be set dep=
ending on this new Kconfig option.
>
> The real advantage with doing it like this is that when a controller is u=
nconfigured, it is easy to detect and can be skipped for systems that have =
multiple controllers attached.
>
> One fun part of course is that you could disable BR/EDR and enable LE and=
 this option could become allowed again. I would have to check if we can do=
 that with existing mgmt commands and it would flip the Missing_Options bit=
.
Ack.

>
> >       if (!ret) {
> >               hci_dev_hold(hdev);
> >               hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index a40ed31f6eb8..6605da7ec72e 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2902,7 +2902,12 @@ static void read_enc_key_size_complete(struct hc=
i_dev *hdev, u8 status,
> >       if (rp->status) {
> >               bt_dev_err(hdev, "failed to read key size for handle %u",
> >                          handle);
> > +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
> > +             hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
> > +             hci_conn_drop(conn);
> > +#else
> >               conn->enc_key_size =3D HCI_LINK_KEY_SIZE;
> > +#endif
>
> >       } else {
> >               conn->enc_key_size =3D rp->key_size;
> >       }
>
> This change is not needed at all if you can not bring up a controller tha=
t missing the command.
This change is different as it deals with the command failing for any
reasons.  In that case it would be wrong to assume the key size is 16.

>
> Regards
>
> Marcel
>
