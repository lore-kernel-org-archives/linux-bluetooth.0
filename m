Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A73BBE9;
	Mon, 10 Jun 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061438; cv=none; b=jnU9DZPsYpUq5iAtc+975ga3KiaFM4DP+A1hSb5zR3dGfKHuBA8BAuw63DvCoNMM59asbE9XVAg/jRy4cZZJSW4v2SMsFtbd3l+f1Sf4JIxnksuUK6EUZraEJQW57dIPDOI9EC+EVqv239utt0dl6PRtEXPAmGE/k6wzPObjftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061438; c=relaxed/simple;
	bh=uMfuVL5fsGtx8MCah3bVJ0vQiUR/RK2xK2BIcZKa+hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Imv0Ubij1UVPuUMX3gCkDB4Fx9kLSjnWM9iDxFt2InN7dOUfsa4gvMIRyaiIFDyQNAK98mdCxTarzTtqPq7zGbz6OBbVC0IoihjLlIXUaPmk+GoMf6Li5sx2ITA1w1oNA6+MvoR64XoCxnqEJsKLnOqt5ng1RPS8mroJ8pUAOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8n43H8i; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8n43H8i"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c2fe7f07c4so1587998a91.2;
        Mon, 10 Jun 2024 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718061436; x=1718666236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mvW7YorewnAQOa3UdIoxNwoNJQ5gL2cRcp8dw6Hbdk=;
        b=T8n43H8idj1wZCNw2p32z4MjNRVjpdwstk2Q6aWEpDAq+WSUxW3MDYnlAf0EkE/mwB
         spo7KFM50dN42tE1j2i6ngCWgQ+970zcpekDjkldjPrqog85yCnqZdsos+ejOMo7ORHY
         iMj5L5DOBVHFW4hwsLSRFV6sMRnm3a3RnD3OjPA3zzZ2RJRrp/AdkaJb1IWw1M3lGdPj
         zaWIfwsbuFgGfJbVwOHbjmryagB76J9xL+/AnoqFt0BWrmT8Ac38pKHL05Ysq2nvkMBf
         8GeRoC9wxY1snq2gyZ8w6o4BOPCzqD/5g0m8gbIT/VzIdTBbG458fyf/Wqy4j+iwI5IY
         OVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718061436; x=1718666236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mvW7YorewnAQOa3UdIoxNwoNJQ5gL2cRcp8dw6Hbdk=;
        b=eq0q+ds2bMgL2hLdMJl9tUpWfgcGH/LqSJSOrXGORhp/RgDGWyVPFAu/aBthJOHQlG
         tZz2yjBMiVofLKoIo4O3fjHD+UqY0AcpxX3304dPyuVvq0rHP98WzJywL4yU5I4aaz1K
         GaPi+kFyUKrX8cog8xpUwnXi1rdtss4OHwIKorCZJIQW+ZvQPKWDlM72pL2EM5auVW16
         dJ1nYMIWfzq0FVuLDLiqQEJuPSvs2ile1NeNQ7tUhDzJp0wkWS07XGqDQyKCk6ucZaZR
         vKtXU5nVaXWq/5R6tasT9BXVKuTU9XKyKIklKwWrkO0U/amsHo/aZzJedRY28rA9c6Ez
         fqiA==
X-Forwarded-Encrypted: i=1; AJvYcCXdUoS6sNWFkudCWnxn/JQgmZAwML4HSWJOgUDm5XmI51hHHUaJfEY+mcuLeUGL3vP45X2+XjrFtwKjzWZ6HwBDVdULCkNExtC+i6bRZ8VrSwjSF8Bfvd7Ut/Kg1cx3NG0E+CMp80qDKX4RYSQM
X-Gm-Message-State: AOJu0Ywl1gaDi0HDLb1wAEtCShSHmpOkWXWBzCnqpqMH7qaAcZHPRLsh
	cZntpawmgTe49J7A74WNR+eXRNDu3H9LbFZPCTh6r4FKblZpbsTIp3U7K8jcCIQyyVJCl8li6w/
	xaI6aWJzcb2MuX73U8LjbZ9ljJAI=
