Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4654A99D7
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541031; cv=none; b=nlWQ9aIW/6XrlMowucMG87uw45hsXJG34hJPjRaAvxFjVRKGS7UXXwUDW24TXKfLYPp6p980jaehTLQ1f4lQtQlmLsD8sxAWqzbVJ0NumgnJq/Cul2nlIcREekRfOL7MNcSJmtxS3WzKjRkqQm6DOO3Pq0XOv7bBjvSUtOom964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541031; c=relaxed/simple;
	bh=8szByh6gaOq/ag1jRmH2MJ4NCRYdiu9F0msNUxbycy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oswtSxkooWVjhaYlZnL90vljxhoPhrSLPzxOjt7iwGiwhbUxKfEotJcNCGMr5kfKtI96HWsDLDLaYeLtxkqRWL5RZhybgi0Et9fuGg/HBHu1Df9G0DP1h1A+ol4rlO3UdqKyAlm5lTw0H5vuwxL3LBNi+uhMkFjf7MKOU9phYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGnSScep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGnSScep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E8F1F00AC4;
	Fri,  4 Sep 2026 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541029;
	bh=KxTwbkiCHEKL3tKtql9cSDsALWNAf9gP85EPYZ+vVX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CGnSScepSLG8+gUG6zYyyllr8ldVWWNaYh117j1wk4MI0KHnnxA+ykxcoduPKN52w
	 ZNAVk1Fyv06xO41IsdT0N1r3Gsy1AY9ybB356/qSiWEiF8U7JIOn4TvDv9ZHkGe+VU
	 ifJwCO8iGK90EzMDUI+gS3j+1ffPYEm5xA4fa9Q6X6I6BEJaXwhiZ+oDRa7MF1q7uJ
	 6kSGEDOB66zOMgb+ic1oqvlRHcaEniXzK9yShm4WmeJ//vv/tMRAvr8InN0uyNQD1Z
	 XKwVLxAhxb2osRHurDvrscyLL86RMxw6Ofs+E659XviRcSOnB9/J40E5FedGrXBcX4
	 ZutEjvws0Owdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397E3924A50;
	Fri,  4 Sep 2026 16:56:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/4] Bluetooth: btintel_pcie: remove duplicate
 BTINTEL_PCIE_MAGIC_NUM definition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854097014.344939.13290030369198120031.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:10 +0000
References: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Aug 2026 19:57:22 +0530 you wrote:
> Two identical definitions of BTINTEL_PCIE_MAGIC_NUM were present in
> btintel_pcie.c, one indented with spaces and one with a tab. Remove the
> space-indented duplicate and the surrounding blank lines. Kernel coding
> style requires tabs for indentation, so keep the tab-indented copy.
> 
> No functional change.
> 
> [...]

Here is the summary with links:
  - [v1,1/4] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
    https://git.kernel.org/bluetooth/bluetooth-next/c/1cdf710cc2a1
  - [v1,2/4] Bluetooth: btintel_pcie: add MDBGC multi-buffer DBGC allocation
    (no matching commit)
  - [v1,3/4] Bluetooth: btintel_pcie: log mailbox handler latency in msix_gp1_handler
    (no matching commit)
  - [v1,4/4] Bluetooth: btintel_pcie: unified decoder coredump format
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


