Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAF35EF9
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLGG+0am"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62FC8C433C7;
	Fri,  5 Jan 2024 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704485425;
	bh=b9sce3zmI20YPlOL+g4nOhWt8nFfqxozCSECz8iOV5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BLGG+0amQoxcHRWr7CLE8IqdLHi17p9AwTQaD6CgoMNY1dik9oqxaV/7uPzwSaOxH
	 RdpQlYZQnMKDobFtdMC8NcXwopZSKegraISFbelw9gN22lHL+o384pHcW3MGOySJk9
	 Hez3z+5e/e/mTO/o5bMHU1F/WRbgtxE5cLWsBFDi8vnHvJLU/9ukRuSt0fmjAInGwG
	 H/34uEi9X3uEQXRCCfpLT7muaxGE+aFoYLSC7D4gAo7y+80xgX75cKAvYBZO8wPId5
	 MVjI/J+eeX6t1FiudrHgfYg2lTyoTH1QemIL1LRg30FU+3p//3P+f0rE2ny3FvcZnJ
	 U2CttD6O0pllw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E1DAC41606;
	Fri,  5 Jan 2024 20:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: Adjust the SDU size based on the
 number of locations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170448542531.9425.12016424946000942314.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 20:10:25 +0000
References: <20240104175530.4011031-1-luiz.dentz@gmail.com>
In-Reply-To: <20240104175530.4011031-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jan 2024 12:55:30 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If there are multiple locations, aka. multiplexing, being selected then
> that should be accounted properly on the SDU size since the presets only
> account for just 1 channel.
> 
> Fixes: https://github.com/bluez/bluez/issues/662
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] client/player: Adjust the SDU size based on the number of locations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c85546cba715

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


