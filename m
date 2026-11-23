Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795455735;
	b=RqGs6jlUzZryEcq8sk8FM+MxuKj07rnO1/iujCiZMuKx2QD+4EA0ac+YdjgVcR0Sk3DJ
	 b822Ng8foNHoWxCb94fkOUWbY8ZoN/fY/e3Mxg7ZfQViQCpNd67oepKXgFzreBI8o7j6x
	 w9LUBr7HGNn/GetxARPugTL6jVTduasvZstuei6ImFu8OPtRW+ylaz+rC+Wv4bApVaSFs
	 4yQy7iqd0JhCGa9NCt+iJzl+Y+pkm9m8INOrQxiYFCZdOYLBtPvrC4UBDuZGSyybxYg25
	 obIXIIpFMndW1uMYDN3GEWwMCgdLXNjb7wzBcHhJ7bBV9zqetExLwx6+gnlUhC0ccXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=vxg8u0aGLxQRScovnQb7OLWc9CVF0wbt72UhPJ2BieY=;
	b=W29GqS3KMiaY8OeUIJsOT+bE2Uaw3d2JiflVdGXtpwIXLIrwTZibsjLZCdhklPBXPQQx
	 AFbnLwVmuElgk3gGgMZZRhIibWmQke6mJqcJqcwgOOBlE88vYlzv1zlV1Es4zUFsY3YV1
	 nEf9AJ9y/Ue2vsjtDokA99EU8VptDe5lhs9ZqX2sXj+n3w/YiE5KdVyieVjW4NyciAaP7
	 +mv56jllBZ0SRYi76C3VqG0KctLAaYGSpB1lGg6VtAFGW2SWmyQx11ry8koXl4rOPCuB1
	 /JY+JeQpRwRfToa+RQHpQjfv1OR8t5uQP+Ghckl289g6ysLz35B07ULL31GBy5y59Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAEzTiTX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBE606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAFBE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAEzTiTX
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so4056660d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:42:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795455734; cv=none;
        d=google.com; s=arc-20260327;
        b=Es3pWtmbw2vcrFyShLjfEFyN+FGwPHUFe5LDlLnHVzxRAyxMYWa/a/In+Q6HbLDZId
         RTlyduHKS4HQgtmgrTPZ8wLVnHlOC4/Ymwijydw8L++a3hkG0TO/EJPo/BDxTOiBZFqV
         2Nhuo9fTU3DS2gOB4L2hcDMCwcGENY45xVei/ykfK6SlSMLQ7EYqIpywBWT0eJArkRtX
         RvzJ23LYOSrxxkSqrQU7RXp0GDH4LPIoIR6S06AsLjKuZ3q0MvjQncIBUabKNilqU8Ix
         L1hKL5ilHVQk4WuGJwIBvgPTnK51bPtuuIiTZpoQBW7+Am7fA7qCu8bO6SvF0JBzAu9H
         Pfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vxg8u0aGLxQRScovnQb7OLWc9CVF0wbt72UhPJ2BieY=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=pYlmhhy/x4xGJRPWE3LSpDzOSZnVmpbQsy386qcrxKrJ60QxHFlKrjlBF9OVkIQhBe
         krwPaY4hrJ9ChfpoNPKwnEK0hpZQ7S51FgDWBqA39UjiVfd44aPsdoU2I6XHk463oWHl
         b+j48ARcca2Z3+Uuyvh9Uc++hV1a3SSW5EFBdaNwQ+2FQK36Ap09LEkfkpwUPEuZShSa
         wK/2teyB/C/cnT7u35Rfkk9JaHW7pFYO0/bj/bu5HUzcMdTd1J8eDBKXl6V3mLY59fEP
         4jggXxMCpyc9Buq2rwczKI0kcKjou06ZasZKoSbQNqDKJTyclaM141bmoctDWSL8DCeH
         NzvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455734; x=1796060534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vxg8u0aGLxQRScovnQb7OLWc9CVF0wbt72UhPJ2BieY=;
        b=iAEzTiTXmNxDtAa3I9Eo4Jp0aIUrJ2V1UC91gIw0BN/qIWuwN0ijR3103zMk6S6Y96
         x0sqoFFQlMemzDe78LwtU58I+f9hwI+VMSIEQrNI85iF5h1/k2rhD0BgB3pjDjiKpJCl
         zA9aLxC1iB99vzUOXSsrwue9U1uMQixQOB+G/DzsnSPJuE0emffaPYFU2b5/nmZqALgX
         fSHdJIleh83ieAQnhen5X/e5gDVGgOcL/aVm0huZgjZDPiluvz7QUs9bfYD0Mm64r7vn
         1ZdN9mTz0+J0lKSvIrjyJE87kGfsrZ1n3yRamNR1s3cIjyGlOwydm8pDy4LXnA/yy+6t
         hbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455734; x=1796060534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vxg8u0aGLxQRScovnQb7OLWc9CVF0wbt72UhPJ2BieY=;
        b=WWU3uNgqQ/GL6uNL4Ov0pPgWeXhAwEbdruM6p/iytfOu4uFmEkDt1jX++7fQxVD7ez
         6dFMHEoJYA9wra0rx44qu4Eo9Xqs9+yi19sXe+SyPyg0dA9i8P6RcV8CCj0IHY4PZojw
         9omLzvmkZzmhZH5h090QCdEAxlguuAJxKWMZwh4u7ypZTa+P1rc6x9Lk7JBqDMriRV8N
         01LfMmm0u28zIgfIonZ+IKbGAanYKgJlQsfJwireVJ7cJBavI0KZRrHikpUvHBEm6k9a
         2Q/LCWo6OlfB3qrtDEFZ+sEcvkT/+RkwI9A7iRmvVXqhNlvuxuwfyeBNxATZwuSG+Cw/
         HKXA==
