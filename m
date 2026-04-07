Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10CD175A9F
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568627; cv=none; b=fmu2kjIEVGfkmnCorLNb0EZ2aG2YxQ24A7Eyn9uNbXxBs2/xja/Ykqd1josj9esXQKn3Egg9ofnFQ3JQezD/LiaQ2nJ64NjDZg19+gxPq7KeVrRswC++xoVwWFHpuDKUEflOJRlfB9l394pAEIR4UmLaI+a86w4dJjXN0W71YwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568627; c=relaxed/simple;
	bh=kYnvxPRFVwxkKHWxFLVxOrhvAKF+LlT6T/l9YuPIFJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fcDCeRoOnOVYkL9F7iDbUxohM4z60iIcvykBapo/EVZ8SWBnQEj7rd8nYQsVQ4NV0io19PktZXFrirJyty9tvqcKjt77+jtLF59yuAngJdZWlroy6DSUfT6H/OUTaBT1plVNlguPyzBDT9mG+AjJUkgRj5LWtUSt9o2xDe13EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndNdkstH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndNdkstH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A067C116C6;
	Tue,  7 Apr 2026 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568627;
	bh=kYnvxPRFVwxkKHWxFLVxOrhvAKF+LlT6T/l9YuPIFJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ndNdkstHD2g4Hf5OiX8ScP4eImR1M5G4feMp7xbSnrz1+PRBc4iSOybK+9SKcz6Am
	 xB5dSBYhYYnwOYeksxq28HM9myBD7ShYXu3u24p9HS+crxyH3NKLqs6HTU+NUhm+0w
	 eCNKG7sKV+jdX+d+RYy8e/Zr+pVyO9lYxMa7/IFyk/6/UKfjTnJNmp6hmXDFcVcwKB
	 BQJzgZGXFyZsLc7Ebxeit1L9LfpETsfNSlBk9AEtYkjGSnpALNQI9X5o7Agxv3xSgX
	 ETw2KBRURH+MYKZvK26GeFDArzAKRtr5kAXJrFD0pmKsggjJyR2m1wPfO3UrACrmk1
	 ae6xuMZKQRApw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD1D3809A2A;
	Tue,  7 Apr 2026 13:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Fix not loading local GATT DB from
 cache
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177556860505.3573370.14036849633845549950.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 13:30:05 +0000
References: <20260406200043.3447321-1-luiz.dentz@gmail.com>
In-Reply-To: <20260406200043.3447321-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Apr 2026 16:00:43 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The local GATT DB maybe discover in previous connection and therefore
> should be cached as well to be able to decode follow-up connections
> where the discovery may not be visible.
> ---
>  monitor/att.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] monitor: Fix not loading local GATT DB from cache
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a73fcbf207d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


