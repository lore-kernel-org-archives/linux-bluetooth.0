Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428409;
	b=EkgxRlaD388bERCCg6PRBvKmbcmjyMMY4YVLdF+e/T1TIwYCtsD30PfHcct9QjEvbkn+
	 ACCwIl0uRVQAxymbX5g3gpcD53Fu4Jv0C9SyKm/fi9BE9yrLWE9shere5tC2WeHfHcEzO
	 Frl5SbQS9et/lkmgRCw3TdLuqBFn9OjPk4qB/I6G5YHHDdEMnF30JnzqZtQb/Peje1Hnv
	 R8aiIgGiXh1140earicNhoyzVvjHLlgF9Yzu0bdwn3+J21i1aDiBEnVxApsuN3f7blCjz
	 3IxokQcO6J3gjvKGuv1RugsOzeM+HcGTA7Lz5GRWR+0Og3ciou/aY/dDgLX6zo9vKhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=IO2DdP/qkuqzaLwklEKRvUD8vG7D6jQ8uitlFNc+8IQ=;
	b=qzhfD1exH/c+hn1395+ceWhpxYXhjpDdJwm36IYmqH7Ydx+J+sZt/TljGKV+2e2gqsfh
	 zQmFlRDk2ZHUowEH6hH/T4tx1VxFkDU/OLYBnfcxAoCg4QVR9yZZbf4kiwBqpaeOy9mOf
	 QfGHscbxWjDBnuUeWtMj953wgrI1iEruIIYSmbbWRK910ie46EFxYJSVEVeiwYRBnGNR8
	 u4Tpzf3wvcxBv/whYuLvFNJKvkRyA7hTSgf9D0gbXgksCwAwQoXoG7xv4/pHdtd4UvjkT
	 +Cy3WpqAlKwK3GMDTiIGZd6Iqtb/LQcWyzIW7p26s8a96f4rJQuBdU7JCms0eTQvflw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGuUSBRH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D95606A882
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGuUSBRH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DF41F00A05;
	Wed, 11 Nov 2026 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428408;
	bh=IO2DdP/qkuqzaLwklEKRvUD8vG7D6jQ8uitlFNc+8IQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gGuUSBRHmkXpIJ9NwXu66qXK77iTjwSx9eJ7chweY4BSR4sTu8R5kFC4qC/Ft9YTC
	 +yDoAz/+0vM093riBEKB6wkJbm3k5Si6v82yEGL06HRWrMQ2xshm2AQp3hENJxjrHh
	 x9oSCHJEDIyGQ7xe9O2b1EZZ13CCQits7LGPswuQXQ1xA+24zk2A1Mb9HdPXTkrvwC
	 sYdoxAZaVTcyQf1gKsk50qxe8m27AZ7bzfEjgvGhbU0At7kyx2hS3kI5LyFj3pzN0J
	 YMtyVdudIhE+K97DNp8SjIF2kJWFaiLVt3uQAHevoiJN335XjMnm3Wa2kmyYR2GOfh
	 w0NKdHjThlEUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8259391AF9B;
	Wed, 11 Nov 2026 20:20:08 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Fix SCP DBGC base address
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179442840742.1623293.17516886836216832680.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 20:20:07 +0000
References: <20261111141822.2888893-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20261111141822.2888893-1-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 kiran.k@intel.com, aluvala.sai.teja@intel.com, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 19:48:22 +0530 you wrote:
> BTINTEL_PCIE_DBGC_BASE_ADDR_SCP was entered as 0xf0d5d500 by mistake
> when the define was added. The base of the SCP debug controller is
> 0xf0d5d400, as documented in the Intel SCP SAS document, so the value
> is one register row too high. The status and wrap-around registers
> derived from it at offsets 0x1C and 0x2C therefore point at the wrong
> addresses, and the debug buffer status and wrap-around state read while
> dumping SCP debug traces are incorrect.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Fix SCP DBGC base address
    https://git.kernel.org/bluetooth/bluetooth-next/c/1752a2c40059

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


