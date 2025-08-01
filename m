Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A828C844;
	Fri,  1 Aug 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064592; cv=none; b=X+scA1oeeIcmD2A2CZ7EiZWrlK7oSmkasw4IU5sen+FWSww5RY9jBjurWG8pauuf79EvGiXSH1IiIdidBKeQqhZvB8cJ9ArXOthqq92sp6LpKe0agRBl3lGvUqH2oWrA2sRIVW7fwZQKmjrsgarLHmQq3LQXTOCbU2bvPK1rhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064592; c=relaxed/simple;
	bh=557zFmaKmS5bXOb+hv1LzxNQ0EgTYImX1LKbBCq3dEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bCBgpi2cGilgt6YiZIrUrfX9Fm4MvronzJi0keWGPf5mnVN8aJpD8QnrozXE/BfNmCu2IRE7h5TtEMPLoQxzOwQO2KeYcmeg1Jex7zPK92mO6ZTUcUPLrMq7nRP+PLT9U+iozkMvJzpWi5AaPys0WMT5f6xsAFlVtZ7IUWSFfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WViL9ibG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WViL9ibG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1997EC4CEE7;
	Fri,  1 Aug 2025 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754064592;
	bh=557zFmaKmS5bXOb+hv1LzxNQ0EgTYImX1LKbBCq3dEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WViL9ibGPexJ1p5LhUn9e0uJTI+eX6Svug5ZIc86AB+Bjjjdgh67xU0jDbNgD+aOR
	 DDzf0wehy9DFzcHHPLoAo1SvVnJfppdzcGLDGCCeevoR8sunPcQNvOJnenCiVcStx0
	 nenD956h0xsoA3qcN98eEdENC9qheLfveCLQtajO5+bP62YJ86V7r5gHcDy8y2fGDG
	 lJAbXUcbIifmkePQCQ5HwoOcuy9yiQyk0YK9fWCdlxHTC1QCuG6XjWcMzFcFwxvjwq
	 D0ca8C31sTGXEDiGZsPPW/RjInDqXsMAEvleS3ZQ7sFE4fImd8cIRU5qAGBPjrqG6F
	 ay6MowWFP8bXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD03383BF63;
	Fri,  1 Aug 2025 16:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: Fix wait_on_bit_timeout interruption
 during
 shutdown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175406460749.3987296.5929961346941776054.git-patchwork-notify@kernel.org>
Date: Fri, 01 Aug 2025 16:10:07 +0000
References: <20250724085117.2678313-1-jiande.lu@mediatek.com>
In-Reply-To: <20250724085117.2678313-1-jiande.lu@mediatek.com>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, will-cy.lee@mediatek.com,
 ss.wu@mediatek.com, steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Jul 2025 16:51:17 +0800 you wrote:
> During the shutdown process, an interrupt occurs that
> prematurely terminates the wait for the expected event.
> This change replaces TASK_INTERRUPTIBLE with
> TASK_UNINTERRUPTIBLE in the wait_on_bit_timeout call to ensure
> the shutdown process completes as intended without being
> interrupted by signals.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: Fix wait_on_bit_timeout interruption during shutdown
    https://git.kernel.org/bluetooth/bluetooth-next/c/5ecd1fbdacce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


