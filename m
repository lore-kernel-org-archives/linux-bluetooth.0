Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794510736;
	b=qSV/C/yxqyboayoJWFbcjkNVT3vDB/Y4z7MN/9BWHH2nf0UNsDeHLwm7YYjl+41w+KnT
	 5XPavs95dV+1lWwWss3iVhk2rsG24ygv3oQpxrzw0zttzYb/nn/HQ1a8FMmPkAQ83QPbq
	 Uqx2U6A5nSKC9RZ1k8EBFn1ei/zC3WsGu9Z22OQOKOh2EdoFz2GrGPyAQB2bgRznzcNlf
	 ukVgMgxH1i1x/vkxPnhcdKXSb39pNYzK7st/87K871hN0UjQyuIvh/sDt2NiJbd3P6jbc
	 XMSqVAW76lfip9ZXuzwZPOsBJAdQJNpVm/wj1K8lQMG5Q1yxZp5d5mHW1o5cPMOd5xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rqk5CPiY59UsLG0gCy46rqp54XEDSm09ZFeKrVVDNPk=;
	b=A7XbrkVTgwdzzdKj9ARCJgx/Ra7ha03ExuUixN2zp9AhICz27ZWPzglQFIVyw1Q3ZN21
	 fpCTcZT9xWW296D781BZQaYapwolENVswYSmLuAOyby/d7vawD7voubH8/1IlsS1nHCXH
	 /fpgzOSmlgwtTrpUsfyq9aHYW0pWSeKphvBcUfhTm9AqRY/tkPbRxMZS65wcFQcEmZA+E
	 z8G6po4mABs/5bl9dA8mJOB/4lMiBg54Q2zyc8RoYphVSKfyoA1Ze7NI/61hvL/wvaLi4
	 5/MGwV1IKhGwt4iGXDPwSqznDMCBDcUb38ioSiZQDB+hs2CYqwMQJetTjRfBgv+6msQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QW04nIwu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A0606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6A0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QW04nIwu
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c2c2ac1c3so195218d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 11:12:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794510735; cv=none;
        d=google.com; s=arc-20260327;
        b=jvWASrdAk7l+sPlMxBHgLkvJz7bA+HEIOCMT2DMYCfhGoxyNcN+a56PhyKQsdp+4Wk
         74xsYdKIx0mOGtspmYhyZVWoBL1zK4HOvHKrmJ4j1HsgaK6U1YeQE5wLcb+XVV84VPUG
         WURAWmbNawDgzbNSF8Yhm3aq2mZXE6WE6jWE0f7IbQZcf18yCcY9cbxMIhzxHVG8DtBC
         jspF6jiPXPiPqAfkZvCvGedQE6GCXzQF0PG3kMXqJb8+zd4T5aRcaEgMkUwYCi6JOrnY
         FLTk9LVHL+XGHh9Imf/pPraySGQLEBVNG3Qr29Ds2Cuok1JrrJwMdjoHhzof8phxAT2c
         jQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rqk5CPiY59UsLG0gCy46rqp54XEDSm09ZFeKrVVDNPk=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=hMaoWTg/eOrI5/JJQAC2Jl1hvX54v2hgI3pxrJcmqzRyOdU6u9vk5TAEScOaSd9855
         2iRarrxNO+2OMlXJ+4DrE9SJi/TrB/n4ygwAN93Yzs8cirPyrVTCXnvFLpTRYOwfJQgJ
         r74/VD/X8yBYA8SjII9vjOJFUwCrfZVNXLiI//D45cUgZzqQOLE1SOamc6D4vQeQZA6t
         bUCnlQhB70EgPeXVFJj0EOBz2O13gIzxQdP+fZ3oucfYBBgLyZa+WtRXPh2W5f4dRHuZ
         4aRhnHOYvAnrOlD19yE9n7pcdtpF1d+rPmAGkOe8mg3KuLb7tbKzvkxS2mUfHGJoLK9u
         cdYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794510735; x=1795115535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rqk5CPiY59UsLG0gCy46rqp54XEDSm09ZFeKrVVDNPk=;
        b=QW04nIwupNVamdUCXdwoq5SOTPpvu9ql7RQs326lvFhr2RQ1XkB9FOlrAZObvSqvAf
         xPnC3H2RLZmFflPBNGXFxJwzbifYzPriWMQzl+X1d0zuFk5/WD6L1IdkYcKMVBP4/ehY
         ZbtOAFKnePuR+t5hUoYFVTCaZGfNHBhqO1ChVXVWBu0fYjY4Bv4JZGwZvdjxk8NHT7CB
         VVE01V14wVQaw3Rrbhvtwn/rsl1fl73ccbRFmYItNTqKcVzBLIaPxFs3liVENGqGQSiz
         +E8bmM+dmZ1jqM1G8XeIEtE5WqsHP7nkiL1i/XuUxcPaNGZ7Whurz0/Bt3Ah7DuV0Uqe
         npMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510735; x=1795115535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rqk5CPiY59UsLG0gCy46rqp54XEDSm09ZFeKrVVDNPk=;
        b=poDLxvpuxnz9e/fTc0jNTwo++Sjn1AFJ6BcfPdodB7UQdNqR0B7BvunyLGXR3btNGh
         Jwsv0zH87NNf1NZJztc41rWzG3uFfOJPuw2DTLbbToqUZfgFt2ZcYB7Fx9060EfDiyXQ
         FrrXNY/mjThp5zldly2r0SH4Yq/ph0+VLVuqV5PVogTVv1KsphKwLXn1L07end9p/yIZ
         p+nwLGgutE6uWLMOoP9r1uh6RSAiEpnGxOE4l7DfS94P/oYZIYy3uNWbf5yLGyMrn1tM
         kEZYRRzaDKXwpZWGwljrS0VjmMfO8w84XPElxqW1EL/sujoV1sDxByQ/W/EHTbKNEXpZ
         de1w==
