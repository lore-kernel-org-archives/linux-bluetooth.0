Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EC263C7F
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749583198; cv=none; b=JRq0HYfXJhOlQeM36sdEvlALreDTPLCMILbjK8Z57SQrCxqx/gHViTVch7MdQFPejc6YIvFzizZScKemrIw8QN8+/YIouD+eOM+ncu9UzorItj8MXFvmFQ2JBjoZV++8KfzdYPsF95JfoE9VcMTYM8n/+zw8V+9wI38MGJurizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749583198; c=relaxed/simple;
	bh=TkEy2SXW0wvmrJ/ByzFVj7hGHeDVnoUBskDIRzgolPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C8IH/Sano2N1QBpUb2gQBhb/L68+5EDWPbbYK1xSyquLj/kibxK5e+3lyO5ZzlHqDLlod1eDI0B3T0oG/w13BvSjSl4H7PYndjO5PlGYVy+7HUn3dXFzjqjHf8MmkVQiotj13E3Lbm6B2d1c03ZDuqjWDV2xJIq/XIAkPNjPEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbmOY4R+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbmOY4R+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D20C4CEED;
	Tue, 10 Jun 2025 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749583198;
	bh=TkEy2SXW0wvmrJ/ByzFVj7hGHeDVnoUBskDIRzgolPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbmOY4R+C0WNgjhGGj3HqhutmPMu/vkJ3muzItrmw/lSd16oHgIu9nyQcbpIETZBP
	 U/CJyI2Yvkmu9uGp4LcwLreYWmRbWuLAdTuXh9h7HJt+q6d3q34Wb5Gr5oiG0Ec21A
	 cnymraEjdyzvRoSdaJkDXynWmh4hFytg7r4V8FxrZRxkEKfhgjxB/OEW2Vkbpw2qW+
	 fZwxWAZLqv8LaqqRuZDst6NbYvUT1UdKke4f/SCdtGhsOieIPlJnR6V58/uSrIhZaq
	 s7WpGldgv2TjBgGLBBdsNVNYjn7pZGbuBKQGHgbnHgMYyN9LtYyAj5P6NRPT+98mwA
	 z5pp+piAk+iEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9839D6540;
	Tue, 10 Jun 2025 19:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: ISO: Fix using BT_SK_PA_SYNC to detect
 BIS
 sockets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174958322875.2576109.4791071003354252665.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 19:20:28 +0000
References: <20250610180359.1133739-1-luiz.dentz@gmail.com>
In-Reply-To: <20250610180359.1133739-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Jun 2025 14:03:58 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BT_SK_PA_SYNC is only valid for Broadcast Sinks which means socket used
> for Broadcast Sources wouldn't be able to use the likes of getpeername
> to read out the sockaddr_iso_bc fields which may have been update (e.g.
> bc_sid).
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: ISO: Fix using BT_SK_PA_SYNC to detect BIS sockets
    https://git.kernel.org/bluetooth/bluetooth-next/c/618cabed8257
  - [v1,2/2] Bluetooth: ISO: Fix not using bc_sid as advertisement SID
    https://git.kernel.org/bluetooth/bluetooth-next/c/dcd2b35c9b56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


