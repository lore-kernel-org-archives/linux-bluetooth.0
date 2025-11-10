Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6702EAB61
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806041; cv=none; b=oLX0J0Zoy0JDf7woHZBaE6HVEtL3oGomUU6XxogIAIMfczvHJVz1rTadVpdnI/hwfRjhgmwe1DI1ET3g1roN2/Z2uUrncu6pgKO8uMwfmSIZHlQJnlAZNJKwnDej0aIpdsYqQaul7mYYyLgXDVguVxQtGbArISVk0QhEMqlMJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806041; c=relaxed/simple;
	bh=W0BnBPFbEBYl6GMh/xB1VQKu3onH2yD2NH66I3B32eM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s0CGhwROOIIxWHqNMcjeNWi0OKn5whvtBV1yNL472UvovNc2U0R8oXnP5EaDQ8DeQtymY0VzZDPaiLMiWDa0jfrbGTbwgc6hYS71yAeYek4QznwDGO7zGWYgmcipLaiW36HZHaMfFCjkpYl89RxViyDmH4XHRsvRzFfZyGTx4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBmC68Pr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBmC68Pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79A2C4CEF5;
	Mon, 10 Nov 2025 20:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762806040;
	bh=W0BnBPFbEBYl6GMh/xB1VQKu3onH2yD2NH66I3B32eM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CBmC68Pr1yqV1ut9YHElqmk4C45lPjZukcpu0GubkB4xa11yT6hHkw860nTdfZuWC
	 7FmwFM/nxauskziwi/97c7+ZWW3tkurUzALBiW/o4IuPfaq1VvQP3TutTnED0867ku
	 3R/AYeNdqmzeedXfHF+IWmUsNpbZeuGN/5zQx0dthty/BchKzZe2qczSNnICw0fxeq
	 ZCLOVofNIr6j03DfgGPV92o22oQbpdA/s26BblyUWlfU06qleDIEWgWtLuHUGzLkdM
	 PZo7YygoLDcSmHDHHgSfour+wMmVtGaKb4dbA44dyPmWropzUv5RuGi+KW8BrgtvCd
	 Cj+mEjoA8UumA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC5380CEF8;
	Mon, 10 Nov 2025 20:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: make SetConfiguration() work similarly for
 ucast
 and bcast
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176280601148.2762084.9033693578348154249.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 20:20:11 +0000
References: 
 <e22984df6d0f3bacfa58ceb2ce98eba115d81db8.1762686379.git.pav@iki.fi>
In-Reply-To: 
 <e22984df6d0f3bacfa58ceb2ce98eba115d81db8.1762686379.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Nov 2025 13:07:04 +0200 you wrote:
> Change ucast SetConfiguration() to always create a new stream.
> 
> Previously, it also removed all streams, but this is not useful now as
> it prevents client from creating multiple streams, and since it can use
> ClearConfiguration() to remove streams.
> ---
>  profiles/audio/bap.c | 7 -------
>  1 file changed, 7 deletions(-)

Here is the summary with links:
  - [BlueZ] bap: make SetConfiguration() work similarly for ucast and bcast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bfbd3d902981

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


