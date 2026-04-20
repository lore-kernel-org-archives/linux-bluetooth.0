Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1163238236A
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718881; cv=pass; b=MweQD5lgXm22Q4YKKXytknbE/t2Rmxiqd3kftZAcqRPH4jDt9s55qKv1MtjJZ2hzI6qfxi7/eB3U6EaIszi7BhMoa6oXO2ker4sJO+87xknN7RqxwDZIWduvwe4T1taVf1VKLCP4jxeQ4fJei3oZM2tEPlZJOB4mr9EnUkVC6XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718881; c=relaxed/simple;
	bh=Lsf4Okv7HTZ9iAe42dNp3+jzOjC3Qh23Ohn3Z8Wfwwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufr9um3MnKvULPZPUyVBvAfw3yFY6ChMsdmmnf+b97sEg7GEn6ktQ79t9CcxR2IGq9fBWW7OTG+/FbNtznxjyBHAN2i4s2jc5+Q6NktRrY8MLAhKInJ77kBaQtafZJnylIAjCoePjRRV3pC5/iFEHixMNemcENrsdODWqKVwWDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5KwwPWH; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5KwwPWH"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501c4857b2so2418514d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 14:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776718879; cv=none;
        d=google.com; s=arc-20240605;
        b=HD+abxmNqZYHuNB+Rk84YGEZmG89rkyugS7psb4pzYS4tvqTZpUypZkBUbe0L0XSaq
         Dpz3GHVezp7yghDznjVhIDlRUztc5+gckYq2RKJ1CipLgheX6Xs1uIoL8Kew6/vMLINL
         JtFNBe3lKKMbwOQW72DvUjglHYy9TNWM2qdxvA3m6lXsz3XIjZ9oiMeX1SruU4bM8f6B
         udIRrZIn262ULv1qspAyC/IGliZRX/z0I1Y/1GsnaQbbgSEncRG5T/ZEvw2KPyaSw39G
         p4gd/eYN7067QVnTzMRF1xKIqAJBngmSTCcEG/6p+BpG2FNx2mACNmFZHmVoZEcVaUnT
         b/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZAtYVlmHPuRBFzYaYlufiDG5fXwqf8W0W5SccwCY8Yc=;
        fh=pH8pu1PmjzKFq6S4GXYQFBuT1crio9cszpcIk3VsxcU=;
        b=b1BJG7ju7/GoluLYwq3s/R362g/0w/iefaytZwXSi2aoaU2RaC+2XAFSXB8JBUxINk
         n6U+bQfdEjqvZitbsJwMPZ4x5OZb+YdzFNDtzii5jZmmd6ZeiF+5tySCrBBl7aMpaZNo
         khVXoGqw2XgRkl4X4KtiJn7LorYWGgHzqws5YZnGccrAt/jhng/VmZi7Fw4fKsTYe0MW
         UqXkuGQhTT4ePx7DufG3+LLb3JV2pS2PhoCwSavwgPP+TG/GMvJW12GKrFFhfdszIbmu
         amyThkdrT54ANYG4rnElGsX42jU+cR+DTLg6KwYK15QaSj/oEbiBlezK8xfem9473Hcw
         k7xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776718879; x=1777323679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAtYVlmHPuRBFzYaYlufiDG5fXwqf8W0W5SccwCY8Yc=;
        b=R5KwwPWHydbhXfZlhL0WSblv1Zu7ZZn7R/WHMuMSlphaHs53lX5qYHcl/Xo/6tZKfU
         phjKqyoYBohgPWqK+ymkyGOWky+UI05SyCv11xLUVSVEOyFYT3WWVPGvtAS5GI3C4R3W
         AHjal+UijLbD4fCk2wqhYHrYUZ6f6BjZH4MGJuA92yTaRWoLdNMVaCPROgOI78UZJh97
         wSIVLRAj4s9sDSSvHJzoxRDkaNhwAhBCvpEFfnN5merByxqyy9VvKhgL9AV6retH7IL2
         IM5fto+1N7tPtOdPTxrNw7Q71UveRfpQfvWol9tMglEVCVeGwl/cOLphJDoqqKOUAHuZ
         Xgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776718879; x=1777323679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZAtYVlmHPuRBFzYaYlufiDG5fXwqf8W0W5SccwCY8Yc=;
        b=fSKotH3w2U7JjAnHsVTGaMaQla55v+HPT44EdGtI2I1MrlTnPNoI0poshJbhLTbAqZ
         k5u6LSks9j6QbrBLrMNGAyZuhO+sM1+PJV5Z0xvwSVahv+Eh8Nopi7XG/StM+Oocvq8u
         gtgb4HqSmAwV24XmWMcg6L0wR4fG1eWVma/Nq2ZrPnpISyoUYrWCDEOwsOmsMj/Oj+rj
         097HunLP5yCegUF2F/+xVGlL6xqxq5K9ayL3VLH//PKNjY/7j4meU2T+FHwZlg6roIeH
         4poxqeGujzGm/R36eCswuT2qfR0q2O8vHsDL0I5CLvwJyHC1joH092/8baU6lZpIhsdW
         +yMg==
