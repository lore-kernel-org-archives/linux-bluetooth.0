Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B904207F
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 May 2025 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747491288; cv=none; b=N7/I6n45giDE9u/TxfS9i1QrLSDsGBThccSrBM1UgkgOGNQrbUhSaQYh2UN6OQRGIxHeDzWjmkOA+7+7TeRt8yY9yleOZ3msxB/ustt1F+aEkxeKWkB0f15E7Jmm5L/HNo66SRei7XpKKU6eJXjWD+ae3KeOYYM9oouKkz57RSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747491288; c=relaxed/simple;
	bh=7AZ52t3irYXAvgbx4AKKGSPeF5UUXVSZc45gHp/kN0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmBnUsuTa0JIwRVjXMMvZUSrLCJ9Hfqfke7kAVSMnF4DZ5PHdtwf/fqBhjU19C7zmM4UbcQrrS9xuFf7XRoTIHIBCRfTMyJqtK7vPBHH0FKRoce7jAgmO6dUlf9+dxFOd62PADZn3bQ9ABhO1cYRAhyEdrqd0lt4+dwySB2Nijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=Tg+CHVBV; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=i8T1IW9Q; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="Tg+CHVBV";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="i8T1IW9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1747490769; bh=7AZ52t3irYXAvgbx4AKKGSPeF5UUXVSZc45gHp/kN0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tg+CHVBVb2mEu6vbjBOnhrCT3enBWz+1EQpxWdg/3+JtVkqsAQ6FY5UezMd+gAq2Z
	 /oMHJ6211M74/ci6CngORfqMxmqZhwsV67vncXm3X2BJ7W5tOBeVrrRPqXnOeX5VLx
	 tqflVzUQlcr06k3BxLYpmX/wtylgoFVlkuYAxIvAHRWdKy2Qr6QPmNLBIJabcseq4T
	 p82M+2u03DPpbhh9yAuJe0dxO9YOLE/C/WOC75kWadcb07ZO90vYPqNepNgE3Q71ma
	 ZIi+FFwmkcXq3v/3T9PphOlTRkpOM3GP6qvnLuH5gX3F5j7uR5rHcAu+7wsl8+KcrE
	 EQgb1jLdN5Hiw==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id B6150FB03;
	Sat, 17 May 2025 16:06:09 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AHiv3M2Lkb3N; Sat, 17 May 2025 16:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1747490766; bh=7AZ52t3irYXAvgbx4AKKGSPeF5UUXVSZc45gHp/kN0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8T1IW9QMekXgsL+1VmT3T+hph8x5+hEaCQ66qDewVohytWD81XT7gvjADGoS9hE3
	 nr4Tah3PS9y4jvLZawgVUdKaiUh7g3edS3gPpa+Xm2nQZ7hxlDWivJbmAZ4j3HW0wg
	 TDePmVgiIEA/E3rYD0iuT71k/g2XhTTvou/wM7jQfLUXNjbD9Z/LECZRGldY1abbaS
	 WwrfdeznkaAHUZbXvOqhL9raF1bFdsVurS3TGT87EwjezMY/H5Y4+pbnPzVy0ysnLm
	 oN87kDg+B9oA6G+/xIqqnwXqD0KNMpoWRXhM+oZTdbgma0QWFXCPFQu+txi9sGnPcO
	 GP+yQa+HUwFlg==
Date: Sat, 17 May 2025 16:06:04 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Antonio Russo <aerusso@aerusso.net>,
	Andrew Sayers <kernel.org@pileofstuff.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Do not start mpris-proxy for root user
Message-ID: <aCiXzHmhgzLbZMZ9@quark2.heme.sigxcpu.org>
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
 <aCiLTy-IuqV6V7WA@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCiLTy-IuqV6V7WA@eldamar.lan>

Hi,
On Sat, May 17, 2025 at 03:12:47PM +0200, Salvatore Bonaccorso wrote:
> On Sun, Jan 26, 2025 at 08:04:27AM -0700, Antonio Russo wrote:
> > Hello,
> > 
> > A default installation of bluez results in the systemd user unit
> > mpris-proxy.service being started for all users---including root.
> > This unnecessarily exposes root to any security vulnerability in
> > mpris-proxy.
> > 
> > Please consider the following trivial patch that changes this
> > default behavior.
> > 
> > Best,
> > Antonio Russo
> > 
> > 
> > From d9e02494e661109607c073968fa352c1397a1ffb Mon Sep 17 00:00:00 2001
> > From: Antonio Enrico Russo <aerusso@aerusso.net>
> > Date: Sun, 26 Jan 2025 08:00:26 -0700
> > Subject: [PATCH] Do not start mpris-proxy for root user
> > 
> > A default installation of bluez results in the systemd user unit
> > mpris-proxy.service being started for all users---including root.
> > This unnecessarily exposes root to any security vulnerability in
> > mpris-proxy.
> > 
> > Inhibit this default behavior by using ConditionUser=!root.
> > 
> > Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>
> > ---
> >  tools/mpris-proxy.service.in | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
> > index 5307490..118ed6e 100644
> > --- a/tools/mpris-proxy.service.in
> > +++ b/tools/mpris-proxy.service.in
> > @@ -4,6 +4,7 @@ Documentation=man:mpris-proxy(1)
> >  Wants=dbus.socket
> >  After=dbus.socket
> > +ConditionUser=!root
> >  [Service]
> >  Type=simple
> > -- 
> > 2.48.1
> 
> Looping in all primary involved people for adding or touching the
> systemd unit file. Luiz, Guido and Andrew, any opinion on the proposed
> change?

E.g. pipewire does the same, this makes sense to me.

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

> 
> For reference as well discussed in downstream Debian in
> https://bugs.debian.org/1094257
> 
> Regards,
> Salvatore
> 
