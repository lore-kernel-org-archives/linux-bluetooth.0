Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050815;
	b=NE1nKbXPEpzHjtA44gI/WkXyhNsLR8LR+a8G6p3tDGsa0ql88VsrN6zoIVqjFodJzgzA
	 k4mopvCKlgAgt7N1+ONzI2bRPr594ZqvY7US5oQ+WNyLZ3De66bxpho1NaOmQ0236y3DP
	 pYRKii4zONPjFOQ14LGT7DR86r+b4iNVAgg0s38gB49HK3/Zjwdg73X1epD9jIlpdBpRS
	 fkGmTwkTDP5NybesyIKjDQOThOH2tBG8h7n+HWDH7YiDpi0tdASGs5PYKdqyHrsTPibTC
	 9vroYpIgcIu7yuedztOQp6UOhyO+ugaR/iDA30wXvEm4B8swVaaWTiC5Dpzi3V/10YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050815;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=atkEgt9SOg6Dz4m57vGAe9WWymJIHXY0SDWH2u0Igsg=;
	b=PEQDsQnobEGpFgoyD4JDgvGNehCaUSY6/ZA32i7B9a6RzGgnZ/nPIIO6E1+EV51xqMbd
	 iSuTudCj3IV2sbSXUNM+z/qjnRqvMca6LFinRvO4Zrih/nY6FlYEaNagGjUWpw6mb5Rgh
	 VPSQLQdz5eX3lPHFC4uvaPvRCe0v6Z3rQL0A6DG2UDzPRGzARuXg8QxFlaFATbCIXniwi
	 MDlZH0nxH994mlZQV6Z2YY5Dv1FS/D4+rAScPayN6lT3Ud32iJ4+d9SwcYkb2QludAkQc
	 SI73PeUQtS6RN7wfBoFwNTR00ZnuLiwB9GoonM+aLhLIMQ3Cvkt/nTuSZNLzIEOt+gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxndEocF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC287606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxndEocF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DA61F01828;
	Mon, 26 Oct 2026 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050814;
	bh=atkEgt9SOg6Dz4m57vGAe9WWymJIHXY0SDWH2u0Igsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BxndEocFi265QRMfzK9jYL3Cb5DqJ7OE/MfxCsV0Kq68aeLKLoHZN1MRzjVpak0rg
	 A2EwzcUL2PAdwkde2yp56ojYOqN4Zyb7miajTI2uAC7+pg3AbkIvB6XUrlWgF4+axw
	 86T+O7Lr4NcrzKdGno67mbwoG68z0V/fbyXG4J6T+bRQYt3+k69CNAxDh+q6Kim6F6
	 Y7Y2j1pFUMMjzH97MVVyWg/HwZyHUttmuW1faX56PH/e/eSNxhWrY2zFyP8g8jdvCp
	 LmWS5ZGabHhC+Je/Q10yhZw1+V5JZm6NzngHm9by5M1caKHPgkkRcpfeNnT3Tkp7F2
	 qdkORUyR+NIuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 814393AA80E9;
	Mon, 26 Oct 2026 21:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc: Improve obex MessageAccess Filter Types doc
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179305081306.3403508.13118296201106438377.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 21:40:13 +0000
References: <20261025071533.2567150-1-sadiq@sadiqpk.org>
In-Reply-To: <20261025071533.2567150-1-sadiq@sadiqpk.org>
To: Mohammed Sadiq <sadiq@sadiqpk.org>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 25 Oct 2026 12:45:32 +0530 you wrote:
> ---
>  doc/org.bluez.obex.MessageAccess.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] doc: Improve obex MessageAccess Filter Types doc
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b1f3f9e1fea2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


