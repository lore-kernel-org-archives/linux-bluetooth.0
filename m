Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F227146B;
	Tue, 27 May 2025 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351996; cv=none; b=UL7ljnD/e/Z4sUnA+vdO0Ue5uY1CQ6YJ/MqcJP8rcBRhHDqm2CblkDrH7YDw42RAGi1pJ+cTk7ZC5YzUNBrsra3dM+rOHi+/zupZlcrL/k0YwT2Er2SJlGzHJj+lnD1wfqKbcaFBCYvohQj/s8O3U+Ifs+U5Zi47eVfg5pi6hpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351996; c=relaxed/simple;
	bh=8s1MA+N0n5dZM4f46+/G2uYJwPwyxl3ozUCgNxI/ja0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pmrYLWy75ywtwblxRbB5qAwK6UC/k5htKD7yURdy7QF1ukjDXpW4S/OCOIcZ19uwzkQ+PnGiEXMDwLe7Ai5hBIV42rnuE2oRAm3uaBgA0j7gnt4s7GdVpmU8Eu4kZwQKqGpb8mL4G1M1B1WIlgyIi/IzbWoCa/OyXqIh7JrnRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2llyjNN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2llyjNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A6C4CEE9;
	Tue, 27 May 2025 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748351996;
	bh=8s1MA+N0n5dZM4f46+/G2uYJwPwyxl3ozUCgNxI/ja0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I2llyjNN2aIdvsVeY4IyvXhNfSIXOzs9h0gqfvXcZX1hVmvoywgm9S2sfrUY+7R89
	 wqgBPJvFBZY31IcZYdUNEtsxruWPRTzAHeG3+IanCln4lT1zdDLtnEmNDIzsTonKss
	 PSwXjqfdhVXE1ly3foERoCguR9c9HDut2vnZGOuNIPaKRzr7R/wiGmxVoBdJg50q4k
	 jCp9BAW3P5x08z6+0T4fbB9PJ0q0o2524RNIShHq12EtERZWspepfpP0oImh+o3oD9
	 QI83ZoSp59q+8vLTXFbq83eWP85rczBsDvjfEKhetCYBbV/ZeY3QQk9xsJ8b78bqIa
	 M2gxPrmEmgKAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0A2380AAE2;
	Tue, 27 May 2025 13:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btnxpuart: Fix missing devm_request_irq() return
 value check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174835203049.1634553.7692124762265533667.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 13:20:30 +0000
References: <20250525190020.27286-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250525190020.27286-2-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
 luiz.dentz@gmail.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 25 May 2025 21:00:21 +0200 you wrote:
> Return value of devm_request_irq() must be checked (function is even
> annotated) and without it clang W=1 complains:
> 
>   btnxpuart.c:494:6: error: unused variable 'ret' [-Werror,-Wunused-variable]
> 
> Setting up wakeup IRQ handler is not really critical, because the
> handler is empty, so just log the informational message so user could
> submit proper bug report and silences the clang warning.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btnxpuart: Fix missing devm_request_irq() return value check
    https://git.kernel.org/bluetooth/bluetooth-next/c/4e221e2b5ee0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


