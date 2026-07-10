Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4D3939BD;
	Fri, 10 Jul 2026 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714241; cv=none; b=IYbqesqsyXr3uGgtoXgM5DGbURtmNuBBWi0WIbEomwtj3SgNdHJfUqVAD3ZJaJlCrYGdlFU6oE7HcSSUnS4JQdrR7i6quGP9wQlfFlg04YfOoGWuKfWMt3oRFr+wDcb+UTO9aAVy3lK37n5+njOxDoIunlTdz2hWAFM7+Vys7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714241; c=relaxed/simple;
	bh=p14rRGecptaR+q56LGaX+LJPDu328fUHy9RJYfUnsAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hwz82/GC3sdcdaTGF9F3iKFZYDfYaPKk+LcysH57uIbBFn9pSM1oQabMI4/H8ACsAJr9P5BSvDo7WyzXl32h+vU9IFmyaeo/Y0WYZfmxAOS28LUY9NBqAGNRimxcQ+TqUmTONAzBAQiDPIwrlzAmfhYqpHCCfZ0imrxhGSoVZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knQlHswE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knQlHswE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CE41F000E9;
	Fri, 10 Jul 2026 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714235;
	bh=KJ31Q1idiCW7+oKZDiGYxPIZyZ5sEFzlGk+7UGgxGIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=knQlHswEo2VjmtDgaux8ZVcfB4BLdoYki5VvdX6cKyLT6qAXbRvwy+YTlqtascQW9
	 wn8q7ew9fCFfanoG9bdMbY+Irb1gxJnaob34XikCtp7qTDQEwXf7kevFeTC9Kas9Vu
	 YoGHRNus9HD0iR7mQ8NeRBsZ8zTZd5gTCvNL7g483DJiLOepzltY9URQ6kJjV58Rf0
	 CcaQolee7Wp21eggJQZsiP7rj9zaWpMyeeKP83XtU2PpGxLpzGbarlHPFSdP+oJulB
	 +05fu9eM2LXjZbitVJsGzGiOXHA9+zdeSx/swEPqMd+p7Jkg4S6WPBGg6RDmLVyOFX
	 OKfY4x0b/Fn0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A083924600;
	Fri, 10 Jul 2026 20:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: coredump: Do not export hci_devcd_rx() and
 hci_devcd_timeout()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178371421289.843459.5568720195662261030.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 20:10:12 +0000
References: <20260708-unexport_symbol-v1-1-25c0f602a92b@oss.qualcomm.com>
In-Reply-To: <20260708-unexport_symbol-v1-1-25c0f602a92b@oss.qualcomm.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, zijun_hu@icloud.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 08 Jul 2026 21:14:53 -0700 you wrote:
> Do not export both functions since they are only used internally
> within the bluetooth module.
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  net/bluetooth/coredump.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - Bluetooth: coredump: Do not export hci_devcd_rx() and hci_devcd_timeout()
    https://git.kernel.org/bluetooth/bluetooth-next/c/e3421a0feec0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


