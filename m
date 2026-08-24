Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF674248D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582152; cv=pass; b=YtoUR8rON/WZtyrF7yoPcW4lmH6aZ9oesB0JaZ14fIcKibDVhKKHeXiK1kTxpozqgTQV2f4Nb/g6JfDpdCtmyrDuUt8GjlZ493QoU6EFl5JEOvKodE+bzCh3+0Jor/fIRqMYVTPA5B+vubxO2lr7Qzp6w/S20+VxU1KfkOc+Je0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582152; c=relaxed/simple;
	bh=Y6V0kZp4BD8ZRN/0Gddqg9ImoedWspC2zyyA+T9P50E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeGGKDo9fJqlgD/mw3e646OITS6oyC0uerMg8/8IsF1AYUUwq6WYkKIx64Hydh1Da4tF7hu/lK6GpQOzqf/qJXuhNQXputpW4kDxl4PNIxbu42fzvs78cJ0l6eimKqX3gkptmKqS6HXBfbN9SLYn2XEbyhgeb/mVEnDgFu0rrq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqDrL1rn; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqDrL1rn"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66c83e34212so4341970d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 07:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787582148; cv=none;
        d=google.com; s=arc-20260327;
        b=EsHQwBB8NI1GWtoCRjQz4hzRNS4/PEgm6WX2rEuKEeYvlIzLGA3lBh3BdRNWgYpX1A
         cRQ0D5/REtNygMv6kAgGjyhReAenRKJ61pIAYQEyDnPc+DdXQdm40upO9J5n4Wa/Jx3m
         FCC1GsNdk/7wYQvdFNb1pX4y7bRnAb1jvwye/bJsIvfjJIIv1p59NS/6LKruqVmIWLSP
         u/dihvA0auUsZye60LIY+/0zwF8JEoOukhKvXLSRIiyYfe80YK/zYk68IKzSPcaWwAIL
         ufclS/bcd8vN3R47m7BqO2DWyaKZVTLMA056f/oq5KoKmswarUnSeszab+AGHeQ1fJHl
         GYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DlEAhHb6rraj0pL5d9U0h/2riTkYg1T2t1YsFrpCceo=;
        fh=0IIrL2vHaSckIk3+BullF3gqHfQOmvHORm3JUyU1vGw=;
        b=bvvNZVhmprsWFRg2TSoKTMCzqvahDW0ZBZiBnNtQw6PEZuymxZYj9DQVMimp7/NCpA
         CwdFcqtYHaIq2lpOM+QVHf3j3SKmTFtz7q2h49OYTlmUZVCZKwaiUBUFwnw7TG//6k2M
         oouFnOS2fSs/4nddurB6EUR4YgiRI44qfuG7a7aVvA++tyiPrsapNuo4uG8Zw6Zll8V1
         EYYMO5FTmXYLgQ8tyHoPKI8+mgZf22dzh/z4oNk4NNQHzkq5Ycyq5MRez2KCCCsdF/O3
         YpTDDu4uxQT5hB2iEVNc//MDrDkGbSyg1dOH0nZEH43pGt8LeRZ0eyxax4UJYryT9kjt
         67DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787582148; x=1788186948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DlEAhHb6rraj0pL5d9U0h/2riTkYg1T2t1YsFrpCceo=;
        b=eqDrL1rnHvKV1YDk80akVb3tMGHUcjEw50mgRdlIYfcyJVyBSusYMqFH8AOPoVJMfv
         sYnE/52fkK/Xwv6TV+pmrGAJWyVj2X8mbtmXiSaBXZXzaJLMudLAI8thpadwFuHB9tqy
         nYoy2zerO/EYnqY8yFnqYUvAD+aeb47Ztf/Ti/0tmYoCUcxqHDQSYbiK3rQp+ZPg8N9k
         h062lPN7/2bWK7P7RB8KXdOOSnTbQzMRVe3GC5EkTMzC3hdomCOLEwNNsSlIgq6NbhL1
         wdM+8bYln7ueXBkkVxew0iKPlntz6tSaN8ovkHnynC2VSeDE1Jsh6xtoXFnexEWlw6TI
         uDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582148; x=1788186948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlEAhHb6rraj0pL5d9U0h/2riTkYg1T2t1YsFrpCceo=;
        b=H5hoAMosHU1SHL6x6VLuygfCimM0g7opyakhH3fnCGcckQntMRNhQCnQlvokYJ0tYA
         6rosvAodvNEEzQmOslwaSn8mkC5NWh848S+KkKKRYDcZt8+UGEBU4+9QgnvRP58FPS7v
         aNYttbtzJi903ArbLQRqJTARUjel9ercf4rcwPdSOPN4aq3502QV4Ixb8mRdxXEPhErc
         so/9OGlqk8/blLPr2UBIRfAu26oWNc+xa74qDChkpu9ccqIBN8bXJKDQEIDisq/ml7wX
         /46Kc9ESGuZqzQIIxCN2psiVKJ+OZMZtRbzvHuts6FV1H9+ZIgOysamqcj4oI3SnTKHU
         bs4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpsPTlIY/8cSVBr8SicxbhxJQ0n4IGS7KExSG9GK9FDeFRusnn18Jf1ONRyC0xUhe0Qz5okQbhWXzoJV8YSr2I=@vger.kernel.org
