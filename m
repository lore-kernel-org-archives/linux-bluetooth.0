Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455C55E69
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748679651; cv=none; b=Eb6p5+wwz47nOkyJM5uBKJAWFaVh1y43jXT23NIaJRUT3burI62c/FwdvkJON+T/hzWULruZUIBbDFTf5y2TWPZtP246dDuU53LXFGs4YTkDxSfvfkDcsejYJ+HCDvsyUsd2nyuhHCpBFzU16JYKrmn4HFiz6br4DHiK2hYJFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748679651; c=relaxed/simple;
	bh=1vlYZmgTa+c6PdcjBOm0bSQCfQ2A0Od0AYLp31vGMqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccRyKDlpfpIMtylQLl2XrV2oBQEjeJizF0NRjAG3tpQykteNtDabJMXIsZK0fgYJeRId7tziBtC2GOrEE3aApDnyrn6B6b8yZBaUwDMV4USzoOYwGc0Bja2nuUbup+hmjGucHslecFLW9OjOgHyEUu4RSiZsnn7liOOPJkociJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9cwm8GR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9cwm8GR"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad89d8a270fso796607266b.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748679647; x=1749284447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lyyaIlp8Ls0DKLnOXoYHQT1ZRagcGjnJa2msDzsoVc=;
        b=T9cwm8GRp6I4v6gxBfB3mGHilT7z23r6f3Efc5FGt0ojqeDewMQP0mJ8wsyDGYOxs9
         2tyFobIfP/wQnCZUBDWSGYOK5glB3kp5mJslx0iJCnNaQq8dq/Nlqher5TlM2O1TiLi4
         zOZU5wfrLE/ti6zGs0nuJvxdzmQR3YbhIjJBGMA/77D45hK9Vtf3isMD5bfv9KeV+Ud5
         Uo8iPkPPEhbsC6VSvy2iNZW6UhpoXZu9d8l6S9n6xDcGnaNobL/SbeoPeW045EaqK40K
         5BVzxW6cKUaIzXzma66i8tkiHkI5aoJeP4UcKfVDaEU28DfEK6+dfUjHQxdnrDMGK/BR
         luqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748679647; x=1749284447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lyyaIlp8Ls0DKLnOXoYHQT1ZRagcGjnJa2msDzsoVc=;
        b=afyiY5awhmZROwJDLFpiGiNJXhanJ5uFJpQ4B4OaRSqPll7nXCVs0CEBuNiW9+/NMA
         44nzS58SIfiGM2iSdjttvkyEoC+OTCszToqfwNBUpJBB40GbmbcyHomTNihjw8lvl83x
         BvipSriOsILXs6fk2svtTGxl9Rox1QBGhdYNxzkTZKX0+zrfchJ+6YIhW/n6MLXJ0BeA
         9iJyeWHmLsKNvET2o26bfL48M3ooyKNpprqm5xuYKUhF6WnRMfNuAfUZB9gfhcblMbv5
         OHVmnG/JbpVetUrXJYFDDmv3CRULy4EHLM0t3wjDjJjfV2PWuKBxC1PsEAHSZOGAkApw
         9P/g==
X-Forwarded-Encrypted: i=1; AJvYcCWx/jDiLL+PHLa/t3f9RDMW/4884x8UuKI8i81unJDaxHynmECUwAFqQd0qflP5sXx1MCFsRzLI+9AX1bp6RWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3biX5JBHy4TG2ZZ6UnL0AE2Tx+Jh8NhpJY07sQLfBywUKeuKN
	Zp0KNJkdywHOLqPQAWVah4vLZwjMcAYBvdnHiFMhavQYrez/wiypnn8j
