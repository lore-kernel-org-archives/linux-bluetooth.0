Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E8284B37
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316428; cv=none; b=cIqgZ3fduBMZUkcpcJni2oBzMGzePf+wQl4PBUGcfkpw7A2I4am5He0qQXsTHxmi6fddnfxUpJbO8CTztD3bxQZ4dIoe/LNACZbd6A/QxSGLKo2KLsVTgr2GtzPfGzhJ2iCu7VuSKDH+TIVSosweFD4So60VYi4/bEcJgNyFnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316428; c=relaxed/simple;
	bh=GCXUMW4wHKCIiIYAyShbpobArzWko78A0+eks2o2As8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9GK6m28+sgvq0vCRbGcvoMfYNRL+GoEkfcWorPj3+mmB7h48kUvP1u1T1FtB7QaapBcq2ri+z73iY0eXrYvhRy4dU9+dGHd0AodQnIdQgCU2z1pXsi3LFVTeVyfpf0QVR7ajAUEbq07bj/MXsUCCIyr7Jto4qrzY+penjzyHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONsbZcCb; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONsbZcCb"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-644715aad1aso7948318d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 07:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768316425; x=1768921225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZshDbN23kyiK0aJaxxbMDv9Sil3+LsBU7rxuoqtSk/o=;
        b=ONsbZcCb5l/qWoI4NwJsVxpVWimRLK+NuHzjRVsLdC/F+lcKkIHzMBl11JyHtId9Z4
         yyHugsFBe2qmnm+OLuKBBIFe4Tqdn532EbcICLqyCkT/MmggAh/ta8Rk6xHnIOnzFnde
         0dAEj4Muxcw9+oqFqbA7rcQjWY6HvwZOxbyfiF9/qPWAPxhbDLyWCZTGcBUnNN8mgu5e
         gpX4CAttq1n+UIxCni/X/rxH4zwu6+YUZlpOk4SdEEEp3QDbSQUYsWpyCa3SY0RFx9nw
         uVxle5iDrTqtpku0Q+XsR48a0KZQar1U4m3lDVWevPEMeLUaeUqybBq7qQMBFuILQGM7
         +b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316425; x=1768921225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZshDbN23kyiK0aJaxxbMDv9Sil3+LsBU7rxuoqtSk/o=;
        b=Egr605hO8A8AolxgJLbZ/GQJJykdIAW7Q+/ryDvO2j2lU0rZcQdI0HLg1UDCLUG9zd
         cRXpnOvFKNMUFYZQwqHX5HLaKL3sUyHLUBBm2ooAV1an5SVngnMKiiJ2/T/5MFFiLSIo
         tdjetcsl/5jIFBVZAVxaudS6M9vze9YAdg/83rMau92WlS43jnM5DMgwxw2ZUiWt7GYO
         87uQCWWuxamUtLmRar/J6XLVyIcpFNtrdFAgDNPi8juhwi9mH13dq/sBd14QtiVJVGL8
         cPEq1wyxXjDnE0hZuySZ7Ic/23WCilVqbJGCjVKZI7UNA8GRvVjGTtK3AXg8U18H/sQ+
         iuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBljtEhk0S5s4IiLLBqq9/Bx0ZuMXAZSu+3Sk1KsET0fGXEOIi2nZyeIB0bZHJjgIn6yFrcXzTngMOEH0+Vro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Wb+pm12wOIDclju+ZXY8PGrMnHIEYb7xloXSoNIpPGZkrA4u
	m2BzJvl+iuORUOZ1FYo5povAlYGzcQkNnHuC/DdY4DHaSK5B07eqEyf4dtXjjso2sMPjHrnuhxR
	8o1H1ptvShF/ImHJ8e0oP51lWYTZGfng=
X-Gm-Gg: AY/fxX6kQ+1BoLv5qY835DinYiNWsi/vI9uW/2dNpCvYIitRDCTCVUgC8CgwAdkkCdW
	Z8mcJJdWRskWsBsp8BAcRRuj6pZyWtJjKjVt2fmkRe2PyfBY3FEaEBjj72RDfnqyWLnHJ/pW7wF
	2CNxWLFeVmDU42HqL7HCQDF+gu0uCdL9a/NxTNkJOyjgSusOatPC/SYNn/w/y4C2tNeOtneUx+k
	Ke/Xg5NGrYZnooneDSWbv5iITBKCE9K+m9hVsuiACk8ocGLrG3d6kEwhqrZdrF5qqDopj6LcziR
	wAMjDuC3X3F4T8gcbyjeo3Y0JUNjWRuM6mU9xtR8OlC/e+4cLH2uYcOxyuXn9J+D7ApJ
X-Google-Smtp-Source: AGHT+IE9VU1ZW1CmN5ubs5ekzlMA9Biwm4NJqhl9gxQAhI8xy7X1c5xWGZtopInPC7nJ0LQVT+bkL7ernSH4jUDOm0s=
X-Received: by 2002:a05:690e:d0f:b0:646:5375:b7a0 with SMTP id
 956f58d0204a3-648f62257c7mr2770039d50.13.1768316423142; Tue, 13 Jan 2026
 07:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Jan 2026 10:00:11 -0500
