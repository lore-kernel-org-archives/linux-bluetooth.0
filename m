Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AE37D124
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472621; cv=none; b=hRMU0z9d8zDLd4fTfsxxSES0dhQiTvlIcEJ8dRH5o61DxbYNdeaNCygbBRU0tOjM8k9uYLEA7rhd/yw0Jyr/d+cLH0Z0XK7i439XznVFMRtFzLW+8QyOrPB0S1Xg8tziZJQlghGAdhODWqJNvkc+II+jyL5r+12AmBsE/nDGitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472621; c=relaxed/simple;
	bh=EajgAuw6XBoTraeHNJSqoDKjlU/6Fz7VMypLVkkm82U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bf+RR+9rSeIm/KJzbiEmcrsFjIwsSiAuydEaxP4FwP8JP8ubVJsAhtdnyRD4POkh4Lq0zjP+S+NSoyanvxEdZz2BOSJwggaoDl2xH80F780pezQlPWGdX9EJXHxehpG02qn59d04DOifTYyovXQANg05Bh024WpM5OZ2PVfkaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH0Uz42V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH0Uz42V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE301F00A3A;
	Fri, 26 Jun 2026 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472620;
	bh=51DhDaXrjFaBgc0qChfck6hPXsS1zRRRIEftlNN94uM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gH0Uz42VdOFKOpMzmeqRHhNt32p0beatQczA9+syfrrtIhKl/35SScLNs7M82QtJU
	 Tiv8TfF98hmnJegO9Y/cR4oVXCRDZRIbHo3ZHPVjP98Y7qUM174r008qErqJP+XNAn
	 ZTWdyLIsm0lg5OcWSu3SxAC4VPwOGb0u3fXotdIXAw/6EilJmyrHE1sk0IS3yfQbjT
	 HnLg3Hf/uyDZ1qkFWld3IucUQKSYxavsff8ZJgE6rlBXBTOdTQJqz4k9+7L44Enwk1
	 90cz7BSMvkKvWdgEPKNWWvc24L/maEWNVAzBkYJYdTe9avavzNPkE8ViYfOXWEK391
	 vtGTOKlcLTx/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099539389EE;
	Fri, 26 Jun 2026 11:16:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: Fix adv monitor add failure cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178247260729.3816447.3243373434534178478.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 11:16:47 +0000
References: <20260623161328.2177234-1-zzzccc427@gmail.com>
In-Reply-To: <20260623161328.2177234-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Jun 2026 00:13:28 +0800 you wrote:
> hci_add_adv_monitor() publishes a new adv_monitor in
> hdev->adv_monitors_idr before the powered MSFT setup step. The MSFT
> offload add path can then fail either locally before the controller add
> command completes, or in the MSFT add callback. In the current queued
> management add flow, hci_cmd_sync_work() still invokes
> mgmt_add_adv_patterns_monitor_complete() with the original pending command
> after msft_add_monitor_pattern() returns.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Fix adv monitor add failure cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/7083dd331667

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


