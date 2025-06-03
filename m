Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD37269AF9
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933989; cv=none; b=oC6EYK7HKYWi2MI2sAHIawcikUC9iX0iYUwsiqoi9YRx7O17slHCTlQIK5eAwXMnI1usggAbDunWQsOOP2sBgD8nkcZlLKvpuOQmiaFT0xpZptekyaqiKB873DRzDqe2hena7x6RcVVVI4lO2Iqggh9yYHsJ+GUfBO7AGnrzopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933989; c=relaxed/simple;
	bh=cnQKlUAdPACz53YzIWVPr51Adv8CZ8oo3BQrqRXaLmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggS/4DNBuuYvJq7un2aqSvAYc5camzQ3F2BBe8izlP5A+8uQzRX7bntwTkYKr++Drdm6DbagWhUjSkkJKbE94/gLXTsGFnPrfn8KU+8Ef2SJ6Jg8F3cAEK5RoOtfb7LA3RNxpcyMTEyfulxGjvFIJfvaEWJbTq4/X6K0TfTtRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=LMbREgtA; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=hkfEjBNl; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="LMbREgtA";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="hkfEjBNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1748933975; bh=cnQKlUAdPACz53YzIWVPr51Adv8CZ8oo3BQrqRXaLmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMbREgtATkEJukGApVQ+HMhG0bLwhi4BN+4FT2qkOLlbMwhvE46YhY7eApInWMY63
	 b4oXhXcchfMPwI7vpfmJA6UnBioVhXq73MmChR6DXs2gUFbVqL1oaHDux2r5XKhhOY
	 yzZI2VZXQukdS0wrDw7A9ZoYAeGYjiOKHH5c7AxzXfKLdqXA9GaEalisXXzIi8ALUn
	 pAY2/P6K+VPh9n60EycDzO8K4WbWPsu6mHQS2YdB8/xPCaNYUVcOdHsBRMnO/r07js
	 FIk69c3CtyuTGAVNAM6u1y9NgLpDDVa+/QE1AdXz3713ZuUTjEkGinuxgTBPakKs0r
	 guLWx0MMqDWjQ==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id EF85DFB03;
	Tue,  3 Jun 2025 08:59:34 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQSKf5E-EXji; Tue,  3 Jun 2025 08:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1748933973; bh=cnQKlUAdPACz53YzIWVPr51Adv8CZ8oo3BQrqRXaLmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkfEjBNlIkmDG+MwkNvbkEUDpk2eHsZHGOT+7TKeaUmNwMKWpc91g8GULqoQaxxoF
	 371TvILlsjBuSnOq1NNRSNeJD9bomhYr3Kbl5DMK8tcQeYjk5Ux7Lz2g51ite0zj/z
	 hvwS4P1byj7LnToZBBtucGRZfAah3F7O1eI/TFDzgDiMfn4cRVYfwHsbMIiWHzZoAa
	 L3V0+cXLoddgeHPc2Ew9B8A/32XryImeuA0yMlew33C+y6sgNbvaZYbtZ3dwizqyaa
	 o7Pni+2HyNRFEBnGn2Tk1507duHYIb9I4nD5M/dcF6YgsbXLhKuz+9eJ/W79lFLanL
	 B3eumVmlVnPJA==
Date: Tue, 3 Jun 2025 08:59:31 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Antonio Russo <aerusso@aerusso.net>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Andrew Sayers <kernel.org@pileofstuff.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH] Do not start mpris-proxy for system users
Message-ID: <aD6dUwsVupRRgJV9@quark2.heme.sigxcpu.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>

Hi,
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

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

> -- 
> 2.49.0
> 
