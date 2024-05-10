Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540238D
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351607; cv=none; b=qY9h3oB+LvRlEgggM0TNF8K2PzQm6CJN2Z1HtoRiO4xb+UToXndsIYehKTWN/LcDDS0CNIGsXnWn/t1PToBi+woDGS+74iD6VTKXZc12ADrdL7UYs2u8YSmpyxSqqen/h+PeLptH2CRVWWruwIsOXk0r/gY7CkMFFUnYXS3eyg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351607; c=relaxed/simple;
	bh=F5Swy5DGjw9Hfrkgms8O9kLNrYJ2J8+nIIgp8iS1aWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eg8BdMZxYB19ZZeyMlzTINJ6ZXWV2Q4QdSV3wkd+14gO33GBbI+yOF68kacgoQgZSG8wb81UNDfXj2ZQxwnQX75c98pL/vNeEzcUPf4mnwljlATfVuFBYY0ilLdm1S96LGu5kLwjcN1G1g2vifW4Igv472jrNcwzTXZ12tLT+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2LOE8X8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2LOE8X8"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e4b90b03a9so22963971fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715351604; x=1715956404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5Swy5DGjw9Hfrkgms8O9kLNrYJ2J8+nIIgp8iS1aWs=;
        b=c2LOE8X8dCks1ZjWQcIICqtEBe9WDh1Z8SKhzpyfV2n5jA/XfLeep4a5ddFLy+ExKo
         uYZmBQrpVyAtsrxN02+PhXJjFPT2yV1ccUWSyj2IRqYLr2NBQUvdLC/3orhCCyNKhI7f
         VIIrjN1z88JBgMpgvLCuWepg4EtQjSlZtgigBGZsgEACZkY+M4eA+ENUOJ1Rb5gFEPsV
         cNVXWBWukF5OvPcSw0QmYBmCZycFPf3srjbIqfRLkbeGNml5r9bKRIYnNxwtp7Sjs8TJ
         iHOLYTV2ZdGT+MQLsNAgalsowTHAXfwYuBokfkU8otSdC3VAXk0C8hYEVkAGN0mODycS
         yGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351604; x=1715956404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5Swy5DGjw9Hfrkgms8O9kLNrYJ2J8+nIIgp8iS1aWs=;
        b=fKqVCltTgf4sDCIAAZSLxkayAd962aShsqTxXSrG7jeB1WrtSytOqYzZf8zzC1JRey
         BiX+HnNToIffyUGpeDeb25oAa5MRqFzKAc3uW+aTwx9EWev04FhgHEeKa1yAOm+DgmHt
         BHdvLD1Qzv0+Hu+Sg4vFB2NxQqoXpl7SOcTIOGpZWDW3Hx1VezvD2NITbZtp9X5tWMgw
         3Tkr9OOlrWLw3MQGMF45ViQodKcx6PtX1EP35y/2sWA2SGcnLfGmuXWfWxZqHWwm/7YD
         5IFZMdItFe7PV6k4i96B4QMN/XAi6FIpjnpmlieFxVwz+d8xApGu7FND6oVtNngOkp7g
         jzCw==
X-Forwarded-Encrypted: i=1; AJvYcCXMre2n6oF3ZUY76UiaK4SM6z2bcpRoPH9MhNGXi9diO6XEmoPBz/OM7jOhkCnykbyXphjkR6rctzJDLCXv3736dZMBEleLgxBysM/ZGofE
X-Gm-Message-State: AOJu0YzBemblKPkgGDEooGVo7JB1rLVWkS2Gc2rlTQyC929dEqW2kyoO
	ltwtFggNz8CUc+uk3pUBI25IjX7ouDLfSkqEMAIXJDCv7/MsnNgrgNBxT758eH7XaWPf8jHEaSn
	KU5Aw9lPPZWTLsL+D7Wd1l6gQHC/cCQ==
