Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9C4F93CC;
	Fri,  2 Oct 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959213; cv=none; b=FYFjW4QnX0CkYWSnG0UV60C5RFF++ZkJo8Lt3hhHP3HO+m3BCXis3vudhpOwa7U0FTtIpCylpnl92EDfOZ2K7wcW2/I/1MlVoiKwSLNeq6wdvvhphbyxmrF1MS6Hf6vg1iTtKt+nDYZddyaF59QimMtba6WvLtVTr+aIq6IlOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959213; c=relaxed/simple;
	bh=ZRJDPRk4bughq3pnYPjOi86WOQWFMEg5PeRbxOy3mhw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=szyhb7Qbz+riSIV4Hy9AAw3Lia0HRU7qixXIKMKSIYlsMaJ3vVn8b6gRCvscZNzLym+iInfpOubVYyo5Q4tnLBpyeVQ/fe9Ssgb8AWsp6vsaaKHKFx1+1r1QCNxR3hSa01ksL4o0EZ1nfT2ViqroCrHMdqPSNNuc4v312twFGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhYqNu8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhYqNu8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F84D1F000FF;
	Fri,  2 Oct 2026 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959210;
	bh=xAvLJ79Wtx/P9UMbevBVIV6YxC9wL5iFyfgHr5EbdIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DhYqNu8e8xgN2YdE9cFAc7ZU/wlW0c/qhvs//JupsYQlS2LC0BAVxSwYLvfVk+zRz
	 xwvbfmvF7QLKqJRYH7Ff33kZoSD8Riz2//00dbYFf45j1oZaW9YEVQ9vzEUKYvQZbb
	 nDOGT+DZJhabTRR+41VkS0lbf5hS6QoDXSa10i69g368IpE2xct2eMPkjH5r/XEP/r
	 vDQiD9sm9Ul2ED5sljkSXTWVzQApTl0RxKuT5qgoQRfMkY+wqy8zuCVnasOev4qdKw
	 buJemIitCk6HxvuQBKT2f60F0DVMeretE2SkHtVOAbdBn1HV22DssBB/7lZ/wre4W1
	 yemV0IUy8vTnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772343811A65;
	Fri,  2 Oct 2026 16:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btbcm: Add entry for BCM4356A3 UART
 bluetooth
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179095920903.3497173.9841096875814984344.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 16:40:09 +0000
References: <20260925-bcm4356a3-bt-v2-1-42098aca235b@gmail.com>
In-Reply-To: <20260925-bcm4356a3-bt-v2-1-42098aca235b@gmail.com>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Sep 2026 01:52:50 -0500 you wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> This patch adds the device ID for the bluetooth chip used in the
> Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.
> 
> Startup log:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
    https://git.kernel.org/bluetooth/bluetooth-next/c/ee8d139b295b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


