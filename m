Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F33D3306
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234468; cv=pass; b=AQToJUw2hHsSxsMiRJFHmJCciZOg4T/YblRqB7rx2gEA2RoC52MxIA+t4ZwWCwdh+FDF9+EuyEYPfaWMAEa4/G8KjI3UghixjAq30nf4ddbhwr37/VlpWI31xbaw7hXdgV8tf5LVymk4yIjE6XsZ9Er7yL7ka0AQi1cNHohnkl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234468; c=relaxed/simple;
	bh=xSQRpKeeNKfKBvS3C02BqcvcZzXfHeCUMzgqxxx2dKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNr9NjhG1lqDRECR1HyL1IzVnFyIT6J71YNyLKY+T6OSFpEsd4ga23JCrb7bPQ62SyyZ+7xPtw5BqQoj8VcaKGH+BwVRzchiHvhrH2mxfXQp4GApYSwAXyiR/NpTEWa6V9I6vgOKJBVQqZSfQ0WyLaf9St4DdaYJ99vZ6g6DpYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Offd8KmY; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Offd8KmY"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c7a743cf8so1448929d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 07:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787234466; cv=none;
        d=google.com; s=arc-20260327;
        b=V61GJnnoBq6YiOxmIqDNdJDzo9vIdOMGNRdwex+X1twRmujI/THgaSMcbWHCQXLuMI
         a7/eZ9VdYhnjlb/FiMjBOF1JRSzBX1ZbFpIkb1CXgzjckbarVOEkNWSgyIqQTOzz/Sb9
         yMteDNib+fmMl46TEYoWibBg+mXESRxcvYfHov2+n17XHDIIvRwtuKtulcpZ14TpeyXw
         hxJ91wOJ8xmbczUlvITtW2PsgJQMYGMPdg1SQ4/LuhdE/3DuMbQedIAkYE6EAU9u9rdl
         NGDcQJ8ADVqk9URUJgK9Kblp4kFvkhcZ1+2EqEtefroJ+RkYTgAf+SX0crUH9bY4McUY
         5GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mFw4ov9UI290U+CzEVnKFU3K8cJlhsqeJ+sQcBuQ1dM=;
        fh=gd5kN0XulitFLkJHrdcw3txxh+2smzqtoNYk3am8JOw=;
        b=X0sQyss9+1aieUEDtqyOgFI+Y+0OqoIBydhLZPYzz2lmP+sQXFlnYLGu18guHQe7Zd
         ZQrmBGvXECC18Xku5jVacgWbSuiMA8cOqmXYGfINGHs3pvuJvowPlZfQJ8NrRrUa9nF0
         al7sLKPYA0aRh8fZCv5jLs54OS9bC8S+54s35Xafw7hZs1BtXdLZT9WoaO2F4JFn1YVc
         Laa5fxgRwstJ6NHnSYFk42o/55JFBswA5nP+XX0f3a5wb+J45KUtXs0lcjHiAH/JAFIm
         tQRoACgAoTvK/WN4SN5AG2zkXZLLL7x9iw2pG/ley3GNmLnZmdsakMK6PPbTgPmPJ0wX
         IteQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787234466; x=1787839266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mFw4ov9UI290U+CzEVnKFU3K8cJlhsqeJ+sQcBuQ1dM=;
        b=Offd8KmYHhNEMHwKPuRd/agRHCN3vu/H4kViNH6PaXjfgm0fRIlSMU2D8BYpxcJdDK
         UFSmnd0TbN8fxronAU8LKEfyqe52xExMbORlagXTNbfXzBcDT/q/FQi4idrglGOQX0Uo
         g1r/Sqj1rokk+JNA9iIKwwzh0vcDSjkci5jtGrZf9FU0mNwjWO0xGpiIX8LIRO8UL9+Q
         9wg4MO27LG66zMCUCVUEMPR3z2b4xRsDO81WKaLXsoyiUAM/bmfnR/9NLtEnadoUNrbO
         lgyHJVrSDhzl2ejM7u+3PAlMuuQCb2x2a5bnVt1qNptfNozYUo7eD+QMn9uDKIV8V+sT
         CjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787234466; x=1787839266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mFw4ov9UI290U+CzEVnKFU3K8cJlhsqeJ+sQcBuQ1dM=;
        b=PX0FbFn8nJJX5Ve/1DI9H4HBQEybCASDajV0kDtyzUMf/44hiE1kQ+BDMflOIK6bBP
         rPW5Umk1aIL0B4Fx9+cKa8zSqKmYwVqcCeNCxAqotw5KZQdpEafXIcbHykHDP/3AE9kx
         nEMpRqf8nuPfNTBTHB51NxrN3DrQKPxJmbSImpS3HZdFf5VMr+MXCU9Txv7mhkNduVKN
         BdzeyWN0EmIT3WVAEoEpkYUaonSUw6DZOljdNLQG8JUWEO6QsGvRChejOAy21GxBJ9uA
         1LcHJ7FN5WsLVN/s97A70EFyA3jvYk4RvMHhuByOqdt7pRPqsQSCDfAMqdyLN8h9VDSD
         c4UA==
X-Gm-Message-State: AFuF++nFFHmSYYT0vfsStKomEZ4RckjlOaLSEgeadzlVaG2uQNZ3M1Hh
	igqKw/sOQt34KxBwUpw96bQ4OFDIpYz1ZLh90+sKP9T7AHSVsRhIbspiMiyNj3Lz1eR4VGEID4A
	/nCfnjb7PpWElI5jvSKtVLDp3MMfrzaY=
