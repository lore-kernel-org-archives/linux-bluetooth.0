Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F528F56
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG4dKKxd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D7ECC433CC;
	Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701747627;
	bh=e7Xt5fxqFqPXDQ1iNjlfjfhIF4XKAaA3TRPZAFdrFS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NG4dKKxdsqdqLqRzK9X9KpJKBti+/p9nlbKyTyipeCvkF6H8RagHi4pUf3AsAtmKn
	 mspeuVBrtH6CGtlIw/yV4YHx68WWCTEYv7AJaqIvyjswLK7co/acdZNG2YdcqwBAuv
	 hfAlHVVIrEQDM83XSk5waIG1QuX/Jkz+uE0oPxNH3FXhuYOogtCzWLINWtl9mzVCnI
	 yWXqGNl+dw/wk/hsVS6ZdlYWFluh5z4fk+TPCZdlnyKrpZ+pl8Qh3mMOL5fmXaC+2n
	 uiJcfSOUYAlzo6ln/gFQpNI3MxmURR0YMOF4B9naLSWQT82fcyJ8mMHzpFb9O9lCQw
	 fukKhnjUn7k3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1524DDD4EEE;
	Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: Enable SSP after enabling BREDR
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170174762708.12231.8519747865289795903.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 03:40:27 +0000
References: <20231129101627.1742015-1-pwaago@cisco.com>
In-Reply-To: <20231129101627.1742015-1-pwaago@cisco.com>
To: =?utf-8?b?UGVyIFdhYWfDuCA8cHdhYWdvQGNpc2NvLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Nov 2023 11:16:27 +0100 you wrote:
> When enabling Secure Simple Pairing, the kernel first checks if
> BREDR is enabled. If it's not, enabling SSP fails. Therefore, it
> is necessary to make sure that BREDR is enabled before enabling
> SSP.
> 
> Without this fix, bluetoothd would start without SSP enabled if
> started in dual or bredr mode after it had been run in le mode.
> 
> [...]

Here is the summary with links:
  - [BlueZ] adapter: Enable SSP after enabling BREDR
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=227e16f5c987

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


