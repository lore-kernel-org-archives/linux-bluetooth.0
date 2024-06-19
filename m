Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D87314F9F9
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805630; cv=none; b=VrO8IRTi2yOj0Pmfh/+zm7fHBVrs434ZDNprLLltAse8g5BDsv4vPFRAWc/EZU0bpZJ2kdoamCeTjtUrdUIwufeDVWEHwH/AGtKFbFo+PAVxuwQG67c1inzYNcVfyoj76lDCSj6kdFcSIsqLVPBSVl/6AjQSNSVTnsOVZJyivfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805630; c=relaxed/simple;
	bh=8uMp0jrT+a+7qNll9q3pV5e8cva5iLLfHmrMiksjRXI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EzN0pN2O5233KAUPJ4dNRU238qjJd5MJ2sNxW2XLoV8Uhl+8fahID5TvZ9jXL5HIXcy+nHs5J6ZD7Hc1xCfeYsz6gjHpINk5TFwnHjUCSCd9WV/KP8Q2xfoBbC+Tt6MVNqdTRZVsUh3j4UrlFIiXygpz/vTGrtqWSd+HK/p7vnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhuWuffM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhuWuffM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA9A0C32781;
	Wed, 19 Jun 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805629;
	bh=8uMp0jrT+a+7qNll9q3pV5e8cva5iLLfHmrMiksjRXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZhuWuffMfOaas/qWUeC9iy6QhV5TLxBXOkLsOw5WBGoFh+pY4ioXxIFvoDWJ2sOxt
	 YfR4rUFD2Oxp+l44pnsvrwjl6xtCD2lbYC9RCd83LC8/LMpEZfxdWI0c8X2PnYg2mj
	 utAMzbdlxXjaFCP/pPhsu2blWOOPuZ2DiiNCMlCnWY2msO5JdXDu+0KQ/wTH+8y5i0
	 b6FqlIa/RScKGQd5hz89XO7FXjseDvmlOJK2bbuzlDD6ivSnpYqTCG859jNzDw46Z8
	 GjUV2/uNPn64FQKvtsF25H9J0f3nx09AkYnP+VWku+sAP2ffmiyim066yZGSDfp0Ix
	 IDjIUufa2YMwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A459CC41621;
	Wed, 19 Jun 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core, hci_sync: cleanup struct discovery_state
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171880562966.14358.16271507513852120875.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 14:00:29 +0000
References: <20240618185932.49963-1-dmantipov@yandex.ru>
In-Reply-To: <20240618185932.49963-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Jun 2024 21:59:32 +0300 you wrote:
> After commit 78db544b5d27 ("Bluetooth: hci_core: Remove le_restart_scan
> work"), 'scan_start' and 'scan_duration' of 'struct discovery_state'
> are still initialized but actually unused. So remove the aforementioned
> fields and adjust 'hci_discovery_filter_clear()' and 'le_scan_disable()'
> accordingly. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core, hci_sync: cleanup struct discovery_state
    https://git.kernel.org/bluetooth/bluetooth-next/c/775f749267eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


