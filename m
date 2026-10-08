Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC523822A1
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470259; cv=pass; b=lOz6N384npidWrMPzX4PTpYlXK+j78d/fTPJu63qC6Q/MNnfC8cgYmEFJcdpnlsh+jslrVLHJyWT9j5o4hF/OvANks89sWULvA9PvYs+3GrfK5eBsfXYmfkejbC+tAc9Gqi1qkNJHhb7A0TUPeITTlB9SpJ1O+iWj+jp02iBw/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470259; c=relaxed/simple;
	bh=ysGe+DtigBhyFYc2jr6TG5beed0A3eRJIFdp036iw3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIp0OAa1C6jDJyFwiEQmxd1CzhEExdhDwLa5Lhivb3BeH9nfNLsrqdbW8SNoQ3Vs4r4YowWqmH+SfEyDpjTY/jNZUk32T1ZeHyXlKKBNguQPg6Yr/jhP4SVMFhf33cVWDngyExRtW3oM1qqkq8SIPt6rCadvJ/WxHmUogBUb7JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GstEYvR7; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GstEYvR7"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4f488ba6e90so1349615b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 07:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791470257; cv=none;
        d=google.com; s=arc-20260327;
        b=H6qZcmx/emcLv2V1NNLZNViVFJgXbkAJ8Tu31zjdsDHS/uj7822/6SFmVgOImiq1rR
         KiQHfAfac0qeqgP2iRn3rhhpnLdQ2Dx3bBI5KqZr8IDbbRDa60HYwjqNTFUVD38Z8L8s
         gFAW+hTEb6uHS5LvQtG0/lvD7PpJMdPk805YyBw85e4jA39+xGHGviRCl9F9Yvz3UrFA
         JqlkqNGyihYaYm7A7mgkskrN1Ja0iqiBe6E6FUqpf8n4kz8JXoJhRx+cT1BUuLILp/2C
         2JNcsNm842JA4XP0MdBh5uFTFCKZkk1JMWHe4ezACVt5xYa3BzXml489W0X3u+zoR3g/
         pvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqA+eTaBuUjPdzpeuBirZgkrhbqs7tdFp54xvvq88yc=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=NrZdZCoNExwWVuOotKA2dafS5hR9OodZJV4Eg+ReyJ3BPOhUJtPv73cEUM/91ElQzy
         DGgWvzHiGjfDUORtIO2/fEMboHC1+7TGwiT5AzMx+xmRowwy23H+/i+572HBTm/oUGC8
         fvACp3ovcgdJ3BU/cMlj0J8b1YYMQkvMrVjRvmvnDUqr7gs7IO5/rvhPyMy9tBOpltvV
         sScQW7ODtm3gUmTNBiAiIIXO+4H4uQDnGlegyo/HhJNt1040jUY1W0S6U5lA5F5MkmRU
         wMgNx3ZET40qs/Nkrig95ETF2+2JN++XtjB8qRFVzjZK5cNfcyOLc0zJ5Q9tRpfgSuiF
         KlCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791470257; x=1792075057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JqA+eTaBuUjPdzpeuBirZgkrhbqs7tdFp54xvvq88yc=;
        b=GstEYvR7ajrV4gu8hAIQj2XwV2rn5wxj8Rss06uyuthbyD+XY34mckbREBP3DCVqT5
         bPr/WOD2uHJUECNxce2teTn++Jm3Ls4l4fSWcxUrXepLApFjnDgEzLQasOiX9tZAJUzn
         kw7y3YPBAv3khdwwpeKAaAyBFz2XQT3uERev90lV51qe8MTlK2di9rFw1XmeEwlsq4lM
         kWY9WcfVErdQ/J7BFb8EHitjl9XWRScd0OSrIE7p47HjsGD6ugzugUKVnMH/4DV7P95x
         QkuqF5kS3U8qQ6dKLSzwEU6IRc2uPCAO87QZumsLBYqGrHCXf5xCvViAfub88VfUH3t/
         ME6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791470257; x=1792075057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JqA+eTaBuUjPdzpeuBirZgkrhbqs7tdFp54xvvq88yc=;
        b=XyH0FUDHDTeT9h4oigpeCbxTKLoOOdPmLUNFJ3qrW5adoiBeAZWJhqAVv+5003WrQc
         haiA1PnMxjAmJV0c4Wnw1yZlXtncfnTdbVhQYx0/+hKKRecUz1mEB/VUZ1wfME5WuiQI
         uq3cuZu749mzfevIDLug23LNlg2aipwGR9oKp6xtveb1OkxF2bsrx4zubvpHuCnT4WwX
         IfFhpQEznvdHD99vhKg4XLbTuAvF/uMuADKqAaNZoEIn5Zk33LvA0jT9koHie5R0GPZM
         p6IRAYC/X+/ETlpRog8fKcrZwxLamNUuaMEx4txTWOGkoWADLKaNRFprFmdsdBXKWOUf
         +iWQ==
