Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EA259C80
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807798; cv=none; b=n5+QUL9MW/GdfUqyLRyGntBAxMBbTC1ejwyvUwiIfgWmGlDfn8kX9tn0PqLUdD/bHiIWKfXGVEjfYrJsIwGjHXI4D6ghd07eInMFFWKa/iXOBxdWbwijdWX+/p6DZi8T1AHAHaoQthWM87uqHmgwsxlE3AgyZlwA6djbqVYMjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807798; c=relaxed/simple;
	bh=2Jv+DoEXQ+Z9Z+YQyHmwBRrzCVjheCRIXfMy1Ws2rKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nrGDPFHFwE9DACfd05xyUT7NP5aIZDQkDsv+pyiA4J2uzHrf349sXxIftOmlBPJcfPZ4uUVpYxL0BRoaGEE8n7QHUbcFocgRKygiVeNlR7dmU7Cen+bp8tZEgOehU13IWa9vmeP8dM5CM0KOxkqQvNLzTYpVomS7WRx3pOuOhQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyC966Lh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyC966Lh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E20C4CEEA;
	Wed, 12 Mar 2025 19:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741807798;
	bh=2Jv+DoEXQ+Z9Z+YQyHmwBRrzCVjheCRIXfMy1Ws2rKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HyC966LhY/TnfPKNPejHq12U01CjTy70q2kTeiOlcO6s9eE/Z2Tm2oBvc3/jll3xG
	 rvOOlv5PM4g/NuXCcAyrKveBhzs9SgnPw9TkzBjCWfmn4cnomcPCQBT5ASkIaaz+cy
	 vAEFlinRUF8c62WiaMC+c0Ox+gLUj1z7NmA9rF3fnzUNmTqOcHNQcE9BWo4SC3OvFd
	 bTOkHKwkaok7p9wwjaLzg2nRH5OMckxBa7BI9mq3rXuRR9ZViS7rHPC30SIfaUNQE1
	 4BxqswX7bVtkw9NeahjajLg1I2rcfe5nmsn1s2vL5a6w+U7STNukIF9yDraKtW/4Ul
	 7rvYgt12WZvAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E96380DBDF;
	Wed, 12 Mar 2025 19:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: Fix connection regression between LE
 and non-LE adapters
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174180783274.904159.4250775441150575188.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 19:30:32 +0000
References: <20250312190943.152482-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250312190943.152482-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Mar 2025 20:09:43 +0100 you wrote:
> Due to a typo during defining HCI errors it is not possible to connect
> LE-capable device with BR/EDR only adapter. The connection is terminated
> by the LE adapter because the invalid LL params error code is treated
> as unsupported remote feature.
> 
> Fixes: 79c0868ad65a ("Bluetooth: hci_event: Use HCI error defines instead of magic values")
> Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Fix connection regression between LE and non-LE adapters
    https://git.kernel.org/bluetooth/bluetooth-next/c/8d35126f69f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


