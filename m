Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DF1D958E
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282155; cv=none; b=jJA57EaY5A58Rtw5WER+BEr30wrRVD/vEAx3MzHZuMpNnCHJtzUWUz+6murrJlUmcEE0Wi2Oo5Zq1BQCPD5WvQpNAKXnbVpblp4A+jB97AbJgqxmwXRVE8keyBZ7C8uVizg9thUPBwPgVFjAfGfSC6KCXyhnig9BjDcrl6zv2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282155; c=relaxed/simple;
	bh=c/tdbc0F+tFog6hIKKCv/xqJ2aWRWrjS+AwSbTILbW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNibnXZC82xvVSdhuUx+1KRaXXSfaJzciqiI6UxstBu0Qnse9l4vIUsjz4GEHKoRZreRLMSRj2kGo1kRwy4CPLnJk3JynhEbU6AJ7DL3glDtLaem24DdQVkLvaNPK/S0aRdsVpntw5R8xg18CIjqCy/301LNYEWeIv8dj07To9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfsHeGnO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfsHeGnO"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-304d760f118so43067721fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 12:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736282151; x=1736886951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18HoIEi6NDZZ32hEPjp5iK+l7su6OgsPiOSc5TIz6F4=;
        b=WfsHeGnOc9JU1xgkAz3slhjv4LSsbsG0aaEIqdYsD/bnlUZ1D89cpcyxmB/+6Ru7FB
         JhL+nBYdsSa0+UNpiwyxuzzRmBplmjfF8Tx8RSXhJO188GRZTUl72a+twxZctKbDtnSm
         BZ3RrurlTVbmYfgxx4b3dMs9a3tPsEPvcuVqBzALASRaqt0N3S9UCkXTfu3bcyKFbHC8
         er5gsLIqt2wHTpPycTUq3GmFxgWk3IVha+bMXQOZjdGO+kXuK7wK5qeNP2gRQeaSXbuh
         RVjK6cyXvjTO8SK2KOJv2ad25aEqQC/0ea3TW6yKExJO+ugPd0mcNYG3pVB/nvWYnojw
         DLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736282151; x=1736886951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18HoIEi6NDZZ32hEPjp5iK+l7su6OgsPiOSc5TIz6F4=;
        b=hyoPczJIwZKq9vSBeSvrGqo/cdlRAAGbxPoaWIxajm6pas029ktTambKrcg1oy/mAM
         aRq4FjEvt9Exkibx7mmW1XHFN7cws6zkjajNPcC36pclZCg9zTk8mZb53kZ0088CdY9H
         OGrYlEeEkg1+5B2ZNx8HnlnJUgUs5vq/U7Q1Tq010XnFw136Esfvu7kiCm+mSabKbRr8
         gQ8S8XWJhbo9FTOf0Yk/nigtlq+1TUfwQnglEWOAgymxZUnmQzFTpY6IIb/S8Wjaw8Py
         QXHkk3NzA1XDxrMSmH4h/NDqkHNqLxAMwA+lF/vSv/yK+vMlr2X7y/iqbCpQj+8iJVVy
         IYPA==
X-Gm-Message-State: AOJu0Yw6u/IN6zMSqJsk40T5a+jBJCRumjW/3rvk3GCNeYC/pDq5gzpr
	ct3xauciN2/Y8v7pEjyKgJ+lNf7s04oW6S98jx4rIfiDdyASnTM7a5ooo1OJ/xgZeLghxrvRcGt
	3o5cLTGl2JcDzSMbRMlxAG6k5BYixeWW5
X-Gm-Gg: ASbGncv0qL8inWqZyi0HA47hKsOCa/AmjwolPSPBXfSgi98ImfCT3wmxnKbiHHXU5W3
	IDlCc5NNURaJBzxeoonpr+BrZJwFpSvIrz17fAHY=