X-Google-Smtp-Source: AGHT+IHpk/kaNy2nDGnZN8oek5QC7kWesfxK+r4ESm9X/Y7+mgu9HWhNWZaXTgUv+5Vl6r3pDAnHO7oWXq4zKj3oPEs=
X-Received: by 2002:a2e:4a02:0:b0:2e1:fae0:8ba3 with SMTP id
 38308e7fff4ca-2e51f263abfmr16799501fa.0.1715351603667; Fri, 10 May 2024
 07:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
 <Zjz0atzRhFykROM9@robin> <CABBYNZLMODHp+jBu2oVDC5Pg6fyAKJugQF0N-XgarjWQJJPObg@mail.gmail.com>
 <Zj0tcmseJCjR4hK2@robin> <CABBYNZLnYz-vPrMbtsJTsLPsyo62j+cxctSkLjRom3bWEU9N3A@mail.gmail.com>
 <CABBYNZJ-6oyLnBov9H_jym9m-9qiUt1ELxYGuBOdZT29aj9MCA@mail.gmail.com>
 <70078624-d766-4db6-8ddb-511251baf0f2@marcan.st> <4e194251-d175-49d0-af03-b2cdd8a30fe0@app.fastmail.com>
In-Reply-To: <4e194251-d175-49d0-af03-b2cdd8a30fe0@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 May 2024 10:33:11 -0400
Message-ID: <CABBYNZKkkAA0KXDR-R0M5jCHNhnLrpH38Ympfm5-JgC0yiD7Bw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, linux-bluetooth@vger.kernel.org, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sven, Hector,

On Fri, May 10, 2024 at 5:55=E2=80=AFAM Sven Peter <sven@svenpeter.dev> wro=
te:
>
> Hi,
>
>
> On Fri, May 10, 2024, at 05:13, Hector Martin wrote:
> > Hi,
> >
> > On 2024/05/10 7:41, Luiz Augusto von Dentz wrote:
> > <snip>
> >
> >> If I print the actual value then we got:
> >>
> >> Primary PHY: Reserved (0x81)
> >>
> >> I guess one needs to disregard the reserved range, well until they are
> >> no longer reserved then it will no longer work. Perhaps we should talk
> >> to broadcom to know what is up with using reserved values and if that
> >> is an apple thing then perhaps we could ask them to provide firmware
> >> that acts according to the spec.
> >
> > Apple and Broadcom do not support Linux on this platform. The kernel ha=
s
> > to work with the existing firmware (which is the firmware macOS uses),
> > we don't get to request changes. If the firmware has quirks the kernel
> > has to deal with it, that's how it goes. It would be great if we had
> > vendor support, but that is not something we can control. This is commo=
n
> > (Linux is full of quirks to support noncompliant hardware/firmware).

While this may work for a dedicated driver I don't think it is that
easy when we are talking about a standard interface, except if you are
going to maintain a separate HCI layer at the driver to intercept the
traffic this will cause a lot of regression to users unaware to the
fact, and it is not like you can't get rid of it, just plug an
external Bluetooth dongle that behaves properly.

> While I agree with Hector here that they won't even talk to us it's
> sometimes possible to figure out what exactly they were thinking with
> their reserved values. Apple provides "Additional Tools for XCode" which
> include their "PacketLogger" which contains most of their vendor
> specific hacks with a human readable explanation. I wasn't able to genera=
te
> this specific event with my hardware here but I was able to inject a cust=
om
> event into their trace format and then load it and see how it's decoded.
>
> From a very brief look it appears that they AND Primary_PHY/Secondary_PHY=
 with
> 0x1f to decode it and then support all values defined in the bluetooth
> spec, i.e. "no packets", "LE 1M", "LE 2M" and "LE coded". No idea what th=
e
> higher bits mean though since they are ignored and don't seem to be decod=
ed.

Yeah, I think I saw something like that not long ago, we might need
yet another quirk to deal with that though.

--=20
Luiz Augusto von Dentz
