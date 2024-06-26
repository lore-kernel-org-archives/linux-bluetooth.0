Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68324192B7C;
	Wed, 26 Jun 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432033; cv=none; b=N07bB8CiBDYJdtw+w+qHFPDdkcCSpzVuWh9cSsBmt1LQzRl9jR74X5QbKtJrc7tW1pUSpm1fvXMMdv6D1pRYzSP3/ex3cs7eFI3UxBcR9yX/2CMsvMx98Aa1zcx3slewu/r1bQS2ey8HwYf4hQjOaI3eTfJflFfuthYG65Vz9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432033; c=relaxed/simple;
	bh=mcPceM2ui1haddXRh5PWmmKeAntT9I0J6EU+0osdCd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=REhUeqg3DoDrf8I87m0H8s39hTbJVXNk9TIif9xjRO5f2eHWFDqKcZ4Duzi2u24yLpwUbSKNc85XOPH2+wNMFG7NnlTAs5/P2dLa038Rg5iFCN/YcqefXNbwbCjbPWlfRQbj8uCd79nvSYALehOa7n5oFPO8/0iDNIPGksPlkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMwUhmlN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMwUhmlN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6780C4AF0B;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432032;
	bh=mcPceM2ui1haddXRh5PWmmKeAntT9I0J6EU+0osdCd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZMwUhmlN0JV0AYHHUbmJBLyGazXmFOtPPwNURFEWm8rB7D3BiOT8UR46FCy+iI0/r
	 4aeFXeIkgMidso7VrEBCBttDy+qwCh1kost51K5uPiLYkvAmbXM8kWU8smMwU9nYCq
	 0HxWk8TIJIjE6fP1OKIrJZjvxq5qruUCITNC/76yKmnz9v0y3PZu3pAgZLXX7LI+gG
	 voQNCp6mET2YT/w960nfL7AYA4kGlh8k32Ck1BxWHMo7VOClrzY2FEem8VYYaxJTJw
	 zbADbzgjrJNe6JZoA/uAFYFCPsXQo8NYdu9EjhKrmE3tN0ckwATyigSK6JsmGH/qGt
	 87Pz1Fw7S0H8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8404C433A2;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci: fix build when POWER_SEQUENCING=m
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171943203281.19782.10216983993886224168.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 20:00:32 +0000
References: <20240623171352.305053-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240623171352.305053-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, bartosz.golaszewski@linaro.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 23 Jun 2024 19:13:52 +0200 you wrote:
> BT_HCIUART_QCA, which is a bool and an HCI UART component, uses now
> power sequencing, so we need to be sure BT_HCIUART_QCA=y and
> POWER_SEQUENCING=m cannot happen:
> 
>   /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_serdev_probe':
>   drivers/bluetooth/hci_qca.c:2401:(.text+0xc48): undefined reference to `devm_pwrseq_get'
>   /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_power_shutdown':
>   drivers/bluetooth/hci_qca.c:2192:(.text+0x29e8): undefined reference to `pwrseq_power_off'
>   /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_power_on':
>   drivers/bluetooth/hci_qca.c:1808:(.text+0x3390): undefined reference to `pwrseq_power_on'
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci: fix build when POWER_SEQUENCING=m
    https://git.kernel.org/bluetooth/bluetooth-next/c/f4938cba3734

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


