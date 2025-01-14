Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2BF20F97E;
	Tue, 14 Jan 2025 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856030; cv=none; b=UfCeZdwRzXJ/dQDWdKF4425W7FPMtI6ZMeZePaaLE4ztU0GZ+/IkeC21qovrR4LHDHkSYmkufxWVGgT/FYN0VT43yBj9B6PbWpMnP5DiN7AV7RYkFqxCcC7YIQn7m7MVpYy+GYw/GEtctuD1JTrAP9FgKt1eNLpM/tUZ0F39mL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856030; c=relaxed/simple;
	bh=WdkfolhkmMPSAd77i6iQwDbzFTGCTL/LG2j07n2IHUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCLokmLCZKc3jnt+V3u92B8JG3LNluwGwJL92vY7ptk1NKfIYsU8MIGBoCfZEKeEXzy+xHprIKnk3JsDj5HaXPcTEuAfxn3VGGlReZEiz/335xmk6eHDATzFPs1dxVfnHsRSUgwYLrlpTz9ZYAvHpQIZZDfHuxLoJbNCPjOnK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep3Io9Cu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep3Io9Cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172D2C4CEDD;
	Tue, 14 Jan 2025 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736856030;
	bh=WdkfolhkmMPSAd77i6iQwDbzFTGCTL/LG2j07n2IHUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ep3Io9Cu+tRphCpEoD31tUJf+K8VCSzUof3fxBrh9SkpiIq8eHsGWOxO+6qnu+cck
	 Pz3Ynadyo2AYoXUpnIOLSCQUB/5QUMhl114fWQM30D6pzz8sqUE/CTY1sWjxIK/ctB
	 jM7IneLY7VNaLNhm+xs4gQlyOMQroXZABlD8jMegVyXb+7ys0mrWkN2FoUgVBbWMrZ
	 dd0CWKzUejKQfCqIu79fELeAQrv+DT5VL2fAHb7WzZ8JVkMvpBbSe6iFzVpIcx27gc
	 tr/qs9FCVBTgtp5hmUG5HHk6218f9b4CfPDRSrDGusfs1a7UcZGuHrznnF38Szc8yr
	 kruN/E4JAF5sA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXfay-000000002P6-240B;
	Tue, 14 Jan 2025 13:00:32 +0100
Date: Tue, 14 Jan 2025 13:00:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
	jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 1/4] gnss: Add AI2 protocol used by some TI combo chips
Message-ID: <Z4ZR4Az75od-JPgn@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
 <20240606183032.684481-2-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606183032.684481-2-andreas@kemnade.info>

On Thu, Jun 06, 2024 at 08:30:29PM +0200, Andreas Kemnade wrote:
> Texas Instruments uses something called Air Independent Interface (AI2) for
> their WLAN/BT/GPS combo chips.
> 
> No public documentation is available, but allow that protocol to be
> specified.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/gnss/core.c  | 1 +
>  include/linux/gnss.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> index 48f2ee0f78c4d..cac9f45aec4b2 100644
> --- a/drivers/gnss/core.c
> +++ b/drivers/gnss/core.c
> @@ -335,6 +335,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
>  	[GNSS_TYPE_SIRF]	= "SiRF",
>  	[GNSS_TYPE_UBX]		= "UBX",
>  	[GNSS_TYPE_MTK]		= "MTK",
> +	[GNSS_TYPE_AI2]		= "AI2",

This should probably be merged with the driver patch (even if I see now
that was not done for the MTK protocol).

Johan
