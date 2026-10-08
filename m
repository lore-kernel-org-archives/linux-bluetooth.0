Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5EF4BB81D
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471618; cv=none; b=qWQxhkBkleabSgO963Fx7aYLmJue5balVotpJpwUZVgV4FDjwwgArDkuJ7ptD1zQZ5/zWhyRQcLy43M8T0VUVfoUHKcsuaBSbBtOMUBT5KqANPcnIknYDe5EcS5QxLMlV2llz1AsegCnG0hk6996TikARqkmYyKH6Drho9z+k9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471618; c=relaxed/simple;
	bh=1RGq8mrrtKGS9i+zuHsHLEKy/wOJSPslkj/TuPicz0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VPG9LxtagRkiSEnh+zE8aV0s8hw8q7QM0rzscge8T0sJxhzrlPFu40y+/NRukPi4m04EwsOSR/uxvzHKQkXsPafxVsH4VxyI5jphOOMAepL9Xu5+j4SkxQC0GapX8Ox6fjUgcG9YgTohscMAH0mIpZ89srvwKFuqhoFc6orITYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSfJfmRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSfJfmRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4D71F00898;
	Thu,  8 Oct 2026 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791471609;
	bh=KQT05lBtfRWWpNS8lEYRfiDGFh6HzLrzfj9CBE6l+SA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VSfJfmRDMgXaQ2gSImaHI+91+Opk81d5fMgpSDnl+Dq1+AnSVJzZDrHpBGDKP2xDz
	 V698amZqr0FZ+Z59YFaN7m+BlLAP5TgOtYSD/JQKPlWPW9nBPXEuN+NdrdA88aiYWw
	 VQ/vdmGGkNbpCDJ4h7JXQK+Fvx1OI8edPgg7A34AVx7GFLp/TFbp+BV60Vty7bugOY
	 wIbLDChxRgCPEd9c6KwDE8VDFTizqByYCvDaw6Rl1pmlABJ4LJkTLGfIpKBCdp/Hxd
	 wjE/e06uS0emx01WvK02uCiYWcgAXSPRtSOuCzajHq+Ub+EcNkO9XYJstQI7UntZ/0
	 YYV5bx0JpCZ8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D2096380AA75;
	Thu,  8 Oct 2026 15:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] sdp: Prevent integer underflow in string attribute
 length
 calculation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179147160852.307075.7678126183237517482.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 15:00:08 +0000
References: <20261008042720.3134391-1-benquike@gmail.com>
In-Reply-To: <20261008042720.3134391-1-benquike@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: marcel@holtmann.org, johan@kernel.org, luiz.von.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 04:27:20 +0000 you wrote:
> In lib/bluetooth/sdp.c, attribute string length calculations subtract
> sizeof(uint8_t) from d->unitSize (e.g. d->unitSize - sizeof(uint8_t)).
> When d->unitSize is 0 or less than sizeof(uint8_t), this subtraction
> underflows in 32-bit integer arithmetic to a negative/huge length value,
> passing invalid sizes to memory allocation and length extraction
> functions.
> 
> [...]

Here is the summary with links:
  - [v2] sdp: Prevent integer underflow in string attribute length calculation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1baa0a2aef3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


