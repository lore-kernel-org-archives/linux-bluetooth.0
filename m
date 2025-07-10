Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6B272E4C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158046; cv=none; b=u3gh3mKtmTMiyjoqu8yxpFqN5SCIavAR+C3nHWdDvWABj+kSDfiFycHZ8h+nvZIQxGWMWpt0/bdVP4kECa3OEYZVcuw9W0njh7oABZQGj2jtEz+XQQKmx2uZ/KNonItjaauCzSGldVP0frfVrcs18JzYKCgCQdz8jOUXP2jws0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158046; c=relaxed/simple;
	bh=JFiQ5as5BbTcTKxKJCgMK5gPRoSId0mDyE52PyuxhkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDdy58Q4T+R2BSovhiKP+0Q9WKw+SYAkv+fYp3dBrzx7M49ydNIcOQF/1yyhvEtkHsw5Bq5B0pgFh2vCvwpYMEt7n2MbX3imj+GjesTVX0eXin0m2kz0E1+yM3sg3fa/w2naVuHrY+DgpmlSfN4yvMgkquK/sn7wY4CHlzqjLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=x0FaLDWx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="x0FaLDWx"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adfb562266cso165684966b.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1752158042; x=1752762842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysHNggQWWJD/EINpDTqc3pBI2AvoZ/5RsJcTw3TVl7w=;
        b=x0FaLDWx69q+AABaV5lHIFRa9O7sxEbnlcITzsYArO8+EQWu+qDplq8VQiWBkzWyEb
         9mi4MqNzJPL/f79SS/vn4Z6c4fPBINEfblTfkooLnlfI8XGcCzopmhWos9BcxS43tZ/k
         llghZuZ0MJ3wl1RdylJq2Qr7KALnpuPIcEcWDA962S6gQpA97D75bwnkInpEEolLPqfM
         C8Gr4SnXmK0hHz1agLE8HgsNGj9wbX39S1zusec1y4fMDVfdnDgKClAThiSCXgcYiRFA
         Cm8e+gOsAJXALMHleiiP8GPXVASceanhcmXLBs+9yRTJSWe8veMmOYtdfIRCUdWdWeIh
         esVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158042; x=1752762842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysHNggQWWJD/EINpDTqc3pBI2AvoZ/5RsJcTw3TVl7w=;
        b=wx/oXOp84FkiARnRTEhQghm9UBAV72ZwejAR3ry+RkN+CE2d0Os7NndbKEw0PCNHA9
         ssBo1IyKM5g5BWEDU2++4Ys58DyqzVi9CiTIl7Y9UkchboOsRc76DlygEU3cghTMvahL
         EggIUVbDuJTKooLsZrHI3IDYWYTMSEMcw12KZYv3CvzrjKJx3I3kwEoivOa9TFTR5h8K
         iHnFvxXQRmdJ67gnsSn1RzAD/vNPwP/HMGlKNLoXN/evCkeQyq7Pn3RdDKVpFeyWU9Hu
         hPs58alV1RXjcD6KStiVmEP2kXXNMkeEKTj1GVB7kGCKK8tDKCD8FDvcAPUHcNUVSKTn
         DDhw==
X-Gm-Message-State: AOJu0YwMgEIj4HnqWvk1OwK1k7O8cKajl7YNhJIUGHlF9CyuibxF+Kdq
	zEOZZdJzhOnKATwofmoVM7Bn0lpVdjbZsgIviQVZVvAtYOA2+f2JOioAe7rLpLxoRwJ9tB6h7nf
	WzybhotOhAuhHMJO41JQ92gXSlMLQYXwb/arw7bRZ5nN3Hl4QNNoFXQ==
X-Gm-Gg: ASbGncsS3B+AILnzTCkYv+KlCUbpFmykiDnPv14R2CBJ3/KM9kZLIcZB3w8zvsH5Snb
	Qm2XS218+MefW3Myeu91PJ9jCxNAQQfNnRP9GJ2Jyu63WMv64Sjs4hzsxq6wxMatwsg7QZKAtQ7
	duwyqrU2k3W4aU0UKpR5mc4isjven/s/JaQ5rzL7+ubhSEJZc2muEj
X-Google-Smtp-Source: AGHT+IHei0fA7K4wesno4V9vhaa4h7VXB/gvMkSo4JBaabmdMiofng8I3mlMmsjOqPKRq5J1PNh6e1cty3esxTj5hGY=
X-Received: by 2002:a17:906:4816:b0:ae3:6705:8918 with SMTP id
 a640c23a62f3a-ae6cf7a22fcmr659559366b.49.1752158041778; Thu, 10 Jul 2025
 07:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709191333.3374053-1-luiz.dentz@gmail.com>
 <CABBYNZJLLWu2EEEsZ+tE0+0H4o1ba3gG2ab9dLaPbAxz2BzGmA@mail.gmail.com>
 <CABtds-0U4mD9kr708UdB+SAHRvBAPYrEaOSCjKkqTDXjJpWOUw@mail.gmail.com>
 <CABBYNZ+Xo8Ou=dLfHhPVfiqMCehh23aFY=G+KRMb6d9uoKxjjQ@mail.gmail.com>
 <CABtds-0gkRj+ns84Avc6pQ9ofXRXQ2PEO-mwbr70hZea-N9DQg@mail.gmail.com> <CABBYNZKS4n29S5JOZc48UV4nc5NuJcGQxsXLbAC-cY_8ZyFw4A@mail.gmail.com>