X-Gm-Gg: AR+sD137iz0T8TN7dEXxj2YTdgYogOhRcVEoTmBcO+LcYRuG92RGGAqeqtVl4M3YZEP
	BcuC1XjfVc0SXOQHKPmqK5OcUBdpwwpnbSO0h1vvhVqSVvbKpNMtszZ67TROAbxofe8vkOj2Vl2
	eOvkx/clBh2RbPpFCbMF22fgRO8w6mFnblMe+KeARiC0C4Emq02eCo69ErmI7QIYhoyeddjQfM3
	81zMZ76K02hCkWeHYiBtcZNR3lRVIA36NE3j+SVbk8wQSWDUQrDraUCAfowz5pod2WtcHy2Si2m
	b9SH7qdaLQJNnhAk85E+K86tPBoU9KupBJYEuUDHzSENfMUX1my8O8/dkXv2pyRJ
X-Received: by 2002:a05:690e:4814:b0:66c:de56:3acc with SMTP id
 956f58d0204a3-66cde563e2fmr693386d50.20.1787234464737; Thu, 20 Aug 2026
 07:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819223144.82045-1-m.kurz@irregular.at>
In-Reply-To: <20260819223144.82045-1-m.kurz@irregular.at>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Aug 2026 10:00:49 -0400
X-Gm-Features: AcwNN1VUTclKEHO39i1TQD4K8eF9QjvOxOLAdV39FzccRZixJPIZJT9VVNWZp5M
Message-ID: <CABBYNZ+4uMBiTcmTa88xKPg-454gOQXqnhvgq49DbjGYM6f2zQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Add component batteries and Fast Pair Message Stream
To: Matthias Kurz <m.kurz@irregular.at>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Wed, Aug 19, 2026 at 6:32=E2=80=AFPM Matthias Kurz <m.kurz@irregular.at>=
 wrote:
>
> True wireless earbuds can report separate charge states for the left bud,
> right bud, and charging case. Battery1 currently has one fixed object per
> Device1, so BlueZ cannot expose those values without collapsing them into
> one percentage.
>
> Extend the battery core and provider API to support child Battery1 object=
s
> with a stable identifier, optional percentage, and optional charging stat=
e.
> The existing Battery1 object at the Device1 path remains the aggregate
> compatibility interface. Component objects and their new properties remai=
n
> experimental.
>
> Add an experimental Fast Pair Message Stream profile which connects to th=
e
> advertised RFCOMM service and publishes its left, right, and case battery
> updates through the new component objects. The generic unknown-level stat=
us
> bit is retained for earbuds. Treat the TWS-specific case value 0xff as
> unavailable.

Wait, what are you talking about here don't really match the Fast Pair spec=
:

https://developers.google.com/nearby/fast-pair/specifications/bledevice#mes=
sage_stream_PSM

That seems to be BLE specific and uses L2CAP not RFCOMM.

> If the Message Stream closes while BR/EDR remains connected, invalidate t=
he
> values and reconnect with exponential backoff. Reset the backoff only aft=
er
> a battery-producing stream remains connected for the maximum backoff
> interval, and do not retry permanent local errors. Once BR/EDR disappears=
,
> cancel pending work and remove the component objects. The final patch add=
s
> a standalone diagnostic and provider tool for interoperability testing.
>
> This was tested with Pixel Buds Pro using an ASan/UBSan build. The live
> tests covered fresh left/right/case reports, an unavailable case value,
> explicit Message Stream disconnection, remote device disconnection,
> reconnection, adapter power-down, and cancellation of a profile connectio=
n
> in progress. Component properties were invalidated or removed as
> appropriate, and the daemon reported no sanitizer failure.

I would really like some clarification on what protocol source was
used, because this doesn't seem to match anything like:

https://developers.google.com/nearby/fast-pair/specifications/extensions/ba=
tterynotification

> The full 40-test make check suite passes under ASan/UBSan. The Fast Pair
> parser tests cover payload fragmentation, a complete frame followed by a
> partial frame, invalid input, a zero-length frame, the maximum 65535-byte
> payload, unknown-level status bits, the unavailable-case sentinel, and
> reserved battery values. The Python tool compiles and its matching decode=
r
> was checked directly.
>
> Matthias Kurz (4):
>   battery: Add component battery objects
>   doc: Document component battery objects
>   fastpair: Add Message Stream battery profile
>   test: Add Fast Pair Message Stream tool
>
>  .gitignore                         |   1 +
>  Makefile.am                        |   8 +
>  Makefile.plugins                   |   5 +
>  Makefile.tools                     |   2 +-
>  doc/org.bluez.Battery.rst          |  35 +-
>  doc/org.bluez.BatteryProvider.rst  |  16 +
>  profiles/fastpair/fastpair.c       | 650 +++++++++++++++++++++++++++++
>  profiles/fastpair/message-stream.c | 129 ++++++
>  profiles/fastpair/message-stream.h |  42 ++
>  src/battery.c                      | 401 +++++++++++++++---
>  src/battery.h                      |   4 +
>  test/test-fastpair                 | 561 +++++++++++++++++++++++++
>  unit/test-fastpair.c               | 286 +++++++++++++
>  13 files changed, 2079 insertions(+), 61 deletions(-)
>  create mode 100644 profiles/fastpair/fastpair.c
>  create mode 100644 profiles/fastpair/message-stream.c
>  create mode 100644 profiles/fastpair/message-stream.h
>  create mode 100755 test/test-fastpair
>  create mode 100644 unit/test-fastpair.c
>
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
