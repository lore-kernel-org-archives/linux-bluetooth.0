Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57D15FA6B
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845627; cv=none; b=bzmpc89M11vuBawnfguJ14i/vyubxpOnLSrtiv1zIKf0ihCm8nfqkEiK4I9GLhE4Qm1ujoN4eNuQIGwNVdZ0kUCos/d8xSgUvdLRXIC+uA6hMWvAjAQrFcZNbzIULvsDaFLHQS6NUjgoLGzsBoKRYlQHXwcFo0Yb6OSofM2trN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845627; c=relaxed/simple;
	bh=uWbsoaA7o2jn18ph2xE+KTe62+SX/OKHY4QjDgkQysk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCwTg3VboXefp1SmhHQOeZHnoFOJ0BfU+Ds48QDV9ZSsXTt/NG96xZ4kgbR4IMlJnp97llnAR+dvZ4xcOv0xnDZfE9v0ZaCMJR6dmqnDp8hbekdmQ3+J7qQTiUULzQ/lSYWk02A4wI8Aj72vNcuhv/Ds9wnw9zTVh5W8gAtW25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8poaa/o; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8poaa/o"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so1787591fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721845623; x=1722450423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1PRZpgyZdEPZHXkHQ6E0B5+Y7PHBW1XY9H32/k5xeQ=;
        b=F8poaa/ofPx08pE5R5O7mkbhgBHKQcMSyM1eArC2hsvKZiXu3x02z01X55kLA+wsrO
         OG2sJi9bt2hgdtiuHfSuczYnO0vBENxsXiDps/6lByfBpqJLKMAqgkGxtsLD/B/DhFsS
         BfbBWXXQLXqGBWwqgV64gPmmQZbTMUq/UDmQueCdi94mD570FxKufSoOLK3tag5omhTp
         845XjiGI6d5Vgu2IkBUGqPhsh46SEDaTXv2n4EDT2Nh/JHzmSHuzkedXKgLEc6gsvQbQ
         1EsYcXE7ecKug7z6Kgaa/FUbydLpYNMmpGu/5vEDtrcBlp+5yDdrwNoVRDj3le8yP+pF
         9fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721845623; x=1722450423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1PRZpgyZdEPZHXkHQ6E0B5+Y7PHBW1XY9H32/k5xeQ=;
        b=tBV/YfY/LWrLB8G80IgWOqNrVY5W+FISbjP9vyN0kGDLoqgziSqFOCL7QmGN1fw9Cq
         GN2Zi4tEVoZHsYI6lzheYrlv+yTaGDLqwZeq3zc3cYRFOlObVxH7VW74YgE1GYxtVHRj
         QFapIuWnjbq1H8dFEfgLq5UIKuMfts47uT1Sh7Nyjy8xl0mXzMj/FCmPBZv/AEj08brn
         rVu782ipJrbB5cc+M3oJXvaP4xmNycG/9wsb2XU+1z+GviFxEbnkPKqioPIjYJPtPALp
         rOXPYkS4Tbx8JNY32ZqKt+GnwZypfFmPPPlvnorcAjwfiM/R6IGv0iaLqC9aFLrAu9mB
         wwaQ==
X-Gm-Message-State: AOJu0Yw3RYZCmumavbqiaVk0q4S+F9My0/sEV+gAo/NehzuSX67dV/cF
	Oe/3Kx2HFbb60vSliOVOwKpJaNXxtkJgqMbCNuZRqyCufvufDOx/pV5YZlXM2nX/K/o0N1hkVQi
	Q2gWYXUzieWMIPddNP16i0LGfmqTRRQ==
X-Google-Smtp-Source: AGHT+IHMS+Vc7xmyWAqA5W4AYdaWgYLXx5vDOzMJRUmnvnUQ1RlZCgxeFW+YhUOWQ8vek++e/Iuypu+7MezTUecgWt0=
X-Received: by 2002:a2e:2a85:0:b0:2ef:18ae:5cbd with SMTP id
 38308e7fff4ca-2f039ccb250mr5688701fa.27.1721845623207; Wed, 24 Jul 2024
 11:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Jul 2024 14:26:50 -0400
Message-ID: <CABBYNZJXg1pGQK08cCCcuuibS81jKT_fdOwCF5tMhE4OZ6-sFQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Add 'broadcasting' state
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Wed, Jul 24, 2024 at 10:35=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.c=
om> wrote:
>
> This series adds a new 'broadcasting' state for transports created by
> the Broadcast Sink device as a result of scanning a Broadcast Source.
> Such transports will remain  in the 'idle' state until the user
> selects them, at which point they will be moved to 'broadcasting'.
> PipeWire detects these transports and automatically acquires them.
>
> The transport selection is done using the 'transport.select' method,
> that this series implements. The user can thus select the BIS that
> he wishes to sync to.
>
> A PR has also been opened for PipeWire, I added Pauli to CC so that
> he is also aware of this change.
>
>
> Vlad Pruteanu (4):
>   transport: Add 'broadcasting' state
>   transport: Add "select" method
>   client/player: Expose transport "select" method to the user
>   transport: Broadcast sink: wait for user to select transport

Where are the changes to org.bluez.MediaTransport.rst? That is the
sort of first thing you need to do to explain how it works, also it
shall probably be broadcast only I guess?

>  client/player.c            | 52 ++++++++++++++++++++++++++++++++++++++
>  profiles/audio/transport.c | 50 ++++++++++++++++++++++++++++++------
>  2 files changed, 94 insertions(+), 8 deletions(-)
>
> --
> 2.40.1
>
>


--=20
Luiz Augusto von Dentz
