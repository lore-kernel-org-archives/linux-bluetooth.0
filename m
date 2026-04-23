Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB13D6CAB
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927915; cv=pass; b=frgKvK6VUJQGIsRg/vrxCLmALBij9MtGgfrEOBBqYmS2X29cHWIXCNXxJkvmOGyZhTHIQ2kGYAHvumNhkcrXzq9HODzEk7tKgJfVQtQTfh3JuJQ/4slBvxq7KIqbQAAfreYG8gT9j1al8Qz5RXw7arSAO3h565ytP16U5TeTByQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927915; c=relaxed/simple;
	bh=nu5Wy/Jl/X+xmTkZVA00cnCWHoPCgNZsMAk5f2XuKDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=h3Rziu70xRDNsDNq7tskky7RLTxTxNOQ5eYWVESVd0P3xAn3H/DR9YFoow9JNJ5FmbLVpzwagAABivddrBUG7Ggmu3eXZMRz+bCD9/oBafoIgrDOc0leTdES1xdwj7BURpNzaml4XkAMJJ8HPhzGUXojYgDQ5mJd8/RFlCR57Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPS4Adii; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPS4Adii"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a093c784b0so74866516d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 00:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776927913; cv=none;
        d=google.com; s=arc-20240605;
        b=F/6Mg/m2wE9NKGvvF3+HFv4Y9ekqcK57l/48IbCFdpg0xra+O0pqjeUobBGTO3AyGX
         ufaEMj7xMJFEClLVfHg9ESSg3xMTsWAjHtHMkVKuIdBz0CBtJ9U823R++ui4vixHIB4I
         kdPC79KxXJyBDpkjA5Emfz0kZirrPa0+T1thz0LCbzunqp1uh1e9hzby7tv70ZauaPP2
         GhgcQ7De5Ail2b4okliPt80vMEvzZNEynjg//LYcxhyl55b5xcoTYgCoARPEYrRNtO//
         SpjVK0WMSPfXiKUn3f91KFEgN1kSk6H4unBYmiXHon71AnyQRT5r+hNRU+pVOe1VpLf2
         CRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nu5Wy/Jl/X+xmTkZVA00cnCWHoPCgNZsMAk5f2XuKDA=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=g19tMzqf9qbr2s3sqW8xP1QCdPqvl6roJ9BOxstwlLuMoS0nmN7sDW2nW55xOlYu7A
         YamnEKiMpR1rvPkZpBmK/0TUYzJch+zq9bSMK5/p27UJ8+A07ra0JIhogLIeP0snwyU7
         SH9tOaqzcijITWa0VGkadut07BozwFQVnPWAWghmrDjAgba5ZHqKy1JouEu5MwTCZSou
         s7yAqovZ6ioOuVr+Ek9wZcieu9qFNOygle4LxGhMgxP2eD2E/uKJGw2c4UmtLFXUBg0E
         xN8bQWWKhTCsa7uHGggMOfzFRTozXqrNNDxDLtRn1/pci7c3tAk5SGVy22SO0nH1542O
         k0Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776927913; x=1777532713; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu5Wy/Jl/X+xmTkZVA00cnCWHoPCgNZsMAk5f2XuKDA=;
        b=IPS4AdiivhgMOwKdO/yEJ/xwaSz/d3eQByTQvCsLy1QYXA8wHhbzUJl3JHNWwI+jDX
         lX/wZ2izy1lvZYx6aqTfI/ZhSEgxCf6zhlQ6yCo0XoR0R8nGzMyAEoCe0OeonaZUoC1y
         M3fQO2Be8vIDXHFsCa9Wx/vJkUjqfcOEhGxdBuxi3joA9PNPnuZxBkBCmZGM19U2g6WE
         hv5d5hJM2YIqLVNaUMlEjwwO2KtePx2C2qmhCrDfAguqHkIe49661cZkOsA78/3IP7a4
         XDcqtxxpPuZnUxjJy6GjyL9iH5VOdjRphKSJ7PIwk0thIyTKWZUAR1QE5kmZPLSUOW/8
         RHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927913; x=1777532713;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nu5Wy/Jl/X+xmTkZVA00cnCWHoPCgNZsMAk5f2XuKDA=;
        b=btWWVGy8Rq8e7yzoGqCSyEF/F56EpK/t8NTTiSJh0+SKzyZK5I04hKLg2SnxtAX1Ac
         o8yo0Fu1UR6TCIPmfFQnUZWCrZDAhwhX1OVfoEuilExopP06ITSvFepET+1cxauTGv73
         g9ve/tuFwCAtxGl3CltTGyHofuT2ZC4aB5DdFDKyDeln7syvzCoyTtW0IPPIGnCVGwON
         FlAqYRkC0PCiqfncUiyIZMpxbWNrLlygQufXy20h7kup+7LWPQVrDgXpUxRE8zvyuDCD
         YcyTSxF+Gz7jRHSn7CXp2ugPgTm8JArW/JSMH0FosGXTjZNG0S9UkqPe9MRnAex1pXCe
         V0ww==
X-Gm-Message-State: AOJu0YwXIkGomMD/FrDbbee3Oq4ORMYRnKU54/fA6H/p4zEj/KACFhJ2
	ZCyUS2xNhEfvp81kdDqKEbd4rbCevwRs3rtPz2/WLCd1UfmAhKhKJJ6JiTrQEvnbON1pAayKQnf
	uFDjqb2U+83b1iD66o6PmQKFdxTZlQ1tkKfY=
X-Gm-Gg: AeBDiesLuGZoxTFK1/Bk7dNAjTs/9vn/vBkaupc+HsDfgHGd0a8A6o+XBFH6AsweCDC
	XUnvl+aoGMq28REqG8LTNnY7Vka0lCkBdkvRRLq5B5X1f5OlEOBK45g3aoYxDMKumo0kpjM69QW
	RZgBPSnTiz81VQKaI8ZTkYlsN44jj21tCx0LUCMbDauJdyQh5PERVLqvQqtZABZWABT9pSjBAvV
	VasVuNeK/1phz+H4Ja9sOZ6kHSEKkFs9u8n+E3nB6D88SkmQyesNNEypgaXVZNRcjLexvKG8i+c
	D0rom30oKWh6Rs/ERl84JleFKTqz++bN0SoE+dyEXQWj1fvCNNk=
X-Received: by 2002:a05:6214:40b:b0:8ac:ba63:a1b1 with SMTP id
 6a1803df08f44-8b028176865mr436359786d6.49.1776927913358; Thu, 23 Apr 2026
 00:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422212045.1325603-1-ma.czerski@gmail.com> <69e949b0.d40a0220.217dff.c3a9@mx.google.com>
In-Reply-To: <69e949b0.d40a0220.217dff.c3a9@mx.google.com>
From: Marek Czerski <ma.czerski@gmail.com>
Date: Thu, 23 Apr 2026 09:05:02 +0200
X-Gm-Features: AQROBzDuFzctpcYXhHmH4Q1qTj48t6ccuWPUsNICFoINVs4dlJ44VA1W0WhPhpw
Message-ID: <CAOOgLvopWS=LivSfa-VErCwzpBRA+BfWuva0UN9xJdbs_rEQ8A@mail.gmail.com>
Subject: Re: [BlueZ,v2] sixaxis: Fix pairing Esperanza EGG109k controller
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 11: B1 Line exceeds max length (84>80): "https://esperanza.pl/esperanza-g=
amepad-bezprzewodowy-ps3-marine-czarny,176,1701.html"


Should I split the link in commit message into two lines ?
