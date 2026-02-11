Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E321D3E4
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834650; cv=pass; b=e3wDbMlPyO3TuDberMS79W80q8SJdsq/Y5g1XNChXWtkF/+KU6uhY9GJ3lDAVRptW5MeQ8Md8U+fUs7Fx6jqOjQsdIcl37AWCzXlVuGFHD1kYWaQ7i/LOc2mCTAkFhiJw/4lYQR8N3zLyorXFqsjuijrMutaJhF0pFkwjKxtfro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834650; c=relaxed/simple;
	bh=0QM7M2W8LYK3DjVJJBjTPTpxduOt7LfUYTztBfZEk5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOqQpNJd3S+X9qZyDBqCSa2J3Fln1Mhleg4U9Uvz1hDuCPfxNTmYwTcNlS5PmBNQ37E8dsCsHRAiU8Dw4h9HKJyp4fuUXMgxisZP857YjezNC+idZXu3KC3Q4r2PYOn/S9+XfExxJ9YHE4LGT3IqCdsLFXjAz63sqNTiVL97Lio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaGYBb5J; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaGYBb5J"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7964fb9ae3dso36829457b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 10:30:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770834648; cv=none;
        d=google.com; s=arc-20240605;
        b=a7J7QyZhD5hOdcUDimK4y6RY5OyhuuoNlkdpP657cOfbGPXXmZo3tf7iJKTXXq6mwu
         vR6LtK8jozLDv2Zw30jxP5+qBTSTPZdVpS5bXVxXKbPHeGIqSBb/BCNxkonctBvDE5Qz
         R7Z6zeqR3MyTZ8B2DDloTLCBtlOBjXrfqpkRt1mEDg9d7fhOZAolP4omzYVznQBZGmug
         ev8VBhuM8ItBtjehTN1Ygb70w98GnAhLicUi4UTDpI9TUtAujQke4hz58PgBXZ6FXPPX
         D28nfseIwEZQnh0GlTDsIKSZhKXWCSbStMhHGpq89JO7V73OBmNJ0HJo4aNRM/NbO1B0
         MDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0nD0oejct/PeLvhFaDZJP2Ng/kaYAx3Y108YLtSvXMo=;
        fh=1fz9LSvKI35CJE+hUnH4yaORc8MHueMppyFMJ5ZRfM8=;
        b=JTSKUWTyXy5KFQ5KOTDJJWGVgxyUyoRW0ntgD4LB5V80bAPbN00PmB04Txw5jgGB5Z
         t2ermO0YRmV9z48Q5xYdn3KvSyldXmQ/WnzGcHaxsnrpP3YDFo9me3EtfspxDx7YqfSA
         udJbScRtrEeMJnqGU8vV8X/JB1pPGNvCA0PYoV8aT9x/Dcx8vcrsNo5jVhxK+UTs5h7h
         23887lRNfKjwEA5UcD5gnVVsFqNpUSRHdWFi8eXehaaOrcX3mAwapbRwoTvv0OIab1f2
         Kn536ylx2uGJqcRju24xuqiPJOaW1GZ2Mfh6fiI7X/hjhLrB5W4MApkMMrJnbMvw3SV8
         llIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770834648; x=1771439448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nD0oejct/PeLvhFaDZJP2Ng/kaYAx3Y108YLtSvXMo=;
        b=CaGYBb5JkWWVwcJ1FBVnyjvGqlq8++mGyF3yRF9CCCKqC1ZJ6yyAbXhpdM3ZhkzlNR
         +de0dRRzlJpEI7wfsTs9VxpAGVh2q8PmUgl8HJaNlEBvvRGOBhFwNZkv9075IRjCR4D/
         uZlGSra+P/orOTMzIuC+TS33ZxSzj18FV36CrHwOh+UN+Wke2Mjy7xHY7WNZLpZeG4Bg
         1gIoQLOmXX6eBoBIynQYTkMgLZPI+mBPYBaKS8mTeOpnxi3A2fYB/gwn9rGYEeJDQW1l
         8tJvtkaafdb/BlgsHrjblb31IbNE4qsDs1Ufi8SvsoA4s5oEOlTMf4R1K4VfqFoltILX
         qEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770834648; x=1771439448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0nD0oejct/PeLvhFaDZJP2Ng/kaYAx3Y108YLtSvXMo=;
        b=Uz862lAYzeqm2VccfXEXqOjQzTz81MV4hcisWM3Luld0F/Qgpyk4Ykib+8KY1j104u
         +52hR25unwumIXPYGcrBtCoazGP/RZMgFCyAnXInLqjG67yJ/MK5Jdt4KNFsTFzF7yVl
         jKRRdEXHuLGZNJ3vbNptdwu5pNHR9nIf/FBIq4taIVqQ4kWEiSLkplsJW9sfUS0Q7ya3
         98YQYJYcym80rH0G5W0AM3yJBGA4fqPbXR1jkz12a8T0GpyEdujlnexve7rlagDkodQb
         /Z3boPdBRef4NQDka78oa26xzdnZ2OS8cl2WgoFHFEtJYFEXcVRP0Z31KTaBnrlu/dUR
         8Kuw==
