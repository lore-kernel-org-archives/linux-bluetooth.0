Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258B155389
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157972; cv=none; b=MxCGgIdnf9/cqZYgo0JXXhmpSFtGXAXqooiuH4AlFrp5ZXM42cQbH3WVfOqDlVrt9D/OGaRBGJ3pmUwX/LOlBJWr6ctsq5EdP+tBp7sqdGTKXj0RTEQD7I5Z9ANijcHpyYRghMvidjAKi9R9z3AohG0B7wlIzBTR2g0yi2T+6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157972; c=relaxed/simple;
	bh=uyMCN2UcB90RNY7IoScRJi1TNHyurhjl2gDiYCnOjNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pg1QpIunMkGO8z71WDi4BLKzeSfAytxZghNd2X3qCD1JULXHeks9ddFUEe8vakMh17/Ckyj/XGAwQ8V2johj55NVsOKrGaZtqiiMooMDqoWS89nhi1JKUtnbErwNwfFzDaX03iT1Yu6hlRXrJaAy1zI1RxkqtXooZ6yMyUk5Vec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXp5S2E6; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXp5S2E6"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b4876dfecso21582321fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752157969; x=1752762769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtflqQ7NWJFyy7jOg/wpuRjQMb3uRcAzBxTN9SGhGZU=;
        b=jXp5S2E6d6c/EwBRJOYijENfM8BEBoBIe+YkOe/udZpydGaa43x5WviwdsQ7w00Ua5
         /dA12eM4yiHxZZMKgn4ThZzp4Kg5YY2/ALhmQkoOokIm+zF1ETAAAFCy9TecKcJSaXP5
         sI8pNjQhtiWLRKALUpDv/FcSiPeJA+/1H7M2qAMnbLoS2ywFi2TM7Fho5/iJuPxdu9ii
         OpDWrN0i4UUuW1UItJ59jD9Btajri/TccCJ8xFituseE25dfGO+xOchghr9F1eTrJm1j
         jMf7FoTFt2LM8mZpXdvG2PkZBU63KLxxW0fdtytfR8TrkVnoW65FAVXx6FmJKllW/Ynp
         Bh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157969; x=1752762769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtflqQ7NWJFyy7jOg/wpuRjQMb3uRcAzBxTN9SGhGZU=;
        b=IogcOIBQU/OTagFk2bYZag8RkhR/O5YkUV+KO4GgrVECm/fCW4IRHZGucovfSuwIMO
         +HlnhO1lOFYM2SGGWXbL5koepREW0++SQKRjXyiWazcZPkji8On+vHZVGiTr7NFpV1eb
         SoWj5xwbpJ4gKmJA3Ympsmeb3DnpOtNHsEF13igaey14ksP77eWONEAYSQOtOoODBf4y
         njxieoppo5AYV5PiNr6vK/T+mZ4ZkquBUXaqFeF90aYzAh/GFPi/kq7sw1ZMcdFo+Fxz
         2dMUAcH+fwOU2QTC4+QK1CEGdJnUCpKu/r4bOfrU2gqKpc+gNh93cSMS465ZP8zJdUrJ
         TM3w==
X-Gm-Message-State: AOJu0YxmQSTs9/O8d1QcFDgN+643/PDv0eYzYDeXX2+wcvGKO2d+ga/S
	JSYuQ9SIAVgWwSTYZLfvva9IK5KiSPXZeAK5CZOtLXN6DpojLJbDskRlN6qw0dQKJMSeweK80+e
	bCKz4/JEBBFqpyEp9az9v+olZ/ZfffEY=
X-Gm-Gg: ASbGncv2USfxEMc6wX+d1mJEzCG5Rqp0/R6Wky5vhfZZwnKrsS60KZwbS4xK5BUQIJI
	w3c5d8cZ9/F/KvXjhSedNDnim9kGkAfmzvwJm3je463cUtDC7ELrTrccmvIZqABBH/pc7UXQfWz
	bN4O5jk5iZKI1h3OqhrhpUhLwzTk8ae8Wh+T+EiP7lNQ==
X-Google-Smtp-Source: AGHT+IEnmb1N4GR+9lAYrr3qGG1DCcpc1SWEuUdw4hkhRAzJQVaZorzw3lrRYItCe0crtGrbNS+NLK0MK/aN0qrtsd4=
X-Received: by 2002:a2e:a592:0:b0:32a:e7b9:1dc9 with SMTP id
 38308e7fff4ca-32f50c28a4amr13811531fa.3.1752157968696; Thu, 10 Jul 2025
 07:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709191333.3374053-1-luiz.dentz@gmail.com>
 <CABBYNZJLLWu2EEEsZ+tE0+0H4o1ba3gG2ab9dLaPbAxz2BzGmA@mail.gmail.com>
 <CABtds-0U4mD9kr708UdB+SAHRvBAPYrEaOSCjKkqTDXjJpWOUw@mail.gmail.com>
 <CABBYNZ+Xo8Ou=dLfHhPVfiqMCehh23aFY=G+KRMb6d9uoKxjjQ@mail.gmail.com> <CABtds-0gkRj+ns84Avc6pQ9ofXRXQ2PEO-mwbr70hZea-N9DQg@mail.gmail.com>
