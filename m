Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113006;
	b=VcwRVKbbI55DPsGtcZ3y5VEcJjlEUsDpB7gIqJa4KKbhCNddaEBmDIzWoTk1oHys15CF
	 FS+diUFZ/6c27Bf/I95dYw1pHMeo8WaKxNS+iKfp46q/H9FDj8Vby2hc4FLR0FAOzTn1F
	 hqd8fmhvzwcbdENGlmla8r49PayPfmgxypi2xRbMBfdLdo2cJ1h3skb9m8txcA3LCmiEu
	 scSDC+D+vHlneYpD0G8nVHAqUrmjlJL9gEwqMoPLYEloxurz9u/Wk6znslXyrnTzaGlrj
	 mLMC6pNcW6Grt408I6MvITjVfpthCvda6ugQ2fYpLQUGBxo4DiZCX2be17aX5hCqjTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Gc0jlhD8fYBpp2JOB5FsEBrptnYoEvq455CnUlQvFbw=;
	b=p0LpbqbFpU05nxDxBkY+dbieSrZu1eDPjB7RXuU8jrXD1fOp7rm67wI/veV31uQNVb6L
	 nlRfu4UlecCR7zjif3MGBjLFU3vwNm0Ho1rOxgQI3SqRM3f4S2nWfKwvOQFvH6TMJ0cb+
	 9C1UFW9IWqXAr2kZ5pqCEdy5vcb1d+H0eOwpyw/lm4+FeClhEmXE3SFOL0I5v84t+GE0G
	 duY7V0w+idj7Tsy4QO/L6lm9T/196pLxmwL1skpJ2r5qwKwB/GXphCr61ylHmrYPf+B49
	 MSnULeedYuyJyDVvlaiaWHCs8X0jwJmPzEaKX1TdDWhqSkDTaiWKosLdMAptms6L9ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6zG9wsG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ACD606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6zG9wsG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F371F000C6;
	Thu, 19 Nov 2026 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113006;
	bh=Gc0jlhD8fYBpp2JOB5FsEBrptnYoEvq455CnUlQvFbw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q6zG9wsGwQ8B+8gbvt2J1DL//A3J7o9aiwPLFEigqPzwEJ6X8dD3IVCOdyT+MpodT
	 i2ruioh9Aq7QJJiMtLhC29kQxWCh36GhOBwfrmbch+5w7sMGNSQ1Lk8LuD2YRQCv2b
	 WotHoAVu8YoGWgXmb/CK/V+v7Nrbj7SHL8ikbwfm0mwkFPgRV3qKDuJehIpLBjUDOz
	 qSVJJNUETxxomAOCAFxps9mfQbKpsHjpiatJHFJ2gecTT7m21PdKhbkVrm5oH03vWS
	 eIGLoGzXqc8b1OB2IzxW6cNHLmSIstCF5VONTqfTcMd03q1nw38rnis6idjTPRVmDu
	 IQdZvxBO2hq9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DE9D3808210;
	Thu, 19 Nov 2026 18:30:06 +0000 (UTC)
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
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Reject user coredump until
 firmware is operational
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179511300528.3261689.3188065362433475885.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 18:30:05 +0000
References: <20261118232043.1987049-1-kiran.k@intel.com>
In-Reply-To: <20261118232043.1987049-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Nov 2026 04:50:43 +0530 you wrote:
> A user can request a device coredump through the PCI coredump sysfs
> attribute at any time, including while firmware is being downloaded
> from btintel_pcie_setup(). The request then rings the DBGC flush
> doorbell on bootloader firmware that does not service it, or, if the
> core halted, reads debug regions under MAC access while the setup
> retry path is resetting and re-enabling the device.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Reject user coredump until firmware is operational
    https://git.kernel.org/bluetooth/bluetooth-next/c/cb60e0e5df95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