In-Reply-To: <CABBYNZKS4n29S5JOZc48UV4nc5NuJcGQxsXLbAC-cY_8ZyFw4A@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 10 Jul 2025 15:33:50 +0100
X-Gm-Features: Ac12FXw6FZiTxW2FIAHH4jgipvropyrU3hwpoylNPrlnZKrIAx6fAMeTVyYh2dM
Message-ID: <CABtds-1exxSpMNh8GJUARNtiviMSogJgge7o2DxM1Kgc2MWAFA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Check if controller is ISO capable
 on btintel_classify_pkt_type
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Sean Rhodes <sean@starlabs.systems>

On Thu, 10 Jul 2025 at 15:32, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sean,
>
> On Thu, Jul 10, 2025 at 10:23=E2=80=AFAM Sean Rhodes <sean@starlabs.syste=
ms> wrote:
> >
> > Like thus? Sorry, not too familiar with the email patches.
>
> Just do:
>
> Tested-by: Sean Rhodes <sean@starlabs.systems>
>
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > Due to what seem to be a bug with variant version returned by some
> > > firmwares the code may set hdev->classify_pkt_type with
> > > btintel_classify_pkt_type when in fact the controller doesn't even
> > > support ISO channels feature but may use the handle range expected fr=
om
> > > a controllers that does causing the packets to be reclassified as ISO
> > > causing several bugs.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219553
> > > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
> > > Link: https://github.com/StarLabsLtd/firmware/issues/180
> > > Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classific=
ation for ISO data")
> > > Tested-by: Sean McAllen <sean.mcallen@example.com>
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  drivers/bluetooth/btintel.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.=
c
> > > index 55cc1652bfe4..06575a0b9aee 100644
> > > --- a/drivers/bluetooth/btintel.c
> > > +++ b/drivers/bluetooth/btintel.c
> > > @@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct hci_=
dev *hdev, struct sk_buff *skb)
> > >          * Distinguish ISO data packets form ACL data packets
> > >          * based on their connection handle value range.
> > >          */
> > > -       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> > > +       if (iso_capable(hdev) && hci_skb_pkt_type(skb) =3D=3D HCI_ACL=
DATA_PKT) {
> > >                 __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->hand=
le);
> > >
> > >                 if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_BA=
SE)
> > > --
> > > 2.50.0
> >
> >
> > On Thu, 10 Jul 2025 at 14:33, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sean,
> > >
> > > On Thu, Jul 10, 2025 at 9:18=E2=80=AFAM Sean Rhodes <sean@starlabs.sy=
stems> wrote:
> > > >
> > > > Hi Luiz
> > > >
> > > > Yes, works perfectly with that patch.
> > > >
> > > > Thanks
> > > >
> > > > Sean
> > > >
> > > > On Wed, 9 Jul 2025 at 21:06, Luiz Augusto von Dentz <luiz.dentz@gma=
il.com> wrote:
> > > >>
> > > >> Hi Sean,
> > > >>
> > > >> On Wed, Jul 9, 2025 at 3:13=E2=80=AFPM Luiz Augusto von Dentz
> > > >> <luiz.dentz@gmail.com> wrote:
> > > >> >
> > > >> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >> >
> > > >> > Due to what seem to be a bug with variant version returned by so=
me
> > > >> > firmwares the code may set hdev->classify_pkt_type with
> > > >> > btintel_classify_pkt_type when in fact the controller doesn't ev=
en
> > > >> > support ISO channels feature but may use the handle range expect=
ed from
> > > >> > a controllers that does causing the packets to be reclassified a=
s ISO
> > > >> > causing several bugs.
> > > >> >
> > > >> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219553
> > > >> > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/21005=
65
> > > >> > Link: https://github.com/StarLabsLtd/firmware/issues/180
> > > >> > Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet clas=
sification for ISO data")
> > > >> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >> > ---
> > > >> >  drivers/bluetooth/btintel.c | 2 +-
> > > >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >> >
> > > >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/bti=
ntel.c
> > > >> > index 55cc1652bfe4..06575a0b9aee 100644
> > > >> > --- a/drivers/bluetooth/btintel.c
> > > >> > +++ b/drivers/bluetooth/btintel.c
> > > >> > @@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct=
 hci_dev *hdev, struct sk_buff *skb)
> > > >> >          * Distinguish ISO data packets form ACL data packets
> > > >> >          * based on their connection handle value range.
> > > >> >          */
> > > >> > -       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> > > >> > +       if (iso_capable(hdev) && hci_skb_pkt_type(skb) =3D=3D HC=
I_ACLDATA_PKT) {
> > > >> >                 __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)-=
>handle);
> > > >> >
> > > >> >                 if (hci_handle(handle) >=3D BTINTEL_ISODATA_HAND=
LE_BASE)
> > > >> > --
> > > >> > 2.50.0
> > > >>
> > > >> Can you try with the changes above?
> > > >>
> > > >> --
> > > >> Luiz Augusto von Dentz
> > >
> > > Please add Tested-by so we can move to get it merged, I do intend to
> > > send a pull request later this week.
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
