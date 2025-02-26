Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21538243952
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598948; cv=none; b=XaEG+SBLBdGW+X6e+qH/OOl7EPJpa1+S/3YsS6PD7+iVZQ9HUpEqhW4sU9i+O4wUsi1cLOZBdHskYnqfO1ZiRRMGfEobYFcTBU4SvlPVq9vQV1P/Rfih22T99eUlCOBxzG+0b2BIO+8JxYv5XmJcCyKRHbEifUlwnjpCjr6oFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598948; c=relaxed/simple;
	bh=uB2Jvc8xVumMU743+56/6RTSfjiMC8VXuUaZMXWG+s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK4jlvhgPSzxVQ0nYW62URJUFY0dZYBcW3lgqLdONjCE4UmdaYwST1UOKeQdK1pm947F1pLzrvQ7YOxHlN7DbzqIb5evyidgQdFU2rR5jH0VhJwi2dzcOxopBm3D85w17fhv0j1y/1qVPAWiOZE5Y8Rwe0N0rxltnIhqvvssscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT6wL34w; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT6wL34w"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a59so2280711fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 11:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740598945; x=1741203745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksdZCZ1u/vxJkG3nxgH12+F581RLUydNFa0Q9CtW8BA=;
        b=VT6wL34w6zEDYA2rqROR0EqnMGCuLCJLrvF/R+ce+8LIsb2VTMClVYe2thtg6e/lIL
         ghB7V2c26punDUNLTtZOJNuhR0RBZRG1vza6pS0sx9jbm/NVQQoEzfV+/RWMy/5B/6HR
         te0Hx/01hkQTZh0Ptdxb2aLwlM35WvP/T37eLO6pWLVW+oGk74QujTCy95gWIubuUclR
         0LsgblGZqkXBN7bDFUC5g3TBuzY0EL//oZmtdlibznmZPrCSHq7KKF/zi35GjWHL1AyO
         s/PEH0OaaoT83A0AJY0oyukkLbUK8wAc6uJmGgnR/TzHHbnDlUtWYVpwGkwAKIuU/hZ5
         /V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598945; x=1741203745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksdZCZ1u/vxJkG3nxgH12+F581RLUydNFa0Q9CtW8BA=;
        b=AjvrspbTfCNeEEVN0crrFNNDbEsUPRPKEowWAShHCW01Y5kdbuulQVMsYy5C0dEIB2
         eFyEcS333+3l2JBpAn+UXt/WHoub2BJIFajk6OE0Daj8AhLBynYDu5OuIF0VzRsH7tq0
         0k6RHxUljmeRBuSciisoCYAmG0YF55eErd2nplhcEKdAiiMwjejEx+8qSe7bDYcd3kSo
         IB2GotdIKkyVOgWf2Cf1l/F/qlaV8BHBflm6Ktz9EqyYIlFICKqEDKnq8EaPCiZ52dfq
         wmDs63vP5EgOKg0DSwbTwjOYI9EZZrODbiTJTXf3a0aoaWnPLGt78fv4ROU1kYbtnMoK
         7D5w==
X-Gm-Message-State: AOJu0Yzr+AqYMUtqJSE8RvT+0BdWJXDKLSNW8S7ehs546BiWpDOPUfKN
	0zEntxLYoKYYOI3BCN5Q+0DeUVKIXB8jshkSQBGerca+BIkr0EJZcP1G+GxkghuIiPqs/2FjBqh
	v29PbvmvjlU0BGouNIRuN/sb4lrnjYFM09Pk=
X-Gm-Gg: ASbGncvZeKWv8zNIr7lCSl5bppsRjxCQyjNreox/F5mEFxgHdknLc3GP7tjiXRMxVgQ
	O3ou15sC9piG93veYL+x54SZttrfCidi7kW4jLgV2T/kLT/eI9EJnvlIC/++ztlYxGj5JGHeWAY
	STd04uIA==
X-Google-Smtp-Source: AGHT+IH1HeRWdWnwP9xvmT9HP6rsWM4nw2H75Aqcv9cA+lrN5iWmFeh1SZhhbYcOvPBBlVwLQhcdMIn7I64h5/fQWpQ=
X-Received: by 2002:a2e:6a13:0:b0:308:fd11:7700 with SMTP id
 38308e7fff4ca-30b79184946mr29523381fa.20.1740598944823; Wed, 26 Feb 2025
 11:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
 <20250224205439.18672-2-nishiyama.pedro@gmail.com> <CABBYNZKLPh48LqZjYboJ=6wEvRvdaEqu7Aykb5a_ONF1t0GCOw@mail.gmail.com>
 <CANoxumidPyvgUB5mKVmy0AAjU2AQOAXnbHByeZ5=RPK7pSoFDQ@mail.gmail.com>
 <CABBYNZKvXUzwTNVu97y72dEBMrFWALD8ksFQumLVWgjhKyeQ0Q@mail.gmail.com> <CANoxumhJYYnz4iSJKiq-c58hgEhtdMM-0JxS6iBOzaOWW3c-1w@mail.gmail.com>
