Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDBC69D2B
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089024; cv=none; b=jkOcYJsONljfsOuZE6xl0sqpvpBJ0UjHIpLM2V6LFiRd3SmAKCD9El5yzEBhVGn8LS4SVIb1G1z7ufC/XXIBuIAkPT7MfR0dxtwWgFM569pnLiGyfnyYIZSQtXfDiWWE6s/6I3fZJXaL4eTLzSEc1+LF44Wg1qqR7LVzXUTPx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089024; c=relaxed/simple;
	bh=/N/TZx9q5fT1ABw8nlL+2pnvnD6E+qfSp/ffOc0KihY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fhmHMHA96QtZlQ1wXtJufA6Ponyp1uah9NEAugDOvf2iCPL425RhmwzoGdyGbhuIB+G3uB08AjSZ+hFGjTfuMUeJZLcMz+SOnLZv3NUarpHddEYUe+jjeAPErjwJiGL5vozdg0I6WIh2qEp28Rh6htfwka4AYKZmBVj0YPPmb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQVbikrW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQVbikrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB66C4CEC7;
	Wed, 16 Oct 2024 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729089024;
	bh=/N/TZx9q5fT1ABw8nlL+2pnvnD6E+qfSp/ffOc0KihY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HQVbikrWepXStZ72k42iWEt8qnj4BKtlnRyXOdPpWDwnGOxgWTPhtdLK4pPzHAYfE
	 TFnILLUaXN7i69ArNSyw9TAQsuMTGX0VwnjIVHjuorlEij2QICMqFzHCjrBSSTy/R5
	 h4Cy8dtwUsTPR1wFKDWs0QS3eX7aNsk1OWGdEORNnLR+Xr0fYoFEDlZ7H7ewYkPAgO
	 QNXuD8JX69yh9/zESKCj1XCWl+tq5Hdt8bs1kJxx8JeiHiqKQN2PMu64G75lfyjBWh
	 MF9MOIbg/kIKSnS07qowNi+2lptceQJYefuGtlpASFWGtdetOw/a4WWpJOwl1ELMwt
	 cS66Bgzt5bAIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB83822D30;
	Wed, 16 Oct 2024 14:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btusb: Fix not being able to reconnect after
 suspend
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172908902904.1835967.8641401200037950562.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 14:30:29 +0000
References: <20241014202326.381559-1-luiz.dentz@gmail.com>
In-Reply-To: <20241014202326.381559-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 rafael@kernel.org, hkallweit1@gmail.com, kenny@panix.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Oct 2024 16:23:26 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Calls to hci_suspend_dev assumes the system-suspend which doesn't work
> well when just the device is being suspended because wakeup flag is only
> set for remote devices that can wakeup the system.
> 
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend requests")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btusb: Fix not being able to reconnect after suspend
    https://git.kernel.org/bluetooth/bluetooth-next/c/1608d6243da9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