X-Forwarded-Encrypted: i=1; AFNElJ/LgZd75fv6szk92EdvvCkBzQxYhg9hsp+P8ife/LHkx+oPZu34N9Jh09qvDn39jrAKTMozmrAQr2EePKjAAMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5CycOBUhiFDLrM6ttWfWd5876AoK9c2Sl+NR/D+aYBX7WLN0
	MadORQkBijkhXCrTqbp0VXmJXjBd69py8eOZ2BeCd++gvnoCGmwXB3chU5FZMF/9xzCxXyde0Qj
	daEy/z1mGQ3mD7qqJ1vyldtzWIsVWPs0=
X-Gm-Gg: AeBDieucAktfyf2BgfuioXgyiYntGS1t8mMzi9JtSk1ahuiCgm7Xh4G62Qm/oA6JcjQ
	O8CLYh3Ul2+2OEYNmdF9rmws15hhwyW1nZ0mrh7wBtEUkdqc8PoqvqX6v5S17uSXEPDJK0CRL9e
	tlcK0RxdKP+TmGkpJd7pgMHAvBg2p2uT6HoFn0HwXv9s4rD0UhHcXjgyG15I44szR9VMwSPRncP
	3wjrFYu2WkPgQtH9n9QQvfQ4JG97QZ9+cr+woDaENgW0Org7W1Z7v3FgvyOvTX6PB5s2tpCtJWz
	9O6tmuM9PO3gRNeuvZRfMhoHzUPpfEjekWXqa8eQBx3pXbxMAcJ8/RGpHEXWjCW2o64yi7sC/PH
	M8Hr6
X-Received: by 2002:a05:690e:2497:b0:652:ddea:11f1 with SMTP id
 956f58d0204a3-653109fa092mr10645816d50.30.1776718878929; Mon, 20 Apr 2026
 14:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419072433.55976-1-condorachest@gmail.com>
 <8961a9ba3e4a48eaa33060114366573439bbf73f.camel@iki.fi> <c4593a49ef6ed7151eceebfd22d602a0d018e9f5.camel@hadess.net>
In-Reply-To: <c4593a49ef6ed7151eceebfd22d602a0d018e9f5.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 17:01:07 -0400
X-Gm-Features: AQROBzBoKrL7YVfwOKDoxYz2FcarMoWIRwqAtb6MmYv8uApZgeXg81jczeAHg5Y
Message-ID: <CABBYNZK=fnu9sWLPKwGSi+N2ebLVNB-4MJzM58ScOH7_HhDYRQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED for
 combo chips
To: Bastien Nocera <hadess@hadess.net>
Cc: Pauli Virtanen <pav@iki.fi>, StefanCondorache <condorachest@gmail.com>, linux-bluetooth@vger.kernel.org, 
	marcel@holtmann.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Mon, Apr 20, 2026 at 5:08=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Sun, 2026-04-19 at 13:35 +0300, Pauli Virtanen wrote:
> > Hi,
> >
> > su, 2026-04-19 kello 10:24 +0300, StefanCondorache kirjoitti:
> > > Realtek combo chips share a single antenna between Wi-Fi and
> > > Bluetooth.
> > > Background LE passive scanning while an active connection exists
> > > causes
> > > antenna multiplexing conflicts via Packet Traffic Arbitration
> > > (PTA),
> > > resulting in audio stuttering and Wi-Fi packet loss.
> > >
> > > Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED to suppress passive scanning
> > > in
> > > hci_update_passive_scan_sync() when active connections are present.
> > > Set this quirk for all Realtek devices in btrtl_set_quirks().
> >
> > Some general questions on this, which are not immediately apparent
> > from
> > the commit message:
> >
> > How is it know which Realtek models have this bug?
> >
> > Which ones were tested?
> >
> > Is it better to set the quirk for all Realtek devices than do it per
> > USB id / chipset for each known bad device?
>
> I worked on the rtl8723bs Wi-Fi driver in a previous life (so much so
> that I can spell out the model number on top of my head), and I
> remember it having code for BT/Wi-Fi coexistence.
>
> Is this only a problem with the lack of BT/Wi-Fi coexistence support in
> the upstream Linux drivers (eg. not in the Realtek vendor drivers)
>
> How do you actually test this in a reliable and reproducible way? How
> will we know to remove this quirk?
>
> > > Also add device ID 0x0bda:0xc829 to the btusb Realtek device table.
> >
> > Patches adding USB device ids usually have USB info from
> > /sys/kernel/debug/usb/devices in the commit message, see other
> > patches
> > add these. Probably should be separate patch?
> >
> > > Signed-off-by: StefanCondorache <condorachest@gmail.com>
> > > ---
> > >  drivers/bluetooth/btrtl.c   |  6 ++++++
> > >  drivers/bluetooth/btusb.c   |  2 ++
> > >  include/net/bluetooth/hci.h | 11 +++++++++++
> > >  net/bluetooth/hci_sync.c    |  7 +++++++
> > >  4 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > > index 62f9d4df3a4f..00dfba656970 100644
> > > --- a/drivers/bluetooth/btrtl.c
> > > +++ b/drivers/bluetooth/btrtl.c
> > > @@ -1299,6 +1299,12 @@ EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> > >
> > >  void btrtl_set_quirks(struct hci_dev *hdev, struct
> > > btrtl_device_info *btrtl_dev)
> > >  {
> > > +   /* Realtek combo chips share the antenna between Wi-Fi and
> > > +    * Bluetooth. Suppress passive scanning while connected to
> > > +    * prevent coexistence issues.
> > > +    */
> > > +   hci_set_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED);
> >
> > This sets the quirk for all Realtek chips.
> >
> > Realtek chips are also in stuff like Bluetooth USB dongles that are
> > not
> > combo wifi ones. Can they be identified?

