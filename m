Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 18:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349594AbiC3SCN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbiC3SCK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 14:02:10 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2F5597
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 11:00:25 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e81so9032368ybf.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eeMZmw/kqadzdyJs5nlh7eHQdmfPhh8haxuMTK6KHSU=;
        b=VrkFiLX+YLqWOBkWoDB8TCWdc/YNwBjSHrLL6FNC6hfaLS2LnORZUOvWG+fUoSyeJ2
         iwqyOd0hRtuP68kSyo7AMVIYh7m4SGruPGBqifd49YgjPwMYZgHIypF8Kb8hpvFjrZtY
         92KCTu0FjaZ6FaHFe1gihyffJSz53RA/b6ttbZDTf3BAp8ykEVRc1V6/M3SMNAZzSvDx
         YVNvj7IUxCS0eR1UPAL7dh/X8gRvxoFGnCCkxkecwmePlGqeiE8uabLlYxyDC4OCCiD8
         VzDini5gPQWIT24yCmZISqNnFFreRxkAeOJhg6LDAey0U9QO5y38AOjI1w7IGzB8CoqI
         MuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eeMZmw/kqadzdyJs5nlh7eHQdmfPhh8haxuMTK6KHSU=;
        b=Hsl17PtMtnSJEYG/2O7IGIsj6anEsHaSa3Y0Iomuo9xIKZQMSd7Y6655PEY+H1LdNn
         BDXej27waaBq5Qgn/5DRuSbTl8W390tHz3dbk5BTRedCYMAWKqjtfXEUMKxrFCJ/YAya
         zEsnmu03LK4+Cf/OBkFTsHkXq/xpujSvwkKfwKFxIh/obxXdemnm6lVEV0JZbnH+jfUa
         4KFw9NHmxCeNXteSgavL3m7GuvmtC/maIo68h64XgUewwa3iXMGF080Ux/rUcksV/GmI
         pbVBS+hbZbUMWAp/0u1O8PIMSKVgi9lZ3sIra+GdeQ8cSJqjAHa4dCea2B7QW7jnA2hs
         fWPg==
X-Gm-Message-State: AOAM533vQZlGqubgEVoWnlP++XFfI7w+3J3TlxMslVCnsuV3NWx5icMW
        /7b4wCt39ywV9WbSiFRD6gHbMEjq8yTxQLAUS14=
X-Google-Smtp-Source: ABdhPJxmcqenpANha42/ct3r+dM/v1iFYLA0tPl3zOcHnudZSB86Y9uCMStcDW0HMQyZ02xAZUFYiAQjbd8OkAhc8Mo=
X-Received: by 2002:a25:9742:0:b0:61d:9526:ebc3 with SMTP id
 h2-20020a259742000000b0061d9526ebc3mr824713ybo.578.1648663224446; Wed, 30 Mar
 2022 11:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220329201646.2296314-1-luiz.dentz@gmail.com>
 <20220329201646.2296314-2-luiz.dentz@gmail.com> <e8c5b25a-6e4a-d958-c3c0-aa9dad797c8c@molgen.mpg.de>
In-Reply-To: <e8c5b25a-6e4a-d958-c3c0-aa9dad797c8c@molgen.mpg.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 30 Mar 2022 11:00:13 -0700
Message-ID: <CABBYNZKmb6Y1TSaVOoAaSuMpOK4GA9AMtBgpaZSGEXdzgDJAUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Bluetooth: Print broken quirks
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

On Tue, Mar 29, 2022 at 11:13 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Luiz,
>
>
> Thank you for your patch.
>
> Maybe as commit message summary:
>
> Warn about broken quirks
>
> Am 29.03.22 um 22:16 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This prints warnings for controllers setting broken quirks to increase
> > their visibility and warn about broken controllers firmware that
> > probably needs updates to behave properly.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   net/bluetooth/hci_sync.c | 66 +++++++++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 62 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 8f4c5698913d..8994ff1f94e6 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3825,6 +3825,67 @@ static int hci_init_sync(struct hci_dev *hdev)
> >       return 0;
> >   }
> >
> > +#define HCI_QUIRK_BROKEN(_quirk, _desc) \
> > +{ \
> > +     .quirk =3D _quirk, \
> > +     .desc =3D _desc, \
> > +}
> > +
> > +static const struct hci_quirk_broken {
> > +     unsigned long quirk;
> > +     const char *desc;
> > +} hci_broken_table[] =3D {
> > +     HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_LOCAL_COMMANDS,
> > +                      "HCI Read Local Supported Commands not supported=
"),
>
> The user wouldn=E2=80=99t know, that this is a device firmware problem. C=
ould
> something be added to the warning, like:
>
> Therefore, device firmware VERSION violates the spec. Please contact the
> manufacturer.

We do print out the firmware filename when loading it so I'm not
convinced printing it again would make any difference for the user.

> > +     HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
> > +                      "HCI Delete Stored Link Key command is advertise=
d, "
> > +                      "but not supported."),
> > +     HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
> > +                      "HCI Read Default Erroneous Data Reporting comma=
nd is "
> > +                      "advertised, but not supported."),
> > +     HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
> > +                      "HCI Read Transmit Power Level command is advert=
ised, "
> > +                      "but not supported."),
> > +     HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
> > +                      "HCI Set Event Filter command not supported."),
> > +     HCI_QUIRK_BROKEN(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN,
> > +                      "HCI Enhanced Setup Synchronous Connection comma=
nd is "
> > +                      "advertised, but not supported.")
> > +};
> > +
> > +static void hci_dev_print_broken_quirks(struct hci_dev *hdev)
> > +{
> > +     int i;
>
> I=E2=80=99d use `unsigned int`, but no idea, what the subsystem does rega=
rding
> counting variables.

I suppose size_t would be better given that sizeof is used.

>
> Kind regards,
>
> Paul
>
>
> > +
> > +     bt_dev_dbg(hdev, "");
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(hci_broken_table); i++) {
> > +             const struct hci_quirk_broken *broken =3D &hci_broken_tab=
le[i];
> > +
> > +             if (test_bit(broken->quirk, &hdev->quirks))
> > +                     bt_dev_warn(hdev, "%s", broken->desc);
> > +     }
> > +}
> > +
> > +static int hci_dev_setup_sync(struct hci_dev *hdev)
> > +{
> > +     bt_dev_dbg(hdev, "");
> > +
> > +     hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> > +
> > +     if (hdev->setup) {
> > +             int ret;
> > +
> > +             ret =3D hdev->setup(hdev);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             hci_dev_print_broken_quirks(hdev);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   int hci_dev_open_sync(struct hci_dev *hdev)
> >   {
> >       int ret =3D 0;
> > @@ -3887,10 +3948,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
> >           test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> >               bool invalid_bdaddr;
> >
> > -             hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> > -
> > -             if (hdev->setup)
> > -                     ret =3D hdev->setup(hdev);
> > +             ret =3D hci_dev_setup_sync(hdev);
> >
> >               /* The transport driver can set the quirk to mark the
> >                * BD_ADDR invalid before creating the HCI device or in



--=20
Luiz Augusto von Dentz
