Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64586582B9A
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885073; cv=none; b=j+lvw4PkGGJE2iNIc9WCVHDxBTpZ1QLEe6sldLbQ9NPDYPVY7mi6l7mC18Ru7FLtsd9IYe2/zYo83Rn71a5mX7WqPQbpQJvOfgW0ix1TrixUBiRPu4DH4kO2TfCMUeGKyYvBtSVE/6hVLUbj1r9IZTldOF+FHcVBr7qL2ywgDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885073; c=relaxed/simple;
	bh=RsBZV1aVBG75DGAFXVYP+BHqKrOMVvIhqXEzn+VM23c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Amfkiy6SiNGAtcBdJBvA/O2JL0RXj7zv71F478yecI+Rro94yvfPysQaQWPORnhd/iPTk20OT7Avp7FktsZ0yO9/EYrVjq3MIAWR66gIf7gSQcFUHsOuhfOOYZj4aqASOSa6nSxNdNr8iXyZtpBGjq49b2V4WelQCZXdZfaSgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO1YmJgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO1YmJgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E5C1F00A3A;
	Tue,  8 Sep 2026 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885072;
	bh=MAjeHBctLuMQhvZn2/D131+gG1gNNZmiGv82nJ5j7Ts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nO1YmJgpHdhgmybLOBvBETpM8inrCKln3ImmZqTN4+Ac48q74uALIdbevBNxTR/XM
	 R5d8TN2Ze7GLD4g/PyAlQQhiIzCwpSsl9r/rzXNTjHL+n+Sk+i+ub87MNQi1b0g0Ge
	 4UMEY5V3ZqU9Nlwess3u7DIPUvOfhGe+QLxokl1YmUnE/FYvBDB2VtFoW63v+Ine3X
	 HKZsXF9pucAgId/Q3ufcuO3yhL4FYJma0PGxpDpAFNdN3PDHC/9X5llN+Y24efR/yt
	 dBVCb6l5kMnBBcab29zXipKZxKLGF8ZnLFvgj209SwtKLmME5FaIBJ4gFcyb1Kkmui
	 O2H+jBo1RalpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D1C39EAF6D;
	Tue,  8 Sep 2026 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: validate TX skb length in
 send_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888501048.3627954.5315062891707768596.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:10 +0000
References: <20260908095658.729390-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260908095658.729390-1-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Sep 2026 15:26:58 +0530 you wrote:
> btintel_pcie_prepare_tx() copies skb->len bytes into a fixed
> BTINTEL_PCIE_BUFFER_SIZE (4096) DMA slot via an unchecked memcpy.
> Oversized packets are currently rejected only in
> btintel_pcie_send_frame(); any future caller of
> btintel_pcie_send_sync() would silently overflow the DMA buffer.
> 
> Add the bounds check in btintel_pcie_send_sync() itself, right
> before skb_push() and the DMA copy.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: validate TX skb length in send_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/88906c2d5b21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


