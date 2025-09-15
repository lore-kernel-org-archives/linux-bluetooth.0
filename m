Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05623191D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943606; cv=none; b=kaNHQmtWxnJg6asuX9RAlJmOlRp6UNWmu5c2/4Gp4fxxTYgyINMy/wBWEiUf39Hsr8ULO5U7BLZftiamG8UD3tD3iZh/nnYyuPNIjwaojVWACmHzlqXWFxui3dhdAiZFE09j3PNDc8rRksDHAVBEQwZZ2BdsTZSms2tiK56Hauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943606; c=relaxed/simple;
	bh=gHykwsgfA17fU/JOEqLYBak2hnrZUluWeUur79XcqRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oF6MwS1BFEWM3IFHUwk/Q0o9OMgCpJdBNG6WqpZQuUWMp6YWz8/mvzl4C+qN8pGSE5I2KHDMVQD+ULvgxr1rQH27nAqk/HIaCyxx6ggRY6SElbh3JO1huWAa8bTXt4iXhWy2XmdZWueXTRWeULtKvCSnMbYZuHdUDF6klRCyvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRSrKKZj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRSrKKZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7277BC4CEF1;
	Mon, 15 Sep 2025 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757943606;
	bh=gHykwsgfA17fU/JOEqLYBak2hnrZUluWeUur79XcqRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LRSrKKZj6q+WfQybXBDSmuskFxYouA05LLX95bpK9LjnVoeWuZi49joyhfUP3sjLk
	 +9f5jWRF4a18R1Bnj8xyD05jpm61m15jHIq747Y/O2ULFqXps6j2jprjwSP0leJZwP
	 p64CWrSzbb8Dx4mKh1PvAdZWwVLm/Dg/2k6xO3LFRJJuYIutADCqlkC5W9RfRck4Bw
	 daH5BvMPoXwNvjf5iRRHt9/qTxVv+gYf3xXYaxor9wh53cq6SL7GsXhVQGO3lEpeDm
	 s4RzsNH/Z7cuHXJO9k5wSEp4IxG1aoodBg8IByBB5lECJb6u6XF61NZYCPrto22sYe
	 6eQs4pt45rQeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC039D0C19;
	Mon, 15 Sep 2025 13:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] avdtp: wait for L2CAP Disconnect Rsp before
 CLOSING->IDLE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175794360774.4175453.2807731063299766583.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 13:40:07 +0000
References: 
 <82a0baea3c6d33392719fd4530e2763f2131eddc.1757854496.git.pav@iki.fi>
In-Reply-To: 
 <82a0baea3c6d33392719fd4530e2763f2131eddc.1757854496.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 14 Sep 2025 15:56:02 +0300 you wrote:
> Delay CLOSING->IDLE until remote acknowledges L2CAP channel closure.
> 
> It is not explicitly stated in AVDTP v1.3 Sec. 6.13, but some devices
> refuse commands sent immediately after L2CAP Disconnect Req, so wait
> until Rsp.
> 
> Fails:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] avdtp: wait for L2CAP Disconnect Rsp before CLOSING->IDLE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d7d25b70245

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


