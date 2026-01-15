Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A423A9AD
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494820; cv=none; b=ZJs896VJebsMm7sTVEOqXCYAJpcNy0U3NpXYqKHskMcrbSAkddo/yXcQWZFIBnUwjVw0Q9m//4RHitM5+CyicuMrNXPo5hhOq1l/h5UWhUWLeqp1X45UA3fYPkcuJSMZV2M1Iw4rfZFrf5qh5LYu8Z0Bumge+C67Q7Ecmt4hKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494820; c=relaxed/simple;
	bh=YIOqSV6MuNB84znBo868QrAwcNWdyq4cCEgjAh1jk04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cWkZgsRghbLT3snCL1zqT9owr8ElgH5Ra6wIeSl2JdWDU2KFIS7TFO4ifFTwduovMOJQ4NG1SLtOKY3d7vZyRvD17Jt0rFQ8X2qvzSwnCdmr1Lzmpx+CX/2jqWEi5zDm9pqRvSz2FJH2EuK7hDh65iZmgAYofpZ/iDX87/tN3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDaNVu2x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDaNVu2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3EFC116D0;
	Thu, 15 Jan 2026 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768494819;
	bh=YIOqSV6MuNB84znBo868QrAwcNWdyq4cCEgjAh1jk04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pDaNVu2xQmZPdg/7sdFOy2AR138JYA2J1k8NGUvsyT3t4lTWP6DXTC/P6FocSf6cx
	 W5xEacYlhdXzI6gqJ+grBnzPrTHZarr7N9EeLe0uSgJHlm9o3dm1KhlKODWGMfurPj
	 qj9i1iCEZ2bQiLIgP/SJybV4j0YxL05yzI4p8QPkL0UXNDXoF9+vUlxXnhi/TsTGcM
	 ltOxDhSPQL5XI0Ec6WoV3wzz+EfhWMfkJsRO6ZXFAywdrQ7wPZdCHtJvv5e6+4gTw2
	 SfpPV9LcdKs5mPHPuaBI+TxYgjbjZTkJ84Y127ON2t86GLgB+BrNjAOAbFpqBJn278
	 mWY6cy9hq/vMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA4C380A965;
	Thu, 15 Jan 2026 16:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Use pm_ptr instead of #ifdef
 CONFIG_PM
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176849461202.4062473.6413542675414250616.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 16:30:12 +0000
References: <20260113090128.244709-1-hadess@hadess.net>
In-Reply-To: <20260113090128.244709-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Jan 2026 10:01:12 +0100 you wrote:
> This increases build coverage and allows to drop an #ifdef.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> Changes since v1:
> - Fixed build
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
    https://git.kernel.org/bluetooth/bluetooth-next/c/2d7b5a53007d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


