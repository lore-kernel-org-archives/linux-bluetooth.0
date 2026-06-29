Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3F1DD525
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760154; cv=pass; b=K02MssMJfSE2bz8CppIWrdCFuEQi/mCXtHjNex3g3Vj4IXJflIjKKl4ph7EqFOXP1Q0Qgsa3CEU1moVMan74BPHgoxyg33qlT2ELNBudik/jEF/DHqP4HtFQwdeCSSpOb8TSoppkfRR/9VIbf/4YJNxO7dNbZEogUfUNigXpMgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760154; c=relaxed/simple;
	bh=R2yDTukhiAQMOvcgThVBDwwS/RPW+K/VvD2HSB2ShiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBVxlWc7RLhW7qofUA4Ir/FnuPlvuA8bPzyUXfu9uz3DPtxPTMuzGcXONFixNzgByt5keQhO/XY21nwvNErPpDNKyDnuNnfdOto/O0x/VA6LEtSRCrqz60PQy/pghf0JWuMGMOXZVL7nPhQRpbLQUr0MHEpD49QU1ObjBVMOg/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FunrP6ap; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FunrP6ap"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c04bf4711so14228741cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 12:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782760152; cv=none;
        d=google.com; s=arc-20260327;
        b=dlGs6TP9bJBJr91TJN9n48pC4DV+0OByT1MEiKztOXqFyOjHpe+ctrgM/OYny+97zd
         /xwn8C9SSxTEYqcza9MtwsAfRqi77YF6y5YbQcY6SMmI9JhAMOM3gNkc/bjd5qq7qbGT
         KYFMsdK4+vF7a7HMBUWuZwzx6GemBexQUD758QXC/zdbLriZ2QrxLReGGG15ODGFqxRO
         a2gH0CIuDHFZkCOthEnwIQvQP8WErsOim9LT0iU/1MB35JEoOLnaiv8qc+t2HGGYFW+F
         OekeJDEAuqGmQOLst6XnWYJCzulkB0ABhoO5G2Kp1x+feHw0GWG7dJ36/rVTpB2X3O+S
         kzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YZZpJVpu7+jF4ezl3jYsXe751QKsmUqs85dMxEJqVyI=;
        fh=gV5esG65CWv/FWnroKfYIPAEGtOz7REhYRPPX4g7x2w=;
        b=mVhTLvnO7/gH/YwuWezJzjICP1YXAMGRcF0NAyWAN31OLQaTaZLnGsPKEmoVbYp+ET
         sghJSADByTYF5N4gvMMA8jxJFr44TNjmd+Jo8p2HOWcZltbHvV9DiGOPjwkY8/PzyorP
         76AZppAM/NpykKRBWWWwLntuMaZD/axZqy9JiPer+mOzT80SKbgcmQGV1R6dwATa2tg9
         fF3kl5IdnrLXpHyjwoeaRVXTXPUhdSaB8snHr68CnPHf0obDjMpXaZ3qwquyta21EqIa
         Pywj038cbv7V9W0P/eMWNXuYvs0Oz8k5z1dXg1CK8BimPmS9FGPFz/hl486JqxspcBMJ
         8THw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760152; x=1783364952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZZpJVpu7+jF4ezl3jYsXe751QKsmUqs85dMxEJqVyI=;
        b=FunrP6apBNysxl215Sfr1IQZinvRDls//OMIg7gc16NKlkQljwf4qL4PeSYVOthr8O
         y1MnZ84G/hw7FkygfxX3m1lY5NYObjZK+pgXiP7S6lprYL6Y5rzJ+KaHxk00hJZ0YfxQ
         XG+M85Ua0z35OcMjzg8pSUJbPqnpdh8Wo0UEPE0WRFoKK8baX941sgU2f0esdK2Yh2dm
         SAVxM/mPEMu5mfWlxBmDUtVmBwCQCpmJz/l7kPRjy9fQtRPE5/k/40XSSfY5M310wV/K
         v+d6WlaqAMIJtjLF+elIY44tpyp2FRXdYgk8iSt/5F4/Fe7DAe8Ow2Bak2NoreuqU/ky
         Ke8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760152; x=1783364952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YZZpJVpu7+jF4ezl3jYsXe751QKsmUqs85dMxEJqVyI=;
        b=azelC7DNc4uuhCv1djNJWi3Mk0DoQFz0GwUPvX+Fb8DR5qllNgOMVNK0jIw4zmHZOQ
         O535R/MXlCSy0GfDh2fqG1W3S4REl875uH0J0xbijoMRm2KyTBGuNqeR7a+ErcZSPayR
         bMc+OovB2ZtZg7uWoJ4rV0tk4Ad8WhLZahdqu01lgqoDAqBHFS97FYz8i+U41UoIRnY7
         Cs46rx4ATtiaBJy48PBgj+yoP7zT5jyOzrgAP2kf+5R/osulDRALLS67ed5q6IHFaGRB
         T8psv4ZBRJGMKsnasdC6IbhBZdGrLyAxpWysiE7iGZJe8bEwv4m2kY/rPP/IAl9dOQoz
         jZsw==
