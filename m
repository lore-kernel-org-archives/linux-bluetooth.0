Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C121A3154
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114816; cv=none; b=SYPBL33U43Z327Ls5qE7+nfPh56e2e/gYZ9ks1Y34nDaykD7qe6ij1ZCKBYT68DCt4RXbE283UNrMZ2JmpmKGqs/hPV0pdmParWSp9iiSJ/TCiJ/91UvINJkb7CZhd81UTVqPO6pPBMMZLFY7o0lYOjNpGrctz+79sMF2Ut8RME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114816; c=relaxed/simple;
	bh=PsP5ylbeo51FJHBniuDMTYFNXdqCM5ydOh48OLsb+ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8H/ncpO1hKdDC+AoDHX5KO7tZlJQsQckShfXICHRPWlFkZ+ZRrRDEbb6iZPlP83gHKmwNp2stdZpTM25zYGvp/pF+Snbi1TDHiPhP1+NRG9iWrUbbVT+kU/S6zA4jUK8C0L/Y4ou93U4aKKnjaukmN1xSGf5S8Zl++V02OaEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+BnOWCl; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+BnOWCl"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so40534851fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753114813; x=1753719613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/uPd/UjXcdD1y2cIWdaZXgVYnwlNvP/l2zwGLvBB/U=;
        b=V+BnOWClvX9y5z1ZQi++du52bq2QUTMI8yQg/folJZIlryiAAcChtOFOq1yQ5tim5m
         NhzY545uv10+D/kd5o/y6EWI/u3god0WwRS2/ejs+xdRPTIEiBpaZNY080V0pqo3fTPk
         xLtasr6EMHjcOkFiRUuZ6RisnpDsR2zoJQkyO/zflRQ3tHXwNmnw73KTqtve2vlnigKB
         /r2FgoDkZpDMtsNAz/V9g4RShgvvMfiS9WbgPzgIHhO+jmg3S8+smgRwEbPVsO5VprIg
         KkCcmrsCP3QEoDHZVq30s1YwysP/FqGTP1Hh5QXPzfGkvezr4V/lto893yUIl6JcOLrN
         wR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114813; x=1753719613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/uPd/UjXcdD1y2cIWdaZXgVYnwlNvP/l2zwGLvBB/U=;
        b=I87whdbwmEeUMh7QVLmKw4C3hm4lvHx/2tYqcGdUNYZt+vEqCy4dzD9SRQ9F1d1kED
         v1YcLWL6xxO5IHfVOLYBZ6L1/TqUhDwStw2TT5aU3uGl095LjoFjSCukTg1SZ+n5gu2+
         LsynLa4FHoG5c3leqjumQk5fGr9B8TGGNIc48H60wyj0bId3INF0tq1+okZu6EX7hRwz
         0Hf8Xh1hmXRaYkWCgu1RCHem0wyN8L3SXcrqa9rjbybyfknOEKPX4cYUfzB2ZAOooTbx
         39ZsdolguknJL598/raE0ggy1vNpM/a6xQsqHU9rHnHmw/J7We+wQJvGdN3bVakQE9Kb
         abPg==
X-Gm-Message-State: AOJu0YymFtT9iThuRiUumpRlv5pBR6LLAU+01m4R3JjqfwmsRZhyMrTW
	rA1GqTHMPEp2QSMfPjOmImSBFebahl93auoIKHvtMQ+cipk5tXBQOn8hecyqEc8jDpf2QQHhDPf
	KAdGIXBwIt3dISwzrYa6cgTJa5kql40VEtbOmZfY=
X-Gm-Gg: ASbGncu3o6RaszOF+Ux1s0gXzquDXaAEcsia0x6fhGVDAebdXKMm5DQnjkkQ3EXHSaG
	XYnOJmY0ZNZbX/h0AKD2DUkbTQAqZ9HTY6X0LmUKk8k0QqEGqFxFPMknVxM8SChWqk9pfh8ypYd
	Y3Mkh+sxr6rI0J1KPD9Q8FomexHaKQWhdpgfwiWXdTqD4VmsWIZhrFn+E9YP8rCC4IrVrjZ5z6r
	UiBGKfr7a//iBut
X-Google-Smtp-Source: AGHT+IFn7DQjD2gqhZQhvyX+HDsm7AauXtlzJF+PEx738VseR8sY5J7+OJacos60PQF9K2AN6f//iNIJGlO04Ig6+Xk=
X-Received: by 2002:a2e:a99a:0:b0:32a:8916:55af with SMTP id
 38308e7fff4ca-3308f4c5e9cmr58294701fa.2.1753114812784; Mon, 21 Jul 2025
 09:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
In-Reply-To: <20250721152219.517-1-quic_fgiancan@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Jul 2025 12:20:00 -0400
X-Gm-Features: Ac12FXzZm2dKPfQIFLYn7FeQdK21VDobYQYQgceg5Y6M1CqPl_lLr7TNUTi5Nb8
Message-ID: <CABBYNZLUK45-eBcYAn7oq9-gewhE_XLXpnPiwKXPF-tOX6JYrA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
To: Francesco Giancane <quic_fgiancan@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

On Mon, Jul 21, 2025 at 11:24=E2=80=AFAM Francesco Giancane
<quic_fgiancan@quicinc.com> wrote:
>
> Hi,
>
> I am posting this patch series to better decouple `bluetoothd` daemon
> and `libbluetooth`, as mentioned in the subject.
>
> I am introducing this change to make new BlueZ more granular.
> This will allow more control on which components are actually selected
> to build.
>
> Major use case for this change is fixing circular dependencies when
> bootstrapping new builds where the whole build root is to be recreated
> (e.g. Yocto Project).
> In these scenarios, to have Bluetooth support enabled in Python,
> `libbluetooth` is required at build time to be present but the direct
> chain of dependencies would require a Python installation available,
> thus introducing circular dependency.
> Separating the library and header files from the rest allows build
> systems to break the dependency loop.

In theory what we should do to fix this is to add proper header to the
kernel, since libbluetooth is basically just used for syscalls to the
linux-bluetooth subsystem, btw doing that would also fix the likes of:
https://github.com/bluez/bluez/issues/989

> `--enable-bluetoothd` flag is added to the `configure` script and
> it is keeping the same behavior as other flags.
>
> Francesco Giancane (3):
>   configure.ac: introduce `--enable-bluetoothd` flag
>   Makefile.am: build `bluetoothd` if enabled
>   README: document `--enable-bluetoothd` flag
>
>  Makefile.am  |  8 ++++++++
>  README       | 14 ++++++++++++++
>  configure.ac |  4 ++++
>  3 files changed, 26 insertions(+)
>
> --
> 2.49.0.windows.1
>
>


--=20
Luiz Augusto von Dentz
