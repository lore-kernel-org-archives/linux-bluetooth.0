Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2ED1E493;
	Tue, 10 Sep 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975292; cv=none; b=jC74adZw2ML1CuOaNDXDo/qBbQwH4tuPnEAzln/wt9X5UpWbkPVPqN3AWG4gcMpe+PHFTkyfAayAO2GWhAnpBEpAlZq4Bh6qFvYJxUs+5ugJaKjXOajWRSpt1+bhSd926a4C7lldh1Uq9KnXKQL2npalfiIgEzAjtnI+AZx4xZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975292; c=relaxed/simple;
	bh=O53f7rbnvqpVCD1pt+wiSLnCd5tW/FK4LsdM+LJyIDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAMaJAYcaGHGiCQn/N6Bb2YzfEr4xgDHR/sOR0mlhhKfpoAOmwQ9AR1WlEoQfJBe6RFRHgo4g2UKPPa3h8/JOlfiCrAAivgPtNjrg+QQfSAjYdQ2JhyCxKCrBExad6hgt89W13qACe/g1YfoTbrKvWGH3ebYF/Qbp8tXbDFaRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0rro3GB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0rro3GB"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f758f84dfbso6166991fa.0;
        Tue, 10 Sep 2024 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725975288; x=1726580088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/2dhYmqzVQj21Zis9HyVEbCA0RMNcxW7L5Y1sXl9II=;
        b=O0rro3GBM/uy6xmIPNeKwNTzC9ghKU1A1EMCaNVUPw2KLg/POMFkuJiY6XtOBqoDb2
         aUs2FtKsZoOQVqLatG2p6JlO5w02X0dgPrs/ZLkHlV120XyfM89BMP18KrHQmu78HiPp
         zMJdO1nFSVJJxwMLC8qBkriKvWNFFuimuGwXDvJU/wy1+0j5FJprxEbpUnbGVCWb0S5T
         aMeH2K/EweBdIPxpeme5Pe2weWmt6ZuQkIlVjK496qBpCAGR6H/smwft0JWhjYvsCrZh
         rE84lEnwBCZ91F7uhQFdKFOgtmIWwmzVRtnPgXxUaCpBwIkC3xXImIvlNyC+6VUSKAMN
         RT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725975288; x=1726580088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/2dhYmqzVQj21Zis9HyVEbCA0RMNcxW7L5Y1sXl9II=;
        b=Ao+IO/oeGz1ThlmSZ0cz5/EV19gnn7V6HFXY/V+xqueIxzXmdHTlfFjQX1P6mGAiwy
         qltGDhZHvzT0NThdropC0pxlgJR/A+9BAjcFu3Vr6/Iu1lq5apKh9X3cwuaKIl33Gqzt
         N+I73JbESqBVuAC6tUIr/pHj2S9tWj9kMJ8sL9k1rBnkOnfFbyH8t7d7cXWjoTD1H6z1
         xwEGoaLfu5OZ1e28mM6xDUJ2iPbuQrSxg/NTm5OCOAM3h86MpgCeb7qU+hyJXPULC9gu
         4e+upHE01abzKBUWmiQiKnz6WUXBOO6+CBNRoCXB01zzW9+MJtmSBM3YDo7WdhzvwdJR
         VkMg==
X-Forwarded-Encrypted: i=1; AJvYcCXgp0BrNgxd/ZI4mmAM2v+x8bJUR8aPt07psXY0GeZc/mdPW3+0V9fTKzFI3PgWJdolWRebtzC9Dgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0nKuBxK/qNEm++CV+1enGz5BfeIsempHqlhF88T1MszUw9rY
	rXnWkK6mXgqLJYVfEQcA2crRYaIsZU/UARr5N23pOKnob7W5nxwJS3Y6hTAw1lpral0sP/c56us
	x/rJ684UmJcfyTDqpV2x4HAfjlE6EEg==
X-Google-Smtp-Source: AGHT+IEAA2I6AIO3F4pKXQ9YFbUFUEDGbSv3reF1Gzkzsbwu0pq0bHJPgw4SJT3VSh77/gY60DFCYKxaXQADs3ETy04=
X-Received: by 2002:a05:651c:b0c:b0:2f7:4b90:204b with SMTP id
 38308e7fff4ca-2f751eb876dmr105662631fa.12.1725975287392; Tue, 10 Sep 2024
 06:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909205152.2397337-1-luiz.dentz@gmail.com> <1a2b267a-8d9f-44e6-880d-2383f8b5369b@molgen.mpg.de>
In-Reply-To: <1a2b267a-8d9f-44e6-880d-2383f8b5369b@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Sep 2024 09:34:35 -0400
Message-ID: <CABBYNZKJNT3kY7Ug+S3=v0p2x1S1adR+wmb7RNfy0_DJBqJg1w@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btusb: Fix not handling ZPL/short-transfer
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Sep 10, 2024 at 3:31=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Luiz,
>
>
> Thank you for your patch.
>
> Am 09.09.24 um 22:51 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Requesting transfers of the exact same size of wMaxPacketSize may resul=
t
> > in ZPL/short-transfer since the USB stack cannot handle it as we are
> > limiting the buffer size to be the same as wMaxPacketSize.
> >
> > Also, in terms of throughput this change has the same effect to
> > interrupt endpoint as 290ba200815f "Bluetooth: Improve USB driver throu=
ghput
>
> (*interrupt* would fit on the line above.)
>
> > by increasing the frame size" had for the bulk endpoint, so users of th=
e
> > advertisement bearer (e.g. BT Mesh) may benefit from this change.
>
> Do you have a benchmark script, that can be run?

It is a **may** not a might and not the main objective of the change.

> > Fixes: 5e23b923da03 ("[Bluetooth] Add generic driver for Bluetooth USB =
devices")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   drivers/bluetooth/btusb.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 36a869a57910..83df387aea92 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -1341,7 +1341,10 @@ static int btusb_submit_intr_urb(struct hci_dev =
*hdev, gfp_t mem_flags)
> >       if (!urb)
> >               return -ENOMEM;
> >
> > -     size =3D le16_to_cpu(data->intr_ep->wMaxPacketSize);
> > +     /* Use maximum HCI Event size so the USB stack handles
> > +      * ZPL/short-transfer automatically.
> > +      */
> > +     size =3D HCI_MAX_EVENT_SIZE;
> >
> >       buf =3D kmalloc(size, mem_flags);
> >       if (!buf) {
>
>
> Kind regards,
>
> Paul
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
