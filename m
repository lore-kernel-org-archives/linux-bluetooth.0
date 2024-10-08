Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2F1DF733;
	Tue,  8 Oct 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396027; cv=none; b=LRYbZulw/uTtmUwwCznPC34jRQJN7ABu7wKYaCScnXsgv5LCyMn/FkyKcaGuxXRAd8lAOx6lv5LOnF0uxSCT3PCN8gTUeHXcKZ2VTRDvibjDQbUFjMAyoNCLAU6eUM0ngmQLvLhfM3BzOvgSvVbLLw+Dv94Q4EJHG+nvIzW0iLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396027; c=relaxed/simple;
	bh=r4wujnASR6D/hXBsKF9WAbc//3dXDucJJY8k4Z3RIVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PrfgexZGFpynZy5F8UXj5CSXr2XVyFv497uaFVuw2tL7ff0lhWo2UReEPo88X8xOQjcjyo5FgswosYy+ifXnWTmw8zRWKsTBvBjoLvkKuqPWJakPdmQldntwcrsjJfirvKXLYta1XAqaAw66R8zmubTO5W0625hCSWLkEl1vfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbILffz7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbILffz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128A0C4CEC7;
	Tue,  8 Oct 2024 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728396027;
	bh=r4wujnASR6D/hXBsKF9WAbc//3dXDucJJY8k4Z3RIVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XbILffz7WaM0MxCKaDb7TlAHpU6uTw9X17dwwjZjLCdKeFRuruNnQ+LtfuXWmpadr
	 hRgl0ZSOURmGUyQhxa7UgAYLnKAuH7RHWh42RZv6MTUlNAmnCVfK6XNO/rXaFWHx1r
	 6QwyjVRcAQtxgD3lhoGK4PWqsIKhXS/Lk8bQ+9PdSFeYhdw1paxNbAcO/TG7UPiMu4
	 +joLEnWrqg9X9+/hjjasSMJnl3+OOEeqSd066p/I5gBem0YnO1+7XzlODTpaqAgusa
	 6cfQLF3N/NFSquvgYopIo1R4k4F+09hAN3W/kqFUzwi8BxkIPFhNpFbm1mHQ/Q6qyf
	 bo+Q7nIf/XcSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715503810938;
	Tue,  8 Oct 2024 14:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] Bluetooth: btnxpuart: Add GPIO mechanism to
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172839603126.554899.7517324308392311956.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 14:00:31 +0000
References: <20241008091159.650531-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20241008091159.650531-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Oct 2024 14:41:57 +0530 you wrote:
> This patch series introduces a new optional device tree property
> device-wakeup-gpios, which specifies the GPIO connected to BT_WAKE_IN pin of
> the NXP chipset.
> 
> If this property is defined, the BTNXPUART driver uses this GPIO to put
> the BT controller into sleep or wake it up, instead of the default UART
> break mechanism.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
    https://git.kernel.org/bluetooth/bluetooth-next/c/99ba211a9b71
  - [v5,2/2] Bluetooth: btnxpuart: Add GPIO support to power save feature
    https://git.kernel.org/bluetooth/bluetooth-next/c/039468a21912

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


