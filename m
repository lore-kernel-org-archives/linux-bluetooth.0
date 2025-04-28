Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B341E51F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876394; cv=none; b=cfzPOsbKozY6KX6GX9DqvZkVbd79jMD0tSNOkXg1dI+Woh+THGMBfETDjSpiYOQPtDaGTgEoz4ikoLfTxBGTZgdPX62sbjhStoXghlLNkF8aNKkK3vWO5ixw0FWUZu5jYXs9reUkyabHFuL6YgYYwMTpk76ySUsV5jPUa9yY6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876394; c=relaxed/simple;
	bh=TloNaaJnBw2fggo06IbYY76kW7MvDWABMTjTxb0Ea8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OgbM/boL3qWDt4ovzknVDsAdeOEyVlQ4eG3fWaKfxK9yJCLsfadBxv4kXgp/zp2Y3mligFH/wJuauuzg1TwDqkdJLMp9nRDuY0PWxQjTup2PNqDJ1kHsL0lqvBlqrFL4QfEUb9PWtG2fa2q6pytS01+3/cSmSyNR9jNVJenWqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVxzrc8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVxzrc8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA66EC4CEED;
	Mon, 28 Apr 2025 21:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745876393;
	bh=TloNaaJnBw2fggo06IbYY76kW7MvDWABMTjTxb0Ea8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gVxzrc8/LIIEsB3eCPOIY3gviZk8HAIpxEDqSRP/rHrdl60Y7buXck+mAED4G9brZ
	 YBL4LuX7cdc0rVv+3e8dpsvZCZwtDsEFmKVYp8Ib1gX8SGzgp7UcLRQuRP4X6tdOXO
	 mixAudwFdPXYEH2YY9RVbWpsRo26pj44SYIYszH05MABqAIdYANuqJ5QN7bRhEouRP
	 dYiqJFABhyHSqvU69jc/13k5/5eEMZXVzVJeDv62IjBxIyaSaoUTUGc3mFODXL6t2T
	 AER4+c3+sUewYC1POfuibhkIR1FOnuymq594mwDsA1O1L7nYM9hjbXZLFZj7FqsrOx
	 1K2GTzrqHALBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE73822D43;
	Mon, 28 Apr 2025 21:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] main: Fix scanning alert no. 21
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174587643273.1053120.280753460139247782.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 21:40:32 +0000
References: <20250428153950.1942867-1-luiz.dentz@gmail.com>
In-Reply-To: <20250428153950.1942867-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Apr 2025 11:39:50 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Comparison of narrow type with wide type in loop condition
> Comparison between of type uint16_t and of wider type size_t.
> 
> In a loop condition, comparison of a value of a narrow type with a value
> of a wide type may result in unexpected behavior if the wider value is
> sufficiently large (or small). This is because the narrower value may
> overflow. This can lead to an infinite loop.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] main: Fix scanning alert no. 21
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=295ec99499c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


