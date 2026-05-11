Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE33FF8B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510826; cv=pass; b=ak5F6cg0bddcS6MeuwaJo5Sd+imetYB/0OHM1/U/b0TfkGqNog10Avo7eB+FWKypKtIFq7PawQ43ZlRh8jFcsQtilKR2wJdkGW0iJgfZyxz4DmYGwC/TvhobMNwI+S3h63L9UPIM53EY7PVp/YCIajMAvGFIumHFY9k5AhoQeK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510826; c=relaxed/simple;
	bh=soEsa3tUTOG6JdSr5huOrWqs/34j+Pwcq0cOOxiNc3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jznE/z385Z12muer3Ba7gKwymHYC7PXDCuImJnrrYTlUWLryUHpk3lHaFE4tbcsTf8JQfBKcYOz7lfFW1jm1s1UCsqr0gqASIAXBdrEp3/hKU3w6PErVK7VXyr6jCq+8Ab+d7NVVRRcuxWiRwXoS8bXyd8+rC3yOH9r3cM5HWs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOGz5ffR; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOGz5ffR"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651bc83e74aso4509142d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510824; cv=none;
        d=google.com; s=arc-20240605;
        b=PH/IFzW4sEQwV7RHE6krPbb08GNN9VizTmNSS3kJ9/+AZaud8NMMarQqIphRE2Kfnq
         crY9vAQF3ZFXjnd8Qiwvq0uzM0WiXMDOs/+r8PGMWX/2CK0d6hAO1olZz6/jq8Nv9toE
         GMF33q2CCpSooT5A0b9uOQ0QUYYS9jcqJo/jPgkTm0FQuHIFo6Pw5uNaeHK7bRpJTRgS
         HzxpkrZfDKqANY/nLom/hmQgc5VGjjML2ZiN7gfmgA9UO1H50px+SPWJ7GSyFayljUKq
         VXSY8xSiLsG11r+fJ9QV1baep0ynE33azU+lH7flxCMD4+855lui3A159Klpob3RPnS7
         rJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=913Z8wN5aRe7Y7ZvXwheQtw55PNzkBfnlIGObXm3NPA=;
        fh=7jTDQpu2B7cbxqO/IE3DliLY68p99ZWgJKKVAIvyCQo=;
        b=XSriChvuMr2HVY+iuawVFcXJMERPSWrf87IbixtXv2zbkqaTHo6weCXNbZib2lqBWN
         YfA7u0dUoAKMM7is2YfYxN9hajWQh6seOX5dO6yn/XZuPDtyJ+pvUepdMGSA/UQ10wRE
         fitkrK7z3GSQFgjVnetH27UajMoaE7ykHQbB0R5Qp+pS6WMuwuqhw43JKf9Ym9AUtgRh
         kmS5JCJ7gTaWSPA0gzrDMmTXL1MVO2Pl27ULgm5ELnTuKfKOcEbgbY/gF4SxN+x4xcFO
         cSqTguJXS9dpFQlIR77FCLtOYxoPm7/AAozVg9S5i1Yt64tiC0YG7gdqNZH5Q4SpESmt
         l60g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510824; x=1779115624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=913Z8wN5aRe7Y7ZvXwheQtw55PNzkBfnlIGObXm3NPA=;
        b=GOGz5ffRksLu5+u6q40zZRAy1kG2ou35uU/+Oxxw7aso1CDHixZsf8HQTVD7OK2+az
         z2T9eEdaXkeeYF9+/vb3KdA4JaaYYF1R70mGOjSHKcsO9vLWLUCumwO3t6D/F/7GIbnf
         l4pujbkbvIvD+6D5QM8XMZhs5u4xQ9XqoWfemoDJ6lIpYkfr/gQr2unshVHxjH4YXL/U
         7wsTZ1q0x76IktylMozFoNNxNbfnoo6p+uoF/D6/vPajB4LQAeTjdIELeItyVPUIB1gw
         WyAk43nwCy9zPKrBi/Qs7uYdIpxkQIUynMzcgERpT0KT3SIvz/sUJXQiQsGheXHIvdxV
         hMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510824; x=1779115624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=913Z8wN5aRe7Y7ZvXwheQtw55PNzkBfnlIGObXm3NPA=;
        b=DKAgR0ToWqVhAG9LakeIi5UovOJrrLyRZMiD/iAY3N8C738FdX/4SN5VkR44Lm8HxH
         sgu2QEpUszjmCoERjUvHOXGMnHQjmdYDRXIoGHKXmZU4tSBYDPsluzAhyBcAN5BaC65f
         55Td9ioZIuXJt3jvKBtYkuTvnQRbysMQO4i6xpiFq6gwpkKG7E3xWF35Ks1lglf1xmsk
         E769JxlX98DmIYijKM8XAYHo7kNUCMxGGY7z94yWlucnTaaRuW/AxSyYksEDJvGAhNuD
         UglODoV3whqoqZ9q5SGk5+pTu0KOHoKuK+QYMDKV5b0PPz51hmbRfknowHTUOVZGOu1b
         wXEg==
X-Gm-Message-State: AOJu0YxzgnbSR8az8XhQh5aPGp549y/jli3zMC9W28zBfU4Oqnsb8Y/o
	Je4hSnkwMPLSer88u+CePE27inYkAMYafogrKVAivMA41Gm+wMdT10+1HOYC5UWyelVYVIhPzQb
	KQ7NJJWyrDE2SqLhwR43Rz45tzpPPWN0=
X-Gm-Gg: Acq92OF6+IwIFNxU2smVYgXTv37hGtz7lNspXP5L6l0qAukRPtSuszRS6gAwHDB6ZN5
	hNykNh1+MGE855SrkW9+9WzRntfOm+Ux3nFB5QSVtjGEXL6BKnssStnByZuYCVYbxEGnzMXe+AQ
	8mQFJcO5/iOrIqjeFAiLFTRqOqk+ARyfeWQX2Iew95APCwgs9kmJT7VMhFkHMvmEdRTpSR+VAlY
	60YMDMv2O5F79d9TLMRrubY+J3wYR3Ee2lIBDVOY8RXhbxrEXP9/2GN9QwiRYjHModb60R2J62v
	28RxHrAb4/HR37BYBmd2Kbm9SCJERb0zNEmJuG7A3pm/pV1x2sqgYyoDd3yhRdpTRZ4=
X-Received: by 2002:a53:ac8e:0:b0:652:541e:9681 with SMTP id
 956f58d0204a3-65c79c67ea6mr25890686d50.3.1778510823622; Mon, 11 May 2026
 07:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
 <CABBYNZ+jM+2BQ4Fek87OCKbyvuxjsyeCG0qpGRkAO4LA=pj4xw@mail.gmail.com> <d9fe37aa17175290bc406ccad8ed4cf533dfd8b8.camel@iki.fi>
In-Reply-To: <d9fe37aa17175290bc406ccad8ed4cf533dfd8b8.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 May 2026 10:46:50 -0400
X-Gm-Features: AVHnY4IGoPgw4d0fIvipGtsBveaPxZgL3RQu-HjG2UesWQH9AkBZVxdfXxjDoSs
Message-ID: <CABBYNZ+FfhYtU2=J-V4pjKf_vKV=Y5LhVhxS_epKe-qaUUt8_g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, 
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, May 8, 2026 at 3:09=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
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

My bad, will try to expedite a PR to have it fixed asap.

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



--=20
Luiz Augusto von Dentz
