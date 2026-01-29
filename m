Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0671E346A02
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704213; cv=none; b=RStjDNdyTTbqqQrXy4Hlw94M1HhCFrk5IQ6rxR7lTRV57uUjToZp3ZKLJZRznekbE/NGB9lCGrjwLgRZ+r/0NH+NTirQn4rzQwA8DOS+6AiFbOrE/s0udQIbF4wdUsWhQxXw+G/MlNhzaIkKHx3+sAXQITVSSwGsBprJSLN6IIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704213; c=relaxed/simple;
	bh=wfClSVRN+fFsKBDCcyrkVDxDGPhGoUtY+ZaC6xnR97Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RAT/a+DaXF7uCSwM5GPFjBrebHDhLnT9zKT4dAs3TX0sSmkmhMtW7W66KZ0GXnU8TullDsXiYqc9esUuNn2MgIyMcZI5KjQgCktrDiVEr1puewzvRvgLr+w+QIYfo9gCk+fbkuZC729lrAL3QzltXRTPEuH5CyNqxbeMcmvKcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt+eFdHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt+eFdHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08AEC4CEF7;
	Thu, 29 Jan 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704212;
	bh=wfClSVRN+fFsKBDCcyrkVDxDGPhGoUtY+ZaC6xnR97Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pt+eFdHSchHDZpH1LiGoYySJflRM+wCt2l4Z3vLnldiDNvKmLEbA8/gYzwYfzsliC
	 J9rSdvANCl+wcvcd9S5TeuCP2Qa+IBTIpXKJYX6DLYl0yiMjySVknTM1i+71QHSgI6
	 LzuBb/g/Lqz9VpVBCmkWI8+P21bAj0LTiRtcPQj+dm8LgYMhrJ51m6v0nFL29vnQOA
	 3oY9QMKA8CEqGb0ncC9VAM5K2a+IROFGqx3UeQfJ470swZ6ynDlfVnWMxamYQ20Zax
	 o+5vFTu8GTfguXiq3zn1GpwHod/qvfiYUiuZNEPtdQQ95Z89JJbI1Zynar2XgvS+Rl
	 kBfCKD1wYLN5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 119F9380CECB;
	Thu, 29 Jan 2026 16:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] media: Fix G.722 @ 16 kHz codec ID value reported by
 transport
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176970420584.2563498.10397591263771732571.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 16:30:05 +0000
References: <20260129154755.410853-1-arun@arunraghavan.net>
In-Reply-To: <20260129154755.410853-1-arun@arunraghavan.net>
To: Arun Raghavan <arun@arunraghavan.net>
Cc: arkadiusz.bokowy@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Jan 2026 07:47:52 -0800 you wrote:
> The G.722 @ 16 kHz codec ID is 0x01, not 0x02. The 0x02 value comes from
> the ASHA ReadOnlyProperties GATT characteristic which is a bitmask with
> bits corresponding to codec IDs - setting bit 1 gives bitmask value 0x02.
> 
> Reviewed-by: Arun Raghavan <arun@arunraghavan.net>
> ---
>  profiles/audio/media.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - media: Fix G.722 @ 16 kHz codec ID value reported by transport
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebb33150ba76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


