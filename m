Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4A86352
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068471; cv=none; b=ESxn+6u2vCGMzRW6feTCfW00lwqp57hozkm3KdolqfR3jMcGtyN4PvriYLdoFZ72v98Lfum5/07ek1vdGFTJZbBkk7KNJ8E7Njtg7Sb+YrHUgHgpyhxcX9c8kv+icZ3L5Vtbu+1RNwPvPRqA7bfcrYQUqLXfMhbEUHaHfbjp1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068471; c=relaxed/simple;
	bh=ItXwnOm7vBJ8Z5lGUai5lZrpb5+Iip4uDUr0Tur85OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQmvpldeEPv9Ov5JEbbt5pbt96IJ3YxIR9ICEtt5WCmtCH7yHV6voJN3cJOc3cfy4TQcZxy95LH52s1VtxRoWXEILDXIdivuBPBgInt4gq2/ZCqlrSHJzi6nn+ZGeq8+cFmTt1CqTHuUDKDXcN2F2Y2yrb4Nk1Lm90F7WAtF/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1RYmF/6; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1RYmF/6"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3106217268dso43262481fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747068467; x=1747673267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItXwnOm7vBJ8Z5lGUai5lZrpb5+Iip4uDUr0Tur85OY=;
        b=a1RYmF/6ns2pXFxu3NRmlXLbsGDB5DpPB5H6iby4Kf+THS0EhVUKTTyCdBYLxyoPrs
         xsW9nUh26Jvp/8aX3p20AkZVA/14xlIckp3ZF56KFtYe4y4R32SRVBSvtXZnnduQT/hT
         YkjBekDtfn9+iYZFfwgDzitX0YE/D00HVxKXy9tNfy7MMBH/qmQiNcSMn3OKHtt7HBnw
         1QbPl4JNU1OLBBFx2CjzBcXY/R32SlGE4x2TpEOe09wSLfk7HBGPJ1op3YRD/y4V6QMk
         g0gZ31cokNfrxeoGkosaNkxbjSkIrctypXGfBHvYP9tsW5bgRTSpOtkjvSAzhlRXDkSZ
         tOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068467; x=1747673267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItXwnOm7vBJ8Z5lGUai5lZrpb5+Iip4uDUr0Tur85OY=;
        b=VsTeMRnkMHDWDeJKisBZOI1VONav2IAv4F4jEZz0DSUL+oTROB82iUmzNT38YUc0Fl
         BuEWwgRrmb0EXlzQibnLM9spretYdyQDrvh33cl+ljru9Dlkq4Iy/kRgWFAfCwI8ySAw
         SHBm11B6FRYS9GDAebKUGOirznlF3wUvXnl35NQc7jaTOix1gENI41dI7/UI1Vtj4sQ0
         iAI+OCMXTsEavXv4Lf/5a7h/EObNRjKlFbjBWFMcKkIHU6cydilqEV751GkR3Y0r6hZd
         om54KfMKKbqkm5o9Rp8vE05RIBpTATQVOw4nIoLEZxeVqSqZSsoX+MBWgHzEswVNzxgp
         6wGw==
X-Gm-Message-State: AOJu0YwbOQCircBI7wlkpovXwK/+CDfdr+bI2xilEiHmrx/W15crY8du
	bGiswCs+Ob/9/I08RlIgHwETaTAOlZMAMdWkpd848RH80RAoBDYFX/OCwN0AbnQIRm4DDznISkh
	uu4OXCkpmIeLdiRiIww2kBzCRm6/6Izy58/0=
X-Gm-Gg: ASbGncuUy19CmZErwiccvbZ4+8luxyw7ln/KN4On3I3xympMN/Wx4QcVfvpD52VyU/0
	zIn9tCfa5WP8BRozmkXHO5sw/KfqM3o4Bc3uRt9epTRFS1ILF5iW5kkNfAik5LMMNVWJ26qOLA2
	I/5vww0p3143lI6tZjDMygDuGRN7nGQ+WGUWHjBVyy2A==
X-Google-Smtp-Source: AGHT+IHTc+VfllZLkiW6UUOMsdB5SovkLrAlUthSDLQHtdsbH24R3a0eL4xWY0lod4aKDIKofypeKvPTAW+UIlZdrDk=
X-Received: by 2002:a05:651c:210a:b0:30c:317:f3ec with SMTP id
 38308e7fff4ca-326c45900bfmr49584171fa.17.1747068467017; Mon, 12 May 2025
 09:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5681377.rdbgypaU67@n9w6sw14> <CABBYNZLruNnKJKCzYdF6803JsCxidQCu4OH9T-1wezP8NhS0Kg@mail.gmail.com>
 <22123914.4csPzL39Zc@n9w6sw14>
In-Reply-To: <22123914.4csPzL39Zc@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 May 2025 12:47:34 -0400
X-Gm-Features: AX0GCFvMNdBpUtYdAq028EdU9phuhLX5Oei7f6Mn2byqI0hNPf8jdvtZeqyRvzs
Message-ID: <CABBYNZ+uGQD7WeOJi+c3iTLH3uqE=FR9yeB2-cDwKwA+MPtGXg@mail.gmail.com>
Subject: Re: main.conf: GATT.ExchangeMTU
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, May 12, 2025 at 12:05=E2=80=AFPM Christian Eggers <ceggers@arri.de>=
 wrote:
>
> Hi Luiz,
>
> On Monday, 12 May 2025, 16:04:54 CEST, Luiz Augusto von Dentz wrote:
> >
> > ... but if you
> > want just LE perhaps you should disable classic then?
>
> Do you mean setting "ControllerMode" to "le"? I already have this in
> my config. It seems that this has no effect when creating the GATT socket=
s...

Oh, looks like the BR/EDR socket was not made conditional to BR/EDR
being enable, it should be fixed now:

https://github.com/bluez/bluez/commit/5e248deb85872a1031d2e18602ad04f39eae6=
1d0

> > Otherwise we
> > will need a different setting for ATT over Classic.
>
> I only needed this because I wanted to test with MTU < 64 for Mesh
> provisioning via GATT. Setting ExchangeMTU =3D 48 is sufficient for this.
>
> But I think that at least the documentation in main.conf should be
> updated.
>
>
>
>
> _______________________________________________________
> Christian
> Eggers
> Software Engineer
> ARRI
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Arriweg 17,
> 83071
> Stephanskirchen
> www.arri.com
>
> +49 8036 3009-3118
> CEggers@arri.de
>
>
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRA 57918
> Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik G=
mbH
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRB 54477
> Gesch=C3=A4ftsf=C3=BChrer: David Bermbach, Wolfgang B=C3=B6rsig, Christia=
n Richter
>
>
>



--=20
Luiz Augusto von Dentz