X-Gm-Message-State: AOJu0Ywvtbb55Hl0+u+G9P9iH8QeZiCQPINmiZh4Gnl80BCygz32e8Ir
	920bAwxZu0ZfWpfy0XMS6SkY7WXXhX5v/gRh9bv9wb7QYxkirlUQS3uH0Yb9MCbTbNA7eXGAzYX
	3dkal+8G4VbphDwhvZQA8V7vhw2AIHuo=
X-Gm-Gg: AZuq6aIO56zu5U/qVNuGsfxW1TkLV/42oXt2gj0z2IYJA7wuv2urBJsq1tEw4dyfqWm
	3wEPGtgfiAaxYm/lkAK1aLcSoqVLuVpgPgrCK4XgAuUTjX4GaU79ER8ydtWwRWC1szqL41pHckS
	BcQkU+qMNlQZplYVr74ePbuwdxZbI+FiJeicakOQL7w595B2cal1atEUXsonHwroD0F/CTBCKct
	cWE0swaJMH/EoGmcwQIb1/8L8KKRYc2MX3lKx7d8hFvPQ0lAQ5jpPg68QkOy+zztp0r2jjIm3MO
	fjwGZ5PjKDeSLdnECvFiJTm81P3pyvUdMU/hZX7zI2m4NPt60Ck6FdYg026yEviOjaGwAw==
X-Received: by 2002:a05:690c:e36f:b0:794:6fa2:a045 with SMTP id
 00721157ae682-79737684efamr3877577b3.3.1770834647535; Wed, 11 Feb 2026
 10:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5832992.IbC2pHGDlb@n9w6sw14>
In-Reply-To: <5832992.IbC2pHGDlb@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Feb 2026 13:30:34 -0500
X-Gm-Features: AZwV_Qhx1oISKHa--F5aWMlUY1lrbOa10XQk6oN_BBu3ft36bssi5xqugvsxdLc
Message-ID: <CABBYNZ+O6KbjXoxTKSaPnSd=p2CDJ7j6cBktPT4xXD=PR0CBhA@mail.gmail.com>
Subject: Re: Running GATT/SR/GAI/BV-01-C and GATT/SR/GAI/BV-02-C tests
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian, Frederic,

On Wed, Feb 11, 2026 at 8:17=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> According to Fr=C3=A9d=C3=A9ric's instruction [1], GATT/SR/GAI/BV-01-C sh=
ould executed
> with a custom service/characteristic added via bluetootctl:
>
> +------------------------+----------+---------+-------+------------------=
-------------------------------------------------------+
> | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl=
':                                                     |
> |                        |          |         |       |                  =
                                                       |
> |                        |          |         |       | - [bluetooth]# ga=
tt.register-service 0xFFFF                             |
> |                        |          |         |       |                  =
                                                       |
> |                        |          |         |       |   - *yes* when as=
ked if primary service                                 |
> |                        |          |         |       |                  =
                                                       |
> |                        |          |         |       | - [bluetooth]# ga=
tt.register-characteristic 0xAAAA read,write           |
> |                        |          |         |       |                  =
                                                       |