X-Gm-Message-State: APuU4Z9qiI5smYnoFiV/XhvHBQaRkjsWS3uuObz1E5/wXkBNd7tDLzoM
	QW6AaEI+fjgF3aGLkEiMI/1QMzkcfjxLpMOyLDfO6E6JUHogTaYk6GMIzqjzRA4Y/jTI8mHj4M+
	EBs4wwyefkmhgGPREV2JblxO09DAQDCTbQWEc
X-Gm-Gg: AZFdTZea9wOceJMPzBEhyHMtBenCW/I3fmGGUvQ+F0mTCJ+AaIeCCap5kHv8+oSUIVn
	OmW1felqnjXoDJQPgzx2JBwb21eGC4RwR1IdQMr/lHeD1vFFRIemd65EFY4NkzPrfj47Dj7xGyE
	IRHI5Uj7Q1jO3LC/saa7OuscpPVWnSfxobZe/TVzBpUAH0FDEhmoZHD7Enm+E8kfsixN3IMrBxS
	yspwZuRJnNOAsptyGR/uEz5f61vthJQfb8x0dZzeN6GydBrrxEU5chXXpoEh/3GBwedQaCP3S+I
	8Cuy50oE4tmlk6lBUp3SZ+q0tUSvKhV2LjUwr+l+EDTPEFNaHD9wMD9m0xSjl89iGGhJBb1WPyM
	wb78gucqZShK++f+zVyBSgjlPcTlWfeYo0rNvU4VKRxCq49L9IIAgXh9SZ+0He/OYynYM9N/2s/
	D2ZWBMrt03SYRDl73lH7PCYHh3RLN7Gv9BhrbZzuxOIeaWzAv5fS7Ofh+dNWE=
X-Received: by 2002:a05:690e:128c:b0:67d:c122:e5e6 with SMTP id
 956f58d0204a3-67df440b767mr4476869d50.31.1795455733756; Mon, 23 Nov 2026
 09:42:13 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 12:42:02 -0500
X-Gm-Features: Aa3M54oqjMrqhLNOYpi-AAWW5aV2gp79fDj8QkZtrXvHeUyK5-ltKNEmiMC6Kno
Message-ID: <CABBYNZLN5m2AC428tuHo-uk63cU-gqceCv8Ue3xWbqnOsvz5_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/8] AVRCP browsing fixes, and browsing and cover
 art in the target role
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Nov 23, 2026 at 11:59=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> Patches 1-11 fix the AVRCP browsing code, mostly in the controller
> role: the browsing PDU parameter length is not checked against the
> bytes received, the media player list cannot be read up to item
> 0xffffffff, ADDRESSED_PLAYER_CHANGED and TRACK_CHANGED are sent in the
> wrong byte order, a player addressed before it was listed is never
> browsed, Search in a folder whose name has a space crashes bluetoothd,
> and listed Now Playing items lose their Name and NumberOfItems. Each
> patch has its reproduction steps and the logs it showed. A unit test
> and a functional test (with its documentation) cover two of them.
>
> Patches 12-13 prepare avctp to answer a browsing command later, from a
> D-Bus reply.
>
> Patches 14-22 add browsing in the target role: a local player
> registered with org.bluez.Media1.RegisterPlayer can expose a folder
> tree (org.bluez.MediaFolder1 and org.bluez.MediaItem1 on the
> application's objects), which a remote controller browses, and cover
> art, offered in the target record for a player that registers an
> ObexPort. Documentation, the D-Bus
> policy and a functional test come with them.
>
> Testing: every patch builds in maintainer mode (-Werror, ASan/UBSan)
> and the unit tests CI maps to these files pass (make check). The series
> was developed and tried against phones and other BlueZ controllers on
> an earlier base (2026-10-12); rebased on this one it was build- and
> unit-tested only, and the functional tests (test/test-functional) were
> not run for this version. Valgrind, scan-build and distcheck were not
> run.
>
> Not included: the GetTotalNumberOfItems parameter length fix of the
> earlier version, as a80671987 ("avrcp: Fix GetTotalNumberOfItems
> command encoding") fixed the same thing.
>
> AI assistance: Claude (claude-opus-5-5) was used for analysis, code,
> tests and the commit messages; every patch carries Assisted-by.
>
> Simon Mikuda (8):
>   avrcp: Fix not checking browsing PDU parameter length
>   avrcp: Fix listing media players up to item 0xffffffff
>   avrcp: Fix byte order of ADDRESSED_PLAYER_CHANGED notification
>   avrcp: Fix byte order of TRACK_CHANGED identifier
>   avrcp: Fix not browsing a player addressed before it was listed
>   player: Fix crash on Search in a folder with a space in its name
>   player: Fix missing Name of listed Now Playing items
>   player: Fix NumberOfItems of Now Playing when its content changes
>
>  profiles/audio/avrcp.c   | 121 +++++++++++++++++++++++++++++++--------
>  profiles/audio/player.c  |  78 +++++++++++++++++++++++--
>  profiles/audio/player.h  |   1 +
>  unit/test-media-player.c |   8 ++-
>  4 files changed, 178 insertions(+), 30 deletions(-)
>
>
> base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
> --
> 2.43.0

Copilot flagged the following problems:

https://github.com/bluez/bluez/pull/2871#pullrequestreview-6023493268

--=20
Luiz Augusto von Dentz