In-Reply-To: <CANoxumhJYYnz4iSJKiq-c58hgEhtdMM-0JxS6iBOzaOWW3c-1w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Feb 2025 00:42:11 +0500
X-Gm-Features: AQ5f1Jq6vu9ncHCqBKpDyA1nGJc5P9QuLGpT4tAgaBpG9T41tP3jnpNsm2TujFc
Message-ID: <CABBYNZ+bAQD_g7Nx0ttXX9O=mGNMM-tHxc3w4U6+fBZkjb3YFg@mail.gmail.com>
Subject: Re: [V3 1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro,

On Wed, Feb 26, 2025 at 2:18=E2=80=AFPM Pedro Nishiyama
<nishiyama.pedro@gmail.com> wrote:
>
> Hello,
>
> On Tue, Feb 25, 2025 at 12:55=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Pedro,
> >
> > On Mon, Feb 24, 2025 at 7:27=E2=80=AFPM Pedro Nishiyama
> > <nishiyama.pedro@gmail.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Mon, Feb 24, 2025 at 6:36=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Pedro,
> > > >
> > > > On Mon, Feb 24, 2025 at 3:54=E2=80=AFPM Pedro Nishiyama
> > > > <nishiyama.pedro@gmail.com> wrote:
> > > > >
> > > > > This adds quirks for broken READ_VOICE_SETTING and READ_PAGE_SCAN=
_TYPE.
> > > > >
> > > > > Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> > > > > ---
> > > > >  include/net/bluetooth/hci.h | 16 ++++++++++++++++
> > > > >  net/bluetooth/hci_sync.c    |  6 ++++++
> > > > >  2 files changed, 22 insertions(+)
> > > > >
> > > > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/=
hci.h
> > > > > index 0d51970d809f..b99818df8ee7 100644
> > > > > --- a/include/net/bluetooth/hci.h
> > > > > +++ b/include/net/bluetooth/hci.h
> > > > > @@ -354,6 +354,22 @@ enum {
> > > > >          * during the hdev->setup vendor callback.
> > > > >          */
> > > > >         HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
> > > > > +
> > > > > +       /* When this quirk is set, the HCI_OP_READ_VOICE_SETTING =
command is
> > > > > +        * skipped. This is required for a subset of the CSR cont=
roller clones
> > > > > +        * which erroneously claim to support it.
> > > > > +        *
> > > > > +        * This quirk must be set before hci_register_dev is call=
ed.
> > > > > +        */
> > > > > +       HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
> > > >
> > > > Lets split this in 2 parts, one for voice setting and another for p=
age
> > > > scan type.
> > > >
> > > > > +       /* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE=
 command is
> > > > > +        * skipped. This is required for a subset of the CSR cont=
roller clones
> > > > > +        * which erroneously claim to support it.
> > > > > +        *
> > > > > +        * This quirk must be set before hci_register_dev is call=
ed.
> > > > > +        */
> > > > > +       HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> > > > >  };
> > > > >
> > > > >  /* HCI device flags */
> > > > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > > > index dd770ef5ec36..e76012956020 100644
> > > > > --- a/net/bluetooth/hci_sync.c
> > > > > +++ b/net/bluetooth/hci_sync.c
> > > > > @@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct =
hci_dev *hdev)
> > > > >  /* Read Voice Setting */
> > > > >  static int hci_read_voice_setting_sync(struct hci_dev *hdev)
> > > > >  {
> > > > > +       if (test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->=
quirks))
> > > > > +               return 0;
> > > >
> > > > While at it I'd add the checking for the bit as well, that said
> > > > perhaps we need to disable SCO link if voice settings cannot be rea=
d,
> > > > is the controller able to create SCO connections?
> > >
> > > I did some tests on the version before the regression and with the pa=
tches.
> > > It is possible to create an SCO connection, but the connection is not=
 usable.
> > > Before the regression there is no sound, and with the patches, dmesg
> > > is spammed with "Bluetooth: hci0: corrupted SCO packet".
> >
> > Then perhaps we should disable SCO support if it doesn't support read
> > voice settings.
>
> I'm having some trouble disabling SCO. We can't add BTUSB_BROKEN_ISOC
> to the drivers quirks because not all 0a12:0001 are clones with broken
> READ_VOICE_SETTING.
> The fake identification is done after the btusb_probe, and we set up
> the isoc during the btusb_probe.
> I'm not sure if removing the isoc device file and releasing its
> interface in the hdev->setup is actually safe.

Well I was not thinking of disabling the ISOC endpoint if that is what
you meant by adding BTUSB_BROKEN_ISOC, but disabling/fail the creation
of SCO sockets in the above layers if we detect the read voice setting
is not working.

> >
> > > >
> > > > >         return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETT=
ING,
> > > > >                                      0, NULL, HCI_CMD_TIMEOUT);
> > > > >  }
> > > > > @@ -4132,6 +4135,9 @@ static int hci_read_page_scan_type_sync(str=
uct hci_dev *hdev)
> > > > >         if (!(hdev->commands[13] & 0x01))
> > > > >                 return 0;
> > > > >
> > > > > +       if (test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev-=
>quirks))
> > > > > +               return 0;
> > > > > +
> > > > >         return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_=
TYPE,
> > > > >                                      0, NULL, HCI_CMD_TIMEOUT);
> > > > >  }
> > > > > --
> > > > > 2.48.1
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > >
> > > --
> > > Pedro Nishiyama
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
