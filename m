Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522B13CFA6
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498920; cv=none; b=oomqWUoQtxOtoYV1guEWP+wIpUNz9Tty3dw2QlqaGiZbbm3aRTrDSe1GwDphzL24pN6ULlECep7aOlomH/ZJX+tPkKN7sP2cTVjhJdNyXciXeENc8uD/vip5DYMS3VkWQ0Z+Z5y9uG6Oc6H/3ZNBilPRc1FuAPojKUh2QQowgh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498920; c=relaxed/simple;
	bh=ny6prnD7gE53OHF2Cpyxc6rhK4xf+SVaa6JsTJAYs7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHmq5xvOSfO/zjcbXhRU46DXW+JJizACbGsScAPv1yyEVAsM2fV6Jei4UUCiHGKp6pwVukjvedX56p7vgN2LCueDpiUvmzNJXnRJh5xp36N6EHENePwacE8I61xgKF4w9dgjrIWIpu+0iVkKzbFwOjJe35ovKoaF3oRZ7AjTFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCrX/VAK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCrX/VAK"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a29f4bd43so51712521fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740498917; x=1741103717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIpdDvrxx+VeLnYeV2akmD6/+PA136xAIkm267GiExk=;
        b=NCrX/VAKwVcAQIzDffzNBcw7N1x61YBCclKySGAVxmEETWXyBqpC5h/nts7Aw1AsSz
         XmzTazh9sFWR745H+J71tu/b41V5J6CCD+SDA2UHL3CSc9TiQ6M2nnO/OHaebeSSzWSH
         8VCBw6TIO8X1wpuXzVPkC9IH7rBbvovEPIDKXnByZ5BVMYPrJtUjzrL3b/JNN80N7AdE
         kWbS36x5xwr5SvbiCNAAyYZaJA0178mF5t4JKeO2OvWwczpKtdcMsbhgi9wpIYAVbEZ3
         HEulsVymwKBU3MxvjJSWxxHDvolvMsECKTBKQFAw9xmTXrd9zHvug7jbUMundeV9s/QA
         M+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498917; x=1741103717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIpdDvrxx+VeLnYeV2akmD6/+PA136xAIkm267GiExk=;
        b=Dxmu2H2Pm7SndeK47rTA5ujt+94MhGOmUi6l8NPI1/A+xkq5MtQ4vMuRntLdsiFANR
         f3JiVasyp1qQTxd9YAh9fiQ9hNnnhB0qwO2lV1fm8uogh09ppxE/+JGquAkyAIaf4n3A
         h+FE3KrjysYPRLajSp/oR8UBhRmvs6wbNDkx6hHH0ZCXFpg8rxA80Nz+mRjbTvFVTdel
         X8ms2kXw+AZf7im5AO1PW/oWNB/Z7AJ3OKNhrymGS5e2sYPP2PImnQ4NZ3xyaDmydYJW
         358k/fXssTSxqhe7S0amQhgoK74CSVuKZh5PmxCxmCJIzrCjH643VfU4LNQPkUtPFgq+
         l70g==
X-Gm-Message-State: AOJu0YyW0ii/wNUvO6PW4eceYeqPAwWqELA1meIVoNwEP3urTvWTno4V
	WZviJFrh0dtzV8DGzfIU9r22PZ5gDFicQ54SZ7yW5Rrqrn1xC8UUf+F7VfmcZe3c0uj335I9txh
	JEZQfxs1xAvcf35bTNBsYIQeYn2w=
X-Gm-Gg: ASbGnctTHpMr3n+S+QoDSvvwphTp8dntOY5ABeKW4rtXjV9S+bDAyQceC9gyOszQ92t
	AaddwYuHNUdjQfinVHTHW3J00UVh4ZEXwQ6fUDZFBHIyb+BCnmA69LH/2G4K1USjTVkn5Rr+g7l
	NU1WKqYQ==
