Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1522540A
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597530; cv=none; b=iTor3EXMJQ5p0Q4dvSLv4b4KeCGtFDh+/AHL541So8q3ZB7LJZZ5u+dl5fVHInulHFcEskZtOn8PO0VeOiAvoEEMl8+09QsGG4fjeyjUg6b4jWzQl7jLvGjmGF3InOm6701TIIOBKTeDfsu8WaalEp9iq7Q8S5uShjrG0Jf/ASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597530; c=relaxed/simple;
	bh=yKQm604LQOV3O0yj6v1u69TXpyWodp2QQ3bMJhpvLRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gchRFvsl0TyF9WPBTT8j+XufQBmAF4qpDZDh/NyCDJlZy6z6mxmXOwazU9k1vU7cXWjrVkStWslAi8g+UnDkLbrcsa1ISaNanTNl+6RiBBfvV2MyIwPv+3tpkKe6vr1Sqf4kZf4tjp5rCydCqAi+TF2Ruo4B6ya/ZCceGw+ODN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn7RGGNJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn7RGGNJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43b5859d1f1so133395e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740597527; x=1741202327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB2Ey9RBWq0+dvbTM293eHPdY6WKj/n63lQyI9Op8IY=;
        b=Hn7RGGNJrgFJtk8RMjsnsspP7qBVbnO5LytL9JoAXnVR0OMr0UffdWvUNd2ulZ+Yf2
         C29tJo5Y0Z8m9UyMYzkxRSmdGcBz4fZG3wgyaQK8ix1nwqxATm6BhrwVWQPj2uXudQcS
         1XBAXgr+ZZOgF4jeWiqXnCkunyNIORr6ZYLdiy97dAIXsQ9uAWKvEFeOmuyrRNTax1WL
         hB0t2zepD9wo3GILa7xrDeVwHlIN7egpgYOzJEfqYVtS+Z89ZuItQd3m/+Xg6Yev7ZJT
         5QmM0wKOvIe7CEV7ptvU54olFXyWbwBRR+rNs55a2PdcZgPW0S4JdT8JQvvUngtzK11L
         2sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597527; x=1741202327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FB2Ey9RBWq0+dvbTM293eHPdY6WKj/n63lQyI9Op8IY=;
        b=v4TjZ6t254MyE45rEaBlVzD1bPMcYSKMvvIWMHQl19SvvaX+7hXJM6g08exOwL7bHV
         4DWlCzZ3MtcNTQyJnhVtnPO+bsNOkRlOhahJQ/yqqpXV+/7jB4ryiokkm0tGxAiraigs
         Tk2O4sgADQzDJDVXGuz86lmCS4T70sRssp8swBC9WWHshtPSmoZ6UZtAFn/aLVSy6E7H
         detQVN7xgJ5K75PJxNbGqhDiI6kVTA2lyuMJhGwvbc4Hd7dne0m3hfAHrpbKYRxnpiaV
         OHZ6yMtlCmUf4loKmoMZDB6MODhqh0pwZ8QZUfb6JHzVYF2RFzNjSlVvpOU6Eb/DAq15
         nnGQ==
X-Gm-Message-State: AOJu0Yz5fBVq85LGduVYya8ZV5O2V7eOQGZg3mJuOXLa7O2kRj162Plw
	Nq/3HsIB8SYdNXSMAr8ySh0DkVtXETFYYah9aeoViRg2gqtQnOgr7EpaXpdY55shhsnbrC4u8H0
	TsSOcxXShTW7286W0y6JWU0BFOSo=
X-Gm-Gg: ASbGncsIUm6Botw9tsKX8aIKkHbO4TPawwnASbV9d5No4Ronw0+88tP9Y4l1BwtlFK3
	fG1xcgnn+vXSI7HHyKAPVSQQzr5Og1XQnrrQgergJXXCBq1CqS9f511D7BnO6IhcSSCHRTQPdCo
	1k+xfsLo8B
X-Google-Smtp-Source: AGHT+IHMRSf6G0unQeUHMlwSiuna6/AtHkQ6F/tniUUWM+988aEil7FOlBKe2HIZvdmXH/0PxcFBx31brKgQKl+sEsA=
X-Received: by 2002:a5d:47c5:0:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-390df75de40mr2032115f8f.44.1740597527129; Wed, 26 Feb 2025
 11:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
 <20250224205439.18672-2-nishiyama.pedro@gmail.com> <CABBYNZKLPh48LqZjYboJ=6wEvRvdaEqu7Aykb5a_ONF1t0GCOw@mail.gmail.com>
 <CANoxumidPyvgUB5mKVmy0AAjU2AQOAXnbHByeZ5=RPK7pSoFDQ@mail.gmail.com> <CABBYNZKvXUzwTNVu97y72dEBMrFWALD8ksFQumLVWgjhKyeQ0Q@mail.gmail.com>
