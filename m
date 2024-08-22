Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76624A933;
	Thu, 22 Aug 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362953; cv=none; b=EfSH9laIv7aYIWuVl2nKhDtcHY6UO1jPV6BMOx68hTRN7X0TxGgPAnByABEsXJ8BA2hjq6AtCJnniZAWvsYBpEtBZtRj1mH0OQ+DMh02sZeGR5DqQPanQ/3p4vighEp1P/hNZompYyHuMSttr9yy+YegqYcBPflPtSoD0sbUQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362953; c=relaxed/simple;
	bh=RonItg1Xd/SunYcSkqFRspw+YkvUnNSQrO5Lkh+YH18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXUkUjHU25rQJckWnRKeS5EUofXxhAOYJWjEo1yefGzzbJ4bn1h4gHBNrpSP1arPD7cwyZj8t/LjEGVe4lpV0+Q2UlDdb4o0XwGhzkoGeFCHVlwwjcRB8/nzxLPifFu01If/P5t+ASvuqcPR+MscQwjI2+H0b+Fq/Naz/+SeHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+lPa/MH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+lPa/MH"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3fea6a0a9so11714711fa.0;
        Thu, 22 Aug 2024 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724362949; x=1724967749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awwpG6BcnKIVmBP8lggk8RTlcBpoUDmXTZGY9kK67gs=;
        b=E+lPa/MHeu1dOEUP1sTd+HMp2F05eS2HGQpXZ7yf6pBgpSEYLBT7QSpuHlVF915GFf
         +giPOnZOBOYMCNyr18m8V3cbvTOJ8Jz9LrSQgVAG+fJnciTOajk1MhRscrlZ+8xHcYZS
         1pDCovLvc5bVnGC2mJjUzSJaVCwSPtoc0B4l7bWt9Du89b2cPrQcN1Egj8SaLx/NNP1U
         QQ2LCEFTt/scfaX7D7DK/rfGN9tv4/5hYrRTEDI7gXSPHZ/285XZbFTww12UeiMxMiY7
         tzLgBESzYPkCaGe19qWxt3LLOnN1O3Iod425LVQWZ0ih+IIAtNzRpZGxR5BofGJNHQgc
         aSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724362949; x=1724967749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awwpG6BcnKIVmBP8lggk8RTlcBpoUDmXTZGY9kK67gs=;
        b=iS7eNBGah3QAFKCDyWmoY3WbzvIXSnP1Wg/B1jLjs/oSZfgBKEmD2MY083N7inEmk3
         67ZFIcD+0OyVuN+xq8/3kn09QA4ll7lHzbcP2VG/6Ll30EquR8MH+Eus1J42tr+tMd7R
         l1ZZ2g4TGveJuOzIKsYxZ+m71oigTvtLYJdfZLmIGQnzwxhIRnsnPgZl1ufRdGAODYCa
         FJkjg5MAlMqKkeGkA90UT1aVsUClSPJuqiS0RLU6n4Vo5cXsUbqD4GR/MgCsE8SNYkO+
         IqxJG22UBAhBaT8FwnsR0SqOK6RFFP+ifg3dVaLwkJTXe8be/E9Mz3UZBk1v+4QSn4eK
         EUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9vDtdF6FwE/73Bxo8nVQaF8E6TuJL57qGGjbcZWoes+kc4KKev7RnMGCZFxakcaMWd1X5zT91VrSciRbH@vger.kernel.org, AJvYcCVQhbDOPK5XCipQbXUfUEw7P3cXBJlKxgnFyymY6M57fcrcRXN28kkn32nG3iiha5zf2SwAZ0aw26sDavUaIVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGUreQ1ppqD+9I6Ca1LtN4UF2v8i0baC9YNCQBZMjYtg8g4QL
	OCj3EfjOn00FQxe6pvCmHPNH0wjjUC+hhshadigBeth8WL2dvss+/Tt5Z5iG5lDkCrlVMJpHLkg
	dPnriKxAnenxaa2rqE3M9PzM9l6s=
X-Google-Smtp-Source: AGHT+IFZJWagQvx5+2x+g91KGo2waPGKCL0f+e79wkpFqT045NpDP3GLMXEFPHm1GgcrX3bTw/UTgJoGytHjbkY8LkU=
X-Received: by 2002:a2e:b88f:0:b0:2f3:f1cf:5314 with SMTP id
 38308e7fff4ca-2f4f4910acemr1141741fa.10.1724362948284; Thu, 22 Aug 2024
 14:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821110856.22552-1-pavel@noa-labs.com> <2b7a1c4ee1d6e78f166d545b31f4fd3fbd252e26.camel@mediatek.com>
 <CAG-pW8EgBE4RwhcFtMXEuFtG56JJSyvOjG5+q71zG6pJyo05hg@mail.gmail.com>
