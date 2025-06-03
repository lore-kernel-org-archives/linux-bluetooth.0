Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC341DB366
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961393; cv=none; b=ADrjK7zZedvNRWbUME2oWY573ARb2am0SS6O+Db2+zB2cgruLtin1KCH3g9YatoNLDPbeRPe6v7qGTmQXqNeQM5Rlslfg16+3UPm4Yl1MiKYP0YUFrcEKauYtOtsaJPWU/4auzOo4Z83AP09EYPa+pjvfXssbLtfkIvae0g7DBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961393; c=relaxed/simple;
	bh=Au8tohT63CIXSOc9lZCc0ErS2ZogOdRmosGaoLKYWKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUX2HgGi8/K1cUJRExFq/riZ5/RZvwiXYAcAwCjOtzfsRlYDcSG89F/ULE+T23tiUWDp82Na84+Ci6EKz33cqW0bD4WzEtHmevUsKYl9i9AGcSPgylY9SEwu0qiQhl6Ha9RTwqBbs5IBXbSwZDBO5Tz8tH9WVgcr/gazJ+eqpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from b.c.7.5.4.6.c.0.5.9.b.5.4.1.5.6.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:6514:5b95:c64:57cb] helo=andrews-2024-laptop.sayers)
	by painless-b.tch.aa.net.uk with smtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uMSkd-001rq3-0K;
	Tue, 03 Jun 2025 15:36:27 +0100
Date: Tue, 3 Jun 2025 15:35:43 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: Antonio Russo <aerusso@aerusso.net>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] Do not start mpris-proxy for system users
Message-ID: <aD8IP-un7nkRdUDv@andrews-2024-laptop.sayers>
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
 <aCiLTy-IuqV6V7WA@eldamar.lan>
 <aCncrfc7qbtLEpta@andrews-2024-laptop.sayers>
 <aDq72xTNkz0kDqpW@eldamar.lan>
 <aDtHoRCof-iND3Td@quark2.heme.sigxcpu.org>
 <30a9641a-05fa-4a44-af58-6b155dc7ecfc@aerusso.net>
 <CABBYNZLQ+HkEm0koVtwJGgxaOTxiy=UTOtc2Do1n0q3CRXEm7w@mail.gmail.com>
 <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>

On Mon, Jun 02, 2025 at 09:37:20PM -0600, Antonio Russo wrote:
> A default installation of bluez results in the systemd user unit
> mpris-proxy.service being started for all users---including root.
> This unnecessarily exposes system users to any security
> vulnerabilities in mpris-proxy.
> 
> Inhibit this default behavior by using ConditionUser=!@system.
> 
> Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>
> ---
>  tools/mpris-proxy.service.in | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
> index c49d255..6ae56c6 100644
> --- a/tools/mpris-proxy.service.in
> +++ b/tools/mpris-proxy.service.in
> @@ -4,6 +4,7 @@ Documentation=man:mpris-proxy(1)
>  
>  Wants=dbus.socket
>  After=dbus.socket dbus.service
> +ConditionUser=!@system
>  
>  [Service]
>  Type=simple

Reviewed-by: Andrew Sayers <kernel.org@pileofstuff.org>

There was a question earlier in the thread about how to acknowledge me.
I believe the protocol is to use "Suggested-By:" when I haven't replied,
and I assume the "Reviewed-By" line *replaces* it now I have.
But I could be wrong, and don't personally have any important requirements.

> -- 
> 2.49.0
> 
> 