> |                        |          |         |       |   - enter '1' whe=
n prompted                                             |
> |                        |          |         |       |                  =
                                                       |
> |                        |          |         |       | - [bluetooth]# ga=
tt.register-application                                |
> +------------------------+----------+---------+-------+------------------=
-------------------------------------------------------+
>
> With the current PTS, the test is being stuck waiting for on indication o=
n the
> characteristic with the handle 0x0008:
>
> > Please send an Handle Value indication handle =3D '0008'O after enabled=
 by the
> > PTS.
> >
> > Description: Verify that the Implementation Under Test (IUT) can send h=
andle
> > value notification to the PTS.
>
> According to btmon, this is the "Service Changed" characteristic,
> which is automatically created by bluetoothd in populate_gatt_service().

Hmm, it looks like this was done to avoid manually generating an
indication, so service changed was used, or perhaps the purpose is to
test the service changed behavior.

> bluetoothd[511]: < ACL Data TX: Handle 24 flags 0x00 dlen 27             =
                                                             #36 [hci0] 118=
7.212787
>       ATT: Read By Type Response (0x09) len 22
>         Attribute data length: 7
>         Attribute data list: 3 entries
> ...
>         Handle: 0x0007
>         Value[5]:
>         20 08 00 05 2a                                    ...*
>             Properties: 0x20
>               Indicate (0x20)
>             Value Handle: 0x0008
>             Value UUID: Service Changed (0x2a05)
>
> It looks like the testcase doesn't use the characteristic (0xAAAA) set up=
 via
> bluetoothctl at all. Instead it seems to pick up the first characteristic
> returned by READ_BY_TYPE which has the 'Indicate' (0x20) property.

Well it is a Read By Type what is the type? If it is 0x2a05 perhaps
the intent is test service changed behavior, not an indication of a
specific characteristic/handle. Do you register after connecting or
before? If registration happens before connecting, it would probably
explain why it fails, as no indication would be sent then.

> After comparing with the instructions for other tests, it looks like I ne=
ed
> to use 'btgatt-server' for manually sending the notification.
>
> Q1: How does btgatt-server interfere with bluetoothd? I guess that both a=
re
>     listening on the same CID? It looks like btgatt-server has precedence=
 in
>     accepting new connections, but how does this work?

I would go in the direction of using btgatt-server, that probably
doesn't know how to handle service changed at all.

> Instead of following the bluetootctl based setup, I then ran btgatt-serve=
r and
> sent the notification manually. But there is another check in the testcas=
e
> which disconnects/reconnects the ACL and verifies that the client configu=
ration
> descriptor has been reset to 0 (GATT/SR/GAI/BV-01-C, no bonding) or been =
kept
> at 2 (GATT/SR/GAI/BV-02-C, with bonding):
>
> > 4.8.2 Characteristic Value Indication - by Server
> > =E2=80=A2 Test Purpose
> > Verify that a Generic Attribute Profile server can send a Characteristi=
c
> > Value Indication and that it retains or resets the configured CCCD afte=
r
> > disconnection and reconnection depending on bonding.
>
> After reconnection, GATT/SR/GAI/BV-01-C fails because btgatt-server has
> exited on disconnect and the consecutive READ_REQUEST is processed by
> bluetoothd (instead of btgatt-server), where the CCCD handle (cached by P=
TS)
> points to another characteristic (which of course doesn't contain the
> expected value).
>
> Immediately restarting btgatt-server can fix this, but it feels like this
> defends the purpose of this unit test.
>
> Q2: Are there plans to implement "manual sending of notifications by hand=
le"
>     in bluetoothd/bluetootctl?
>
> In order to process with GATT/SR/GAI/BV-02-C, I modified btgatt-server in=
 a
> way that it accepts further ATT connections after disconnect instead of
> exiting. Although the PTS test is happy (due to the retained value of the
> CCCD's value), it feels wrong to me to reimplement the lifecycle of the C=
CCD's
> value within btgatt-server instead of testing with the "real" implementat=
ion.
>
> Any idea how can "improve" execution of this tests?
>
> regards,
> Christian
>
> [1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/qualifica=
tion/gatt-pts.rst#n1106
>
>
>


--=20
Luiz Augusto von Dentz