X-Gm-Message-State: AFuF++lzBN5Fc1syPx4osN+uMBZkC14BPUro/+ML2Ouyjuay8ISyenRY
	FQJeGfbnWnQleJNmnlkjmJq0wNgY4smB2JGjcUmwDAdVtVEOKuB9/Tw83KbkSEYngWmqn0TUavH
	SYCpkpFDyH+NIALBotdRzKK3I4h3bo55n3QtZHVY=
X-Gm-Gg: AYBFou1iuaCvAA028VPyAxf4oSKtzF8MthtOgG6Y8VJqi2Zx3G9iseangt0rvYoTtX/
	JkCbFsRH/GEmBBljnm0Wya6dycBn6+QJPaW8HcuHy/i5V/LsUbqKoVfQM1Tzjjqe2sy36yvzvJB
	Vn6mH3oeLwpZoZJ1122R2YMMkef3OlEXm2LKrCKZU66q0ApYF/qCWuPICk8j9mkkHRPYhRPI+uQ
	0JrWucBS6+ALg+vJxhfXcz3DrwOQ8pVmuEj53NR3ASjybvx24Ky1ZMPmH6sviuGeFF9QCC4ofRx
	qKBmUwroJaAd9LXqTZh3lcaSxPYhzNSQU9u8KVYtfryR8qmoBmjiIGH0dTu0S+y2SFZa33FEPpD
	Y+nRzYCYn5qZ2WYTOWb6pVV5UghFb81m0z6WPl4C61A==
X-Received: by 2002:a05:6808:50a7:b0:4c3:e93e:e331 with SMTP id
 5614622812f47-4fc45d52602mr6097323b6e.30.1791470256527; Thu, 08 Oct 2026
 07:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008133634.30362-1-kevin@simpleble.org>
In-Reply-To: <20261008133634.30362-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Oct 2026 10:37:24 -0400
X-Gm-Features: AclHuK9kAFalRNOXa6pf1u3bGcaQ6zV6Q9s2ndwVoB9VUqXq2cMAPa9skI0z87A
Message-ID: <CABBYNZJyKcO-TYUeFqvA4dHm6ju8GsHPrLKxt4Ha2Yz9mZAfJA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Add Role property to org.bluez.Device
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Thu, Oct 8, 2026 at 9:45=E2=80=AFAM Kevin Dewald <kevin@simpleble.org> w=
rote:
>
> Applications acting as a peripheral, or in both roles, cannot tell
> from org.bluez.Device1 whether a connected device is a central that
> connected to the adapter or a peripheral the adapter connected to.
> When several applications share the adapter, a device object can
> appear because of any of them, so the order of events does not answer
> it either.
>
> bluetoothd already knows: the kernel flags connections the adapter
> initiated in the Device Connected event, and bluetoothd keeps that per
> bearer and uses it, e.g. to decide whether to discover the remote GATT
> database. This series exposes it as a Role property, "central" or
> "peripheral", present only while the device is connected over LE, and
> prints it in bluetoothctl info.
>
> It is limited to LE since an LE connection keeps its roles for its
> lifetime, while BR/EDR roles can switch and the switch is not reported
> to bluetoothd. It describes the link only, not GATT client and server
> roles, and nothing is stored. Other stacks report the same per
> connection, e.g. Zephyr's bt_conn_info role and NimBLE's
> ble_gap_conn_desc role.

Yeah, but if a device ever connects using both bearers, I'm afraid it
should be reported on a bearer interface so users don't assume the
Role applies to all bearers. I'm also afraid this may create problems
where the application might interpret this as all procedure roles
being equivalent to the device role (e.g. central acts as GATT client
vs peripheral is a GATT server). This was one of the reasons we didn't
expose this before. And yes, I agree LE connections don't have a role
switch procedure, but in GATT you can switch roles at will or even
have both client and server roles for profiles that support
simultaneous roles, so I'd leave this to be on a per-bearer basis only
to make it clear it is per connection.

> Tested with two btvirt controllers, where the advertising side reports
> the other as "central" and the connecting side reports it as
> "peripheral", and with a real adapter connecting to an nRF52840. The
> property goes away when the connection does.
>
> Kevin Dewald (3):
>   org.bluez.Device: Add Role property
>   device: Add Role property
>   client: Print Role in info
>
>  client/main.c            |  1 +
>  doc/org.bluez.Device.rst | 20 ++++++++++++++++++++
>  src/device.c             | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>
> --
> 2.54.0 (Apple Git-157)
>
>


--=20
Luiz Augusto von Dentz