Yeah, this needs to be detectable and not just set to all Realtek
chips, actually I don't think even with quirk this would actually be a
good solution because that would limit the number of connected device
to 1 since otherwise the user would have to manually connect its
device once anything is connected, which will probably cause a lot of
furstration to say least.

> >
> > > +
> > >     /* Enable controller to do both LE scan and BR/EDR inquiry
> > >      * simultaneously.
> > >      */
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 5f57953393be..87972f5fc567 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -516,6 +516,8 @@ static const struct usb_device_id
> > > quirks_table[] =3D {
> > >     /* Realtek 8822CU Bluetooth devices */
> > >     { USB_DEVICE(0x13d3, 0x3549), .driver_info =3D BTUSB_REALTEK
> > > |
> > >
> > > BTUSB_WIDEBAND_SPEECH },
> > > +   { USB_DEVICE(0x0bda, 0xc829), .driver_info =3D BTUSB_REALTEK
> > > |
> > > +
> > > BTUSB_WIDEBAND_SPEECH },
> > >
> > >     /* Realtek 8851BE Bluetooth devices */
> > >     { USB_DEVICE(0x0bda, 0xb850), .driver_info =3D BTUSB_REALTEK
> > > },
> > > diff --git a/include/net/bluetooth/hci.h
> > > b/include/net/bluetooth/hci.h
> > > index 572b1c620c5d..8466dc52aeca 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -378,6 +378,17 @@ enum {
> > >      */
> > >     HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> > >
> > > +   /* When this quirk is set, the controller suppresses
> > > passive LE
> > > +    * background scanning while an active connection exists.
> > > +    * This is required for combo chips with shared Wi-
> > > Fi/Bluetooth
> > > +    * antennas to prevent coexistence issues causing audio
> > > drops
> > > +    * and Wi-Fi packet loss.
> > > +    *
> > > +    * This quirk can be set before hci_register_dev is called
> > > or
> > > +    * during the hdev->setup vendor callback.
> > > +    */
> > > +   HCI_QUIRK_NO_SCAN_WHILE_CONNECTED,
> > > +
> > >     __HCI_NUM_QUIRKS,
> > >  };
> > >
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index fd3aacdea512..5e30e725efa2 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -3194,6 +3194,13 @@ int hci_update_passive_scan_sync(struct
> > > hci_dev *hdev)
> > >     if (hdev->discovery.state !=3D DISCOVERY_STOPPED)
> > >             return 0;
> > >
> > > +   /* If the controller requires no scanning while connected,
> > > +    * suppress passive scanning when an active connection
> > > exists.
> > > +    */
> > > +   if (hci_test_quirk(hdev,
> > > HCI_QUIRK_NO_SCAN_WHILE_CONNECTED) &&
> > > +       !list_empty(&hdev->conn_hash.list))
> > > +           return 0;
> > > +
> >
> > Does this break initiating connections via hci_connect_le_scan() if
> > another connection is active?
> >
> > Is it possible to make more than one LE connection simultaneously?

Yeah, I think it breaks even when a user initiates a connection, so
I'm afraid we need feedback from the Realtek engineers on how to
address this properly on their controllers, not that sashiko found
many of the points already described here, and some more, which
further reinforces that we shouldn't just take these changes in as
they are:

https://sashiko.dev/#/patchset/20260419072433.55976-1-condorachest%40gmail.=
com

> >
> > >     /* Reset RSSI and UUID filters when starting background
> > > scanning
> > >      * since these filters are meant for service discovery
> > > only.
> > >      *



--=20
Luiz Augusto von Dentz
