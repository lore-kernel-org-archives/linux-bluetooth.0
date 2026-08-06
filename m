Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509A41836E;
	Thu,  6 Aug 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046142; cv=none; b=uyCL6dfb/QGixeoVqMWDB+V9CGHj290s4rWm/aiaR+UKuzaRaF5yk6LLQumO6lXh49EZ1twqId+Q+g0U6c19evVJdCr0t/qlB5s+k6FGuUUXndWnE0Tr9jZWW2uNK0jiLPINvITlC/CmHRDUD/JiM5wk0SBDs2FUpZiixmcZ5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046142; c=relaxed/simple;
	bh=b2Uo1RVrDBJHNRw2oJx/d70ZON8LcjbWExQqISahIkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CjDeyfs4dGzDfBw6qW7vYtyBXka1/ikNu/62M4TxrWwYRPeQc6jjGq9oY53J95IJ+1Gx514jdCa8FOm7if4EXLypFg3/Q+2GX4XHP+LQjHxbUAiizsK5LJdjJB4aF8p/KR8pGeUBRyRXvPPhkrSb7UXwzdwhP4mf8+Ra0q/MRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM153pwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM153pwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F6F1F0155B;
	Thu,  6 Aug 2026 19:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046139;
	bh=HVi+W9P3XGtHzzWZcFf4M2oEiOZ5Y6CWAFcc5O8u/7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PM153pwHLZyLYSCYPis20hbSbYRz7hkBTa8gboTHDId3aI4ipG3J4PNuVCTxJZRI9
	 SjclwfCVWKxnjX8dZjnQYGHNeXLqcrUtPqG8u/0RLOxRd17M3rvDTwMbsBqTIvBIIs
	 /GSzPfWwQJ3OWARG8UFRF1tyqmn/cYVr6BH3g7SyD2JHlJs50A9PQRzPH+Hoph4F1T
	 djxS24z/BTJClmohgIzNAeF6C7vztLWwMmqXV+fqVdF9+y2r7syDytTVKmAO++7R6t
	 MI9vGieTI4bI1lyUS3+I7DSk/jVTxPTNY/4aJmErznxEP9nDR+4d4YUx+dh7D6lCKS
	 5hPRY/UtiWZcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938AD3809A29;
	Thu,  6 Aug 2026 19:54:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V7] Bluetooth: btnxpuart: Add M.2 Bluetooth device support
 using pwrseq
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178604609814.1449574.1250783761019962599.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 19:54:58 +0000
References: <20260721030458.1160824-1-sherry.sun@oss.nxp.com>
In-Reply-To: <20260721030458.1160824-1-sherry.sun@oss.nxp.com>
To: Sherry Sun (OSS) <sherry.sun@oss.nxp.com>
Cc: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
 luiz.dentz@gmail.com, imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, sherry.sun@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Jul 2026 11:04:58 +0800 you wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support
> for getting the pwrseq device if the OF graph link is present.
> 
> Once obtained, pwrseq_power_on() is called to power up the M.2 Bluetooth
> card. The power sequencer descriptor is obtained via pwrseq_get() with
> the UART controller device (serdev->ctrl->dev), since the OF graph
> link is defined on the UART controller node.
> 
> [...]

Here is the summary with links:
  - [V7] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
    https://git.kernel.org/bluetooth/bluetooth-next/c/c424d3c907ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


