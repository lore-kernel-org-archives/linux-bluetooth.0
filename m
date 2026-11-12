Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499677;
	b=oTtzZRpo24LntnRW7b66xsmTxHrVi5c/n815tIkp+FTms8da+MIstwZ/xUzj1eDioqRS
	 B/E1TbXAvVFwMriNGuOo4wV4Fy/SynFVGt6amz2nvFlhWyD1CDcjTRUuRTYfqslUjCHNt
	 5Ew/nCEz0yOBMb318Y7i2LX8dLGpbJ4oIJmTkDEbUK8QCG6i1RZot3mdIw7sYjRUDJ1Oa
	 QTBmf6YSp670cvpYjOPVSuFVqpaFTBctHGp+9MvahmTc2TtU6MWePZJdwIPzyq+gJUvI4
	 7EMnOSDGg4C908Ol/xW4x1ZTwCQuF8LQ4RW01Be6+dku1Wis7RksrhItvZyGVvagfXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0j9XAe++jFkHvVPrr2Fgcz/pjM7x8OzYNQ361KAdK8Y=;
	b=vwcoIylCk5naz4q26J40YhFLqVcghgEU0gBN8nd0MJ2OIxBn1Ua9bdwDpZaoqmPPg7sK
	 UDh3/uEyNdNdmGa2KcQrwfmEB6sbgTcVwn/Tixe28SZrDP/5xtjj+8bdh0fbKEiXgWukI
	 tINjA1ZAQIph/ISDsSsdhndR0Qm1q4K5+aNswQXueLyMK1fBrhfttc+aQB8sgSfMYQD/h
	 Q5Dj6bsWcMXS2nLwSV91hYLHavdFzNc8vfQ3cHSQ/jVXOYQucI969fFuRhiTD1gnd4PqT
	 Fq2l97usS423PER3n6/pEqgE6pUkOvKkvTDwaKnyGaKBk31QJ7fOaD7CXWnXMJnlcGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ficoD+iR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC0606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 16:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25AC0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ficoD+iR
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b3b57a31f7so58257b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 08:07:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794499676; cv=none;
        d=google.com; s=arc-20260327;
        b=b85QOEzqfu0e5rREuD3Vju9IiWePNQWu+mMDzM5So+ecgwft3jXJyLsbqrUJQMFu0K
         66eyQwN/ldrQULyuBXdS1mggQsSPYYKuYyxxi8Lk46RDesFpzw1QC86BoARj81DarUiX
         4mJoPuvCPS1qFVV192qPQd6yBwVTzc1PX1PilQpnGq50ajlENf+Z4vDe9cht32gF6pN8
         mt3qTJHKfZPkLUzNi9/bQKnpcvLDWzyq/wBzNL0aSCUgM9BhwLHggig2yU9AwUd9tI6/
         owkyoZgYEDrbWlVY+7ofa1uXLg3MrWYHl6drSC/VPaNtLEb9czMCG5q1yMmlq7RMEL98
         5Alg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0j9XAe++jFkHvVPrr2Fgcz/pjM7x8OzYNQ361KAdK8Y=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=i0H4iRjkeVnuDXKJoWGGV9ZOR9a2V5HFX0evDBEoiewKO2579VnrHbDziytDNrDxoj
         XKuv2LJzdmB1ljhIePPaqNyqXJ4sO9W+x6+PF7kYGPBRJvEzEFR+VImMvd8cV99ozyfS
         aD3xnLe0dXTiqURDrjP5bHoPsOT4qnNw+AgNwKclfPA+H4x0WuE7v5CQil/slxjXkn5Z
         315oHV1mtgE6bLXLcBsqzp7ss4o+ZUFFtuMAns6EMw9e3aQwk2ECwOG8dEgMTxTHbN3j
         n1+VOAnAY70CFxmr423Kz3xwpXs6cdkJPQfibOXmgXmHgH8O901+SdOO8xGa5x6nW3JQ
         AmOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499676; x=1795104476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0j9XAe++jFkHvVPrr2Fgcz/pjM7x8OzYNQ361KAdK8Y=;
        b=ficoD+iRtpU9OIwoRLqYS4UAEAMMUDSLoTTj4koto/tA+qrP9bRMI/83glzcztaYHc
         x8XzBPsDYo4L/UxZfkXN10uBGTBmMa96sqvshWVVJpC2cUO4TJplo7LiKpFpQIpGT7hX
         a1UwGFKfpK5gzoA1sZ3NZGFRwfn3RTYtVasw71ouDp3EvJngV5WD1mPU1DKcioRS7Erx
         PrP2ZfBCprmY4GwvJ/es5X4HYypPd1UY+TU40gDlPYY6CzQVxhVJJMaPK5ItSPzyHCNh
         e/8ssBs11pyfWQ1CG/Ati/TWv9Ztb26XZEs6sjsV30SO/Cf/OatA94KzsEEYVO0tes3R
         gJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499676; x=1795104476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0j9XAe++jFkHvVPrr2Fgcz/pjM7x8OzYNQ361KAdK8Y=;
        b=NqmNGjoOEhCEZjk6Tqhs9EtD0FmjNbzUH/c+mUATi5j8BExh7H34TcYCNglIHjBggJ
         4Ad2mEbthbE2gMy1ovTfpv9zW5L8PfkYsGX/H81BmF1hQz5bqpQ9AYwA/THljJjKBInN
         R5nfsKmDZF9q0c2JmWbuVFefhyEce403mu6C3c7nyKIBd0803ssngySVH+1eU245Pi4L
         z05qtqLT27QANhY14d7QnSZTuN59eDQtVWDpSTSXef+vxeMIAF9RFKXr+FmJaUQiHALk
         slsBSzPLR+d24NqWuJ1EcIPu2aLkCpJSpp5tuhX5Cs5IHMjqlx07XK8tTH38sCuJgjAN
         vusQ==
