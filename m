Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311A7442E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190227; cv=none; b=JgL8cbaa78bhboE+DXZp+f/OajHk8WFY/V2ejOBnbAd7MbhwQPAM7T35d6u4CqGFCx9rw9eixoOYVIox0rswaCSzspmyzO2LyIRAxrYp3w0JQazPmCap3bABdlEP/4o1koRd9xQFPOOhVZo8QVCssLY7laeBZnAwt3xvcevpaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190227; c=relaxed/simple;
	bh=0z3ZZtL9mEslJ8cYj8RyHOsViMLx6qxFkmHSENqNLpE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V1+velsTJF89xn9dxl/lxobBLDM4CJX4+pS9X9grbi8UxRKbw1HGgugXRLUNGskT4EFH/SRQ586xIQ8JwgLwEN+U3c8EzzOM3RDHznVV2RQZbizDnl8nWYsUEJTAlRwwPEOCjPI+C0RZWWQFGTG6zJ4Vt3X6nGCwIJaEJRgYivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEeKeqYX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEeKeqYX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0883EC2BD11;
	Mon, 15 Apr 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713190227;
	bh=0z3ZZtL9mEslJ8cYj8RyHOsViMLx6qxFkmHSENqNLpE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fEeKeqYX7XRtl5Nx+KrOJTBeX3Ycg+trFkglqLw263BGy9mwUTsABLqMgkYI5Lwyc
	 5o5w0SnjXOwivFcOH4T5JyJILwpIx7AyXapMdF9V5oLlPBRQpL6ir1KkhcUXmmmZ/X
	 +9wUzT2744kVjLa9PcHgIZb6IdH+CsZD+m9q9WxhjoAO+bhuBZrIVz0SURnw1IFaF5
	 Whz36gf9Y4QQQ/5ApJSr8+gFlAna0FoLcRu3n/M7kkY5VGEtEb+fNX8gS+vjLvSKNL
	 A/RCF6mkGsIJrmTUp6MFhMh+kL/3DyuiRm9bZSC/E2SUcz+IngwTsGH58Yq1NLxNuD
	 wvGVO77oq2mrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5A6BC54BB0;
	Mon, 15 Apr 2024 14:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] build: list new tools/tester.h header in sources
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171319022693.21717.17547820893982144893.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 14:10:26 +0000
References: <20240415094440.5820-1-jpalus@fastmail.com>
In-Reply-To: <20240415094440.5820-1-jpalus@fastmail.com>
To: Jan Palus <jpalus@fastmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Apr 2024 11:44:40 +0200 you wrote:
> fix dist tarballs missing the header
> ---
>  Makefile.tools | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ] build: list new tools/tester.h header in sources
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1955b833c7a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