X-Gm-Message-State: AFuF++k6SiUjmFJRRBZ2DQmMi/R5amH4CXQKGtDTSgFH3mjbzrqqQru4
	7emBz5y05cqVVgKDOciyPkwyI3kdbuHkLRtWt4qVlfTswtmh7V0B/vqbKwLocfDr5LydlwmbAVy
	HUFbOE+/X7kAAwEcb80HQNn69FLNsMjs=
X-Gm-Gg: AR+sD12zTpXrFzKnOg6ynIRzJ5pTQEYYVjiXvumJ786vfhv2wwVNyXVBfEYA1auSa8T
	qopkCZlJ8Ztrp03YNh8kkqrKmfgyFJiePtO5EAOnSfWrXmJmYjf2x3ZM09STpW3Dt+gPmmaa4Ly
	rnHFkw7AEOnhwcLYR9L8ZkmvVZQLyaLOHIpyXOpUVVpPRNG35TsCf2j2x6whkvmNB34ReF5cnPL
	SZ8DqHKHYtMZw/GN7xaiYAcaqUF5lgXPA7bSibbMEa1yfleLTsIpSXz8AlhqbkIEpgveoGYnaUm
	jKfE+zfYwplmckopFOmS2waLms+vn/uKuTqRDcwfRnUY7FViwVNTguGcVvRNApffgaqql+zv9Px
	iM/Z5dKAiT9d8q9gE4XWFY8X4BsVe
X-Received: by 2002:a05:690e:25d0:b0:66c:e932:2592 with SMTP id
 956f58d0204a3-66cf21deb78mr4733001d50.38.1787582148414; Mon, 24 Aug 2026
 07:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824053227.317496-1-junjie.cao@intel.com> <77f94165-3d5f-41de-8969-c7318284fd6a@leemhuis.info>
In-Reply-To: <77f94165-3d5f-41de-8969-c7318284fd6a@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Aug 2026 10:35:35 -0400
X-Gm-Features: AcwNN1WxDxyNb27MNZYYLQ2YylskKFoLPXWU8dYFUVQ7iT_pAzgxPlP6dclf31Q
Message-ID: <CABBYNZK9ax+iw7xKBtdZTSERsdhQ7t41Bg_1EnG88KOYj6kFHg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Junjie Cao <junjie.cao@intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexej Sidorenko <alexej@sidorenko.cz>, regressions@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Kamil Serwus <kserwus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kamil,