X-Gm-Message-State: APuU4Z/830jM6EmWCqikFCZedFrpSkg+fbDmruwpzAZgAhryo5Cw0LP3
	q+2JZMnDxxqCQAanq3q6Y0TH4sW6+JHokaQ/RXgOhIAiKywvbBvxfF75BZTq+4iBQA3L4YOOuyn
	kLc6fF/mlhgvXXIYXQJiC3YdlG2if5gU/8aQA
X-Gm-Gg: AYBFou1X334w+HPOAoGMsSN+RhJGVw8ayCArFPhkxwi+53QYBANmikFhnuPLsVUfd0H
	hb3lvKMS0WVWfcrhSamfDCjHZWU4QkrkJB+EpqAPUwbUQyWS1ObJpSQBoTV6mTdkJ4StKuPnpgO
	DUrWTiC9HH02fJ53z3SuxznlJhZQyzEOjlgVcD8ateKbKPA2N914ZtXz+4vAAAZMvGxsUXZDc3X
	Uos0GbxJpfJSzr/r3JogSZ67ahj11lotr3dEMpEqyIZdWXl1m2W+3UEf8uc4SvWBi68p+K761yp
	2WXvjsFlWuOlqIkEcOAzVIxBUnMrZFOJyqt572V2d+bA4274R1DBZx6qMd9GXNr0++04MV9KgXp
	+7bA43zjMO3ih3FD08+CIs+CoqCJK56CLFVan+o57Ucmj89SCvV9eIVnVppt7bBBDPdA5jBxNyr
	82MGTAMLWNZRtZUyBTy+h1S6HpHP1jXZBqFd5kLR6RTvc+tyDqdxWt0uFd2XU=
X-Received: by 2002:a53:d6cc:0:b0:67c:1336:e183 with SMTP id
 956f58d0204a3-67c6812cc86mr2642567d50.104.1794499676192; Thu, 12 Nov 2026
 08:07:56 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112032250.37687-1-kevin@simpleble.org>
