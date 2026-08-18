Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5B1D95A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082883; cv=pass; b=DpaQYW0DWvoyZkxukOA1noKv4pR2aEHenaUFqI2WBsDo/eHl/QN0wBB7DpqVTJ5Qf3ForCmafZ+MNXqB9GxL6EcQmlEQCqvwLImtaDlaiw6ZgMX2ll9kcGyaOdo0rTF784PVz4zpVt9v36w4jQ2ohT19kstjEzBHza+IrsmJZc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082883; c=relaxed/simple;
	bh=qaKktGxdxzwMLfgkHKCb9M/ajlWC+bZIy0rR7JRnfJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbdXK32ISt0HxawlelZjAD752uMmThFfah5gLruT4RHzFm+lDYA/v/zLn3BbBE86hkmfGv4+KcYXSkbdDKWuEv4ki8C27/FhOfMbZg6sodHFYP92SLwqAxB282f+/jY2lBhvJnJ1yZbh3IzkS3QUXIRBgHGqg35fZbk4YRDNw4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLWhcCgv; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLWhcCgv"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-836c8bdac50so5153007b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 12:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787082880; cv=none;
        d=google.com; s=arc-20260327;
        b=cBfhF0QuKtfAq7UzCadctd5T1A7BDeIQWWSRGBclFKSXC2hETeaiHQ4duBNl41Izb/
         A50qJbe1Nt6v4FtFkfWWDYEciODOdpNkQgAnfmX5eQ7bwspUc9RdFDpz/gmKIVaKVRxa
         iouh+V4giDio/l8KnVZTMaBfMQEH2qWkYaYcqx3YcZrFdAsZvKlELI94266yfcFt+iAh
         5yh9agO+mp5vLcHAKLQkiNNpK49elTRXveJZ7s+ZwIF61x6VB3aAPBY2OSM7Wl08rqdg
         D+5kP5IBNjPc0nHqXYJG5toe+HSHH3/9Ra4Rg6lIu/IluiSs2NBY9pfKOcBM2/XST8EH
         ivHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hy41MZWlWcX+cA70VTsSYDQT1MFCJM1b7K/eGnq+/wE=;
        fh=aHiCXC+C6enwGTsZrm9hro01wl3y54U8jcWEXujQQ6E=;
        b=CyIcXvYbthuz7aUFUUF5KjXwCq0cRCDA2+zr06fDXXS+dPSvr8DajePtd2rmz8C5EV
         Oj8AJz0izg/BWJSiuQ6elQ6eHElr5q2RVGiV4ch0BwM4vUZmp3daZ5XdeutsMY6kUede
         Pphs4RFRfC+TdAs05Hui+85J8lE+MJCxM0XwCGrl4mvjjPYRq86qm6VsHFZ9RVoRfKK6
         UYHpScTD/pmoRmur5gP5f8iSNdbM6FUEcTiMqKL0TWYhMspAXIBxSI9GxZSoFIUryTSU
         bKqme7/EkTmQFARN+6MSe9hNXKqYb3UpFgcAr63UUyEqY1lcVqMEAaAEOeeb72Vwg2fW
         t9Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787082880; x=1787687680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hy41MZWlWcX+cA70VTsSYDQT1MFCJM1b7K/eGnq+/wE=;
        b=qLWhcCgv4eLHsjY9OfFa9evjqsgskaNPajnU/zoNZSOrmgJWVhkzVkPPkVBcBsyrXm
         C9jR3y8a1ebruUN8LWXvQKVdH2qQtjt8cxb9qXV4zMCHMBPKaj3JkQrqqKrdl3cUmNYe
         zeJ0i5Y8aweTvIssVGX2mH6cmijKx3dKKifqZ3InrMyAwZcLr/NTsNLEbgU0tdLrY5X/
         PrxfxEgHpSrdr59bSmEjlFVKqwTHztpVtllG2CH4XFcCdZfEw752NZ2jsGPRewNNGvSx
         pIDwie9WyzDyvziMOhlrtVAOhUPJB+tKY5TZbNpgG3P6IGrClzyrvqGi/Y0VeeK557kh
         TGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082880; x=1787687680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hy41MZWlWcX+cA70VTsSYDQT1MFCJM1b7K/eGnq+/wE=;
        b=PXF9k+AJ6yZCVxGbTgDxlgKp4wi9lvaHQIjKPJq+fa5rYFZXsYwUy6xDs5tTBZImhY
         7dc6RNCarOBdN7NBL7RAb5PNcWcRYiPglhTGuztlHfMgBbIRQIuhRUg8EzmMIsxr4C9P
         RixdFe0gV0qM6Ebv4tKVsWI9d3Peb83emowWHHtKM2wWFsCNXRWNeZ5603tIR6xxUKyE
         wuZ/ahraqpqQjav4mcaL47VN8y8KR8jcBMHWqub3S4I4LDBoMQjdg37LmgtqPCLhv6Mv
         PCNcGSQsniZd171jFkjaDQAT6Pd5U9RaJ9t0DsTfmZju7JywCVV2TczCUK9QO4c9jmMO
         VHow==
