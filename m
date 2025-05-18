Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448A17C208
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 May 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747574027; cv=none; b=Ct4JFd7n8VblB0a9Wd3WR5s7Psk9h9DFNA4E3e7M/Qfn0lEgeIsRlQsz2BPfMigFzmzwq/8OkLy4QbYJ00RAelwn7NnNpYDgWdZr+/xjw64+lCT83Xg3AA0oQ14FgAl9kCngbqscce0yGdgOx5Z33mNv4CsSaHH15QbM1zAZux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747574027; c=relaxed/simple;
	bh=YouRpO9udCOfFYtPYlXWPN+hho88BQ44dB189UOZ43E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlLSI0neDSuMyfXhOf7qPzHmkIxPxPayjZS/YlvtMCEzE2HKnVyxN35AbbpOQeA0Ppjrxvrdoqxq3tQM8wOmlkxhxfewZ+OlhVPDzrcW9IiDYPX1NM5s6DPQUgYbps8iQYmtI1frVvXcnbSKMkCL+WEPyQ3zjN7m50xAGSKMW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 8.c.a.5.7.0.2.f.4.4.8.2.b.b.b.d.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:dbbb:2844:f207:5ac8] helo=andrews-2024-laptop.sayers)
	by painless-a.thn.aa.net.uk with smtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uGdpk-00FmML-39;
	Sun, 18 May 2025 14:13:41 +0100
Date: Sun, 18 May 2025 14:12:41 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Antonio Russo <aerusso@aerusso.net>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Do not start mpris-proxy for root user
Message-ID: <aCncrfc7qbtLEpta@andrews-2024-laptop.sayers>
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
 <aCiLTy-IuqV6V7WA@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCiLTy-IuqV6V7WA@eldamar.lan>

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

It sounds like the same logic would apply to all system accounts.
Would "ConditionUser=!@system" make more sense?  For details, see
https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html#ConditionUser=

> 
> For reference as well discussed in downstream Debian in
> https://bugs.debian.org/1094257
> 
> Regards,
> Salvatore
> 
> 
