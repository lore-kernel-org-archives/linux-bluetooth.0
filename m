Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAA156241
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673835; cv=none; b=dNXrSA/WDNAngoJa1jaEYy0a14CYmg9GHz23w7cYv2NRUxqeLi4p2uoAZMUWbNG+jjda38huUm329Vu1sz7ZOYTWe+brLV7HaVluTSWnI/HGH+Y058bwy02tUSqhbAZ1D/Oaz2oMyrpSfut2MeiSR8NS8N4fBnTrUMtCdiZZ+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673835; c=relaxed/simple;
	bh=AdKKjBw0DdjcO03+Gfffep72LbSKw0s4dQV6oZNLrf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUQrJJq71wByqO3saIIkCFmTSBepdxdwBQTFwQaQ7booqPjq2wxSqsMPErKNoT7b/8LyasQN5ZZTgh5hYQ4ngs1SGdC5A0ULG4Ht9jbfHJp+dW4N/Gc4MsP8KIZMERWzoa3CgmURnqKH4Y52B+alKBY4xSvm+y1aPwU2cvnmIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noa-labs.com; spf=pass smtp.mailfrom=noa-labs.com; dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b=OjKD+kf9; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noa-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noa-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b="OjKD+kf9"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-270420e231aso2809754fac.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noa-labs.com; s=google; t=1724673832; x=1725278632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTtYynZLm2SbFEN9z92QLFpQbSCk9t7wWnmClZpFWoE=;
        b=OjKD+kf9UGJUK7CAj7Hu88IhZkxv3v2cqysg0hF+eoa8ZMod2i+Shef30cGG3so2mV
         dnTpff8RNWXGRkc9wbspwPXCjzvqat/JArw4zjXhwmBYg3skOzLFZHtO/C+8I+30/DvF
         N2VbCUHNpmQU5OMLCCOGaSUAqisPfsQQ0wY7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673832; x=1725278632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTtYynZLm2SbFEN9z92QLFpQbSCk9t7wWnmClZpFWoE=;
        b=jC8efyce4LTHEoUze6wf0N9mnhCZN9ZliDaYs/p9Q5OAx5hbCLX2sFoAavXP7dFYaA
         sdkDvD+zlya7Fsafns1WVXk87GW/jqAxW+GFSk4lkvp8mIr8qzWXkPY92O4UGoXWORAy
         jc5cgbKMwKV6GquCEgBj4OBQPp5DYZRhInWi13qw2Se3BolsKTyLNPfhTx4JYntfVDAu
         CdJmb5NIJIFwQbaf0YY8erT5QkBjtTk8zdcmtffZve/S+GilPSIFBp6O7UT1fGrJnQ7q
         1f0X1dRZriSkzIrEx5/cY0LkuR05hPSgiQEQxCvg0iQwpO5rBJSIbImrSRdPJ5Dv0gps
         M36g==
X-Forwarded-Encrypted: i=1; AJvYcCWj7cgR2U2z5bx/udpoq3IxHPXocbu7W8xY6a7A8POYM3VAJh0mwke9WmP77UzXMOVOg9OAWjsDbJ7uvL0gXFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+/vCY0YvHbgoJdVjDAj+bu0AzdzwNTpZbX/2EAeOHPcr6nu2
	l+r/5QMKmFI+gh5CrNAnUxuxLgZIP/SqJk5VctdoXkAD27fXIi/E4DjZS2oak41+xAPFQD5u36j
	HhbKD3nbtH8mV5FwEa4zIKIsKZVx7XpTxrCsRvg==
X-Google-Smtp-Source: AGHT+IFrNumdULsnEPR04kBNU8XMjX8bG9XSVfDlwM/zGpHmPKGcSfOV8lPe2vGJr0OSfW68l7jPhnVF9tH+ZD4Q1Vc=
X-Received: by 2002:a05:6870:d0c7:b0:260:f9ee:9700 with SMTP id
 586e51a60fabf-273e652019emr11521313fac.30.1724673831904; Mon, 26 Aug 2024
 05:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821110856.22552-1-pavel@noa-labs.com> <2b7a1c4ee1d6e78f166d545b31f4fd3fbd252e26.camel@mediatek.com>
 <CAG-pW8EgBE4RwhcFtMXEuFtG56JJSyvOjG5+q71zG6pJyo05hg@mail.gmail.com> <CABBYNZJL6qkOPE6UuKz+=03KTUNF4091iR=1j4e2P+Wf2c+oWg@mail.gmail.com>
