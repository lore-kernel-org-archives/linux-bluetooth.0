Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF07AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 16:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719BA64E45
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 16:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhBJQJt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhBJQJo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 11:09:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F5C061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 08:09:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id o12so2225498ote.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 08:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yRz7fqamDcE+JQWwZUW3PpM+FkKAoJaRCTjDxzWj93Q=;
        b=ExY/e9TgpkoeZmwzf77qfLG6mCaDSOhhUH2Z1qczWkAyEOpQwWS2m5MueVP+Fpkaj5
         0AnSX3lPtgamTaTyYNko/L4P9FqsGrYbklLjZLtt7q+G0S3oTNRuIzpslqRiEWwvADVV
         M5ZMqf0rCOk0H6hVpoYgZQ9By4xOzaLuLly5BEzlZMSbFVFgyBz7e5LXv5g+rHpUgmvS
         z9Fls1ATXc9Pvc0y/xi8c8f8xuM+WjAszShXvy9oP3nENnr7a+XEarBZvFZYtGxI6asi
         npXTgxFdaWjiFCYrU08MRZNFkSsj8KNqMhYQIoxfFU1PC15feBMdyYzjv8wC01mz/qHk
         TBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yRz7fqamDcE+JQWwZUW3PpM+FkKAoJaRCTjDxzWj93Q=;
        b=pqZLOH+kWN1E9Z7FSofMRGB2+4B9Jo+bSLqTQS7yZB+JzFLHSm6Vq8zg4/4wJpaZ5S
         N9ojS/RmsWsV+N+HRTYZSUxeZdK/mnlGOyIqlcP0q8heHD4wy56IKkc4hxmEq2FnKCzQ
         Jz5bSsUCGw0VRcNTNtCWVqwQpPOE6LbM0JLWtLecCSLFRgBaKyc2L1G+r63AI/GWc165
         tVyhq6Ipmb8mMkl4KVGl9kdO2ACrUDGR5BrHiLhG0zVvsaTQH8xtVNtYebIc69hp03BX
         X9c1R3HYWyTcrOo1Td4Ht4uj504OadCTqF7QeXN6OvToIabsMU9n8AQhzbK9DRWFqxu0
         cj7Q==
X-Gm-Message-State: AOAM533SKBmQy7nDniHMjAPxtGFKZp2DgP+kYKtAtwDNbNV1hsbNt76F
        13uXIngCyXXoCPrOwnyznIHw/yL5vGvV9I9bTjfFQIY+H/k=
X-Google-Smtp-Source: ABdhPJylx/O/Zp0Nlcp6qQL4j8rnOkrmTn+ueTcbN5bo1hYHDVctoKlAKexxsh1Hu2/NrnmYAEeioAnwEYS4sJqcNmM=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr2505833ota.44.1612973343393;
 Wed, 10 Feb 2021 08:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
 <20210209233404.2121960-2-luiz.dentz@gmail.com> <305CB64A-661D-4C6A-BC0A-ADCF162A940A@holtmann.org>
