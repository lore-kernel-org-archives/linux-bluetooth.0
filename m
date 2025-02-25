Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2311862
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443240; cv=none; b=FPjdsPxO+9YRgflZoXIcdzKJ7XBCTV+fGUTb5+xrB7L/eg527f1EgUmnVnGO3xENdf5sj26kBHbEFjEljB4dnmkbhZ/irQYgXij6VhLBU5/Bypf0EmAw2BVN7ZM3kdtoiZNGr7Rolt2k1XjdUuXtmDAurOWbrgPmYjYdinVM/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443240; c=relaxed/simple;
	bh=bVWRYfwLbAFsHjrVs4R4uASR9/hA7e4a8l9nixwJzyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEeYc/DfRFoi/Xq26kWRLcPhFjjcYF9mxk4VYiOU042lKaiNw6LTbryGMG8fuiTRv7iqGr+MnltMVhDwuwSe9I4Zs1kHz/Wd4lJFwBxjjL5jckgaRiv2q255c/b+pep7EzSGpCWR8+uIe90LJMU3pt0W42jUoGVjy0U+qAhhpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maWJcI55; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maWJcI55"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so29635585e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 16:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740443237; x=1741048037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt40Ib9GHYhxi6Bk+bERlQ6F1Wi91BQmXvbXK2/CrBM=;
        b=maWJcI55BGMnaJRpypxn/zx8I4Q/6zgTFphTc5BJHUQv/2mmeqntoS9PxKLqdUkqBU
         gmrK6rKHx6utLdBq/defTtWQVYEwi6nbQC9vhPtTsvMBwqQwIvNWz5yQ2osRdFGaNp4o
         nhQk2U2WVuuta4HjvI680ATIsNao/jjoW9+TFDuZD/0I0LCIA84/nhzWzYKMBRlIWKa9
         Y+/svu76BwJP/EYxheltlrhqUlcubvakwGuJ8anOoFNoDKRUs0FqK7pT+01IMTABy/U5
         5JemgBBe366etfAjWV6JYAWvmv4c7PtIzey9wu06uDFX4DzXO0mMCe6E1kkT30RSOAfT
         dc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740443237; x=1741048037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mt40Ib9GHYhxi6Bk+bERlQ6F1Wi91BQmXvbXK2/CrBM=;
        b=pSnR0gebcb3DjFaFQB8x9tMFjbGaN8sPGmKlUwJzx9NsIHEv1SE1hNjkp8a3Q9JRMV
         dT/3Rrt9Rhs6eTWe8k1+NTHxEVu/HPeHRe1KCJpesC7DWcTN3RFbVP2iBE+Zt3p+a7h8
         AlZEV5W5BbSyu/fvOuWDQHkOk+gFGtyi6VDcetMlJ+9n/JIW/3a258KHmVj67SwpmP/D
         wMYjBRIL+85/wYaDFMjyF53wg98Scw0++rjxqhbjmC5LxDdLLNY0Q10gIlhXjddEh9+8
         fX4gT0zN58YepYHTzldv8K3W+j7YdHshJ9SXj6b7KyAfhoR8ZB1xt8e92SOlyA94PJ+h
         biYA==
X-Gm-Message-State: AOJu0YzXKXYNaLAEg46hQbSZqnvP1HBo0QF6BdZnXArpKFYvikgqeoxM
	tw8cTsgMKgsgV6MLJIv5zjLcBp9KSlItasVPBIa4EQYRl2k6xytUzsv9h2A+yTnqvACyS6u6x3r
	2Xl6BRA7u6fhGlIYws6xY648TzYQ=
X-Gm-Gg: ASbGncsqphEbQXPkISwgs1IvK21wn8gbovn8FQ28+/pv22u8KOGCS3Y4HtMMNOi5pCD
	q5fKS01VRv8dEgZ+GBrmHx178l93MTkv2nR5VjC93dVSKNlJqPBv8NxvgX7zSW23HPJ8IMvrhlP
	0BA7ie0UcS
