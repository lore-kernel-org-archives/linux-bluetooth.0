Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A615B0F2;
	Thu, 23 Jan 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657016; cv=none; b=CiOjNjvzU5N8+Zco1sczkfJ4WVa0xUPXjW7uJxZ97CGo1rjq19sEkxpqJlk6NUm4GioLdFgtNE2fugoWGMCk8gtFSU6WD2fsHkXrrkY8XdYK68PYRenwFwl11WdbCbIaPVKPzdKPYL4OIpoZWDlDqVsOlG/H8ajSnKlmx41/tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657016; c=relaxed/simple;
	bh=kw7nlw7shuDJddiahtFYBmxbYxC9Z4VpciLxzZCqJ84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dy03o4Wzixe41QyVo8ljPpqfrSM71He1v+XtweG4FPLQYTBp2fZXwxCdfEne+4B7QZH6JfAq146R7Lv9xZOL0wIM/is7LW+fofKqXq4TSqqGYrRM8C87+1GhNlbOVXvjt+k3U1ju6sIc+QGpmlYIlBlkXQ6pNSwMQa7EBbjHwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUWRAelK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUWRAelK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11A7C4CEDF;
	Thu, 23 Jan 2025 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657013;
	bh=kw7nlw7shuDJddiahtFYBmxbYxC9Z4VpciLxzZCqJ84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NUWRAelKgX7LMT6qx1vLG6mvWwIT8ipwfaAvN//JlbF4pTNsn0DLWJ45sQTEnEIeT
	 okXCkBWw2y9lkjmM+p/B2krpqfGOrsij3ysr+6A+BQ5BzK8CtTgKmoZWSOjl+QBGd0
	 BsqH+1ypdA/TqQETGZ+Q2AomPCwuG//njKrebCrVxRuxy8eIaiOlUTB0FX8F9ixtP2
	 4g5g7SRW9J/uSWdYVZkbUSAKfyG+st/gIATkg5dL65YMDWtByT7jgPrOcfYapMsWl2
	 T4e2k41XXxMJOS+8hMm4e/M0+RQkxw5jHjSVWskY/iPWV2douv04JPIfTNMQbopt6A
	 3VN4e4aoPlfWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF0F1380AA79;
	Thu, 23 Jan 2025 18:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Fix glitches seen in dual A2DP
 streaming
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173765703824.1459736.8087924343892066142.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 18:30:38 +0000
References: <20250120141946.2690063-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250120141946.2690063-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, ilpo.jarvinen@linux.intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, ziniu.wang_1@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Jan 2025 19:49:46 +0530 you wrote:
> This fixes a regression caused by previous commit for fixing truncated
> ACL data, which is causing some intermittent glitches when running two
> A2DP streams.
> 
> serdev_device_write_buf() is the root cause of the glitch, which is
> reverted, and the TX work will continue to write until the queue is empty.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: Fix glitches seen in dual A2DP streaming
    https://git.kernel.org/bluetooth/bluetooth-next/c/52f17be9931e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


