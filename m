Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C885628
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277631; cv=none; b=jUpImWptvTDnOJK9nHV8i9qbT9sbqygrjCjGewNwBfEiJ0kTa0f+ymGmLSZxYGxiQc5+FQLuYelv7Z7e58QnhedmIcS5Bj5Sscc9bcfVrXS8iPQje/VBYNTRGZ6YOw2OvOhUfOq54iZLsRfpPMfh24QK8aYGKRc/JssTVPOVx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277631; c=relaxed/simple;
	bh=Bmcr3nzfXPL8pIblIDQQYVKk77+UH37H4F3cgi9FQts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SiCGSJdfnPc8Kcj3SAi1wAuxJA4qPfCBBlMCEbOvGBO+P7YLUyRRiVgPn84R28KeoXi4veBYaZDAIrS+Byh+By5iuvMhOQ670VUCGEdDro8AmYWvsZLqueE0XXPrbp2z6VkVCFD6aXPInX72OhcAnBxhI/MC3WxJ0YtAoc0Vphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em1LvSRt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em1LvSRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBFCC4CEC3;
	Wed, 25 Sep 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727277630;
	bh=Bmcr3nzfXPL8pIblIDQQYVKk77+UH37H4F3cgi9FQts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=em1LvSRtRdLANO3pLJ7hYIraQK0bBbk4j4DpSUbrkGpjw0yClD8VvZp5rLSNQ/dpT
	 sIaa7mO3qGZ8FQk/r3vTy500jIfUSkUSKnDy+r06/4db/DQRBiA3oacA1Q76Z/tMfz
	 R93CMpU4F8HlVVvagLkkENDTPWPgaCbL6bZOdALx0ndnEvvi9H6NXcXpdCjv7mOqDt
	 MzTi/WSdawM+47zmSTyy31LJKawV+haKXjFi7X68MXBf/po6I2qdwfOWzuFE+0uL2Q
	 u0IWVxLAwX/H4aS8NOtlyg9vgnhLEC1t0mvC3vT6bFQIgEsTEJQe/Lz8uSrGkiesAB
	 76g112+kpImrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 350393809A8F;
	Wed, 25 Sep 2024 15:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172727763301.630403.6184726261074394616.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 15:20:33 +0000
References: <20240912031204.2211567-1-ruanjinjie@huawei.com>
In-Reply-To: <20240912031204.2211567-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, akarwar@marvell.com,
 huxm@marvell.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Sep 2024 11:12:04 +0800 you wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
> 
> Fixes: bb7f4f0bcee6 ("btmrvl: add platform specific wakeup interrupt support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
    https://git.kernel.org/bluetooth/bluetooth-next/c/f9c212dd4eb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


