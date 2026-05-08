Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B52E7BD3
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267979; cv=pass; b=Fw5thd+7c6lZOelDGsHmdgLvhRN398g7sfY4GNYRYdq0gGViI/ZLdUoftpz/h7srrI03X6BkGNccVz6pqG9Mw+DRcwuavTq2HwQfXSR+ps17aY8vdISfvNDQ5HFx/+AxVOLdt/M6a+9tPGjhRiytKHuPEuxujCb2W4Q6+3yDmb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267979; c=relaxed/simple;
	bh=fA38PhHc80fLakVZEzPwz7Qe49eZvicUhBiIJUhE+vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO4/2rVxAlmf4zUVL+AKys3VZ08xJaP0G4fv3N4PNmtqNHGwxdnktWb4TSUETMIAM5V/II5xYBpuAbOSQTnhAXGrxTzqiaCKwJ2Nr6ggR/WBP5FW90MXqw45lrHJ7zta9tihyYYpvtj97o0UMqbro6VUoDwpp1h0wwUNTg4JdJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoJprdWW; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoJprdWW"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dd73b7c757so1262449a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 12:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778267977; cv=none;
        d=google.com; s=arc-20240605;
        b=Ulr3SUv/WrHv4R/3MmSALQLInNthY4PJH2AePMCa5m8+2YagI102nmdZExjBJBV0nq
         cIGSetWfI8mRGFNKcMNMeyhqsYU8lGpK0P8aa/gSS4odJvW2WRGBHJCjzOWAHqH72m3j
         sJKrjM6PDE0R3lZPRB1MAGSUEdY4g50qH6oHlyWqyo1pMlDA7htM2xnCLUOSUZXp/9Ya
         aD375MNQdg/1ZqDfd0xSKa3fheXGToh9QmTFfewN3WC9hl0i1CxyLP8KJQ9mz37yhl/0
         BUDDJ8mdXQeGpXsOWTb4z3xn2XfIlOADcg4nrsiraAviE2rja4kbasdNP2NPkpW1zWSP
         fj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7+Boh7qb90FIE19a83/3nvnivqtPSlkRjSt3J5MrE7Q=;
        fh=LUAxcE6YOWRmjE8RNoJoWNDsmrsC6aStH6zDlVrCn3Y=;
        b=dR6zWCK/SVvdIhwNfncfyob8OmeI7eQvjH1FBaaePezKX3ydsMSCa/Ba6W1k4MVzrK
         UbKlIzeYK2l12o4XG6RaPidYl7hbt6S3zkRxerbiskcyI/COUnysXuOPd5kGxqbfWZ+R
         YsAx8FgYueiQy/+nzCrrV7rB2chGmbgHHK+ZFO3ayjw9o6W+14kTV6NfQAxYpDOXsTGi
         kg6GcBspiKvPlLjw/qhqTeJ7xQcIzq3KAlXgOD3B48ZfXl1lBm7/3ADewhaMI/L90sAJ
         kE20ji9CIzKhros47KSqgxK1RnOutTNgFUtuZRsfBvXPhBJKBvbfDNwvo3h5k6lMG5Gy
         4TVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778267977; x=1778872777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Boh7qb90FIE19a83/3nvnivqtPSlkRjSt3J5MrE7Q=;
        b=NoJprdWWGu1PrbqTkEckcSTURmISdMOC4UKb4WOtvnkBLkTopw2FMLwLs+CfIKiHBm
         WHcp7pdLQhhZ45+sv7WPLjhPHiipZPlSx0rT8kjOwv/NfQfYWr0c5RkojZD8DRVCmv1t
         eJ9T6bXNEakLRx0bIORGHPIye/PvS3dYRkgctoNFuHHPiecyPLU36I/qFNwb8CLaGzMl
         5FbjDQw1NHBN8K66QTE9kCKR9B3MEbVukfI/Ej1fGI133fmqVX/WXdEk0KlgqWhN+Z2r
         +RLagFN4Ot3C5QM4QpjFqL5iVjCzusHiqWE4T57SR1D4LC/gAgw21DVClmYGtAu9A84q
         /j5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778267977; x=1778872777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7+Boh7qb90FIE19a83/3nvnivqtPSlkRjSt3J5MrE7Q=;
        b=JpU+ekJ7jfGyagjGaMpQc2zSDXBrMjLtSRcfYEGOraaVS3eUcehu6LLzJethomagJl
         pnF62rSF9MwNNrVvxpSKNbS3PblEYmxpsnZ8UIQBW/idB4YLsHA8eZUCE+6Hqhev9CF4
         tvIvA4I2BqAZoTlFbtC08TWiEOblMzM1eLPQhBr5BNSduiD0+kLWKrhqkdVj6clGeXBS
         rxHZTaBoeGGInYBJhphPXfXZK97YGHeglV0qRKaxtp27kC9tt1e8QAmg646vKGuMNfMA
         wlHG4atbKA2G3NKtVbhTTmEfJihfYB5Rltb0HlNIVNyuk5EP32Naiszp+D3uu+ivuqyk
         Wv1w==
X-Forwarded-Encrypted: i=1; AFNElJ/Hp2tUPrqRbq3rXUIlK+mYMb/hbAk8qxIei76poIXXV/xNdg9KKDWW/BsUlmaHI7bG4BCiWyNY+IkhEbWoFd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybGExrRQdFfShkBlmsm+9kcoHI1PdSRFgKx6hzJCphBPOPAbur
	DNF1JaqZQdA5he8BZYtdTErHp6oLK8AlK3Cz6AHm+iiExIcMCjpusB3NpTY85OIwkouvJKVB0Rg
	3dgh8lVXLdN1cF5xkumndz3Zutf+UnIE=
