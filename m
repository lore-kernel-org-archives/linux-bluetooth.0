Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9D4501B
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859830; cv=none; b=mxLTppFrER3O7k/DZtbE6jHCsMHSVwgzwItX684A+b2xa/sIkO7nQyHXfrklkz0bLFcv7iUzZvq7B/6PWAQjNdUNM4FImWUwIgOsimm0FPgTk5FO+UaFNQnC83KwrEFmWlpy4bAHCoHIp+dpnAm/kcGRNOM/MYQEGrZtXtd3DgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859830; c=relaxed/simple;
	bh=4nZXIbP/Xp9zqm76i4PvDtN+49tHCGOqgndya7j8rQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=to0HiSwjhk2Irhj22/vMbLAtKsX77V1r5Tdl03/XJO/XECwJOpChDs1fcZpLJXm5VKDQvV2E9XtqS6bvibPdD97bUXNWNosndbmkIBr9vAbIpRr+6Zq0MfBUKwLS5ULopXOQGkeeWY50Jf/ceu++Gf8SxZRu7ARPda+A2V7b1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqq233rx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqq233rx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5607C433F1;
	Tue, 13 Feb 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707859829;
	bh=4nZXIbP/Xp9zqm76i4PvDtN+49tHCGOqgndya7j8rQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sqq233rx5jImykqe6JXPjCBFm0gc2YOKbeCujXok4NpvZc6/U047h/9Fw8Oy0+2lh
	 ze8Kog8k01LFWeuxgVFpOJcz1igOouPeLiTvZo01wuSCpoiQLHMBuY4KRuY876qxIW
	 WBKGqybZXIRSEt7YFhsT9fXpdOyYAoLqfyIup+9VG7q17IhNW0C/M+wpfT2dh9gEsW
	 M3Td1zkGU61siweAFqjT8wmZKG5KO7vR8VRBqiZF3v1MO4VkSd1De421WWguSipWvb
	 TXmssyrbehtXHmdGSqAOcuRNLqFCZPEI5w2CPX/GoseNbKfAJbs0WXbk5FW/lMzoDl
	 f7ZN0wn8mrJNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3B63D84BCD;
	Tue, 13 Feb 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6] monitor/att: Enable the notification logging support
 for the CCP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170785982979.10780.15160156427132415024.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 21:30:29 +0000
References: <20240213045304.1558991-1-shahid.bashir.vichhi@intel.com>
In-Reply-To: <20240213045304.1558991-1-shahid.bashir.vichhi@intel.com>
To: Shahid Vichhi <shahid.bashir.vichhi@intel.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Feb 2024 06:53:04 +0200 you wrote:
> ---
>  monitor/att.c | 669 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 669 insertions(+)

Here is the summary with links:
  - [BlueZ,v6] monitor/att: Enable the notification logging support for the CCP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b097bf6d302e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