In-Reply-To: <CABBYNZJL6qkOPE6UuKz+=03KTUNF4091iR=1j4e2P+Wf2c+oWg@mail.gmail.com>
From: Pavel Nikulin <pavel@noa-labs.com>
Date: Mon, 26 Aug 2024 16:03:44 +0400
Message-ID: <CAG-pW8HB=jE-g1b5cy1AnwkmzHP_ckw0HtM+r_Lfsu8eOZpzkw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek MT7925 support ID 0x13d3:0x3608
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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

Yes, just replace realtek with mediatek, and indicate that it fixes
https://bugzilla.kernel.org/show_bug.cgi?id=3D219182


Pavel Nikulin
Senior Engineer
+971 52 386 6738
pavel@noa-labs.com



On Fri, Aug 23, 2024 at 1:42=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pavel,
>
> On Thu, Aug 22, 2024 at 5:09=E2=80=AFPM Pavel Nikulin <pavel@noa-labs.com=
> wrote:
> >
> > Oh my, how I missed that.
> >
> > I think a commit can be undone, and the same patch with a correct
> > commit message submitted again. Somebody with access will have to
> > revert it.
>
> I will do that once I rebase for the next pull request, it is just a
> matter of doing s/Realtek/Mediatek?
>
> >
> > Pavel Nikulin
> > Senior Engineer
> > +971 52 386 6738
> > pavel@noa-labs.com
> >
> >
> >
> > On Thu, Aug 22, 2024 at 9:54=E2=80=AFAM Chris Lu (=E9=99=B8=E7=A8=9A=E6=
=B3=93) <Chris.Lu@mediatek.com> wrote:
> > >
> > > Hi Luiz and Pavel,
> > >
> > > I think these is something wrong to the title and content of this
> > > patch. MT7925 is an connectivity IC from Mediatek rather than Realtek=
.
> > >
> > > Although this patch has been accpeted and merged to the next tree, I'=
m
> > > wondering if the typo can still be fixed? I'm afraid that such error
> > > could cause some misunderstanding to users.
> > >
> > > Thanks a lot!
> > >
> > > BRs,
> > > Chris
> > >
> > > On Wed, 2024-08-21 at 15:08 +0400, Pavel Nikulin wrote:
> > > > Add the support ID (0x13d3, 0x3608) to usb_device_id table for
> > > > Realtek MT7925B14L found on AW-EM637 WiFi+BT modules in 2024 Asus
> > > > laptops.
> > > >
> > > > The device info from /sys/kernel/debug/usb/devices as below.
> > > >
> > > > T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=
=3D480  MxCh=3D 0
> > > > D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=
=3D  1
> > > > P:  Vendor=3D13d3 ProdID=3D3608 Rev=3D 1.00
> > > > S:  Manufacturer=3DMediaTek Inc.
> > > > S:  Product=3DWireless_Device
> > > > S:  SerialNumber=3D000000000
> > > > C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> > > > A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> > > > I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> > > > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > > > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > > > I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > > > I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> > > > I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > > > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> > > > I:* If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> > > > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> > > > E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> > > >
> > > > Signed-off-by: Pavel Nikulin <pavel@noa-labs.com>
> > > > ---
> > > >  drivers/bluetooth/btusb.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > index bb698ca98..df0d2e4ab 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -627,6 +627,8 @@ static const struct usb_device_id quirks_table[=
]
> > > > =3D {
> > > >       BTUSB_WIDEBAND_SPE
> > > > ECH },
> > > >  { USB_DEVICE(0x13d3, 0x3604), .driver_info =3D BTUSB_MEDIATEK |
> > > >       BTUSB_WIDEBAND_SPE
> > > > ECH },
> > > > +{ USB_DEVICE(0x13d3, 0x3608), .driver_info =3D BTUSB_MEDIATEK |
> > > > +     BTUSB_WIDEBAND_SPE
> > > > ECH },
> > > >
> > > >  /* Additional Realtek 8723AE Bluetooth devices */
> > > >  { USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK },
> > >
> > > ************* MEDIATEK Confidentiality Notice ********************
> > > The information contained in this e-mail message (including any
> > > attachments) may be confidential, proprietary, privileged, or otherwi=
se
> > > exempt from disclosure under applicable laws. It is intended to be
> > > conveyed only to the designated recipient(s). Any use, dissemination,
> > > distribution, printing, retaining or copying of this e-mail (includin=
g its
> > > attachments) by unintended recipient(s) is strictly prohibited and ma=
y
> > > be unlawful. If you are not an intended recipient of this e-mail, or =
believe
> > > that you have received this e-mail in error, please notify the sender
> > > immediately (by replying to this e-mail), delete any and all copies o=
f
> > > this e-mail (including any attachments) from your system, and do not
> > > disclose the content of this e-mail to any other person. Thank you!
>
>
>
> --
> Luiz Augusto von Dentz