X-Google-Smtp-Source: AGHT+IGNN82l2lMyi/E0/dQG+zmrRfChcRly38cTdDLtcXFs6dRfpl7el+Dp7tFC7y3pRAYFDV+J7LQf/WTl5BALGEU=
X-Received: by 2002:a17:90a:e394:b0:2c2:97c2:1424 with SMTP id
 98e67ed59e1d1-2c2bcafcde7mr9856796a91.25.1718061436338; Mon, 10 Jun 2024
 16:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606183032.684481-1-andreas@kemnade.info> <CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
 <20240606221941.333a9704@aktux> <CAHCN7xLhbiqTTOwPZ22KekALDn0KtH6vNQEJpSmSCTiMggX5Qg@mail.gmail.com>
 <20240608212004.3707d8ea@aktux>
In-Reply-To: <20240608212004.3707d8ea@aktux>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 10 Jun 2024 18:17:05 -0500
Message-ID: <CAHCN7xLDjnW1gK8DF4codzFLEvC_hDgeACR8wtWF8nxCJ=+RBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, marcel@holtmann.org, johan@kernel.org, 
	pmenzel@molgen.mpg.de, jirislaby@kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Tony Lindgren <tony@atomide.com>, tomi.valkeinen@ideasonboard.com, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, robh@kernel.org, 
	hns@goldelico.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 2:20=E2=80=AFPM Andreas Kemnade <andreas@kemnade.inf=
o> wrote:
>
> Hi Adam,
>
> On Sat, 8 Jun 2024 14:00:38 -0500
> Adam Ford <aford173@gmail.com> wrote:
>
> > On Thu, Jun 6, 2024 at 3:19=E2=80=AFPM Andreas Kemnade <andreas@kemnade=
.info> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Thu, 6 Jun 2024 16:04:10 -0400
> > > Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > >
> > > > Hi Andreas,
> > > >
> > > > On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Andreas Kemnade <andreas@kem=
nade.info> wrote:
> > > > >
> > > > > Some of these chips have GNSS support. In some vendor kernels
> > > > > a driver on top of misc/ti-st can be found providing a /dev/tigps
> > > > > device which speaks the secretive Air Independent Interface (AI2)=
 protocol.
> >
> > I think you may have sent me a file to test, but I can't find the
> > e-mail.   Can you tell me what tool you used to test it?  I can get
> > gnss0 to enumerate, so I am close.
> >
> hmm, /bin/cat is sufficient. It should spit out nmea now by default.
>
> For playing around with raw mode, you need the ai2raw parameter
> and then you can play around with read-gps from
> https://github.com/akemnade/bt200tools
>
> > [   20.759857] hci-ti serial0-0: using DT
> > '/ocp@68000000/serial@4806c000/bluetooth-gnss' for 'enable' GPIO
> > lookup
> > [   20.770263] of_get_named_gpiod_flags: parsed 'enable-gpios'
> > property of node '/ocp@68000000/serial@4806c000/bluetooth-gnss[0]' -
> > status (0)
> > [   29.221588] gnss: GNSS driver registered with major 244
> >
> That is nice.

I think I am stuck.  The closed-sourced GPS binary that Logic PD did
was done a 3rd party which has since been sold, and Logic PD never had
the source code, I just get junk with this driver:

$GPGLL,,,,,,V,N*64
$GPRMC,,V,,,,,,,,,,N*53
$GPGGA,,,,,,0,,,,,,,,*66
$GPVTG,,T,,M,,N,,K,N*2C
$GPGSA,M,1,,,,,,,,,,,,,,,*12
$GPGSV,1,1,00*79
$GPGLL,,,,,,V,N*64
$GPRMC,,V,,,,,,,,,,N*53
$GPGGA,,,,,,0,,,,,,,,*66
$GPVTG,,T,,M,,N,,K,N*2C
$GPGSA,M,1,,,,,,,,,,,,,,,*12
$GPGSV,1,1,00*79
$GPGLL,,,,,,V,N*64
$GPRMC,,V,,,,,,,,,,N*53
$GPGGA,,,,,,0,,,,,,,,*66
$GPVTG,,T,,M,,N,,K,N*2C
$GPGSA,M,1,,,,,,,,,,,,,,,*12
$GPGSV,1,1,00*79

I am not 100% positive, but I think the antenna might be required to
be powered.  I'll talk with the HW engineer who designed the Torpedo +
Wireless SOM and see if he remembers anyhthing about the GPS.  I know
for a fact that Logic PD doesn't have the source code for their GPS
demo, and I know it doesn't work with modern kernels, so i can't
compare the performance.

:-(

adam


>
> Regards,
> Andreas
