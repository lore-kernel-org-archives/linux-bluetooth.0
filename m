Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDF1862
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760057; cv=pass; b=Hyw4izxOymeIjQWYFwni1tGq6wVck/xvf1pEHKuLTdNmW6CTwdoCtSpmmD7qT0klbvI1a2IR2PeTULt9ftAJk1WmEFeOnjsLGgZR/zP5I1ER5AIvEVatULpa+9kIedtWN1a6SXguT6HnbDG0HZawvLp7cwfRKqE53uSjadNEIek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760057; c=relaxed/simple;
	bh=OxkJUP2zxzsBF9vghiL0n0Cgho8Ky5jzI2GNafBCkYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDpyQ+2Ab2aWViqfSUzh0eZUx00RNbAVmpiOBtgTnZExXND17G4GnS51Hh7Vd2Yyk7PbJD6cDPAykMnT1gt7VBhRAVO8jcINgayay8hsxGkeirb/mOWbN74jpEt838Na9KseDR/EHtgw9c6+sBBqesX4EHA7s8Ybh14xxMkhClg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuiQrjoP; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuiQrjoP"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664ae993e4bso3562437d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 12:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782760054; cv=none;
        d=google.com; s=arc-20260327;
        b=ezkBq3anDht1oIUxtRl/8oMRRzfHQbagC1O2v4Jba1+k078lK6pA3VvsqT++RLmdob
         W8MDa/PMDwHvTlzlpWpWp7cqrfuQOMThmHpZRZSmTffVgangPfA0YivswgXVo8B6l++t
         WFIwNDh80JZMFx+6RkXJDtsJKrce4Nso6KPfwLnJw91+7miNm8cHlWfJiyOFHw0hu2Sx
         rJ33Od3jZNY3CNXyyQRnEj3aEqs2Osz830v/3gGK22QJeY9AHC0s5bkROj09V/ht60gN
         nd18Wgf8tKckubsfihjEnjqH3rl8wy7kchMFA3+3RgfB/cM55kcvBsaK4mtTIb2IsU9O
         ZalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yt2B3w4+vzjxrp9zDtLzq9NGNn0o7sja+HKoI4wr/0U=;
        fh=f67XxzPrGVZ1PqxhAKYn4i5HCImqmaYFojVAH2UZcCs=;
        b=nmS0ox6ezEjbY22uu0DuRb+dcZv3yCV01hT6OWym5UGithOJYLE/rLVUV2cMGBalUN
         FsW+5Rf000NqoRWh+VqTTwqcAbOhZdFYw2mNzwyn+QCioDnF1tIQ9x86tXsjvIgMRJEm
         F8hMKU/YWjdR2ddCv2dqTnCbPLrQths9v/bBwW94lYd5veD6ldfGF+oYon5rMxWEY4md
         gO5HlWImjci3Bsl+h4kLFwLux/GipgadkZH/VwQBP8bjY48ODBg4QZsDx+HHEZPobO+9
         d7zgxqtCv+3LljMbGAKPp+RS3ksxCTk5ANX3qCngRnyCj35lNjlNUvg/hdcwmV2iRKJb
         JCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760054; x=1783364854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt2B3w4+vzjxrp9zDtLzq9NGNn0o7sja+HKoI4wr/0U=;
        b=GuiQrjoPLvNKYYSx0lPWncAJvSizSf+zSDkONVBwy6REyJtGpEdGvEXjkSvVF6SG2y
         zD2FBUmau+PVnK+6oYfS5znMOpnEgxU43Dl4zwQJtFEmd54OpXcHWU5GzzWpdemcsQOq
         cVtUGWqoZRdf1MaMvypOBMZt/IGLLOOQIkkPPOVvha8xs2vEEDVsciMRL1llocPK9IAM
         R7Y1aYXHf0pjbdrr8fpblTCkend6tfQ/hjCa8AZw8Ceb9lQ4bHZ8YBwmUXmkxD1DHF1D
         IUNscMQ3+fNMuVR0DBZZQrfKqX1CJcbH4MlR3MI4u9sQhFn/mqOU4OfFIrUsuEYFPpMl
         t2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760054; x=1783364854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yt2B3w4+vzjxrp9zDtLzq9NGNn0o7sja+HKoI4wr/0U=;
        b=Sl4EdLID7V9XlSELq7R+fsPRTTZGy7dTHBUwlVLOVAdf2qVBkKgDXkYUWKpZLcSsiz
         QpGYyRKQyc+BBo0SNZGEUyR52/NLuiiOTxUOy9wQr6oOSe9pW3ZrlpeZNt5rWBeN4vEE
         42HXjethPC31ubZbafEkPeCmlzQr0hfxG/f9EdpGqZW97xF3EDk2GHw+yyYydC2RgpwA
         jwz9IgiePzAPwdALFsSBrPr+5OCD5mHdB5OY71StWUffYZO7sqk0Bl+ZEFY+pk7chlyp
         f8gmy6PXtmnqj4KdEaOmzCNXnm61q5rvwNeVswGNKEO2IIb8WfTXRoCGnNaNImoCXiz3
         YU8Q==