In-Reply-To: <CABtds-0gkRj+ns84Avc6pQ9ofXRXQ2PEO-mwbr70hZea-N9DQg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Jul 2025 10:32:36 -0400
X-Gm-Features: Ac12FXwTy8-3wOewRlogT07GbQE1HKx16ZQrvKTQ2nuUH4zkwNoSrSD4CKm1wpE
Message-ID: <CABBYNZKS4n29S5JOZc48UV4nc5NuJcGQxsXLbAC-cY_8ZyFw4A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Check if controller is ISO capable
 on btintel_classify_pkt_type
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Thu, Jul 10, 2025 at 10:23=E2=80=AFAM Sean Rhodes <sean@starlabs.systems=
> wrote:
>
> Like thus? Sorry, not too familiar with the email patches.

Just do:

Tested-by: Sean Rhodes <sean@starlabs.systems>

> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Due to what seem to be a bug with variant version returned by some
> > firmwares the code may set hdev->classify_pkt_type with
> > btintel_classify_pkt_type when in fact the controller doesn't even
> > support ISO channels feature but may use the handle range expected from
> > a controllers that does causing the packets to be reclassified as ISO
> > causing several bugs.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219553
> > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
> > Link: https://github.com/StarLabsLtd/firmware/issues/180
> > Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classificat=
ion for ISO data")
> > Tested-by: Sean McAllen <sean.mcallen@example.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  drivers/bluetooth/btintel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 55cc1652bfe4..06575a0b9aee 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct hci_de=
v *hdev, struct sk_buff *skb)
> >          * Distinguish ISO data packets form ACL data packets
> >          * based on their connection handle value range.
> >          */
> > -       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> > +       if (iso_capable(hdev) && hci_skb_pkt_type(skb) =3D=3D HCI_ACLDA=
TA_PKT) {
> >                 __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handle=
);
> >
> >                 if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_BASE=
)
> > --
> > 2.50.0
>
>
> On Thu, 10 Jul 2025 at 14:33, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sean,
> >
> > On Thu, Jul 10, 2025 at 9:18=E2=80=AFAM Sean Rhodes <sean@starlabs.syst=
ems> wrote:
> > >
> > > Hi Luiz
> > >
> > > Yes, works perfectly with that patch.
> > >
> > > Thanks
> > >
> > > Sean
> > >
> > > On Wed, 9 Jul 2025 at 21:06, Luiz Augusto von Dentz <luiz.dentz@gmail=
.com> wrote:
> > >>
> > >> Hi Sean,
> > >>
> > >> On Wed, Jul 9, 2025 at 3:13=E2=80=AFPM Luiz Augusto von Dentz
> > >> <luiz.dentz@gmail.com> wrote:
> > >> >
> > >> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >> >
> > >> > Due to what seem to be a bug with variant version returned by some
> > >> > firmwares the code may set hdev->classify_pkt_type with
> > >> > btintel_classify_pkt_type when in fact the controller doesn't even
> > >> > support ISO channels feature but may use the handle range expected=
 from
> > >> > a controllers that does causing the packets to be reclassified as =
ISO
> > >> > causing several bugs.
> > >> >
> > >> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219553
> > >> > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
> > >> > Link: https://github.com/StarLabsLtd/firmware/issues/180
> > >> > Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classi=
fication for ISO data")
> > >> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >> > ---
> > >> >  drivers/bluetooth/btintel.c | 2 +-
> > >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> >
> > >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btint=
el.c
> > >> > index 55cc1652bfe4..06575a0b9aee 100644
> > >> > --- a/drivers/bluetooth/btintel.c
> > >> > +++ b/drivers/bluetooth/btintel.c
> > >> > @@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct h=
ci_dev *hdev, struct sk_buff *skb)
> > >> >          * Distinguish ISO data packets form ACL data packets
> > >> >          * based on their connection handle value range.
> > >> >          */
> > >> > -       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> > >> > +       if (iso_capable(hdev) && hci_skb_pkt_type(skb) =3D=3D HCI_=
ACLDATA_PKT) {
> > >> >                 __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->h=
andle);
> > >> >
> > >> >                 if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE=
_BASE)
> > >> > --
> > >> > 2.50.0
> > >>
> > >> Can you try with the changes above?
> > >>
> > >> --
> > >> Luiz Augusto von Dentz
> >
> > Please add Tested-by so we can move to get it merged, I do intend to
> > send a pull request later this week.
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
