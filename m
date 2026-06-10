Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917D42DFF7;
	Wed, 10 Jun 2026 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106024; cv=none; b=ub5XAlVkAscqMdRo1vCTYoJIgbGPrzdso25tCNNVzBFk5ttbmfOZAAQIgxniZ9p+YFGV1H9qW/7YCYKwIH5of34f2+MR+kZ84aSW3EdFvObHDY0ilm5AEqGTUxSXE2rO/tQxl2+4YEqxB/h//4Q70smWQ+PjggNxNE8RZNKWaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106024; c=relaxed/simple;
	bh=MhqTkfEOxi8woU1Lp2JJsWhV4onOU2Sz05pZXCzQB8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tnff7TyqH1kyZkkE1wHOI1oXVbsc9L6LMvoLBCy7YmIrXJRlcnQDFR/TeuphlCo8pBnoouftrqd5/wPLbVqK0SBopUw3j+Faxnpt0EPAc9gOgghmvHE73IH5gEZzQSAQSsqHp7+9rI1PSpatIk2aY4FPE7vRbG3LQSMLVRg1g5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgFpzQOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgFpzQOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC231F00893;
	Wed, 10 Jun 2026 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106022;
	bh=DubEQuvvvUndkNK7MlijMPCoZ3DCUbTVDGG2fPII0cU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JgFpzQOsX/im3KEJ2IhiVFeYvnW5Y1ek3VPCJLcUJLG7xnx5FzcxVrOOIQ8ONl6G7
	 HwT4jMh2SujXb/pscg9NepWm4nnqm64FoZaqFSrXYfEmjhrZXscOKfQoB3UaJjBj0a
	 n+8B+0G6dYEK5lgaUnZnZtBaqebKDI84vXdHWU4ysk87U+nyh4VDDDtwL+B4lRzOEE
	 wagAuSy7nXLE3QcdsILJnYkQk41FAtz4z2LnXOtY046R3v1l5vg95HasL8oYl+aCgd
	 kqCJ426ECcyQrk5FHQUMAxwhX/FQ8l974TbD4im8PoTgWlgEo4tWami0H5tvWk9wWO
	 ddc3c5TqG2KAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A663930D7A;
	Wed, 10 Jun 2026 15:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: qca: Add BT FW build version log
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178110602038.3101197.11961968582425706354.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:40:20 +0000
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 15:54:17 +0800 you wrote:
> Printf BT FW build version log after BT FW downloaded.
> 
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [v1] Bluetooth: qca: Add BT FW build version log
    https://git.kernel.org/bluetooth/bluetooth-next/c/559cab24b04e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


