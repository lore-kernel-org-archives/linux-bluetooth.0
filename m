Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640C284B5F;
	Tue, 22 Apr 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328597; cv=none; b=oJfsO68k16/6ebvfbGMCoxpBR1Ec766/9EUyHd+V0qyr+cEGKDvEAPoo4U7+OOeEkMc0uEWhRzYd3dZGsfIQSMyWbGp/GMIZT5BGMJpKudRShHZFOI85yIUCh5c121Qs9NuEiv6gN1iNGnePGu9Jq2bxGL7e7F0fzfvNrHPnR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328597; c=relaxed/simple;
	bh=CL2ckKdWyQEF03LN3BXjBPax5VKKfrOO3/dC6q0A6Wc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nDZKVAbaPZsN8E+zT8EwVMefxq7j4sy3nFnVnw/oj+K92sscVFj6miU2Oq64Z6UCUTRtocfmBeGcn5vvPMfog2fZ2VIu27oyfu1VkB8q41lGwVuAtaJ1F/B5zMFJYtwVWm9/UN5MvcBgI4AWCqE2AiXlFfl9XUl84CRGjImLNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgVoomws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgVoomws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12137C4CEE9;
	Tue, 22 Apr 2025 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328597;
	bh=CL2ckKdWyQEF03LN3BXjBPax5VKKfrOO3/dC6q0A6Wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qgVoomws5FoccIq04RK627QjiVSuWooOhRpAh4HGP9GEm7ab8JFMOtKPZ11j55qdV
	 zO7iYO69Hg1OLxv8oTf7+dxdDEZu7XVgspN1qSwi91elD9garjcQ0xfa9v0kBbSXEj
	 ceJxhYaO7L7CKXug1zS2xTads/zg6RtA/yZqrXfx4qYEhstwt/5imF6h1kRu9CzPsS
	 d0sLlmFPifC7Z+0u/w4x4za1zM5TMIRSpnEjJ4o0MYjnyvznvX/ew0ddnrkGzrQURJ
	 rAgwvcPN9OnC1nR0Y4Ts8QvMkdtBzlWZoqkvKD4E7K+Zbjm4kLk+8vu/gslanveD0f
	 0/qg8JeDG08GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB0380CEF4;
	Tue, 22 Apr 2025 13:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: btmtksdio: ensure btmtksdio_close is
 executed before btmtksdio_remove
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174532863556.1909182.13691276348024740432.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 13:30:35 +0000
References: <20250422012156.586600-1-chris.lu@mediatek.com>
In-Reply-To: <20250422012156.586600-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, jiande.lu@mediatek.com, will-cy.lee@mediatek.com,
 ss.wu@mediatek.com, steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Apr 2025 09:21:54 +0800 you wrote:
> If Bluetooth SDIO card is unexpectedly removed due to hardware removal
> or SDIO issue, it is possible for remove to be called before close.
> If an interrupt occurs during this process, it may cause kernel panic.
> Therefore, it is necessary to ensure that close is executed before
> remove to stop interrupts and cancel txrx workqueue.
> 
> Chris Lu (2):
>   Bluetooth: btmtksdio: Check function enabled before doing close
>   Bluetooth: btmtksdio: Do close if SDIO card removed without close
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btmtksdio: Check function enabled before doing close
    https://git.kernel.org/bluetooth/bluetooth-next/c/04c96a7ace25
  - [v2,2/2] Bluetooth: btmtksdio: Do close if SDIO card removed without close
    https://git.kernel.org/bluetooth/bluetooth-next/c/e0af21b30c82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


