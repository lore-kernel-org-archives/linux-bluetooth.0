Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDA30DEA9
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202206; cv=none; b=LjaW/LHHHEFKELwtznhjN+U6pj4RuR7x4hFFhAWHHMoU/SMpCsNEuLljAaX2rJP9oSzDBKKNadhZnN9ueDB/79tu4NbhZ2A14E8z8b/MkP1ieMTs1a7QBQN9CLLnJZzpn+hkZPVZJAogaPXFHvviWS7MZ7oPJuVDBeLXg93Taxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202206; c=relaxed/simple;
	bh=ahUFufixviAAxgRYrZKaNnuoRwry+776iD4F0b6/07E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=spPoINSDYY67Zk6CBtlh3Dk0ck/8vH1iJP5QQj0AztPv/tEaVukix35kUDvHUYYGsBBZYBM/8mj5CccuxxXpMppxwsEw0E0WRy3SYhm7w0Hhwbm2ThwJ36AMB/QmaeDjZY3TAirn0dXgZH9lWlVPtG9M815xZnSGZQjjYIPtAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+nvlCEv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+nvlCEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B18C4CEE7;
	Thu, 18 Sep 2025 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758202205;
	bh=ahUFufixviAAxgRYrZKaNnuoRwry+776iD4F0b6/07E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d+nvlCEvtNC4NJA94ipobaUQjyQQEjDVWZ+fBTHjkxM8uq8roET/93+DXZGBCrmyn
	 VOJtdn4qV91b9KwBV+MlrfR1F+ASKoA3thliymWoZvIYY2YGLpRA3W7c0Lxyx5JI1N
	 XACAGLsryG0n72Uuj86UzlFglV3XxvJsWlO6Xpsln39ahe1r8J5LK8OOYPMFy4Dp18
	 pxfhNjK1Mte0jvUgwqgE4gk+36UOBcQtugyNK1KiD7oEsuP/4g3K1YLImXyrlcSabc
	 RBThnxPtrzphFZnZK0g8EAceBdW7HTe2JoRFJz2rLBqO+f3+i+3123Py6kF90AoS/W
	 cGUdmeN/0BWRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10539D0C28;
	Thu, 18 Sep 2025 13:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] profiles/audio/a2dp: Clear suspend timer on A2DP
 stream
 free
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175820220575.2414053.17652158380840846473.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 13:30:05 +0000
References: <20250912182033.1260032-2-alex@studer.dev>
In-Reply-To: <20250912182033.1260032-2-alex@studer.dev>
To: Alex Studer <alex@studer.dev>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 12 Sep 2025 14:20:34 -0400 you wrote:
> When an A2DP stream is created in start_ind, a timer is set, suspending
> the AVDTP stream if there have been no users within 5 seconds. However,
> if the AVDTP stream transitions to the IDLE state before the timer
> fires, the A2DP stream is freed without the timer being cleared. This
> meant that when the timer fired, it tried to suspend a stream with a
> pointer that was previously freed and so segfaulted.
> 
> [...]

Here is the summary with links:
  - [BlueZ] profiles/audio/a2dp: Clear suspend timer on A2DP stream free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=72b02df3b2b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