X-Gm-Features: AZwV_Qh3ypT5N1z8f3lSRrnyaoqR3NML5bNXq3m_v1vyciEkBPJb9xWr3FkKIWw
Message-ID: <CABBYNZ+crY9eDfy6=cz8FwbUqFbjWjqjiVTHanw2J-7QB-Wh_g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 00/11] Bluetooth: btnxpuart: Add secure
 interface support for NXP chipsets
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, amitkumar.karwar@nxp.com, sherry.sun@nxp.com, 
	dmitrii.lebed@nxp.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 13, 2026 at 2:46=E2=80=AFAM Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> This patch series adds secure interface support for NXP Bluetooth chipset=
s
> to protect against UART-based attacks on Bluetooth security keys.
>
> Problem Statement:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Bluetooth UART drivers are vulnerable to physical attacks where adversari=
es
> can monitor UART TX/RX lines to extract sensitive cryptographic material.
> As demonstrated in research [1], attackers can capture H4 packets
> containing Link Keys, LTKs, and other pairing data transmitted in plainte=
xt
> over UART.
>
> Once an attacker obtains these keys from UART traffic, they can:
> - Decrypt all Bluetooth communication for paired devices
> - Impersonate trusted devices
> - Perform man-in-the-middle attacks
>
> This vulnerability affects any Bluetooth implementation using UART
> transport, making physical access to UART lines equivalent to compromisin=
g
> all paired device security.
>
> Solution:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Implement a TLS 1.3-inspired secure interface that:
> - Authenticates the chipset using ECDSA signature verification
> - Establishes shared encryption keys via ECDH key exchange
> - Encrypts sensitive HCI commands (Link Key Reply, LTK Reply, etc.) using
>   AES-GCM
> - Decrypts encrypted vendor events from the chipset
>
> This ensures that even with full UART access, attackers cannot extract
> usable cryptographic keys from the communication channel.
>
> Implementation Overview:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The solution is implemented in 11 incremental patches:
>
> 1-2:   Add firmware metadata parsing and version detection
> 3-4:   Establish secure interface framework and crypto setup
> 5-7:   Implement TLS handshake (Host Hello, Device Hello, authentication)
> 8:     Derive application traffic keys for encryption/decryption
> 9-10:  Add command encryption and event decryption support
> 11:    Add required crypto algorithm dependencies
>
> The implementation automatically detects secure interface capability via
> firmware version strings and enables encryption only when needed. Legacy
> chipsets continue to work without modification.
>
> Security Properties:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Chipset authentication prevents rogue device substitution
> - Forward secrecy through ephemeral ECDH key exchange
> - Authenticated encryption (AES-GCM) prevents tampering
> - Per-session keys limit exposure from key compromise
>
> Testing:
> =3D=3D=3D=3D=3D=3D=3D=3D
> Tested on AW693 chipsets with secure firmware. Verified that:
> - Authentication handshake completes successfully
> - Sensitive commands are encrypted before transmission
> - Encrypted events are properly decrypted
> - UART monitoring shows only encrypted payloads for sensitive operations
> - Legacy chipsets remain unaffected
>
> [1] "BLAP: Bluetooth Low Energy Attacks on Pairing" - DSN 2022
>     https://netsec.ethz.ch/publications/papers/dsn22_blap.pdf

Ok, I start reading the document above but it says the problem is with
HCI itself though:

'We first present a link key extraction attack that exploits
the security flaw in the HCI dump, which records all data
passed through the HCI interface in a log file, including
link keys.'

It does say that it is passed to a log file though, maybe the
permission of the file is the problem then, either way this would be
UART expecific. We do require NET_ADMIN (aka. root) for accessing HCI
though, both for monitoring or generating HCI traffic (e.g.
HCI_USER_CHANNEL), so I don't believe these claims are valid with
respect to Linux since for collecting the logs with the likes of btmon
that will require root access, that said perhaps the -w option shall
limit the permission of the file to root only as well, in any case it
is not like btmon can be run by an attacker without root access, so it
beats me how Linux could be considered vulnerable here.

>
>
>
> Neeraj Sanjay Kale (11):
>   Bluetooth: btnxpuart: Add firmware metadata parsing for secure
>     interface
>   Bluetooth: btnxpuart: Print FW version and enable chip specific
>     features
>   Bluetooth: btnxpuart: Add secure interface TLS authentication support
>   Bluetooth: btnxpuart: Implement TLS authentication crypto framework
>   Bluetooth: btnxpuart: Add TLS host hello handshake implementation
>   Bluetooth: btnxpuart: Add TLS device hello processing
>   Bluetooth: btnxpuart: Add device authentication
>   Bluetooth: btnxpuart: Derive traffic keys from TLS 1.3 handshake
>   Bluetooth: btnxpuart: Add command encryption for sensitive HCI
>     commands
>   Bluetooth: btnxpuart: Add encrypted event handling
>   Bluetooth: btnxpuart: Select crypto algorithms for secure interface
>
>  drivers/bluetooth/Kconfig     |    7 +
>  drivers/bluetooth/btnxpuart.c | 1442 ++++++++++++++++++++++++++++++++-
>  2 files changed, 1440 insertions(+), 9 deletions(-)
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
