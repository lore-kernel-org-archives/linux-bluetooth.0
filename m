Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD01AB6CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153460; cv=none; b=p16EADnTankB+JBIaD+VXSiap84wNmw3dVyBK3ZnQ14CVwmIAAXilMay8eD327OZiHWwAU8IxZCi1ptEdPUGwUbJ8U7T2aVqmkYuCTM10Q4WgIvYqX56hifpzAMWSdIT8W1LE1X9jvTf7TqN9/5AtHtckFdOQUR2PVpiJQb8yHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153460; c=relaxed/simple;
	bh=WQDIckngGUdAgfDXn32xmnVLjp8gRDMnImcPvhfjkg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh2dwxR/mtyuR+TsIWL2oDqg2MwSgUxhDVfSmOb5zn4IJlCVYcZT6m+aNfbGxGd7kwG5s6UVzVAbinq7SVRxW8z3aq6qp82g6pm+5fJGHnaY+L0uH9tNA+Yb9fLbOTHHwSPOlqZXnQY0EOiPUn+neuFb0ZtQ+S7AnO6aAn6tDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO58NTjc; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO58NTjc"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so13524811fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726153457; x=1726758257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNQlKca0DrOVZ8mFpv+5kn9bGxeRABDURuP8jfJe65A=;
        b=bO58NTjcTqurxu6d3K90Dztr0y+2awlO0AolMHWGwIfnnJ7gw05nJGx396QZJj1Gyz
         DL9Wah5L8vp+NYczWoAonekZkEY1fi/W3yG0//6VU6vTiGKQu8fBuCOXFAY9bAEDDL0c
         MB8DHCKbGX74jF+VlKabmqOx/G/K06GRdlSTdTY/8iBpuD6JvmOXtaKGsHrsN7a8dwGV
         yotp8Z6epnjC0MnjKZhfCmN+POk/uKvp5EOXHCeLvKwk0xTo0r4kPOrVbqms/n/VdEXF
         ECKhgYKRdvQ1WiqPvA2jzMTkofqV35DE9gI6KrHKVtwCmTCuTmhoZdKUz4UCxBmyFT6j
         OZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153457; x=1726758257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNQlKca0DrOVZ8mFpv+5kn9bGxeRABDURuP8jfJe65A=;
        b=QN+xTHlyubl/Wqyay/oTvwmzNjb7Yr26AbDX1lDWsyUc6BytHoBr07UCuYQxZLjsIi
         Fm1ru4ndeEAngo+plmGxH1i/Q4A1f2WGwjpnx7ycsMoDIy6z4B5/dON/IB1VzYutk5sY
         Zzn4PrpcfFFHGL8O98OqqQT9d2nCgpksYXxjGTZjzBUJjamxmJewKyvR7D//Z1kaV2tj
         gjEgRcMzXlRzS3FJ5gAxkG05LNfUeR8rN9PTjUc535WqBfs/9iXxpdzEBxmtGNcHU7r/
         Oqkg/mOt6lkrxGsVoq6P+NgR9rRqacjuxzsdPFeEDIleqNt1w8ck9tR98qQvSiQVBS+t
         mF+Q==
X-Gm-Message-State: AOJu0YzEKKYoG0M4B/UdtYUxoaFe+epBOlXUkA8eryUTphJsnMWHQrQ0
	okEyavIRpN2sWiw6AWA3/AjGl59chAPqPi96NiSB0LMd59onBXE+Udc1Azas4XwMpBk0h0ldtkc
	VtGs5U4QbxvCTcXLdGRGu/4QPHb4sdyi2
X-Google-Smtp-Source: AGHT+IFbcJf2jDnBx/aS6i1SKWjoxQZSLcRhYLv8SkTlQmwSf/MbUkXEIWVf54CKDsOEFhaKPb6fSaQ8D487e2QZ+n0=
X-Received: by 2002:a2e:e02:0:b0:2f7:6f4f:10f9 with SMTP id
 38308e7fff4ca-2f787ed91f7mr13122811fa.21.1726153456324; Thu, 12 Sep 2024
 08:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74b373054d0f2a15e6d585b6d357434a4b880f61.camel@hadess.net>
In-Reply-To: <74b373054d0f2a15e6d585b6d357434a4b880f61.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Sep 2024 11:04:03 -0400
Message-ID: <CABBYNZLpWM4O9+6TPs2kCFm0BfEgdTsihbHV9mL1RGv5UQjeBw@mail.gmail.com>
Subject: Re: Surfacing "Pairing not supported" device response?
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Sep 12, 2024 at 9:44=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Hey,
>
> I got a report some time ago about a Kawai music keyboard's Bluetooth
> MIDI interface not being usable from GNOME's Bluetooth settings:
> https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/154
>
> The code in the Bluetooth settings always tries to pair devices, unless
> it's blocklisted in our database.
>
> Ideally, we wouldn't need to have those devices in a database because
> the device would answer that it doesn't support pairing (as in the
> "pairing failed" line here:
> https://gitlab.gnome.org/-/project/1617/uploads/83953481a1008b8cdbe894849=
ee5b3a7/gnome-bluetooth.png
> )
>
> and then we could retry setting up the device without pairing it.
>
> But the device response doesn't seem to bubble up to user-space.
>
> Any advices on reporting this error message all the way up to user-
> space for bluez, and then gnome-bluetooth, to use?
>
> This is the tracking bug in the meanwhile:
> https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/158

Yeah, looks like smp_failure always translate the reason to
HCI_ERROR_AUTH_FAILURE so this sort of error is not propagated to
usespace, we also would need to add another status code to MGMT API to
map it properly and then encode it as part of D-Bus Device.Pair method
reply. That said, some device may respond with this code when bonding
is temporarily disabled, in fact the kernel do that when bondable flag
has not been enabled:

    if (!hci_dev_test_flag(hdev, HCI_BONDABLE) &&
        (auth & SMP_AUTH_BONDING))
        return SMP_PAIRING_NOTSUPP;

So I don't think we can assume the device is never pairable, so
perhaps just use Device.Connect method instead of Device.Pair when
retrying, that said perhaps the device doesn't like the use of
SMP_AUTH_BONDING (aka. persist keys) and instead just want to pair
without bonding, this is a problem at SMP side though since it doesn't
have a code to say bonding is not supported but perhaps that is
intentional since peers can indicate by not setting SMP_AUTH_BONDING.

>
> Cheers
>


--=20
Luiz Augusto von Dentz
