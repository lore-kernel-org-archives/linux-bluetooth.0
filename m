Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795455392;
	b=n2cAGDOeXafiDY5iIbOqMG3ZV2H4tmHdP4DXaJWS428ELObR/gWprXqmVU+RY2tUZhJc
	 6bj0Rx7gh9EHMVw4OhBRZwD4HjcHf/nYU0gtHX7iYSW99eIY1CC/O+NQRnMj1lT2qPwki
	 Bfn4LGOLSRuOTXWbFHymYegIEmm+ilnibhoPVT0urq54x3Xi8syqsnO5rzOPEV7wJavMN
	 H6sWN3ss5vBJ1d8o5NuPoQKTsEYXUFcvpkTqozB/4cQI8s2XpNGvxNh9Mky4BtR8HLRUZ
	 pvjHfsC7hLZ/TSVWaITW3fqKqvnJq6RAR34yLxjna2h/cwQG/U/Oo5LgkczcH70P2Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6CJJol2UnnCSRf90ZCwi6nbyMtPtlrdOLnPh/Efp4Fo=;
	b=zYVbveteur6rPLz86Vy+DXCF1iOrXt7t7R2RAvxXwIm6OswpOlgrXRV6KN8svL8PeQ7Y
	 3hmVQMgZJRyAxPPLrEAQyHDmMV2R6NTyytcCtxs6gJ7QoBmiFJ75evDL+L++LioSWUCRk
	 wjS+DLRIM1rtIr7+lsbnZfHPqenk18NfLXClnpzGtM7cIWlmPdB5sDM5Ze3DNmGMMfvo7
	 StkrCi24K2+dpp6uErL6D0k7rl8SoJSPtMw06KG1Lyv2qGl61pT2Tv32bep2tlkH07ilT
	 JctQVJVnsjgrGS9H8FS2OKIvFiaxAdDd7P1YWN+Vg/zx+fGDBmWOxlEziBmp4618w6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5UFC92k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164F606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9164F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5UFC92k
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso3740510d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:36:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795455390; cv=none;
        d=google.com; s=arc-20260327;
        b=arqq9Qr4CCku8V8TULb6iMXQK3WAjhsdf7nzhFyLS7TAIYqPktDaNTgJmBViNQjTt6
         vud0NIZRl+R+r91ZICK8Xozvuhs9CTJgYfJNaYEkDgxilQ0nRi2QGrDp3qfYaCMmbe6w
         Yg0Rp/vTWL50oDI5hsjj4Ej/v3ZyPsR1OrMww7lKlWqvVsFfK+Wj+nIwqOLHudhDcOVS
         36GKJt97oF0Y5JZYNXoH4QA46mORA8ZjVsQcVldUPtVJ/KcECqoQy4sMxOyUZKquI3NZ
         3hUAiGxixcaJFZb96rTfvk6fNXMW5kUoQR4Y1t/VQAS+bOg7bSHX3dAMKW8YelGuwkA4
         JK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6CJJol2UnnCSRf90ZCwi6nbyMtPtlrdOLnPh/Efp4Fo=;
        fh=fJTvNhOwO3AM3tYUbNMUqA+BVc/up3gAa8zqoR5nDD4=;
        b=B29hEhYBWAHudPBeAStWjI7IQUOAMJoUJbmHp6x1JsA2NcKsmufmNcRhZgNnhpWjmH
         CCuWEXdvPxYnvYBQQF++vtWrQreQ2DRze1KEhBtbCNSjImrBLAyxtq7vDG09ccMA9kL9
         CEtIbAaNl28G/uC0JkYhCvvM65uxj/qtHPfTHt1205fgr/eq6uj6fUu3V0CVhmm2IT/2
         PLaGqqPaRQkearKXJ0Xo2KmnL5gFs7FaVGZYRajDMvCl8mXDbggLPoRF91MuxjtCR91D
         E3XfKotCAdzO/qb9YsJYX2VTEBmfSdmHm52xNkPGEtk8iyFTWWj7cumTJWnxEAfIJU+7
         TlIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455390; x=1796060190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6CJJol2UnnCSRf90ZCwi6nbyMtPtlrdOLnPh/Efp4Fo=;
        b=f5UFC92kEZpcCpGD8fst+fgQ5Zsx5S1c60ZcCcyAaqnyxz09IX5v8L4nJZj9zd5pbX
         dUhxHYi9D9CfFtlcUaYGzejTzy+DA4bzhNHQcIjQyEbWdU+c/h8fPaY31uKBfz3W/oLw
         zBNeV1zIEjTyg30aqJtXDaxN5M5pOya/4Qxheoj4xWwWn/OsnHXUeg2td6vA4Aqefud3
         RZFHWlObx2R03EVtweRaVRhmFhr1IArfSH61SY1CYxXifr2EIY+L4aU6L/0Q5VP2e7qD
         odMcvHc1yHVKyQyNJ5Nvy6qi0NAqtCXtvq5cFdW76VDmwP09eJxvC7uAmYoDq6wbBJvx
         q9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455390; x=1796060190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CJJol2UnnCSRf90ZCwi6nbyMtPtlrdOLnPh/Efp4Fo=;
        b=Ms184fcVkspMid9A7PvTBf2PKOLPj/HEVr6YHk5Sj2WlEbe6HKPg7rBEdq5ECGJvDz
         9Z609d9O9nPeV4bYyZUilWWc2eFI7oFgd6JcZNal/FeHjgPri12IsCEiFcOQg0u/sDWe
         AonA8bcugRYv7Tu9A/DQjfGLTaWSw0exwnPd9+PzCFJqkebPqFN+xquM8orDM4T6emYs
         o0r4OcEJQrFHXGZsKLjZe46BkWk93oJA5qVJ8jzQQ4/8BPL5QRWhvTQnFkQLkQnnEw2T
         +3q2n+hcbvFwmoO0YEHFJABnLI1QfHS0Au2do0Hw5aRa1CtXjdtWh9re8as6r34os9SG
         NabQ==