X-Google-Smtp-Source: AGHT+IFTBS2xe+s+3egTrf4DPONdxVnGFcknKodHsJsxm+rdOY2Kf6S/inewzlrfcAMmovmCd++wasHYnAfoZGJHiOE=
X-Received: by 2002:a2e:be03:0:b0:300:1947:a28c with SMTP id
 38308e7fff4ca-305f45db5cemr376831fa.26.1736282151176; Tue, 07 Jan 2025
 12:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224142424.10572-1-mahesh.talewad@nxp.com>
 <20241224142424.10572-2-mahesh.talewad@nxp.com> <CABBYNZJ8To9fm4j3bcGsmPc6ChJO376yAN-Wr3Se9hs_3GpJoQ@mail.gmail.com>
 <AS5PR04MB9754DA009526DC605DD32C9B89112@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <CABBYNZK0Sgrkyzmr0NQ2s1PJXWfO8YVPtPzda8bt3=ERj+hcAg@mail.gmail.com>
In-Reply-To: <CABBYNZK0Sgrkyzmr0NQ2s1PJXWfO8YVPtPzda8bt3=ERj+hcAg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Jan 2025 15:35:39 -0500
X-Gm-Features: AbW1kvblVrHes5WJebx-ycpEAU4pL2L-XBDxUzJCLcoN5mp55ixuj0HckHznp58
Message-ID: <CABBYNZJxvdWaogROtkwbpmFU2zSTkRZCuj8F9im2HoqQLzSZCg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] HID device not connecting issue fixed.
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>, 
	Vinit Mehta <vinit.mehta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Tue, Jan 7, 2025 at 9:49=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Mahesh,
>
> On Tue, Jan 7, 2025 at 7:05=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp=
.com> wrote:
> >
> > Hi Luiz,
> >
> > We tried with option - " UserspaceHID=3Dtrue" in input.conf but HID Con=
nection did not happen.
>
> Do you have the HCI trace? Does it fail to connect or just doesn't
> work because your kernel don't have uhid enabled?

If the problem is just that the kernel doesn't have it enabled you can
try with the following change:

https://patchwork.kernel.org/project/bluetooth/patch/20250107203056.1470303=
-1-luiz.dentz@gmail.com/

> > Thanks and regards,
> > Mahesh Vithal Talewad
> >
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Tuesday, January 7, 2025 1:24 AM
> > To: Mahesh Talewad <mahesh.talewad@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Devyani Godbole <devyani.godbole@n=
xp.com>; Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>; Vinit Mehta <vinit.me=
hta@nxp.com>
> > Subject: [EXT] Re: [PATCH BlueZ v1 1/1] HID device not connecting issue=
 fixed.
> >
> > Caution: This is an external email. Please take care when clicking link=
s or opening attachments. When in doubt, report the message using the 'Repo=
rt this email' button
> >
> >
> > Hi Mahesh,
> >
> > On Tue, Dec 24, 2024 at 9:24=E2=80=AFAM Mahesh Talewad <mahesh.talewad@=
nxp.com> wrote:
> > >
> > > While connecting BT-HID device showing br-profile unavailable and
> > > connection did not happen.
> > > Steps followed:
> > >         1. Pair Ref device
> > >         2. Connect Ref device
> > > With this patch HID device is able to connect and HID traffic can be
> > > observed in btmon.
> > > ---
> > >  profiles/input/device.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/profiles/input/device.c b/profiles/input/device.c index
> > > 8cf8e5ea7..a6047998a 100644
> > > --- a/profiles/input/device.c
> > > +++ b/profiles/input/device.c
> > > @@ -89,7 +89,7 @@ struct input_device {  };
> > >
> > >  static int idle_timeout =3D 0;
> > > -static uhid_state_t uhid_state =3D UHID_ENABLED;
> > > +static uhid_state_t uhid_state =3D UHID_DISABLED;
> >
> > Well this would contradict input.conf:
> >
> > https://github.com/bluez/bluez/blob/master/profiles/input/input.conf#L1=
8
> >
> > Perhaps what is missing is the detection that if uhid is not enabled in=
 the kernel it would switch it off automatically, that said it was intended=
 by the distro to know whether to enable it or not, so we don't have to pla=
y a guess game runtime.
> >
> > >  static bool classic_bonded_only =3D true;
> > >
> > >  void input_set_idle_timeout(int timeout)
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
