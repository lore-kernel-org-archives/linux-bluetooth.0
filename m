Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7E84C80
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984807; cv=none; b=HIp93oYB9acDbFOnIzrjrcsZnRDRhMGTVYgBvyuyWCkUR2a5KjXZiarJTHP2gNMmAu1pHmTC/8HP03kFpCKSmpJ17KgwE/8DdNKhhU8csjevMOurtmdYu6eeSaVZ7VLtP6pQNDBadh45tlbdIvT9XDy1BoalYjc3bfOccaLfsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984807; c=relaxed/simple;
	bh=Sn7/qieNIVKQ7rtTl7I9/B7PsbrCpBIhqj70uiJHxvE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MFwnUF83HIXQi8pbG2mEow7BKnyr2hWSa1Hs/OlFAiGUviFWHZASu8covWXaE5H3tdJ8byCXl2yLTuEnWMb7S7Kl4iAvgN+X+mbCTllCJ9nHhhr6YmNCSFZR4yYOXXfr8jzdVc9SAlTy30yDyojys6Qdm8pJK5KEy19CRSOGyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdFblZCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdFblZCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2313C4CEE2;
	Fri, 18 Apr 2025 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744984806;
	bh=Sn7/qieNIVKQ7rtTl7I9/B7PsbrCpBIhqj70uiJHxvE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qdFblZCw2VWCDMk28KrfP2cZyghaOg6zWCR/KK7H+2bp1Ab9gUqw3LpNmIpPOLtrY
	 czla/nYx98cBE1yu5IWjkGNeVriC0kIXnlXdFgh1UZFQY5Z2uXvh1HPQE9nbV+AzXo
	 oVqqATc5NOt2nV7Rt2OBb7yBQPuINMgnwbQNy2rlm75P2oJ6AMjeRzTdNPqZ/debGE
	 9cX2HHYWOdHkvriv4PLct1EEFnhvaBaz1TmBcVYR/VDKSa9pi1mnCmebpKZmSGS+Xd
	 bNo+imIebuebkBEq9iBcc+/kMlStvUCYmItHJJVXoWWOZ+EHVV5kwNnLgZCBR4zWMD
	 RRridbW31lV/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3424D3810917;
	Fri, 18 Apr 2025 14:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Avoid redundant buffer allocation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174498484494.223117.10154428256172753984.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 14:00:44 +0000
References: <20250417034842.165796-1-kiran.k@intel.com>
In-Reply-To: <20250417034842.165796-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Apr 2025 09:18:42 +0530 you wrote:
> Reuse the skb buffer provided by the PCIe driver to pass it onto the
> stack, instead of copying it to a new skb.
> 
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 33 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Avoid redundant buffer allocation
    https://git.kernel.org/bluetooth/bluetooth-next/c/16b4f97defef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