In-Reply-To: <CAG-pW8EgBE4RwhcFtMXEuFtG56JJSyvOjG5+q71zG6pJyo05hg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Aug 2024 17:42:15 -0400
Message-ID: <CABBYNZJL6qkOPE6UuKz+=03KTUNF4091iR=1j4e2P+Wf2c+oWg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek MT7925 support ID 0x13d3:0x3608
To: Pavel Nikulin <pavel@noa-labs.com>
Cc: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>, 
	Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Thu, Aug 22, 2024 at 5:09=E2=80=AFPM Pavel Nikulin <pavel@noa-labs.com> =
wrote:
>
> Oh my, how I missed that.
>
> I think a commit can be undone, and the same patch with a correct
> commit message submitted again. Somebody with access will have to
> revert it.

I will do that once I rebase for the next pull request, it is just a
matter of doing s/Realtek/Mediatek?

>
> Pavel Nikulin
> Senior Engineer
> +971 52 386 6738
> pavel@noa-labs.com
>
>
>
> On Thu, Aug 22, 2024 at 9:54=E2=80=AFAM Chris Lu (=E9=99=B8=E7=A8=9A=E6=
=B3=93) <Chris.Lu@mediatek.com> wrote:
> >
> > Hi Luiz and Pavel,
> >
> > I think these is something wrong to the title and content of this
> > patch. MT7925 is an connectivity IC from Mediatek rather than Realtek.
> >
> > Although this patch has been accpeted and merged to the next tree, I'm
> > wondering if the typo can still be fixed? I'm afraid that such error
> > could cause some misunderstanding to users.
> >
> > Thanks a lot!
> >
> > BRs,
> > Chris
> >
> > On Wed, 2024-08-21 at 15:08 +0400, Pavel Nikulin wrote:
> > > Add the support ID (0x13d3, 0x3608) to usb_device_id table for
> > > Realtek MT7925B14L found on AW-EM637 WiFi+BT modules in 2024 Asus
> > > laptops.
> > >
> > > The device info from /sys/kernel/debug/usb/devices as below.
> > >
> > > T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D4=
80  MxCh=3D 0
> > > D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D=
  1
> > > P:  Vendor=3D13d3 ProdID=3D3608 Rev=3D 1.00
> > > S:  Manufacturer=3DMediaTek Inc.
> > > S:  Product=3DWireless_Device
> > > S:  SerialNumber=3D000000000
> > > C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> > > A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> > > I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> > > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > > I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > > I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > > I:* If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
> > > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> > > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> > >
> > > Signed-off-by: Pavel Nikulin <pavel@noa-labs.com>
> > > ---
> > >  drivers/bluetooth/btusb.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index bb698ca98..df0d2e4ab 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -627,6 +627,8 @@ static const struct usb_device_id quirks_table[]
> > > =3D {
> > >       BTUSB_WIDEBAND_SPE
> > > ECH },
> > >  { USB_DEVICE(0x13d3, 0x3604), .driver_info =3D BTUSB_MEDIATEK |
> > >       BTUSB_WIDEBAND_SPE
> > > ECH },
> > > +{ USB_DEVICE(0x13d3, 0x3608), .driver_info =3D BTUSB_MEDIATEK |
> > > +     BTUSB_WIDEBAND_SPE
> > > ECH },
> > >
> > >  /* Additional Realtek 8723AE Bluetooth devices */
> > >  { USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK },
> >
> > ************* MEDIATEK Confidentiality Notice ********************
> > The information contained in this e-mail message (including any
> > attachments) may be confidential, proprietary, privileged, or otherwise
> > exempt from disclosure under applicable laws. It is intended to be
> > conveyed only to the designated recipient(s). Any use, dissemination,
> > distribution, printing, retaining or copying of this e-mail (including =
its
> > attachments) by unintended recipient(s) is strictly prohibited and may
> > be unlawful. If you are not an intended recipient of this e-mail, or be=
lieve
> > that you have received this e-mail in error, please notify the sender
> > immediately (by replying to this e-mail), delete any and all copies of
> > this e-mail (including any attachments) from your system, and do not
> > disclose the content of this e-mail to any other person. Thank you!



--=20
Luiz Augusto von Dentz