X-Gm-Message-State: AOJu0Yzrq1T/x9OO1I7cvNSv5C+pZXqKFEV67jMZBfEoygibWzvsqdNi
	l66gQn5OGMKO+LNCFcJJrtDjOUHcC+hbasAhQTjdIVS7+L3ta1riN6Ief3+jtp4Tj35Ezybkgat
	3UzzKIaRzVb4lr5ZhFZY53KUx58nfZWofXs+7SDU=
X-Gm-Gg: AfdE7cm4LyYMbi1c71cPHe6YeVF7jdKK5T0xcLVYlWdhfr2vmsaVxlzn/3CuBlm0Q1s
	dWhwomxAE03/Z9ShjuJDOKmhHr7+aIpERDI6v0i1zyuZAV71uGBCZ+lo9ilirof0MysKp19SQnR
	7fFfJ8nHNuErXIC1LBPxON8j2vYZM5zipxEhVeRDcwoa94pKxidDmFXUuEdS8g1obWT4iEHneHn
	CWwrEctRBc/gfGHDWn4iljVgvbRg8tbvE1xmlhzK7yw+/zbQE8oqkfVuinBjMYN4QiqDtLPjjQT
	c5bDtAcCcG1NaCDFg3/2FI2wQCbsnHnTTgUAu/i6JqN/ZgrkGuT6xrI4
X-Received: by 2002:a05:690e:1653:b0:664:ca89:3cb with SMTP id
 956f58d0204a3-664faf32324mr401735d50.26.1782760053641; Mon, 29 Jun 2026
 12:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627153505.20173-1-silurust@gmail.com> <CABBYNZL=TB=jNi+6TmdQycjdL4rziy2NECU0r+eLgS49rCqy9w@mail.gmail.com>
 <CAN2GrM=0wVS03c3zoCwWAJTXrUkRiUhtyJfqprMAhwTKUGzOeQ@mail.gmail.com>
In-Reply-To: <CAN2GrM=0wVS03c3zoCwWAJTXrUkRiUhtyJfqprMAhwTKUGzOeQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jun 2026 15:07:22 -0400
X-Gm-Features: AVVi8CfQvhyHZldqyEPOrqbaT6cPxnfuUzUv5wF5yf1dRJoKfiLZfuSSn3rBXcQ
Message-ID: <CABBYNZ+h0nsd9uX3gMd8EsbLMdgCTiUm6+aNyHNGu0_Jx-tzxA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
To: Tibor Harcsa <silurust@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tibor,

On Mon, Jun 29, 2026 at 3:01=E2=80=AFPM Tibor Harcsa <silurust@gmail.com> w=
rote:
>
> Hi Luiz,
>
> Thanks. Here is the requested `/sys/kernel/debug/usb/devices` output for =
the affected controller:
>
> P:  Vendor=3D13d3 ProdID=3D3503 Rev=3D 0.01
> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>
> This is the device that shows the BLE scan failure unless it is handled a=
s QCA Rome.
>
> Signed-off-by: Tibor Harcsa <silurust@gmail.com>

Respin the patch with this information included.

> PS earlier troubleshooting info is stored here:
> https://github.com/tiborh/bt-troubleshooting
>
>
> On Mon, 29 Jun 2026 at 19:56, Luiz Augusto von Dentz <luiz.dentz@gmail.co=
m> wrote:
>>
>> Hi Tibor,
>>
>> On Sat, Jun 27, 2026 at 11:35=E2=80=AFAM Tibor Harcsa <silurust@gmail.co=
m> wrote:
>> >
>> > Add the USB ID (13d3:3503) for the IMC Networks Qualcomm Atheros
>> > QCA9377 Bluetooth controller to the btusb quirks table. This
>> > device requires Qualcomm Rome firmware and wideband speech support
>> > to function properly; otherwise, BLE scanning fails with HCI
>> > unexpected event opcode 0x2005 errors.
>>
>> Need the contents of /sys/kernel/debug/usb/devices (use git log
>> driver/bluetooth/btusb.c to see what it is typical output).
>>
>> > Signed-off-by: Tibor Harcsa <silurust@gmail.com>
>> > ---
>> >  drivers/bluetooth/btusb.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> > index 08c0a99a6..7963fd48a 100644
>> > --- a/drivers/bluetooth/btusb.c
>> > +++ b/drivers/bluetooth/btusb.c
>> > @@ -297,6 +297,8 @@ static const struct usb_device_id quirks_table[] =
=3D {
>> >                                                      BTUSB_WIDEBAND_SP=
EECH },
>> >         { USB_DEVICE(0x13d3, 0x3501), .driver_info =3D BTUSB_QCA_ROME =
|
>> >                                                      BTUSB_WIDEBAND_SP=
EECH },
>> > +       { USB_DEVICE(0x13d3, 0x3503), .driver_info =3D BTUSB_QCA_ROME =
|
>> > +                                                    BTUSB_WIDEBAND_SP=
EECH },
>> >
>> >         /* QCA WCN6855 chipset */
>> >         { USB_DEVICE(0x0489, 0xe0c7), .driver_info =3D BTUSB_QCA_WCN68=
55 |
>> > --
>> > 2.54.0
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
