Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65620503BD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904207; cv=none; b=Hj4g9A1AYbPgDMW/5xYStWU37EzhFvSO0mDADmEf6LMcwuEopi6trNqPv79w+p9nEnVz0P72rUrqvfwzgZjZwTA8DFniAli57PVyuo0bfOsJ7vqxM9blyHl9c/LFUKGxGEliJ+dZqmZ/RHQyR3q8AtadddxLwiHEXKWeZI2vYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904207; c=relaxed/simple;
	bh=zASoC9Zr68DGBx1cnAKDxt1P5f2UBBH/Z77sy+fdnMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tLg+JOi9M6AXJKfpSLUyuW3VmO0IFoBd2YRbVZ4pxmB8irmHMi/HN/PAJNH+pxAYhtO/uwmGG9xzEzGY7VS22t3XQz2EQmaeOGRSmHVT1k8dxDiUp+FvTmtdf+sVJENZeXDSk6yh23aiAZbuehpwutoxmJR2FtZG9zfg76A+E90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkHSQOUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkHSQOUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D5B1F00893;
	Tue, 13 Oct 2026 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904206;
	bh=/U7/I3wS1h1TqvkUXdByPEz05CBkKDZMgD6vcW/3PDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kkHSQOUv+smq/opfVs75wqV57fJWrYQIU1FFW1Wg6C01cjY4eZtRsPnTgKv0nHawo
	 dQnMGM9ECdm/mAbZaw0fnjc2mI4x6eiN1JeNdkAKFeePX0v3JYx9Q8ElctqRGRHw+n
	 SKYrh6O6YpnrhZHIpc3Yb2XlPvVc7uSjbnfOutl3MGvOIPTQXF/kSGYKLfYQecuy/c
	 FKPLRkdWOu8gT0wULyK+2dJMRsCiPSWW59W7R0S2tyQBIiDPJSO1cjC5vp3X74PsjI
	 Qg2U2F1d7uNhiRrToSWQQ2rCxXsNIiKsDsFpuVqA48Fw8TEdl8hW5tFCyd/64NNzOG
	 +3l3kucGexDiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3E739D267C;
	Tue, 13 Oct 2026 15:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v1] Bluetooth: btintel_pcie: Add PCI ID for Titan Lake
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179190420502.367533.6643573344156279406.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 15:10:05 +0000
References: <20261013093650.423572-1-catherine.l@intel.com>
In-Reply-To: <20261013093650.423572-1-catherine.l@intel.com>
To: Catherine L <catherine.l@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Oct 2026 15:06:50 +0530 you wrote:
> Add PCI ID 0x9329 for Titan Lake (Scorpius Peak2 C0).
> 
> sudo lspci -v -k -d 8086:9329
> 02:00.0 Bluetooth: Intel Corporation Device 9329
>         Subsystem: Intel Corporation Device 0012
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at fe000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [c8] Power Management version 3
>         Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [80] MSI-X: Enable+ Count=5 Masked-
>         Kernel driver in use: btintel_pcie
>         Kernel modules: btintel_pcie
> 
> [...]

Here is the summary with links:
  - [RESEND,v1] Bluetooth: btintel_pcie: Add PCI ID for Titan Lake
    https://git.kernel.org/bluetooth/bluetooth-next/c/88b7183b3945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


