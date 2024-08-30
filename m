Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461F1B5813;
	Fri, 30 Aug 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035429; cv=none; b=NWLt1Z/qo/9Yw3phz1WyG+Vb72zVYopTzj2hxMxVyUwdO7FvlI+ldmUGIU1Dk+t9NIbWPOCasDcGS8OWdcDT/KXg96GGfAM0PLMb36k/++1h62Tus8yY5bZCIQk+Funu9RkI4u1cJWMadTn/mWshXY5HSZB+4S1saEgqVZk7hnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035429; c=relaxed/simple;
	bh=C0OgOM07FRybLvkNQvLp9R8T9gl5CboYjbzmJ70HJA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HcqqZWRaud8qiS5K/HmTG+MkVZM4y4sGYc0k7zCF69pnRPja5nHD5lMBi5hFkZ+UsOasGK5OalsiYfCd9cf0DzqBirpKnI8RS1D0yRxTOGCD71qc+te9Kb6HxfOhHBt8Opd1xp8tvhMhVqXdjDyr6vnGWInyOsB8r6C1jU9Ytrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWh0PDbc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWh0PDbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54751C4CECA;
	Fri, 30 Aug 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725035429;
	bh=C0OgOM07FRybLvkNQvLp9R8T9gl5CboYjbzmJ70HJA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rWh0PDbc42koXVXOo5JufJl1wWaCXb50YU7gJksJ7iWZS4xEqf9XW00qkV+bFIbtF
	 Z/wZzE8Pl2/kMgKqkGYsz+grKCbMuUurm/dv8Q8/RmbvgkyL31jjS0RE0sYrow1vYj
	 H1a2AZK7hzoWZT2OY7SIKeykeZvI0W5XWdyMSAPUzYBSPLZluA6do8tY7iFhjLZfZm
	 MmDgCLPBm7s6D5Y3zHGvRArstnDMoSuN8j97Fy9tfUu1VY1uW0rrLcykc9pMg6o3sO
	 KHe6yVo9BHaT63EppRzvz+aRfm43igil+8BMkPw3J23q/EcOAdHtQCQN/ZfKSH8lJ0
	 xhdO+ELaGmf1A==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8B0D3809A84;
	Fri, 30 Aug 2024 16:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btrtl: Set msft ext address filter quirk for
 RTL8852B
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172503543087.2648350.9477440172287065228.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 16:30:30 +0000
References: <20240829084005.681732-1-hildawu@realtek.com>
In-Reply-To: <20240829084005.681732-1-hildawu@realtek.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Aug 2024 16:40:05 +0800 you wrote:
> For tracking multiple devices concurrently with a condition.
> The patch enables the HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk
> on RTL8852B controller.
> 
> The quirk setting is based on commit 9e14606d8f38 ("Bluetooth: msft:
> Extended monitor tracking by address filter")
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B
    https://git.kernel.org/bluetooth/bluetooth-next/c/e278dcc0a237

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


