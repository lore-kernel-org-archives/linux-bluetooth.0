Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6A2EB10
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740206128; cv=none; b=bG27Wj8hLFVpqNvJfER+/bn+KV45vHFUy0vXO7KQbNKlSweCbQiBI9rlrw7GvFRIUmvsNw0Ee9dOmksQcNbye0IURoDGWY9y/esr5Y3co5hE0wVY2z28kkJ/pg/tO4DbpBRPNaMd39MC8j89qNsCNw4u6aFFwYdB7ohIZceY2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740206128; c=relaxed/simple;
	bh=DKkd7IunJ7SFSt7FdgOoNftZ+D4pryqWLYsCdjTCVlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6PerXaBUZ60WYcaknPicyf1ikCkrnE2IGIoydrz/kFhq6w0rTkswzaNkeB5W8C4oIY9Pg5BBlmj03+DuesciJ6xd2NOToZGFQgAf4EPLAvBau678cn+zXFq0MLGDSWY26NuJp0Ct3UFGT3x56ICHw/bWv3isZ1EsBuk2i5viLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggbAQ/zi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggbAQ/zi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43995b907cfso17344845e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 22:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740206124; x=1740810924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiifT9U/wBIRDxgpkZ3MlCKafLZmxV4r091kuCsT5N0=;
        b=ggbAQ/ziUczXXS9XZOWuQiB7uXiHx+6DaM2Nvsf4WqFc59GtSSCBDUGvjg6kGoPp1e
         yoqKRaJdrfadDdC5kFni1gNrNcPVeo428R9NFmqCBARVmv0smkdvclb6ZVZKYsB1QMKy
         Y5cyCXEsK06qiFQbkerZFyzP+T5smjxgxdItHPg2+ztp1usKZWoZ7zR+AWCpMYYObW8c
         zI9ouDqPhrwpcJwqsa7/2SpGj0LWsFlLRIQQ1z/ZHeAovI0LnqXsiHBZ4Z8g3fo0/aus
         pUVZqAdePnzKZ1ADckKJOkK7n6EQviRCpYa+fdjwJ9qhASHlbW1qfgA2V7Stjts5gggl
         D0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740206125; x=1740810925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiifT9U/wBIRDxgpkZ3MlCKafLZmxV4r091kuCsT5N0=;
        b=ol4hApkrVZfQjBEv81KQH+CZKuMFAj5X2VP8NAjj1dG7QsC2TYDhbjUqc2KOU0YGQ2
         4xKiI16QdkdeGQP6kpz88WKkFlYAgmg/kXSCdXTU4egWAQOwz+Ot1HmRsgMdxbJmWLMc
         sUS6PhVhcRYif07gjeZvu+Sl0zbBNy2O07FZTb0oDGfqkqfvJVS7/JbWxSxmeUJVd54a
         36q8kU2TWwceX/X/PXyFjsihzSvQ16lWkh+3M/AdNHh1jI6gJSuzYRI2CeJrGD9tZBD2
         0+u7uNNHAyhbZgsncmnPZwSxJgrpVFYXsU0vsheRr7iRd/M8RloxtfQ/isvs2CiJlJfK
         Q47A==
X-Gm-Message-State: AOJu0YyqFx1UL9EOcjHuZS6V503qMkVm+lkQcZ/tqH6zxjFe1t0x/gVS
	aRQZMmQtINPOCDUkXj5FSRrb35IJ0Y/a3DPp55btKpONfrFXl0ZryXBgvmYR2qhzIZvY/0263Uw
	24uaeDtcPy3tvGms72A79/eCk8+zWtLrnXqk=
X-Gm-Gg: ASbGnctR26ooroObcXbmrhlrkKq7rAYWArHKifpGUds0na8qVQDffIgI92Jwe+EROny
	iT9qEiIPVw+JDfWQ1C07W45eFs5iU0uUNrjrMJ+t2uxFzI9tdIrfrqckjIOPRHcby6lNfxDNDzh
	GneGvuWrZ2
X-Google-Smtp-Source: AGHT+IFaQK2DsGHgJSAxXrxTG8SHzHTNZLE94kaP+XqDKn+/iSBuvBDrqsS37HPh1ORCrgYd1XTeD8u08N5+wnTCEPg=
X-Received: by 2002:a5d:5350:0:b0:38f:2a84:7542 with SMTP id
 ffacd0b85a97d-38f6e97af1emr4232379f8f.28.1740206124400; Fri, 21 Feb 2025
 22:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
 <20250222050439.1494-2-nishiyama.pedro@gmail.com> <95d0f052-c931-45f5-8212-60f9308a2672@molgen.mpg.de>
In-Reply-To: <95d0f052-c931-45f5-8212-60f9308a2672@molgen.mpg.de>
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Date: Sat, 22 Feb 2025 03:35:13 -0300
X-Gm-Features: AWEUYZkpyQHZpeKVH0bbY3YlihgQoYeJXK7N7KQ-W-dWdSWFhAhGXILDH8nKNRs
Message-ID: <CANoxumjLBd5hfNb+FsXN68A0u3oCk96fJragB4LHVBt1TQ1Kqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: Fix regression in the
 initialization of fake Bluetooth controllers
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paul,

On Sat, Feb 22, 2025 at 2:29=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Pedro,
>
>
> Am 22.02.25 um 06:04 schrieb Pedro Nishiyama:
> > Set HCI_OP_READ_VOICE_SETTING and HCI_OP_READ_PAGE_SCAN_TYPE as broken.
> > These features are falsely reported as supported.
>
> Please list the affected controllers.
>
> > Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
>
> As the summary/title says, that it=E2=80=99s a regression, could you plea=
se
> elaborate, that it worked before, and how it regressed? Were these
> quirks present before?
>

Sorry, I realized I put the wrong commit in the fixes tag. The error
originated after
commit c8992cffbe74 (=E2=80=9CBluetooth: hci_event: Use of a function table=
 to
handle Command Complete=E2=80=9D).
When the min/max length of the commands began to be checked. The clone
I have here returns
a smaller buffer than expected by the command.
Since I'll need to fix the version tag, I'll put this information in
the description in the next version.

> > Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> > ---
> >   drivers/bluetooth/btusb.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 8149e53fd0a7..903361456acf 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2436,6 +2436,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> >               set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirk=
s);
> >               set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks)=
;
> >               set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
> > +             set_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirk=
s);
> > +             set_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quir=
ks);
> >
> >               /* Clear the reset quirk since this is not an actual
> >                * early Bluetooth 1.1 device from CSR.
>
>
> Kind regards,
>
> Paul

Best regards,

Pedro
