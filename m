Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851424;
	b=n5tkUvObHGT9I1L3CgA+YYqCxtYbOYturx1efegRwabM/7CxIjV2xz+AIf2eQrBVIqiJ
	 UCyrwMFoMAP+aLBozScWeGCKw94MjsyxF8vYppt67eOebSMkgQA9j/QYrfFhU2cG0UoRg
	 tYVKdaE+Tmo/Mqft8aMhb6KoXedxtTrJKn+7fROjowlvVptljyk8Yy8VJHtFIfsmyKuqW
	 YRYLjVKKNZ9IOwYJUQGWd+b+PdTjl8Z47C8CwiiILqI5n5Matfw2aWvpLo+qVyYWj8sc4
	 /D85gZ97S0FLJPeYWwEgCjYwp8CQzruNTqCUnYF1p6APqQG2qWvsVGJUxDttLjmAxAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851424;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=91rJEWjxPHIGpYMTg/LFG0q+FN55YR+n+YawYVkO0As=;
	b=GY6iOUVcyoLQUvvKO3EQwxt/+pq3YOYnJTD7AS9zvOkJBETY/FvdUeYA6hhdxj2eW1Fv
	 UFbXZKP33swTUpBmCQAFxUsUPlkkaTCmDMj3LS6RrLms2/sHFjEZXEMEyEadOItRiZcHg
	 opnDTfypPg8SYbTtaqGDC8xl9/A+e1kpJsy68/e5Bi+nJrD5rUNzDXmuPtH7kl5+NMP51
	 PHqwjokvAIEiOoaZ2cfX/kYVKl2I4pX1WREuzrwbUOFus0ndPp9Y7fRAgXuTsOeRG7l1b
	 vUfVZL3ihaDd3rF7o9Nf0OfhqbBXQ8QAV2+dkt9SZc7jBIftLUJDT2ch60lZTetZ6fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTwv9ATH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EED606A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTwv9ATH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B1E1F000C4;
	Mon, 16 Nov 2026 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851424;
	bh=91rJEWjxPHIGpYMTg/LFG0q+FN55YR+n+YawYVkO0As=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VTwv9ATHZ3/BcI7e5PnUUn6RNHFcxkOKQzUeiqUHJbx5jY/Lv2oAbfXPPtvTppzEs
	 zaKcyXRd5vzE3gdpJIZ0XaekjwyFIeBWfLNE1A2nnOY9+mTDf52c0l0lcmhUw7XLNS
	 KLMkydkRr6Nsk+jUfT4z7Xi97kw6/quJR2CpPmX7DPI7y6kV8ssUzPMOXYSjArCf/P
	 jA2umOvzvWIM8NHaD4G8qVWNWV4utTBfvLck68SCRwQAjhney97y9Q5UkOsuMcGRDk
	 FU+mBsFqzlUMqoTypKjL6FP9zGfh3IZfinOroJHziy595/efXj9xr3E76hRHihUH1l
	 u+7EeuoNwYLWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7733B391AFAF;
	Mon, 16 Nov 2026 17:50:24 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2 4/8] transport: Don't hand the owner over while
 releasing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485142302.3796096.8223622744336339718.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:23 +0000
References: 
 <6cdc89f8101db17c443fadd37dc35d4fe5197674.1794414122.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <6cdc89f8101db17c443fadd37dc35d4fe5197674.1794414122.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 11:25:27 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> As a server, handing the owner over to a link still streaming also
> happened when the audio server released the transport. Release sets the
> transport to suspending before disabling its ASE, and disabling a Sink
> ASE reaches the handover synchronously, before the request of Release
> is installed. The handover cleared the owner of the transport, so the
> removal of the owner by Release did nothing, and the link, which kept
> the owner, was left owned and never moved to idle:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,4/8] transport: Don't hand the owner over while releasing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=578b16afd93c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


