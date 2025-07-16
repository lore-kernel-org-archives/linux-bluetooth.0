Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE029C344;
	Wed, 16 Jul 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692388; cv=none; b=UNnKbDY0bbu+x1mURFsDg6+YaXqlBRVXmV4oZHjPNLdIsHKfFEW850G1Qk13+QNf/zREd4VXqpIQ+Ftk+SX6jKgTN6vCO7KB105953Mma611dtq4lb2OYwQIro8FlqXO7/bviqcANmta+rzmTGZsFIfQ1i743JN4PinfF2Dc7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692388; c=relaxed/simple;
	bh=GVZLiheKS3VvwUvq6IEg9RgvAOWlR6tbXdTHHhc3raw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mcy40iHwMKWqDQcuNquQX1AzM51Uw7KaPZP46z/Bx2Uxz2tHlOOqWTE1/pVsGrjVs1d/7jBPwkT2698hmwOeVo/monVavY/129RkFNQN3/YfYNTiQ2N6d72ngA0t5zxsr+1MKXCRdX/Jklxi/tXRObvM4OQQ1yrDTX4HEPgQVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwMjNj02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwMjNj02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB41C4CEF1;
	Wed, 16 Jul 2025 18:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752692387;
	bh=GVZLiheKS3VvwUvq6IEg9RgvAOWlR6tbXdTHHhc3raw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lwMjNj02mgT8XpiiyCsUI87MwCY8pLQnBjU4RViQqw9PyRI2QfDy/Wzft5jDHi/LT
	 MqlTaLIV0ZxHgUCNcTywQ2NyHQJvXhOrreFbamqcgygc28fCKPe7bzkWOCMr4WeD9r
	 Z4veTMz1OkYs6362Tw5HI784oAbYvxObhi1e1Ong6br1Mb1W/XyZDzOIuswcdb7J5S
	 Prgtnpr8xxtQzDwJrhRz3rr7iOjWfNIgHU4o6zASVLrdayLGtXHfXA5wspcuYcZDCu
	 qkIZ2g8MeAas6vOFgLH8wF0au13V/TY3lT4r/oizWkOVIOknXA3UKkMcIX2WE9Ugsu
	 rWXVw+7xFlWKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD3383BA33;
	Wed, 16 Jul 2025 19:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: btusb: QCA: Fix bug and support
 downloading
 custom firmwares
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175269240774.1291922.12542235441585164888.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 19:00:07 +0000
References: <20250715-bt_quec-v1-0-c519cf7a0e16@oss.qualcomm.com>
In-Reply-To: <20250715-bt_quec-v1-0-c519cf7a0e16@oss.qualcomm.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, mka@chromium.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zijun.hu@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Jul 2025 20:40:12 +0800 you wrote:
> This patch series is to:
> 1) Fix a bug
> 2) Support downloading custom-made firmwares
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
> Zijun Hu (2):
>       Bluetooth: btusb: QCA: Fix downloading wrong NVM for WCN6855 GF variant without board ID
>       Bluetooth: btusb: QCA: Support downloading custom-made firmwares
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btusb: QCA: Fix downloading wrong NVM for WCN6855 GF variant without board ID
    https://git.kernel.org/bluetooth/bluetooth-next/c/672143df3926
  - [2/2] Bluetooth: btusb: QCA: Support downloading custom-made firmwares
    https://git.kernel.org/bluetooth/bluetooth-next/c/a69ca4badd13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


