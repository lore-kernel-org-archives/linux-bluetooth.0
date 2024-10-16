Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4D205158
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090035; cv=none; b=fYGmfo0U3cR+DuC1DqRBp+ZnyLnkK9bgmxtN4H/Yg5K+RFtTNE6SQ6SLsLsqAHTrAqcU0tO9tRv5TCLqxhduqy+Haxao8S2O3pnyGk2R9aqqeTumvNUk8vZfrqy1xbcMaDPYlin1S21aZZCbKP+MccFathMQxG5Yiu2TblXr0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090035; c=relaxed/simple;
	bh=mhLkdODoZzwIJonDfjJPh8ZlAtAc02jvhFD3QbM5K08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejas7GXgnan9O2A88FMaYLcL6vTmcd1baPQayc1HmyAIO4yAtuNQ2S3L5ACX8g1DPzEW3OB1C+q4EYQrV1SpE3zlGwmuzjj7t14zRtdUZ7KAqpyIUYNpVzjj7b2eHpg+Orw606+SFtjLBuGCFshdAhif4OlfQNSVbJef2MvrNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewdi/NQT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewdi/NQT"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb58980711so30230771fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729090032; x=1729694832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb8I1KNnqo4NAOaZ85mrwmlxgJIux73vRmSTvwJzZtQ=;
        b=Ewdi/NQTFc8iwxgjFMBirOdhB/0ByD/TeJ8yNIcA0PJUXM0bZ27Lpry9AORBRo0IYr
         nUrvnNcMPa+0Q+k/zLA2cvHU5NkTtJsM3RlZt1pvGKEGvIiPaWCDjPKNuWOBvuBkM/QW
         LEddiH7/WWMPcF6xqZoRgr9MYaADyOGaphut7Giqg3SottqO7xYKFtULr5n6yAJhq3J6
         Sn6r3FSYpi8iRB3qM8r7Q1b2hDCHY8C4aKK5o2jjxRpuridETsEKsgCTvrMaLHO4OgZy
         QPbr8Udzi1BfwQJeg3Mz2cMDEYkWII/artKc+uVrJHpHSAG8cBV+Zkuc742BJMU4O8eK
         IirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090032; x=1729694832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb8I1KNnqo4NAOaZ85mrwmlxgJIux73vRmSTvwJzZtQ=;
        b=SOiBb2gq3Fe5v9IzSKSPAd42LqV2sb0HYgUYqQAGKZ9utO66Iol2KYWfsdDH6njN9b
         DXYBU1SRNNLcI00cglV5PiCeMlYIhkHItcF+x6vKoOTuYJk0QggiIelxA6JMpj5dOT61
         VNHFCt+8ILG3cmbz2xk6WcjOJPqVeXkpu0XUi+0XOUR6++1cW6S1i6Wr23de1eftPKVS
         P+gUUippULeJjifYygmsOubjU5s7VHlAMrPmpl7yoJToLPd08HdSH0Ai8S7ATgcztVTm
         pGAqXES0prvugITR1j80spjklQUpgAG0UGYRSzRe5A+iR7QCB7HStEO1C6myPE7t9jo2
         iAjg==
X-Gm-Message-State: AOJu0Yw7l/GKy1VO83K1lX0q94t+gQxhpGAIqNLCcu3tCIMgjvvnPMot
	JNLOaACYV9Y/LOWPKBCJV1Tm86SazFSXrdvOj96MecsdF1kQ98DNudn4KTJuUvBhDHzAY6ZR+LI
	EsYHksJZ49f7XktrwOjZ2KV3MGj499O36
X-Google-Smtp-Source: AGHT+IHtzPOcxG087DNTf/Mnea8NxvRiS4nLt2rhRjkCuPPXBDdKxjk7wX9778ifUlsmWZiXg2m3vTYbli23CT+xkWI=
X-Received: by 2002:a05:651c:542:b0:2fb:4b40:1e18 with SMTP id
 38308e7fff4ca-2fb61b4ca2dmr29507211fa.13.1729090030778; Wed, 16 Oct 2024
 07:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015153719.497388-1-luiz.dentz@gmail.com> <69fb4d7c-9319-4dc5-8680-c151d25ea8a0@molgen.mpg.de>
In-Reply-To: <69fb4d7c-9319-4dc5-8680-c151d25ea8a0@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Oct 2024 10:46:58 -0400
Message-ID: <CABBYNZJZXQBBr0u0z3G8DfuXxj9ozUCx=Y8+MMs194vWP2vo+w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix regression with CSR controllers
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, Oct 16, 2024 at 12:41=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Luiz,
>
>
> Thank you for the patch, and fixing the regression. Could
> short-transfers be mentioned in the summary/title to make it more specifi=
c?

Sure.

>
> Am 15.10.24 um 17:37 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > CSR controllers don't seem to handle short-transfer properly which caus=
e
> > command to timeout.
>
> The verb is spelled with a space: time out.
>
> Could you elaborate more? Why is starting a quirk list the right thing
> to do? It=E2=80=99s unlikely more controllers are affected?

Elaborate on what? USB short-transfer is a mandatory feature of USB, I
can quote the USB spec if that makes it clearer, now if there are more
controllers affected only time will tell since I don't think anyone
has a lab to validate these changes on all supported models by btusb
driver.

> For people using
> `git log --grep` the product name would be nice to have in the commit
> message:
>
> Product: BT DONGLE10
> Bus 001 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)

Ack

> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219365
> > Fixes: 7b05933340f4 ("Bluetooth: btusb: Fix not handling ZPL/short-tran=
sfer")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   drivers/bluetooth/btusb.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index c0b6ef8ee5da..f72218c1037e 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -1366,10 +1366,15 @@ static int btusb_submit_intr_urb(struct hci_dev=
 *hdev, gfp_t mem_flags)
> >       if (!urb)
> >               return -ENOMEM;
> >
> > -     /* Use maximum HCI Event size so the USB stack handles
> > -      * ZPL/short-transfer automatically.
> > -      */
> > -     size =3D HCI_MAX_EVENT_SIZE;
> > +     if (le16_to_cpu(data->udev->descriptor.idVendor)  =3D=3D 0x0a12 &=
&
> > +         le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D 0x0001)
> > +             /* Fake CSR devices don't seem to support sort-transter *=
/
>
> s*h*ort
>
> > +             size =3D le16_to_cpu(data->intr_ep->wMaxPacketSize);
>
> A warning would be nice to have so motivated users could bug Cambridge
> Silicon Radio to fix/improve their devices.

These are fake CSR dongles, there are many things wrong with them and
it is already warned when detected.

> > +     else
> > +             /* Use maximum HCI Event size so the USB stack handles
> > +              * ZPL/short-transfer automatically.
> > +              */
> > +             size =3D HCI_MAX_EVENT_SIZE;
> >
> >       buf =3D kmalloc(size, mem_flags);
> >       if (!buf) {
>
> Is Intel going to get such a device to add to a test lab?

Don't think we can get a hold of one of these dongles, they are not
really from CSR and they are really old as well, so I guess the only
option would be for someone to donate it or something.

>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