On Mon, Aug 24, 2026 at 2:03=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 8/24/26 07:32, Junjie Cao wrote:
> > Commit 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
> > extended scan") set HCI_QUIRK_BROKEN_EXT_SCAN for every CHIP_ID_8761B
> > device to cure repeated 0x2042 failures on an 0bda:a728 dongle. The
> > brokenness is per-dongle, not per-chip: on a TP-Link UB500 (2357:0604,
> > RTL8761BU, fw 0xdfc6d922) extended scan works, and the legacy scan
> > path the quirk forces is what is broken -- LE Set Scan Enable (0x200c)
> > times out with -110 about 30 s after firmware load, btusb resets the
> > device, and the adapter re-enumerates in an endless loop (382 firmware
> > reloads in one boot). 7.1.8, which predates the stable backport, runs
> > clean on this unit; 7.1.9 loops.
> >
> > Move the quirk from btrtl's chip-wide switch to a btusb device-table
> > flag on the USB id the original fix was verified against. Other 8761B
> > dongles return to their earlier long-standing behaviour.
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2521504
> > Fixes: 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE exten=
ded scan")
>
> Thx. Just to make sure everyone is aware of it: Kamil (now CCed)
> reported problems due to the commit yesterday and provided patches, too:
> https://lore.kernel.org/all/20260822141115.58815-1-kserwus@gmail.com/
>
> I suggested that a quick revert might be the best approach for now,
> which Kamil submitted:
> https://lore.kernel.org/all/20260823102959.100368-1-kserwus@gmail.com/
>
> No comment yet from the BT folks yet.
>
> Ciao, Thorsten
>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> > ---
> > #regzbot introduced: 5ead2063611a
> > #regzbot link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2521504
> >
> >  drivers/bluetooth/btrtl.c | 13 -------------
> >  drivers/bluetooth/btusb.c |  8 ++++++++
> >  2 files changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > index 7f54d2d2d13a..03fa9409e3ee 100644
> > --- a/drivers/bluetooth/btrtl.c
> > +++ b/drivers/bluetooth/btrtl.c
> > @@ -1343,19 +1343,6 @@ void btrtl_set_quirks(struct hci_dev *hdev, stru=
ct btrtl_device_info *btrtl_dev)
> >       if (!btrtl_dev->ic_info)
> >               return;
> >
> > -     switch (btrtl_dev->project_id) {
> > -     case CHIP_ID_8761B:
> > -             /* RTL8761B/BU reports HCI version 5.1 but does not suppo=
rt
> > -              * the LE Extended Scan commands (Opcode 0x2042), causing
> > -              * repeated -EBUSY failures when BlueZ attempts extended
> > -              * scanning while a connection is active.
> > -              */
> > -             hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > -
> >       switch (btrtl_dev->ic_info->lmp_subver) {
> >       case RTL_ROM_LMP_8703B:
> >               /* 8723CS reports two pages for local ext features,
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 2bae85b0016c..84614e60d142 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -67,6 +67,7 @@ static struct usb_driver btusb_driver;
> >  #define BTUSB_INTEL_NO_WBS_SUPPORT   BIT(26)
> >  #define BTUSB_ACTIONS_SEMI           BIT(27)
> >  #define BTUSB_BARROT                 BIT(28)
> > +#define BTUSB_BROKEN_EXT_SCAN                BIT(29)
> >
> >  static const struct usb_device_id btusb_table[] =3D {
> >       /* Generic Bluetooth USB device */
> > @@ -619,6 +620,10 @@ static const struct usb_device_id quirks_table[] =
=3D {
> >       { USB_DEVICE(0x0489, 0xe130), .driver_info =3D BTUSB_REALTEK |
> >                                                    BTUSB_WIDEBAND_SPEEC=
H },
> >
> > +     /* Realtek 8761BU Bluetooth devices */
> > +     { USB_DEVICE(0x0bda, 0xa728), .driver_info =3D BTUSB_REALTEK |
> > +                                                  BTUSB_BROKEN_EXT_SCA=
N },
> > +
> >       /* Realtek Bluetooth devices */
> >       { USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
> >         .driver_info =3D BTUSB_REALTEK },
> > @@ -4403,6 +4408,9 @@ static int btusb_probe(struct usb_interface *intf=
,
> >       if (id->driver_info & BTUSB_INVALID_LE_STATES)
> >               hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
> >
> > +     if (id->driver_info & BTUSB_BROKEN_EXT_SCAN)
> > +             hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
> > +
> >       if (id->driver_info & BTUSB_DIGIANSWER) {
> >               data->cmdreq_type =3D USB_TYPE_VENDOR;
> >               hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);

Any chance to test this change? It looks better since it does remove
the original workaround for the specific USB ID while also fixing the
regression.

--=20
Luiz Augusto von Dentz