X-Gm-Message-State: APuU4Z8jsucPFprpufsxVzvJTU+8CZqqaaRopE20loBDiRl6z55XpokQ
	Zk+79q3NLdU2F72+MhJqq0ZxZpEFY+6Q4wbb6Q/kMtSrmlGXHuq/BBTkaabzzAIGG9JE60xwxKc
	d5eMakgZVUBAz0XxUrfu5WoSYmGBCYys=
X-Gm-Gg: AYBFou0KM2ppJuBGF4e5XpK4Y1yHqCHxA4wOZE84V8r87/E45Ym3BD7Br+l9mmM388d
	mPr1zBXTmb7iAf2tJMJymRtGk4KLimqB2I13rq8n1+w+yqHZufcl1tpXclNpXxy+2ygdebtL+rc
	pn2NRyAIZgaEeBoo7JHOO6KWu5+6zTSqJeOmqAwBUXnnMB5QWPw9042+0ShSeYUsAFm30kJoDux
	dkG+fk1lRLO3tx7HI6AJ04163VTSuWzYQfB3mDtRJLtt1NFMuz1fLV+yksyggzki9zOaGBbYOYW
	ZBmgXjuS/FynxxAynPQZmVTsaMUeZtDBkNkKQRqZt/HY0cKmGRz5/G/5FBd7Yn+E5bPAiE0e/ny
	vRUsSOFDUnHDAYPSQTqte44zxSGuVKswdBeJMJRYgpsqBpLRJkjbfw8CO0uvJc3lV25ZbQMMsxZ
	5rgqv9sRGbaRq96M93Xj7zPlul79BuQwqYnl6OXsCMfWWFgHhjBehvQNcvANk=
X-Received: by 2002:a05:690e:4181:b0:67b:ea15:ece8 with SMTP id
 956f58d0204a3-67d89771ac9mr268520d50.101.1794510735292; Thu, 12 Nov 2026
 11:12:15 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112032250.37687-1-kevin@simpleble.org> <CABBYNZLiwCUAUCnVDYqWdjv5m4sFA=pKX8JAeFU1OXq-6LN7vQ@mail.gmail.com>
 <20261112174006.98288-1-kevin@simpleble.org>
In-Reply-To: <20261112174006.98288-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 14:12:03 -0500
X-Gm-Features: AclHuK9t5CPEemcF-AXKBCD5IE5aRZctLqxS5Y_0dlibhtdA6V9WRp1x56WFy_M
Message-ID: <CABBYNZK4MW92Sddmq9_tWiHAuWiP9VZqmVrPQC0AJ5JHR7-j0A@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 0/4] Bearer.LE1: Add ReadRSSI
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Thu, Nov 12, 2026 at 12:40=E2=80=AFPM Kevin Dewald <kevin@simpleble.org>=
 wrote:
