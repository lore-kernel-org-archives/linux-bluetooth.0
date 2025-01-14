Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F01F9EB3
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886694; cv=none; b=stOYSFdpybGzqIi5gUIbAg6Lu1DO3aExX2BWEfftyqIErid61AtOSMfGVC0FkmFY7QA79z2R1djmZsAD2DnwTilCk8/+/VMmSS5cNV9yQ+yALx4xk50U0g6bjFEbgJkzHrwUHhbB1zj1+13SqsFXoc4+EyXtTG87ahz0gX0y55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886694; c=relaxed/simple;
	bh=XIL3ywKxUlcokfEQiVKQkmCnW1xwo/HawgFmyztZ8aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmXnZ1LU+lGOe4Rs93sBE3SqR0tJuCKBg46c8iD7OpSy1c7SuK5hXtU/9R6K5/dIXhXRlgI4zbfLaE+wEnUrknuEvlHzHCfczjSuitru2+LH5OHXoQUpNWtc0WudMK+tK55gzcjL9TqLw7CJKkO1fC8p277dmLyQAjEPpmgxroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDgQkBFa; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDgQkBFa"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-304d9a1f198so49343251fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 12:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736886689; x=1737491489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XkYyelAInhVerguCmvLq8ppkoFS/GXH3vsoL9zuQis=;
        b=SDgQkBFacZSzbD155lUzwjQXN9YHBQVIAPP3TaYy3DILCfNDhCImgrZUXa9XqIesKJ
         VDfen5MKwQG5dQYFmr9G6pRwtTjwYIcYuZvbHrzi0htyYwYDMW2nWgGkd46d8C+3Q8o/
         19PSOdlNpyGEohPpFp4wSXVYYFmDqTyQ8738q2SjtnSj9N5pzer6cnmLSUpvcSUVbmqC
         Eby03lTcdqZpjQmrERHoj0bHkpP8SD02r3/mA8xfm5Tgm992YN9uYSE17qGXQZwAal4l
         W8LmQa7UyZ1e0D2lw8Fw7p5BWcU9bF6B9BpiflvGqIEOa7ESa9SECEWeTOGnE9aUY4Nj
         aG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736886689; x=1737491489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XkYyelAInhVerguCmvLq8ppkoFS/GXH3vsoL9zuQis=;
        b=NuMXPDx3RKLVhfh86zpOEAYtW2bXj2npZ/xtR6H7zEJFj9d107TF8hrLSruHxYuguS
         iTW7hLsYx41rHvMm1Aj9Y8wuZyzcztSPsF+dD1cbVrJQhDI4SwE5+iw2FyrUApBDsZRk
         y/LuwmyLshvAt1zcnN8XMjyw7Cyi69RAm/rWr2ktO4XLnCdO5ETvFCPc/gwwz+1U1LdI
         F9YUOiBF8semNbtrC1Es+djLbbOM7DJwXtOPsLHURZOlsgzcI7lLDCxTXxQDmrgulA3y
         NKIjMpiyTJYLfBuilE/ZoPpV1UMISg7gtF8CmLHhCrk78NemMO6XJ0zJulAo5+OTlwqw
         FGaA==
X-Gm-Message-State: AOJu0Yw4OFIG4cL5pXMz7p1TfKJ/RNGEFxCZAIytkhQBsB5BTe4+3735
	Vp50J0sbSXC0jMIFYe/0TT8POSS+xFKIFtiISisCLX25v48w4nzlJRYE8z14fCOeGq8vOqIAame
	/wuDpNaJgaQoIsPUWBmm4goS6XSTbOw==
X-Gm-Gg: ASbGncvgiAcXZE+RMbaIWJaSB8dSYjO9LfRy8OwkWtpo4wMouENE0CAJEI8a/k7qTtk
	V0eb4zc3ejjTqbCAZzaxxtpn9uOOVVBIsGkyIGzU=
X-Google-Smtp-Source: AGHT+IEcL6OApW/dbGdLi0LdTTgmgPsiEswmnwISO59KlA8gYAjfA0Ox2SPguw6wdK1ivNfftBrYFxTdxt7Dk4pTfrE=
X-Received: by 2002:a2e:a98f:0:b0:304:4cac:d8ef with SMTP id
 38308e7fff4ca-305f455e963mr80773921fa.7.1736886688892; Tue, 14 Jan 2025
 12:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
In-Reply-To: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Jan 2025 15:31:16 -0500
X-Gm-Features: AbW1kvbv-NOZFs33EQk_8--ivPRbU2X4SjZSezO2qVc1ciYOEyf2JPjeBEiI89g
Message-ID: <CABBYNZ+L0WB3PSGyo5OWdF5KTWgjZ=kKpDGsxXhtQM58cYL6ow@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] connect VCP profile to MediaTransport volume
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Fri, Jan 10, 2025 at 9:54=E2=80=AFAM Michal Dzik
<michal.dzik@streamunlimited.com> wrote:
>
> VCP profile was already implemented, but there was no way to control it o=
ver
> dbus interface. Now it is connected to MediaTransport volume property for=
 BAP
> transport.
>
> Michal Dzik (3):
>   vcp: connect VCP profile client to MediaTransport
>   vcp: fix memory & connection management
>   vcp: allow volume control when acting as a server
>
>  profiles/audio/transport.c |  37 ++++++---
>  profiles/audio/vcp.c       |  62 ++++++++++++--
>  profiles/audio/vcp.h       |  12 +++
>  src/shared/vcp.c           | 162 +++++++++++++++++++++++++++++++++++--
>  src/shared/vcp.h           |   7 ++
>  5 files changed, 260 insertions(+), 20 deletions(-)
>  create mode 100644 profiles/audio/vcp.h
>
> --
> 2.34.1
>

Are you still planning on updating these changes? I gave some feedback
but I haven't heard back from you.

--=20
Luiz Augusto von Dentz