X-Gm-Gg: ASbGncuBSsNI/46MY6Dp0oP90H2BohLxq+6Z1DuJs5s+LZBM2DX/TRAOR0hB8RYk9gS
	jXEl3zmZi86m8EXXC+z3Al8iPIgEQpPnSPDtnh9m9OBIQ2LFwl1eSGSOuNWmCuArXR6szS4GLIn
	tODAueETWP00753ypmaeLI8karF+P8Qp7yRphQG3Z+dtduNPE309XqLmmOjVrxaJ9NrU4U0XQ7T
	DxlmajpwGFP2tDr9NiU9uxgHSk6gltCtGtOE40TGInAqV13KxP99I+XsV5gCdhAP9gJP+TBaquE
	35OS8ni+aYur2PeydbbN9FfeAUFKWR+gYifKgf9FP5hWtLZ1uyTQpmIpZN8GAUFNXsupUmNcgoh
	T1sPnFvYNiUJr+uy4FoQ=
X-Google-Smtp-Source: AGHT+IEitgMfxpJiEdNjojPC3xeqExcB34APiyjqTynORPOYgV1OpdxWwxPFvvNKTX9Gkwj6bNNwPA==
X-Received: by 2002:a17:907:6096:b0:ad5:5086:c2c7 with SMTP id a640c23a62f3a-ad8b0d7163cmr995962266b.15.1748679647153;
        Sat, 31 May 2025 01:20:47 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d84f2easm455062266b.84.2025.05.31.01.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 01:20:44 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id A64F8BE2DE0; Sat, 31 May 2025 10:20:43 +0200 (CEST)
Date: Sat, 31 May 2025 10:20:43 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: Antonio Russo <aerusso@aerusso.net>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Do not start mpris-proxy for root user
Message-ID: <aDq72xTNkz0kDqpW@eldamar.lan>
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
 <aCiLTy-IuqV6V7WA@eldamar.lan>
 <aCncrfc7qbtLEpta@andrews-2024-laptop.sayers>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCncrfc7qbtLEpta@andrews-2024-laptop.sayers>

Hi,

On Sun, May 18, 2025 at 02:12:41PM +0100, Andrew Sayers wrote:
> On Sat, May 17, 2025 at 03:12:47PM +0200, Salvatore Bonaccorso wrote:
> > On Sun, Jan 26, 2025 at 08:04:27AM -0700, Antonio Russo wrote:
> > > Hello,
> > > 
> > > A default installation of bluez results in the systemd user unit
> > > mpris-proxy.service being started for all users---including root.
> > > This unnecessarily exposes root to any security vulnerability in
> > > mpris-proxy.
> > > 
> > > Please consider the following trivial patch that changes this
> > > default behavior.
> > > 
> > > Best,
> > > Antonio Russo
> > > 
> > > 
> > > From d9e02494e661109607c073968fa352c1397a1ffb Mon Sep 17 00:00:00 2001
> > > From: Antonio Enrico Russo <aerusso@aerusso.net>
> > > Date: Sun, 26 Jan 2025 08:00:26 -0700
> > > Subject: [PATCH] Do not start mpris-proxy for root user
> > > 
> > > A default installation of bluez results in the systemd user unit
> > > mpris-proxy.service being started for all users---including root.
> > > This unnecessarily exposes root to any security vulnerability in
> > > mpris-proxy.
> > > 
> > > Inhibit this default behavior by using ConditionUser=!root.
> > > 
> > > Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>
> > > ---
> > >  tools/mpris-proxy.service.in | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
> > > index 5307490..118ed6e 100644
> > > --- a/tools/mpris-proxy.service.in
> > > +++ b/tools/mpris-proxy.service.in
> > > @@ -4,6 +4,7 @@ Documentation=man:mpris-proxy(1)
> > >  Wants=dbus.socket
> > >  After=dbus.socket
> > > +ConditionUser=!root
> > >  [Service]
> > >  Type=simple
> > > -- 
> > > 2.48.1
> > 
> > Looping in all primary involved people for adding or touching the
> > systemd unit file. Luiz, Guido and Andrew, any opinion on the proposed
> > change?
> 
> It sounds like the same logic would apply to all system accounts.
> Would "ConditionUser=!@system" make more sense?  For details, see
> https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html#ConditionUser=

Guido, what is your take here? The suggestion sounds sensible to me.

wonder how we can best move forward here, to have it then as well
resolved downstream.

Regards,
Salvatore
