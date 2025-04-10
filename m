Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC51F1512
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304999; cv=none; b=Ax2gmKaYVUR+gHJSXrzb/v1NtbnP921tLGDDc6z7Pycu6TZuEjo8XfpFsS7hb0G48sX06wj7INrrI555FOXJNAEh3bVlJXN30ldx7Gy5fGZZ7hjH5l8W4LLDf6lz9yv0l1xXnaSEYD4Leuj80YBMAcCxEQsFlT6ed00vORN5OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304999; c=relaxed/simple;
	bh=lbg/sAp1K1GpRl9ODQhC3NMjBZOxFafbQ6UvZsMQqDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u/EccDVr9t6P8xVPR5bHVZNVdp2YLoq9sU/IrcNljcoJqHJmvgMP/sjnxl2lr7VTziL0HReT3z/E3v7hSi8vZut5uAESeaBk4YhvyhYIg6h+nGFfIP8ef/XYghmPEyuf3YBvxKhp9/6OOPUZiF6VLkff5heomH8nEMzBIwOZQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia1Cv3j8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia1Cv3j8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AAFC4CEE8;
	Thu, 10 Apr 2025 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744304998;
	bh=lbg/sAp1K1GpRl9ODQhC3NMjBZOxFafbQ6UvZsMQqDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ia1Cv3j8sXnNs9TSSlohJuUK5R0VfdFEUlh1ic4dO9ah7A8sQiM6YnBHe5wiFMViC
	 v4zTkb0tg6PdM+LKBsR02dHgGCJ4Ark0Pba+8HPeEVjNdZQy5wAaD4wRieqdPQhvUO
	 jEquAXjFdxl/hSqO7I2Q9vGWw9aqq8QSG5J3Ms0swUtDOt6i9FHjjygvg6iLDcfWSp
	 QqPzb20U60UIbrig93kg55GNoUqVA9mDBLCyyI24TLi45ei0pwCYSyeUYBX55n5fBA
	 xZCliVVSxxpy+LDuHAzd0MMneAGxkYoLM9J2wSCabteGHCTgnVSBLxP+YpGk3OsXdP
	 io/WUK9KuaPEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE24B380CEF4;
	Thu, 10 Apr 2025 17:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: l2cap: Check encryption key size on incoming
 connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174430503649.3757803.18341078371686083853.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 17:10:36 +0000
References: <20250409085307.635819-1-frederic.danis@collabora.com>
In-Reply-To: <20250409085307.635819-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Apr 2025 10:53:06 +0200 you wrote:
> This is required for passing GAP/SEC/SEM/BI-04-C PTS test case:
>   Security Mode 4 Level 4, Responder - Invalid Encryption Key Size
>   - 128 bit
> 
> This tests the security key with size from 1 to 15 bytes while the
> Security Mode 4 Level 4 requests 16 bytes key size.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: l2cap: Check encryption key size on incoming connection
    https://git.kernel.org/bluetooth/bluetooth-next/c/50c1241e6a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


