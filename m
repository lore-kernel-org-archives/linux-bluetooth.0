Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D01A3152
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320806; cv=none; b=S7EsXMdC85f01i0L9lgHTJ4dASljbYAIG62Iofepg1lCFtDZ1ls9vsocG/pLpS2VUPiOnN6YJ/jX7QxH+16CushIVTrkaUGWHA7Qv1WFJ3Sqwz1MBtxDvc/qTHTWUqoPjQchhaSu5wwjzUtupKRk5HyEJsqvGFeuH5C5/J2W5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320806; c=relaxed/simple;
	bh=hba/W9beJMogdWKQ2VnVFoD1I47mxbMo2So2TcGJyLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tnn+B0tK19PPhMhhweA1u8Vs4RnJ2e+x+Lfvv2+WnOCXOr9X0IvWUz7dccoA36vpDnAQQ/rrvOzj+qkHwyCX3SFQKnLFIaiNHDNslLD2hTbui97bN5Ci7ikX/6iBoYRvSOrJdOxgGJYvUN8BcWCJk+udw6gy4QnYDBfLk13FM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7/cX9Sp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7/cX9Sp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FFFC4CEEE;
	Tue, 18 Mar 2025 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320805;
	bh=hba/W9beJMogdWKQ2VnVFoD1I47mxbMo2So2TcGJyLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P7/cX9SpecmAymT10jFTnVSR/QRvKeid4eqtKwdveaj6hCnEywcWVJiprrx4T0qgg
	 TgukaEDig42n60mkHiLVyBNlBIhqyWSdeN/PlIs/1zqO7j8ZThzFGFkui3sAERveAg
	 5pJGCWHF7E7sXYRoLaRJka5CiHyPigDckX8u3ZRqKFCZlgBFMz7oVsT22UeQsnC6fb
	 4PiHWESKTevDnYYfahuwIudHeGiBvHzTD35ShfDxvZ6wXm8ItH7A4zx8bwTyq98VFQ
	 TtIfYOUueJpq2qnKmf/f/xwtyOYq9w+z2cKtb4eKPkCFhj5iY5gvPpoEeWQrgXHAq0
	 SOpHtrJ/KglHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC56380DBE8;
	Tue, 18 Mar 2025 18:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: Fix changing preset SDU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174232084023.406856.6269070151502822678.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 18:00:40 +0000
References: <20250307163435.49599-1-luiz.dentz@gmail.com>
In-Reply-To: <20250307163435.49599-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Mar 2025 11:34:35 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes changing preset SDU when configuring multiple channels, the
> SDU of the configuration is the one the needs to be adjusted not the
> preset itself.
> ---
>  client/player.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] client/player: Fix changing preset SDU
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48c33d291d92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