X-Gm-Message-State: AOJu0YyS8sjBQdqKTI9BTxdEku7tKLgy4+FuQr0o+1gAHz1l9LVo3Tr9
	RELmxlicy+MUCz7BKC8nZPieEhFJApztRNsG89VeQSZwL1Spi91QeFYBLDUkM/tW3PNhUONoETX
	QhNZjWhWJ6fRhqozPsltvZLCb4zWnfTc=
X-Gm-Gg: AfdE7cnqs+xzBpf1CG3+QoZgNMatmz06DE6euh9PMPpuXE9Ukok/l/EWEWb6fCJH8bd
	+wLJ9hlCQ02LCXv8TLbNhYa0KOSxgazYpg79V3/Xohc33f+8I57Ah8tF/tIkMhdzdxwwyWMjv5t
	zoumu3dGs2ESUTPJVCsAYDGpn012JhdPqP2+nMH+V8qCkQOeoPtDlG1dGWhwSOTTV48B+3FLUvQ
	81jUyQQ8CMpECXj1I5GEpJbcTKsMQlXB0wxVhP243+Jr4q1Hp9x0Zw9T+bSBrhVxRCz4glbtnIg
	7yRGvH+aR9X9OTll8SiIvxuTUH2TmvQ=
X-Received: by 2002:a05:622a:e:b0:51a:8c86:bd40 with SMTP id
 d75a77b69052e-51c109087cemr7914951cf.61.1782760152014; Mon, 29 Jun 2026
 12:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627153505.20173-1-silurust@gmail.com> <CABBYNZL=TB=jNi+6TmdQycjdL4rziy2NECU0r+eLgS49rCqy9w@mail.gmail.com>
 <CAN2GrM=0wVS03c3zoCwWAJTXrUkRiUhtyJfqprMAhwTKUGzOeQ@mail.gmail.com>
In-Reply-To: <CAN2GrM=0wVS03c3zoCwWAJTXrUkRiUhtyJfqprMAhwTKUGzOeQ@mail.gmail.com>
From: Tibor Harcsa <silurust@gmail.com>
Date: Mon, 29 Jun 2026 21:08:43 +0200
X-Gm-Features: AVVi8CcfkmatzLT3v3ariaMGuWbva_ZzltijsHrjAhwC4mEfOVNOI7E_4sNYaA4
Message-ID: <CAN2GrM=5ybw5KLNP64SPhmdnZyQAf=x=Ew96Yrf9=ny28GCKEg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

resending, because the previous one was bounced back by the mail lists.

On Mon, 29 Jun 2026 at 21:00, Tibor Harcsa <silurust@gmail.com> wrote:
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
>
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