X-Google-Smtp-Source: AGHT+IHvfOSBvailzxoLPH8MY3O2q23sCvs+ApzqZ0TC8gFtEOTbHq9xLGJzRjBC6ZIfnRsyl/nsniz1RXibUwXPQtw=
X-Received: by 2002:a2e:a9a6:0:b0:308:f860:7e8 with SMTP id
 38308e7fff4ca-30b79184c47mr692221fa.20.1740498916640; Tue, 25 Feb 2025
 07:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
 <20250224205439.18672-2-nishiyama.pedro@gmail.com> <CABBYNZKLPh48LqZjYboJ=6wEvRvdaEqu7Aykb5a_ONF1t0GCOw@mail.gmail.com>
 <CANoxumidPyvgUB5mKVmy0AAjU2AQOAXnbHByeZ5=RPK7pSoFDQ@mail.gmail.com>
In-Reply-To: <CANoxumidPyvgUB5mKVmy0AAjU2AQOAXnbHByeZ5=RPK7pSoFDQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Feb 2025 10:55:03 -0500
X-Gm-Features: AQ5f1Jo5AXZaJkwyJb1zablEhVwSQp7YL-54IelLZuWSXZrW2oEagTcmSqmtfXE
Message-ID: <CABBYNZKvXUzwTNVu97y72dEBMrFWALD8ksFQumLVWgjhKyeQ0Q@mail.gmail.com>
Subject: Re: [V3 1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro,

On Mon, Feb 24, 2025 at 7:27=E2=80=AFPM Pedro Nishiyama
<nishiyama.pedro@gmail.com> wrote:
>
> Hi Luiz,
>
> On Mon, Feb 24, 2025 at 6:36=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Pedro,
> >
> > On Mon, Feb 24, 2025 at 3:54=E2=80=AFPM Pedro Nishiyama
> > <nishiyama.pedro@gmail.com> wrote:
> > >
> > > This adds quirks for broken READ_VOICE_SETTING and READ_PAGE_SCAN_TYP=
E.
> > >
> > > Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> > > ---
> > >  include/net/bluetooth/hci.h | 16 ++++++++++++++++
> > >  net/bluetooth/hci_sync.c    |  6 ++++++
> > >  2 files changed, 22 insertions(+)
> > >
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.=
h
> > > index 0d51970d809f..b99818df8ee7 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -354,6 +354,22 @@ enum {
> > >          * during the hdev->setup vendor callback.
> > >          */
> > >         HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
> > > +
> > > +       /* When this quirk is set, the HCI_OP_READ_VOICE_SETTING comm=
and is
> > > +        * skipped. This is required for a subset of the CSR controll=
er clones
> > > +        * which erroneously claim to support it.
> > > +        *
> > > +        * This quirk must be set before hci_register_dev is called.
> > > +        */
> > > +       HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
> >
> > Lets split this in 2 parts, one for voice setting and another for page
> > scan type.
> >
> > > +       /* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE com=
mand is
> > > +        * skipped. This is required for a subset of the CSR controll=
er clones
> > > +        * which erroneously claim to support it.
> > > +        *
> > > +        * This quirk must be set before hci_register_dev is called.
> > > +        */
> > > +       HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> > >  };
> > >
> > >  /* HCI device flags */
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index dd770ef5ec36..e76012956020 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct hci_=
dev *hdev)
> > >  /* Read Voice Setting */
> > >  static int hci_read_voice_setting_sync(struct hci_dev *hdev)
> > >  {
> > > +       if (test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quir=
ks))
> > > +               return 0;
> >
> > While at it I'd add the checking for the bit as well, that said
> > perhaps we need to disable SCO link if voice settings cannot be read,
> > is the controller able to create SCO connections?
>
> I did some tests on the version before the regression and with the patche=
s.
> It is possible to create an SCO connection, but the connection is not usa=
ble.
> Before the regression there is no sound, and with the patches, dmesg
> is spammed with "Bluetooth: hci0: corrupted SCO packet".

Then perhaps we should disable SCO support if it doesn't support read
voice settings.

> >
> > >         return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTING,
> > >                                      0, NULL, HCI_CMD_TIMEOUT);
> > >  }
> > > @@ -4132,6 +4135,9 @@ static int hci_read_page_scan_type_sync(struct =
hci_dev *hdev)
> > >         if (!(hdev->commands[13] & 0x01))
> > >                 return 0;
> > >
> > > +       if (test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->qui=
rks))
> > > +               return 0;
> > > +
> > >         return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE=
,
> > >                                      0, NULL, HCI_CMD_TIMEOUT);
> > >  }
> > > --
> > > 2.48.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
> --
> Pedro Nishiyama



--=20
Luiz Augusto von Dentz
