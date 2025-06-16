Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30A204C1A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100202; cv=none; b=jnCC5mzi1yn+50HAMUf7w52s5nYxRvyFiCE+PHa4+SnmkVdUG/I8KauGHBU6nzAt9BAB7mw4HsKkZmFolYz0/6SEe+jXijoxkTJcPhHg+kRQyA8CN7RMxbgxg2m9cmXDvy1vSoboDc1j5DlwTcn0WDO0raGYK483d3BJiquwCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100202; c=relaxed/simple;
	bh=sC69cR1duFDkt5f3abuT1tybVur9scYxDp5Ayvg/YRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5wDGxySAMM4xJfemq/5LCkhGBkqnavYz8f0qq3A+FODlv4oSoakkcfHY32qz6ILeWaW1yjSq19OXAxdMVfHOtR7gjjoMXo4OgnzxFoF/PkRmzx8FEHcWopdtotJ6mIwHJVS+9GQ1MG+1zuxtNaPqvrLlK33j51+l5RsR4C6BD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWs9+5I5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWs9+5I5"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32918fe5334so44615911fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750100199; x=1750704999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj+aBHN3gpi2m1WqIkshOwbNMK5KP+vwS0K+L+jtZWo=;
        b=UWs9+5I5I9nhHrXRFYIC50d6Vd+i2Mxer3Wr5a+bNE8vS83i5cT1GgtH/CrDWrCDDu
         m1bkZL2gmguD1w5C+A355N6NkAPnj818mkHAESRCblzUzBpEwTa9V5u4weWZYzk4IRuv
         XsME+xN8gbjrSpzoe5aULcCbwXqKpZ4EGM2dpfGFntuVz4McDaNWkJMw8Zfr4JlGDRRU
         boUHBuz5PC6ZztlaILLLspITGhK6OqHLY01TOrIbA7E5hO9//Dfpwfu+jBb3mVrnL498
         JWNQQbUxqgEa4F+VTxYToEJ9UFymuN2z2TyNqYwmJybkkubWslFyF8X8gPCWcgpzh/to
         LZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750100199; x=1750704999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj+aBHN3gpi2m1WqIkshOwbNMK5KP+vwS0K+L+jtZWo=;
        b=ty2dhMvOUZ6ak5Af1Omd1pGFQOmWOMDQzsHOBtCChmnxYLTxmJXKj9o6pC6XFZZogw
         veg7+9ymXT+Ur+t/9ghxWJNRaQULnLCIErD0g2j2i+RKYEDB0YNkcWyzxPdcRGBJwziv
         4FYQGdgJr2YVbP7mTVqapaG1BVQi3DyiffTfjEo4oxxOc/RJFSzZfcdKNzzCQBc6EJ70
         8oQ4dh3jVkuWonP58qnwfXJeLRNeLNVuThemiLub9VSxwJ9cjoYgvcWuJylGO5iuosI5
         LxgQm7vXafVE80zsFJSW3CTi0+/lLBAt+7RC2lNM+LZe7jl1JJN1rXr3yBL6JrTwBRoV
         zKOw==
X-Forwarded-Encrypted: i=1; AJvYcCXlhdT2uhrTVmqORSANeIc+FIfmBymUMWkye56S+m4Cr9SoujPok/NG1w3YQRy6HfY/YeBhgTMQ2eJwxFPj43E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZvVfUxF2MgfJzkLlLRtPxxQlZFOEKR2TeVibjYHj7gIEp2FF
	Tqo3+7X7fArH8+dlzqeDIb9lyVGTjYg1U3sJ2SeiFzTWtH/yel9IZONvDULbQU6OnWGCxP+MFiF
	dwqDcQeygWDAv/w3kmn2rc5/aONo5gZwgVVSx
X-Gm-Gg: ASbGncttC9YumjECCoLqwZSnJJG4FuCsSR85ajQn5lW6QTAgxMoPl/r+AKtR23QBdjh
	47jrK5dx++SXup+0/iP/muiJDWq+kudoPrAvfEQapGHk0U1hPGCHXKpEdADYD3MMwHENd4WBIAY
	i+ItjH+m88WIcsoueOSFIIcXl0W3mG2kDUcVfbK1ndvQ==
X-Google-Smtp-Source: AGHT+IH8e/Q47uoX50emzyBNkZ8y3Hxrr+1Z+cT07A6sBOxJeq7jl5pIXpT6rN7ZrP4ZO2pSzCxMsAGh1xB+4SXmfJo=
X-Received: by 2002:a05:651c:1544:b0:32b:3b00:403a with SMTP id
 38308e7fff4ca-32b4a5cd232mr26803711fa.20.1750100198583; Mon, 16 Jun 2025
 11:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616173803.928382-1-kuni1840@gmail.com> <b964dbbad90d2561b28386d6d254048596d0897c.camel@iki.fi>
In-Reply-To: <b964dbbad90d2561b28386d6d254048596d0897c.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Jun 2025 14:56:26 -0400
X-Gm-Features: AX0GCFuy7ds1Td2GUAp9vPoxdRB6bW5l9Z2ReOzig-usr9FlIamp5sJT-0GsxuQ
Message-ID: <CABBYNZJ0Vggb5J68PBEkv3CzLBO7YoBrqcMvJ-tU_aMghVgBMQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
To: Pauli Virtanen <pav@iki.fi>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, linux-bluetooth@vger.kernel.org, 
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Kuniyuki,

On Mon, Jun 16, 2025 at 2:12=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > syzbot reported use-after-free in vhci_flush() without repro. [0]
> >
> [clip]
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 07a8b4281a39..d648b514e2df 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> >
> >  /* Get HCI device by index.
> >   * Device is held on return. */
> > -struct hci_dev *hci_dev_get(int index)
> > +static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
> >  {
> > -     struct hci_dev *hdev =3D NULL, *d;
> > +     struct hci_dev *hdev =3D NULL;
> >
> >       BT_DBG("%d", index);
> >
> > @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
> >               return NULL;
> >
> >       read_lock(&hci_dev_list_lock);
> > -     list_for_each_entry(d, &hci_dev_list, list) {
> > -             if (d->id =3D=3D index) {
> > -                     hdev =3D hci_dev_hold(d);
> > +     list_for_each_entry(hdev, &hci_dev_list, list) {
> > +             if (hdev->id =3D=3D index) {
> > +                     hci_dev_hold(hdev);
> > +                     if (srcu_index)
> > +                             *srcu_index =3D srcu_read_lock(&hdev->src=
u);
> >                       break;
> >               }
> >       }
> > @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
> >       return hdev;
> >  }
>
> If no list item has `hdev->id =3D=3D index`, doesn't this now return the
> list head -> crash?

Seems wrong to me as well, *d was used to hold the current entry but
that has been removed so hdev would be used instead which may return a
valid/non-NULL entry even when its index doesn't match. Btw, are there
any documentation regarding the usage of SRCU in such cases where
there are still references?

Usually the hci_unregister_dev is called by the driver to inform the
hardware has been unplugged from the system, so we do want to be able
to abort any ongoing usage of the hci_dev so in this particular case
perhaps it is easier to just check if HCI_UNREGISTER has been set
before attempting to flush.

>
> --
> Pauli Virtanen
>


--=20
Luiz Augusto von Dentz