>
> Hi Luiz,
>
> On Thu, Nov 12, 2026 at 8:07 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > That still a poll in my book, not bluetoothd directly but I bet
> > application will start to just poll it on their own.
>
> They will, and Get Connection Information was designed for that: the
> kernel caches the values for a random 1 to 3 seconds "to avoid client
> trying to guess when to poll again". Applications that need the value
> poll today anyway, as root through mgmt [1] or with raw HCI sockets
> that bypass bluetoothd and the cache. Blueman still reads it through
> libbluetooth for its signal bars, which only works on BR/EDR [2].
>
> > Well the reported values are vendor dependent, so I'm not sure how
> > much it would help since you can't use a measurement of link
> > degradation in a generic manner, it needs hardware details to go
> > along. We need a clear motivation for why this would be useful apart
> > from just covering what other OSes might have since they may use a
> > vendor command, or in Apple's case, probably deal with an exclusive
> > vendor which makes things a lot more simpler.
>
> For LE the spec fixes the value: Read RSSI returns the absolute
> received signal strength in dBm to +/-6 dB accuracy (Vol 4, Part E,
> 7.5.4), the same unit as the advertising RSSI in Device1.RSSI. BR/EDR
> is the one relative to the golden range, which is why the method is
> only on Bearer.LE1. Android's readRemoteRssi sends the standard Read
> RSSI command, and BlueZ's own Android port implemented it with Get
> Connection Information.
>
> What the value gives that a threshold event can't:
>
> - Choosing between links. A device in range of several gateways should
>   stay connected to the one with the best link, and a hub with
>   redundant sensors should read from the strongest. That needs numbers
>   that can be compared, not a crossing per link.

This sounds like something mesh was designed for. Yes, you can do it,
but it will be inefficient and probably error prone to juggle between
links, Bluetooth is typically a point-to-point/star topology; adding a
hub as a middle man is a pretty bad idea.

> - Diagnostics. Logging the RSSI next to throughput and packet loss is
>   how support tells a weak link from a firmware bug, after the fact.
> - Production test. Test stations connect to every unit and check its
>   RSSI against a reference unit, to catch a bad antenna or enclosure.

Yeah, that would be acceptable if this is behaving as a testing flag,
though. Otherwise, we will have people trying to use RSSI for other
purposes, like proximity, which is not really the intent of these
metrics.

> - Trends. An application streaming data can see the RSSI falling and
>   lower its rate before the link drops, instead of finding out from a
>   threshold picked in advance.

RSSI values tend to fluctuate a lot. Even if that would make sense why
wouldn't we deal with that directly at bluetoothd rather than leaving
the decision to an application? Applications like PipeWire already
scale the SBC bitpool if the audio starts skipping. We also have TX
completion nowadays to measure how long each buffer takes to transmit,
and I would be very surprised if using RSSI instead would be a better
metric.

> > Which means every btmon trace will now grow just with RSSI reports, I
> > mean I could live with an event generated if RSSI drops below a
> > certain threshold, not a command and event, every 2 seconds.
>
> Only while an application reads it. A threshold event needs the same
> Read RSSI every 2 seconds underneath, as the RSSI Monitor RFC did in
> 2011, unless the controller monitors it itself: LE Path Loss
> Monitoring, which also needs LE Power Control on the peripheral, or
> the MSFT extension's LE connection RSSI monitor, which the kernel does
> not use yet.
>
> BlueZ already has both for advertising: Device1.RSSI for the value and
> AdvertisementMonitor1 for thresholds. ReadRSSI is the value half for
> connections, and I'm happy to add thresholds on top where the
> controller can monitor the link itself.
>
> [1] https://lore.kernel.org/linux-bluetooth/aa77c035-d2aa-f227-bfcd-358b5=
f063b21@labapart.com/
> [2] https://github.com/blueman-project/blueman/pull/1642

If a vendor command can monitor the RSSI of a link, perhaps we can use
it. However, in that case we could gain much more with proper metrics,
etc., but that opens another can of worms because vendors may not
agree on all the fields of their telemetry events, and these events
are typically for vendor diagnosis, not applications.

There is also the likes of Read Link Quality, which is probably more
subjective to vendor implementation, and also requires polling, also
if you read more about what is required to get a _proper_ link quality
then you will see this needs to be enable over the air:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_=
v7.0/out/en/low-energy-controller/linklayer-ll--specification.html#UUID-837=
54739-8b1b-4943-b310-0477faf28c45

Otherwise you will only get a one sided value from the local
controller while the problem could be at the remote end. But if I'm
not mistaken this was introduced with HDT as Link Quality Feedback;
see:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_=
v7.0/out/en/low-energy-controller/linklayer-ll--specification.html#UUID-edb=
79691-f7ea-9136-357c-6533d2cb77e0

--=20
Luiz Augusto von Dentz