X-Gm-Message-State: APuU4Z+LudDaCflfZ9P41AScsGgV9YVHugN80aJMc0AUzZ8HyhdTsFTu
	xdw10rGdIQo7U4PExdjlLcSxeKyaRlC6OGGKZ9vfbb23qX06wb+QAJuF+ItYqbdAqF8s+1ERiYV
	fnkYbPA0gKX1Mckd5b36DIJm10EfEZNMnvLST
X-Gm-Gg: AZFdTZdGn/BUKOhq2mVI7MmSgmoEeQX36/o9hkrLQW6h35mXjsBc8/6n/rvL+UWobgX
	soGt93tTCYQmEaaREUCLA9UKRZlZcDROtN5EIaG0YT7qPuxXJ7NWB9v9qONV0tCqWVTdSAzKlp8
	lSWnu+tyTu5Gr6EtdCut26a8VggoDePTPzE/tM3jcx5RNUyfWi0fqsuXyop1Q/mHfNAj+yKprEw
	94PjAPHeiXw/eZL/aGN/REtwSJWPgFRJwOPy/hk4TITZNiyG4GDEkqEYm/GRVHcFmxZdUoBYlXf
	xX1a8x8cu7sMrqXjPl3i/tqsJ3HbpcqjB6aMiAJ9FiK0iRv7kEHPOQIOaYr30UhxiS9tTxx+ZeR
	e25rZzigIy9W1wCLy9UvPR9yjbDlOCxX/pLPQLVBX31NGjQlXNYpGaDZJ/4gogcbz+4P8+c/y5c
	PsJRqr+na7GBGfccTxwwY27aJe8iYzTnDJ0+zx8sQbjJB6kS0o1YeexdSQzUGW
X-Received: by 2002:a05:690e:14c7:b0:679:a2c3:b2dc with SMTP id
 956f58d0204a3-67df44d7f6amr3735978d50.92.1795455390332; Mon, 23 Nov 2026
 09:36:30 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120222624.150321-1-rolandschober1968@gmail.com>
In-Reply-To: <20261120222624.150321-1-rolandschober1968@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 12:36:19 -0500
X-Gm-Features: Aa3M54rRUAUlV0SqqvkWDp8la-vTyOvXC6h-JmmMQlWedsJNRR4DgWgS1GScOLg
Message-ID: <CABBYNZLfTDE=0Ny7Bb7QiX01SmAbhpr5UnxeURbE40AWjNS4dw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/5] monitor: Fix reads beyond advertising data
To: Roland Schober <rolandschober1968@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roland,

On Fri, Nov 20, 2026 at 5:27=E2=80=AFPM Roland Schober
<rolandschober1968@gmail.com> wrote:
>
> print_eir() and the decoders it calls take advertising data, which a
> remote device chooses. This series fixes five places where btmon reads
> or writes beyond that data, or decodes it from the wrong place:
>
>  - a Shortened Local Name, Complete Local Name or Broadcast Name of
>    240 or more octets is copied beyond a buffer of 239 octets,
>  - the Flags and the Security Manager OOB Flags are read from an AD
>    structure which has no data,
>  - an Unprovisioned Device Beacon of 18 octets is decoded although its
>    OOB Information lacks an octet,
>  - the Apple identifier is printed as a string which nothing
>    terminates,
>  - a Public Broadcast Announcement is reported as invalid when it is
>    well formed, and decoded from uninitialised variables when it is
>    too short.
>
> Copilot found the first one in its review of "monitor: Decode Periodic
> Advertising with Responses" v4, whose new decoders hand advertising
> data to print_eir() as well. The bug is older than that series and
> can be reached without it, e.g. by an LE Periodic Advertising Report,
> so the fixes come as a series of their own. A v5 of the decoding
> series will follow on top of it.
>
> The others were found by feeding print_eir() one AD structure of every
> type with every length up to 250 octets, in a buffer of exactly that
> size with AddressSanitizer, and by review. The same test passes with
> the series applied. The reads of patches 1 to 4 show there as
> AddressSanitizer reports; patch 5 was tested with hand-made btsnoop
> traces only.
>
> Roland Schober (5):
>   monitor: Fix overflow of the name buffer in print_eir
>   monitor: Fix reading Flags beyond empty AD structures
>   monitor: Fix reading beyond a short Mesh Beacon
>   monitor: Fix reading beyond the Apple manufacturer data
>   monitor: Fix decoding of Public Broadcast Announcements
>
>  monitor/packet.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> --
> 2.47.3
>
>

Copilot flagged another problem:
https://github.com/bluez/bluez/pull/2861#pullrequestreview-6025049968


--=20
Luiz Augusto von Dentz