In-Reply-To: <CABBYNZKvXUzwTNVu97y72dEBMrFWALD8ksFQumLVWgjhKyeQ0Q@mail.gmail.com>
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Date: Wed, 26 Feb 2025 16:18:35 -0300
X-Gm-Features: AQ5f1JrnG5heIdj9mGEzIQTflZAwhaXb9bBiKobMUqVHMpKHduSHQ850FWxEiUE
Message-ID: <CANoxumhJYYnz4iSJKiq-c58hgEhtdMM-0JxS6iBOzaOWW3c-1w@mail.gmail.com>
Subject: Re: [V3 1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 25, 2025 at 12:55=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pedro,
>
> On Mon, Feb 24, 2025 at 7:27=E2=80=AFPM Pedro Nishiyama
> <nishiyama.pedro@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > On Mon, Feb 24, 2025 at 6:36=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Pedro,
> > >
> > > On Mon, Feb 24, 2025 at 3:54=E2=80=AFPM Pedro Nishiyama
> > > <nishiyama.pedro@gmail.com> wrote:
> > > >
> > > > This adds quirks for broken READ_VOICE_SETTING and READ_PAGE_SCAN_T=
YPE.
> > > >
> > > > Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> > > > ---
> > > >  include/net/bluetooth/hci.h | 16 ++++++++++++++++
> > > >  net/bluetooth/hci_sync.c    |  6 ++++++
> > > >  2 files changed, 22 insertions(+)
> > > >
> > > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hc=
i.h
> > > > index 0d51970d809f..b99818df8ee7 100644
> > > > --- a/include/net/bluetooth/hci.h
> > > > +++ b/include/net/bluetooth/hci.h
> > > > @@ -354,6 +354,22 @@ enum {
> > > >          * during the hdev->setup vendor callback.
> > > >          */
> > > >         HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
> > > > +
> > > > +       /* When this quirk is set, the HCI_OP_READ_VOICE_SETTING co=
mmand is
> > > > +        * skipped. This is required for a subset of the CSR contro=
ller clones
> > > > +        * which erroneously claim to support it.
> > > > +        *
> > > > +        * This quirk must be set before hci_register_dev is called=
.
> > > > +        */
> > > > +       HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
> > >
> > > Lets split this in 2 parts, one for voice setting and another for pag=
e
> > > scan type.
> > >
> > > > +       /* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE c=
ommand is
> > > > +        * skipped. This is required for a subset of the CSR contro=
ller clones
> > > > +        * which erroneously claim to support it.
> > > > +        *
> > > > +        * This quirk must be set before hci_register_dev is called=
.
> > > > +        */
> > > > +       HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> > > >  };
> > > >
> > > >  /* HCI device flags */
> > > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > > index dd770ef5ec36..e76012956020 100644
> > > > --- a/net/bluetooth/hci_sync.c
> > > > +++ b/net/bluetooth/hci_sync.c
> > > > @@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct hc=
i_dev *hdev)
> > > >  /* Read Voice Setting */
> > > >  static int hci_read_voice_setting_sync(struct hci_dev *hdev)
> > > >  {
> > > > +       if (test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->qu=
irks))
> > > > +               return 0;
> > >
> > > While at it I'd add the checking for the bit as well, that said
> > > perhaps we need to disable SCO link if voice settings cannot be read,
> > > is the controller able to create SCO connections?
> >
> > I did some tests on the version before the regression and with the patc=
hes.
> > It is possible to create an SCO connection, but the connection is not u=
sable.
> > Before the regression there is no sound, and with the patches, dmesg
> > is spammed with "Bluetooth: hci0: corrupted SCO packet".
>
> Then perhaps we should disable SCO support if it doesn't support read
> voice settings.

I'm having some trouble disabling SCO. We can't add BTUSB_BROKEN_ISOC
to the drivers quirks because not all 0a12:0001 are clones with broken
READ_VOICE_SETTING.
The fake identification is done after the btusb_probe, and we set up
the isoc during the btusb_probe.
I'm not sure if removing the isoc device file and releasing its
interface in the hdev->setup is actually safe.

>
> > >
> > > >         return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTIN=
G,
> > > >                                      0, NULL, HCI_CMD_TIMEOUT);
> > > >  }
> > > > @@ -4132,6 +4135,9 @@ static int hci_read_page_scan_type_sync(struc=
t hci_dev *hdev)
> > > >         if (!(hdev->commands[13] & 0x01))
> > > >                 return 0;
> > > >
> > > > +       if (test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->q=
uirks))
> > > > +               return 0;
> > > > +
> > > >         return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TY=
PE,
> > > >                                      0, NULL, HCI_CMD_TIMEOUT);
> > > >  }
> > > > --
> > > > 2.48.1
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> > --
> > Pedro Nishiyama
>
>
>
> --
> Luiz Augusto von Dentz
