Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E32227EBB;
	Thu, 20 Mar 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497209; cv=none; b=f1aDbe0qwztwfWnS/4eYKR0eerPJEZP2ZDJhN+fckBOXMCPsiouXfOFg7AvYXjPaf4DSDHPLle529Fc2YayYh6v94GLFP/O+JQXVarBX80USEHynZMNuJ26KP7mMCSPe2rVxRP8cWtts2Po2mRzd1vO6vTFxkHFrUAQnL0sqUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497209; c=relaxed/simple;
	bh=6fanAW7Ye2sXSBOuAm9kPC3g0KEELfp9nEJRpCc3foA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xu+jbP70eK27Pm/6HiehuKsP81UdYiWLLAnXU7w/MwRPNB6YqNba9Ok/3oqVYiYO8Vzii8I5AcDP+6CSKfFjPeRvlvD2iSt2Xk5WjDcbpDyXl7peWOXLbR7SDxFzCTYza5Ly3Ku0cJSPyyG1yPOpar2AFYWc5MHlXacVjGtMnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq5wk36+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq5wk36+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194D4C4CEDD;
	Thu, 20 Mar 2025 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742497209;
	bh=6fanAW7Ye2sXSBOuAm9kPC3g0KEELfp9nEJRpCc3foA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tq5wk36++F0UVn4WlaOwBP9t5bSKS9tPuAXNLKMTwWeV1/LdCtr5wM/2nA0ItFmMB
	 fWN7gRkymKE8O4tMtvAlscQjSj974pHJknpLxSaCA70JdkrIWKplewWvf32hrwVT1e
	 04r6rCNAc5wth33x+miWdzM8uXlndBxMsZ+pSLtSx+F927NmKv54rr0WvWADt935yx
	 zeTaAScGB3TXq5vH+2uspg9VsyD0KGavNhUV4KWaDHjrQ86Xrdkzj50UUfmhO7jiNi
	 XP8ueedyXyrJmH58W7Kx5zeJFOpyCzKs2BDZilKpqGcCPA1CyzgrwOIgSlopvhYYRu
	 uugDkP+lCoQXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34C183806654;
	Thu, 20 Mar 2025 19:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ
 handler removal
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174249724504.1878155.13264790532381616265.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 19:00:45 +0000
References: <20250312012522.53604-1-sean.wang@kernel.org>
In-Reply-To: <20250312012522.53604-1-sean.wang@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, sean.wang@mediatek.com,
 pedro.tsai@mediatek.com, felix.freimann@mediatek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Mar 2025 18:25:22 -0700 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Ensure interrupts are not re-enabled when the IRQ handler has already been
> removed. This prevents unexpected IRQ handler execution due to stale or
> unhandled interrupts.
> 
> Modify btmtksdio_txrx_work to check if bdev->func->irq_handler exists
> before calling sdio_writel to enable interrupts.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler removal
    https://git.kernel.org/bluetooth/bluetooth-next/c/01c13f057bb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