X-Gm-Message-State: AOJu0YwztZTZpP4g82q8fLOnkzOgCQu5Nx5MGoRhsiue19eR4kaRL7pq
	oyjCom/mu2GRlDFurV42cuIpc+qbHKLgVHinj/h0NaTuH4oW3t495AlrLRhZiF6U/L8FzoLCECT
	46wDhlPAuo2X/kHfUyzafpir0uh/EOVc=
X-Gm-Gg: AR+sD10wdjhSxsf6pVxbQ/FOThL/FILokCVPS2+PTAwu2P1X9CFBZQ0KHEFIy9En9tK
	bwxf89jwN/VsgPzdAewcJeTepChbmXEqN6vwrp21fwUeFYUNPJ09s1gJ1qGqsinF0+MJegKzTzf
	MsEg9wEW1QPlu1RHjdQsHbumyes6qMUcK2pxOTPiqD9yApxxja/wpbEW2531OQTBWWHd9ODoFrd
	OYikrMBDcYWFmRpb0wgwX0UhfnmuUmJOtuhfU0R0hGQAOmac/qsPr76MA2iS3L0VYGncBxHpnjl
	LklLb2aNEX4pWaGaYap/TDEXPfwmj3OiG7b5PBJ4I4XHhobJX7GGFszJGjRn2hE6XBxQnYAcIHu
	JT030QI+V5rf63ACdZ4nsyb2uVIpdEqM=
X-Received: by 2002:a05:690c:e:b0:7e9:4a7:9899 with SMTP id
 00721157ae682-844cff955aemr85097b3.11.1787082875664; Tue, 18 Aug 2026
 12:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Aug 2026 15:54:23 -0400
X-Gm-Features: AcwNN1XNjIfJZOBwoDDgfYxsM7AeSx0i1PSedEWCsIwmrGMYVSpf036pwNJ1xKo
Message-ID: <CABBYNZK76sQpZ1Ssh1nc0CnHXnY72A3Z=J75pOkkh7GMqUWh6w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/5] Add CS distance provider implementation
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Naga Bhavani Akella <nakella@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Wed, Aug 12, 2026 at 6:03=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> From: Naga Bhavani Akella <nakella@qti.qualcomm.com>
>
> This series documents and implements the D-Bus API that lets an
> external ranging daemon compute Channel Sounding distance estimates
> from the raw procedure data BlueZ reports, and feed them back for
> reflection on the device's Channel Sounding interface
>
> Patch 1 documents CSDistance1, the BlueZ-owned interface
> that reflects the provider's DistanceMeters estimate for consumption
> by desktop clients.
>
> Patch 2 documents CSDistanceProvider, the interface the
> registered provider implements to expose per-device distance
> estimates.
>
> Patch 3 documents CSDistanceProviderManager, which a
> ranging daemon uses to register/unregister itself as a distance
> provider.
>
> Patch 4 and 5 implements CS Distance Provider and Provider Manager
> interfaces

I would prefer to name it after the profile as just
org.bluez.Ranging*, it also doesn't hurt to document the relationship
of each interface with diagrams to ilustrate how to register and the
notify e.g. Ranging.PropertiesChanged("Distance", value). Regarding
the unit of measurement, do any specifications actually require it to
be a double and in meters, or was this picked based on some reference
implementation? We could perhaps simplify it to use centimeters, or
even millimeters, in a uint32. That would give plenty of range without
requiring floating-point math.

>
> Naga Bhavani Akella (5):
>   doc: Add org.bluez.CSDistance1 documentation
>   doc: Add org.bluez.CSDistanceProvider documentation
>   doc: Add org.bluez.CSDistanceProviderManager documentation
>   rap: Add CS Distance provider D-Bus API
>   client: Add CS distance display support to bluetoothctl
>
>  Makefile.am                                 |  16 +-
>  client/cs.c                                 |   2 +-
>  client/cs.h                                 |   1 +
>  client/main.c                               |  33 ++
>  doc/org.bluez.CSDistance1.rst               |  36 ++
>  doc/org.bluez.CSDistanceProvider.rst        |  32 ++
>  doc/org.bluez.CSDistanceProviderManager.rst |  53 ++
>  src/adapter.c                               |  12 +
>  src/cs_distance.c                           | 578 ++++++++++++++++++++
>  src/cs_distance.h                           |  23 +

This becomes src/ranging.{c, h}

>  10 files changed, 783 insertions(+), 3 deletions(-)
>  create mode 100644 doc/org.bluez.CSDistance1.rst
>  create mode 100644 doc/org.bluez.CSDistanceProvider.rst
>  create mode 100644 doc/org.bluez.CSDistanceProviderManager.rst
>  create mode 100644 src/cs_distance.c
>  create mode 100644 src/cs_distance.h
>
> --
>


--=20
Luiz Augusto von Dentz