X-Google-Smtp-Source: AGHT+IGYV+wtXpa0pM0EP/EXWM/+jHFfi+XwWLis68xmOEMeekaCmnA9Q3rwjBKUUtwfBJvuui8KmP5Vnv3FJzj/sgw=
X-Received: by 2002:a05:600c:4784:b0:439:8605:6d7c with SMTP id
 5b1f17b1804b1-439a2864c3cmr150391125e9.0.1740443236398; Mon, 24 Feb 2025
 16:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
 <20250224205439.18672-2-nishiyama.pedro@gmail.com> <CABBYNZKLPh48LqZjYboJ=6wEvRvdaEqu7Aykb5a_ONF1t0GCOw@mail.gmail.com>
In-Reply-To: <CABBYNZKLPh48LqZjYboJ=6wEvRvdaEqu7Aykb5a_ONF1t0GCOw@mail.gmail.com>
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Date: Mon, 24 Feb 2025 21:27:05 -0300
X-Gm-Features: AQ5f1JpDHDLPgxpk9egL9I-W1IrounUkgZlRrpS4N87AHQd_0wUn_iq9zYqtM4U
Message-ID: <CANoxumidPyvgUB5mKVmy0AAjU2AQOAXnbHByeZ5=RPK7pSoFDQ@mail.gmail.com>
Subject: Re: [V3 1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Feb 24, 2025 at 6:36=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pedro,
>
> On Mon, Feb 24, 2025 at 3:54=E2=80=AFPM Pedro Nishiyama
> <nishiyama.pedro@gmail.com> wrote:
> >
> > This adds quirks for broken READ_VOICE_SETTING and READ_PAGE_SCAN_TYPE.
> >
> > Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> > ---
> >  include/net/bluetooth/hci.h | 16 ++++++++++++++++
> >  net/bluetooth/hci_sync.c    |  6 ++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 0d51970d809f..b99818df8ee7 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -354,6 +354,22 @@ enum {
> >          * during the hdev->setup vendor callback.
> >          */
> >         HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
> > +
> > +       /* When this quirk is set, the HCI_OP_READ_VOICE_SETTING comman=
d is
> > +        * skipped. This is required for a subset of the CSR controller=
 clones
> > +        * which erroneously claim to support it.
> > +        *
> > +        * This quirk must be set before hci_register_dev is called.
> > +        */
> > +       HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
>
> Lets split this in 2 parts, one for voice setting and another for page
> scan type.
>
> > +       /* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE comma=
nd is
> > +        * skipped. This is required for a subset of the CSR controller=
 clones
> > +        * which erroneously claim to support it.
> > +        *
> > +        * This quirk must be set before hci_register_dev is called.
> > +        */
> > +       HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> >  };
> >
> >  /* HCI device flags */
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index dd770ef5ec36..e76012956020 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct hci_de=
v *hdev)
> >  /* Read Voice Setting */
> >  static int hci_read_voice_setting_sync(struct hci_dev *hdev)
> >  {
> > +       if (test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks=
))
> > +               return 0;
>
> While at it I'd add the checking for the bit as well, that said
> perhaps we need to disable SCO link if voice settings cannot be read,
> is the controller able to create SCO connections?

I did some tests on the version before the regression and with the patches.
It is possible to create an SCO connection, but the connection is not usabl=
e.
Before the regression there is no sound, and with the patches, dmesg
is spammed with "Bluetooth: hci0: corrupted SCO packet".

>
> >         return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTING,
> >                                      0, NULL, HCI_CMD_TIMEOUT);
> >  }
> > @@ -4132,6 +4135,9 @@ static int hci_read_page_scan_type_sync(struct hc=
i_dev *hdev)
> >         if (!(hdev->commands[13] & 0x01))
> >                 return 0;
> >
> > +       if (test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirk=
s))
> > +               return 0;
> > +
> >         return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE,
> >                                      0, NULL, HCI_CMD_TIMEOUT);
> >  }
> > --
> > 2.48.1
> >
>
>
> --
> Luiz Augusto von Dentz


--
Pedro Nishiyama
