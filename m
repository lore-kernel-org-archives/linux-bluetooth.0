Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10A2DAFB5
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309199; cv=none; b=sFcsdliL2FBeUvQjJWhTQ+7j/GqwK5dJfIZip5U/+MREiRBEPQMS/LSPGZHXrlsjMewfQODtCP3EFXBIat2sYv2O3G0W8WuIfHvKjrIH8Jv2LdcDeXljbImXMIpSeRHGJ7Unw7EuXrKKnyUp9cv3e8YRyXrpUeGclwNw/Du2ZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309199; c=relaxed/simple;
	bh=s6NeMvx7VFU1OQiBJuYml7FQXwmcMSpt5CBZImLjXOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sr/tPvMYeFTqiAxoSTDz53QZzEI3DLSbmFQpMLtLA1OhqFiYB+kw6L08vXEBOjXWxR3Bb49tsTCjNrUfc8IYnC13rJSDtmwjo0el4t+H1NzalpZM0Hv5U04MaoolmUVmyXhaF+LiRPrUIzJHgpT9SkmPhGB0pAcOfzlhr+etXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uivW2t4p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uivW2t4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB89C4CEF6;
	Wed, 27 Aug 2025 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756309199;
	bh=s6NeMvx7VFU1OQiBJuYml7FQXwmcMSpt5CBZImLjXOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uivW2t4p6zLVFBEDqn8esjgMBmgxSufOUsWLSH/YxE+FlxyiXI9uwPnibecLBquh0
	 jyiYq6YPNXDiLVMrY25NgZwdvCfAKbgkaNZOPDF2OAq3jhzjiTzV1Z6cNPbIyxkaOK
	 3rSsRRlcPHOg/V7C3At1xrUHSycfQIoe0r++fZ/JgJBMGOdniL8Din5cxk6g30IwXV
	 LjOldI/10HAvllk781K1LJEfznkB1gNmWMCVv8IWZMx2qDeBldfv0ITZ5DQ7U8YLed
	 JBD4yVXkN1hi4ODSapOvtouuxR837jZA0FLm8aSHrCfFyEsyquIsHV2OC7V5IeX4O0
	 /qk8j4mdXKPNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF55383BF76;
	Wed, 27 Aug 2025 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client: Fix transport.acquire not doing anything
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175630920678.752317.3571952625129420527.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 15:40:06 +0000
References: <20250827140416.1338566-1-luiz.dentz@gmail.com>
In-Reply-To: <20250827140416.1338566-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Aug 2025 10:04:16 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If transport.acquire is called for a transport that does not use a local
> endpoint it won't call Transport.Acquire as the bluetoothd does not
> allow controlling transports of other processes, but it doesn't print
> anything either leaving the user blind to what is happening.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] client: Fix transport.acquire not doing anything
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d4efe960fd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