In-Reply-To: <305CB64A-661D-4C6A-BC0A-ADCF162A940A@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Feb 2021 08:08:52 -0800
Message-ID: <CABBYNZJjotPFMCuiqJgZfoFV34Audu4RVy9=6Jt5dSFR7zX8hg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] Bluetooth: btintel: Move operational checks after
 version check
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Feb 10, 2021 at 7:20 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > In order to allow new firmware to be loaded it first needs to check if
> > the firmware version on file matches the one loaded if it doesn't then
> > it needs to revert to boorloader mode in order to load the new firmware=
.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 22 +++++++++++
> > drivers/bluetooth/btusb.c   | 74 +++++++++++++++----------------------
> > 2 files changed, 52 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 153989bd8d5f..ccab05f67df9 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -948,6 +948,17 @@ int btintel_download_firmware(struct hci_dev *hdev=
,
> >               return -EALREADY;
> >       }
> >
> > +     /* The firmware variant determines if the device is in bootloader
> > +      * mode or is running operational firmware. The value 0x06 identi=
fies
> > +      * the bootloader and the value 0x23 identifies the operational
> > +      * firmware.
> > +      *
> > +      * If the firmware version has changed that means it needs to be =
reset
> > +      * to bootloader when operational so the new firmware can be load=
ed.
> > +      */
> > +     if (ver->fw_variant =3D=3D 0x23)
> > +             return -EINVAL;
> > +
> >       err =3D btintel_sfi_rsa_header_secure_send(hdev, fw);
> >       if (err)
> >               return err;
> > @@ -974,6 +985,17 @@ int btintel_download_firmware_newgen(struct hci_de=
v *hdev,
> >               return -EALREADY;
> >       }
> >
> > +     /* The firmware variant determines if the device is in bootloader
> > +      * mode or is running operational firmware. The value 0x03 identi=
fies
> > +      * the bootloader and the value 0x23 identifies the operational
> > +      * firmware.
> > +      *
> > +      * If the firmware version has changed that means it needs to be =
reset
> > +      * to bootloader when operational so the new firmware can be load=
ed.
> > +      */
> > +     if (ver->img_type =3D=3D 0x03)
> > +             return -EINVAL;
> > +
> >       /* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 suppo=
rt
> >        * only RSA secure boot engine. Hence, the corresponding sfi file=
 will
> >        * have RSA header of 644 bytes followed by Command Buffer.
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index e896c6702d60..113ff780232f 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2469,14 +2469,30 @@ static int btusb_send_frame_intel(struct hci_de=
v *hdev, struct sk_buff *skb)
> >       return -EILSEQ;
> > }
> >
> > -static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ve=
r,
> > +static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver=
,
> >                                            struct intel_boot_params *pa=
rams,
> >                                            char *fw_name, size_t len,
> >                                            const char *suffix)
> > {
> > +     /* The hardware platform number has a fixed value of 0x37 and
> > +      * for now only accept this single value.
> > +      */
> > +     if (ver->hw_platform !=3D 0x37)
> > +             return -EINVAL;
> > +
> >       switch (ver->hw_variant) {
> >       case 0x0b:      /* SfP */
> >       case 0x0c:      /* WsP */
> > +             /* The firmware variant determines if the device is in
> > +              * bootloader mode or is running operational firmware.
> > +              *
> > +              * Version checking cannot be performed in these models s=
ince
> > +              * the firmware versioning depends on the firmware being =
in
> > +              * bootloader mode.
> > +              */
> > +             if (ver->fw_variant =3D=3D 0x23)
> > +                     return -EALREADY;
> > +
> >               snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
> >                       le16_to_cpu(ver->hw_variant),
> >                       le16_to_cpu(params->dev_revid),
> > @@ -2493,9 +2509,10 @@ static bool btusb_setup_intel_new_get_fw_name(st=
ruct intel_version *ver,
> >                       suffix);
> >               break;
> >       default:
> > -             return false;
> > +             return -EINVAL;
> >       }
> > -     return true;
> > +
> > +     return 0;
> > }
> >
> > static void btusb_setup_intel_newgen_get_fw_name(const struct intel_ver=
sion_tlv *ver_tlv,
> > @@ -2550,7 +2567,6 @@ static int btusb_intel_download_firmware_newgen(s=
truct hci_dev *hdev,
> >       if (ver->img_type =3D=3D 0x03) {
> >               clear_bit(BTUSB_BOOTLOADER, &data->flags);
> >               btintel_check_bdaddr(hdev);
> > -             return 0;
> >       }
> >
> >       /* Check for supported iBT hardware variants of this firmware
> > @@ -2693,35 +2709,6 @@ static int btusb_intel_download_firmware(struct =
hci_dev *hdev,
> >       if (!ver || !params)
> >               return -EINVAL;
> >
> > -     /* The hardware platform number has a fixed value of 0x37 and
> > -      * for now only accept this single value.
> > -      */
> > -     if (ver->hw_platform !=3D 0x37) {
> > -             bt_dev_err(hdev, "Unsupported Intel hardware platform (%u=
)",
> > -                        ver->hw_platform);
> > -             return -EINVAL;
> > -     }
> > -
> > -     /* Check for supported iBT hardware variants of this firmware
> > -      * loading method.
> > -      *
> > -      * This check has been put in place to ensure correct forward
> > -      * compatibility options when newer hardware variants come along.
> > -      */
> > -     switch (ver->hw_variant) {
> > -     case 0x0b:      /* SfP */
> > -     case 0x0c:      /* WsP */
> > -     case 0x11:      /* JfP */
> > -     case 0x12:      /* ThP */
> > -     case 0x13:      /* HrP */
> > -     case 0x14:      /* CcP */
> > -             break;
> > -     default:
> > -             bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)=
",
> > -                        ver->hw_variant);
> > -             return -EINVAL;
> > -     }
> > -
>
> why are you removing this? I put this in so that really only supported pl=
atforms are tried. We want to fail if you run on hardware that isn=E2=80=99=
t officially tested with this driver.

It is not really removed it actually checked on btintel_version_info
or btintel_version_info_tlv so we keep the checks in one place.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