X-Gm-Gg: AeBDietyiVssOHE9TEBbvLnIfDGbqp/Et3+s+100VDlVsLPyWfJ2L0vBtgZQd0KqbCg
	Ns/F03K4XRSyL8ELd3qZbpOdyuX4EKuXuLivLWglWRpYPP4DcLrC1WsoPAJOB0KGhsZWRJhtnCl
	9tbbBEmVzOwRpmBVq5LnWcICAnbhCuvk+RU1a1/1bxe55C5JfPlwAppZquE7peKya5A/8zmXJoe
	vEnQ7deHm6nn+Dp0nwmGn1nctN+cO2Ld/jBw6SVu9PBtm4aiazWpSwUKUNx5dnLdfnnK9wIcOB9
	unsUCXsuH6GaKbeKuS0=
X-Received: by 2002:a05:6830:6734:b0:7dc:dd58:50c7 with SMTP id
 46e09a7af769-7e1df0c4d92mr8873236a34.18.1778267976695; Fri, 08 May 2026
 12:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
 <CABBYNZ+jM+2BQ4Fek87OCKbyvuxjsyeCG0qpGRkAO4LA=pj4xw@mail.gmail.com> <d9fe37aa17175290bc406ccad8ed4cf533dfd8b8.camel@iki.fi>
In-Reply-To: <d9fe37aa17175290bc406ccad8ed4cf533dfd8b8.camel@iki.fi>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 9 May 2026 00:19:25 +0500
X-Gm-Features: AVHnY4IrsdBhyuJKq-Xvge5CpaqxAbyUSS4N4WDsEojT1qK4mYvq_wknDUMe7HE
Message-ID: <CABXGCsMTKG+XwGUNmARJpxtkkieUWphpGdCX5VU4Mv-W30CXGA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
To: Pauli Virtanen <pav@iki.fi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 12:09=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> pe, 2026-04-24 kello 15:38 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli, Tristan,
> >
> > On Fri, Apr 24, 2026 at 3:25=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > MT7925 (USB ID 0e8d:e025) on fw version 20260106153314 sends WMT
> > > FUNC_CTRL events that are missing the status field.
> > >
> > > Prior to commit 006b9943b982 ("Bluetooth: btmtk: validate WMT event S=
KB
> > > length before struct access") the status was read from out-of-bounds =
of
> > > SKB data, which usually would result to success with
> > > BTMTK_WMT_ON_UNDONE, although I don't know the intent here.  The boun=
ds
> > > check added in that commit returns with error instead, producing
> > > "Bluetooth: hci0: Failed to send wmt func ctrl (-22)" and makes the
> > > device unusable.
> > >
> > > Fix the regression by interpreting too short packet as status
> > > BTMTK_WMT_ON_UNDONE, which makes the device work normally again.
> > >
> > > Fixes: 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB length=
 before struct access")
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >
> > > Notes:
> > >     AFAICS the commit is not yet pulled and is only in bluetooth-next=
, so
> > >     maybe this should be just fixup?
> >
> > Yeah, I'll most likely fix it in place and add your Signed-off-by.
>
> Looks like this got pulled to net without this fix, so it's broken now
>
> >
> > >  drivers/bluetooth/btmtk.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > > index ab34f1dd42bc..68a32d11e5ec 100644
> > > --- a/drivers/bluetooth/btmtk.c
> > > +++ b/drivers/bluetooth/btmtk.c
> > > @@ -719,8 +719,8 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev =
*hdev,
> > >         case BTMTK_WMT_FUNC_CTRL:
> > >                 if (!skb_pull_data(data->evt_skb,
> > >                                    sizeof(wmt_evt_funcc->status))) {
> > > -                       err =3D -EINVAL;
> > > -                       goto err_free_skb;
> > > +                       status =3D BTMTK_WMT_ON_UNDONE;
> > > +                       break;
> >
> > This probably means the original change was never tested on real
> > hardware. We likely need input from the MediaTek team on how to handle
> > these events, as I don't think a public spec exists.
> >
> > >                 }
> > >
> > >                 wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)w=
mt_evt;
> > > --
> > > 2.53.0
> > >
> >
>
> --
> Pauli Virtanen

Hi Pauli, Luiz,

I sent a functionally equivalent fix [1] earlier today before
finding your April 24 submission -- apologies for the noise.

Confirming the same regression on MediaTek MT7922 (USB ID
0489:e0e2, firmware build 20260224103448): "Failed to send wmt
func ctrl (-22)" right after HW/SW Version, BT setup aborts.
Reverting bd75e1003d3e on top of v7.1-rc2 restores Bluetooth;
your fix has the same effect on my hardware.

So this is not chip-specific: MT7922 (Wi-Fi 6E generation) and
MT7925 (Wi-Fi 7 generation) firmware both send 7-byte FUNC_CTRL
events without the trailing __be16 status, suggesting a property
of the MediaTek WMT firmware family rather than an individual
quirk.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> # MT7922 (0489:e=
0e2)

[1] https://lore.kernel.org/linux-bluetooth/20260508173121.27526-1-mikhail.=
v.gavrilov@gmail.com/

--=20
Thanks,
Mikhail