In-Reply-To: <20261112032250.37687-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 11:07:44 -0500
X-Gm-Features: AclHuK9RnvpyLrXtFpSLoDmCCUJI_BvqS0oDKWkIdxwpzlKG9t9heF8IURS33xE
Message-ID: <CABBYNZLiwCUAUCnVDYqWdjv5m4sFA=pKX8JAeFU1OXq-6LN7vQ@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 0/4] Bearer.LE1: Add ReadRSSI
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Wed, Nov 11, 2026 at 10:22=E2=80=AFPM Kevin Dewald <kevin@simpleble.org>=
 wrote:
>
> Device1.RSSI only covers inquiry and advertising, so once a device is
> connected and no longer advertising, there is no way to follow its
> signal strength over D-Bus. Applications want it to warn about a link
> that is getting weak before it drops. Android (readRemoteRssi) and iOS
> and macOS (readRSSI) offer it, and the kernel has Get Connection
> Information for it, which only btmgmt uses today.
>
> This adds ReadRSSI to Bearer.LE1. It is a method rather than a property,
> so bluetoothd does not poll: each call sends Get Connection Information,
> which the kernel answers from the controller or with the value it read
> in the last 1 to 3 seconds.

That still a poll in my book, not bluetoothd directly but I bet
application will start to just poll it on their own.

> This was proposed in 2014 as ConnectionRSSI with Start and
> StopConnectionMonitor on Device1 [1], and you found raw RSSI too low
> level and suggested a normalized link quality instead. I went with the
> raw value because it is what the other platforms expose, and what
> applications compare with the advertising RSSI that Device1.RSSI already
> gives in dBm. A normalized value depends on the controller and antenna,
> and it can be derived from dBm but not the other way round. If you would
> rather have a quality value, or the TX power from Get Connection
> Information as well, I can rework it.

Well the reported values are vendor dependent, so I'm not sure how
much it would help since you can't use a measurement of link
degradation in a generic manner, it needs hardware details to go
along. We need a clear motivation for why this would be useful apart
from just covering what other OSes might have since they may use a
vendor command, or in Apple's case, probably deal with an exclusive
vendor which makes things a lot more simpler.

> The kernel reports a connection as soon as it is established, but
> refuses Get Connection Information until it has read the remote
> features. A ReadRSSI made right after Connect returns therefore fails
> with NotReady for a few tens of milliseconds. Letting get_conn_info()
> accept BT_CONFIG would avoid that, and I can send that to the kernel
> separately if you agree.
>
> I tested it with the functional test in patch 4 on bluetooth-next
> 3f425f95ba39, and on real hardware: an RTL8761BU connected to an
> nRF52840 with a random static address. ReadRSSI returned -50 to -52 dBm
> while the advertising RSSI was -50 dBm, and the kernel sent HCI Read
> RSSI about every 2 seconds however often ReadRSSI was called.

Which means every btmon trace will now grow just with RSSI reports, I
mean I could live with an event generated if RSSI drops below a
certain threshold, not a command and event, every 2 seconds.

> I left out a bluetoothctl command and can add one if you want it.
>
> [1] https://lore.kernel.org/linux-bluetooth/1401177171-19994-2-git-send-e=
mail-andrzej.kaczmarek@tieto.com/
>
> Kevin Dewald (4):
>   org.bluez.Bearer: Add ReadRSSI method
>   adapter: Add btd_adapter_get_conn_info
>   bearer: Add ReadRSSI method
>   test: functional: add bearer ReadRSSI test
>
>  doc/org.bluez.Bearer.LE.rst    |  17 +++++
>  src/adapter.c                  |  22 +++++++
>  src/adapter.h                  |   7 +++
>  src/bearer.c                   | 110 ++++++++++++++++++++++++++++++++-
>  test/functional/test_bearer.py |  23 +++++++
>  5 files changed, 177 insertions(+), 2 deletions(-)
>
>
> base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
> --
> 2.54.0 (Apple Git-157)
>


--=20
Luiz Augusto von Dentz
