Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D548F40
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748715947; cv=none; b=PPodKTMLXT7CVkXI6fc849Z4g9TL1x+lDUVPp5PNFc6RpNzMhjfWy53UTn4jhVRdWfxczJxrnw4sdt9tPKHdSzV/mbHBl8uXXiHuR/58MVFfIj9jPkaJn008eWHtN9xlUOLReChSY19xXiqyA3ojCeH8zsrVcbHRNAzRINqR4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748715947; c=relaxed/simple;
	bh=Sc4tDPNBxAAA2mtYWinUboC+js58LbglR4sWD7AuiYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQPeXSYoBALz+dHdC/YsGN+kKBntmYd9NjlWsGvlJYbhSj3Qr9e7dLyWJK3BCHg0RHL/8JZ9EArgfmOxqMuKOCi459H+t/80AK00RBwACnlGJ91CbYhKCCaf6pRegsHc4/3uRJ1J9mUVX1PHsmEbOtOEV7VyuOP7YDmviJ0KdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=P6XM5qz3; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=j2iq+9zl; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="P6XM5qz3";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="j2iq+9zl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1748715428; bh=Sc4tDPNBxAAA2mtYWinUboC+js58LbglR4sWD7AuiYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6XM5qz3Tw9fL9FCBkWJ3mOwODALFJRkpEz45Qy7p+WpKrkeh1e2Td2vtkdXZYfj3
	 Ewwqr5MVsEIr/XEf3p20483E2/Z++VZMsHDtolRomGPN2Dc/Uxh+QgUA3fvOMTyp+z
	 5K1gtzEtIkyBuGXcEYK8QsTfxMGqnjGAhSz378OfYoFl1CkY+CrTkE4MMqBEZLH2ee
	 YaHJir9Acp8IiO1K3EbaONww7wgpvqzfK04wjxg4iZeohQ5QqnQB7W78Gmew6fdSD8
	 eWpVQixR6PVncwuYeEvjU3UShlXgrcPza8LXxL5lDAvL8woUUjyyy+g18VEURynnrl
	 Y0DwjPDudEHbA==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id E6F48FB03;
	Sat, 31 May 2025 20:17:07 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U_qLxr_XEu6L; Sat, 31 May 2025 20:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1748715426; bh=Sc4tDPNBxAAA2mtYWinUboC+js58LbglR4sWD7AuiYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2iq+9zluSortZ5OVF0TvSKFbrcx5B3wxWOpHE5sCqU8LW7I0q4hAGTdRiKnQYxlj
	 8wFQrIrU3MkWlrB7l3zLwyejUeGJSDmkPrqIUcBjGwFMJIVjy4jULuv1RuWEhgAJcB
	 jfi6sRD5ysidXb73/WtHXsJarQB/Z9UwjHVNq+MJTdy90UFxRO3C60VXoo9sBbfRXx
	 XCPGsYIlhlsaJKOXC8I/qrYC3mgkCiPQgrJdFBQhDJOjupVXJMVUfmLYlb3yOa01Ih
	 EpyhceWH+29vPs4RL5P/JEMu/zEEljA5PJ3R7XevPsUEqa9SzZx9gXw7mpJaiYezIx
	 vMqk7XwjgUPAA==
Date: Sat, 31 May 2025 20:17:05 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Andrew Sayers <kernel.org@pileofstuff.org>,
	Antonio Russo <aerusso@aerusso.net>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Do not start mpris-proxy for root user
Message-ID: <aDtHoRCof-iND3Td@quark2.heme.sigxcpu.org>
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
 <aCiLTy-IuqV6V7WA@eldamar.lan>
 <aCncrfc7qbtLEpta@andrews-2024-laptop.sayers>
 <aDq72xTNkz0kDqpW@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDq72xTNkz0kDqpW@eldamar.lan>

Hi,
On Sat, May 31, 2025 at 10:20:43AM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Sun, May 18, 2025 at 02:12:41PM +0100, Andrew Sayers wrote:
> > On Sat, May 17, 2025 at 03:12:47PM +0200, Salvatore Bonaccorso wrote:
> > > On Sun, Jan 26, 2025 at 08:04:27AM -0700, Antonio Russo wrote:
> > > > Hello,
> > > > 
> > > > A default installation of bluez results in the systemd user unit
> > > > mpris-proxy.service being started for all users---including root.
> > > > This unnecessarily exposes root to any security vulnerability in
> > > > mpris-proxy.
> > > > 
> > > > Please consider the following trivial patch that changes this
> > > > default behavior.
> > > > 
> > > > Best,
> > > > Antonio Russo
> > > > 
> > > > 
> > > > From d9e02494e661109607c073968fa352c1397a1ffb Mon Sep 17 00:00:00 2001
> > > > From: Antonio Enrico Russo <aerusso@aerusso.net>
> > > > Date: Sun, 26 Jan 2025 08:00:26 -0700
> > > > Subject: [PATCH] Do not start mpris-proxy for root user
> > > > 
> > > > A default installation of bluez results in the systemd user unit
> > > > mpris-proxy.service being started for all users---including root.
> > > > This unnecessarily exposes root to any security vulnerability in
> > > > mpris-proxy.
> > > > 
> > > > Inhibit this default behavior by using ConditionUser=!root.
> > > > 
> > > > Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>
> > > > ---
> > > >  tools/mpris-proxy.service.in | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
> > > > index 5307490..118ed6e 100644
> > > > --- a/tools/mpris-proxy.service.in
> > > > +++ b/tools/mpris-proxy.service.in
> > > > @@ -4,6 +4,7 @@ Documentation=man:mpris-proxy(1)
> > > >  Wants=dbus.socket
> > > >  After=dbus.socket
> > > > +ConditionUser=!root
> > > >  [Service]
> > > >  Type=simple
> > > > -- 
> > > > 2.48.1
> > > 
> > > Looping in all primary involved people for adding or touching the
> > > systemd unit file. Luiz, Guido and Andrew, any opinion on the proposed
> > > change?
> > 
> > It sounds like the same logic would apply to all system accounts.
> > Would "ConditionUser=!@system" make more sense?  For details, see
> > https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html#ConditionUser=
> 
> Guido, what is your take here? The suggestion sounds sensible to me.

Sounds good to me. The system users include users running the login
managers which can have more components on e.g. mobile (for emergency
calls, etc) but I don't think they'd need the mpris-proxy.

> wonder how we can best move forward here, to have it then as well
> resolved downstream.

I *think* the patch needs a respin by Antonio and once applied we could
cherry-pick to Debian?

Cheers,
 -- Guido

> 
> Regards,
> Salvatore
> 
