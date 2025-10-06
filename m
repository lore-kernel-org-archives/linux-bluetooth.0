Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436F2D77F7
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Oct 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764018; cv=none; b=NWM04rvCUQMpvqfhljnKfTcoi69O5+ffDz1ctFV2CUpjG4RWB3DcTb9GyZC7X/gCx9jXHaeOUcP7i6gP273Wclof2bCcIXEwcSzSx7BhugHk4j8Z/aLJ9egUAgXbzks/QPHy+Iy8CsSpCzxzjWYRdSmpN2cHif257MVLf3jgj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764018; c=relaxed/simple;
	bh=HUfc+dCZB5OMdcHgfyrVuw0I+GdH/7rbKrXXGn3sAns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HZfnUvVe7uzE6zEmn56KdqIqg22L3GNic5dAWqcNgWrgv0Pp66Fzy7dTJfJl/6MYlldQ3A0L/Ob2qOLyEzX9pIdvvtahMeTOMf22V1oVVLMEvXlnl4SV89jB2huOPPQo63nzCSAi7y80ZeBOhsak7r1fuubTjQUDEiRPqeZTCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJalR50i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJalR50i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744A9C4CEF5;
	Mon,  6 Oct 2025 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759764016;
	bh=HUfc+dCZB5OMdcHgfyrVuw0I+GdH/7rbKrXXGn3sAns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJalR50iNLpMm2rZx+yA5RJb88ooip8/yVyR8CGl7IpCu410Sg4LcTnnakZ+jox0i
	 I6zc6AjsqGQbQGTQsLD3JwP6XFcw3Ssfe8AbHKn5Bx9Q3FRVJdAhDxk/ZvedKIE3L1
	 DPEw0lF2x7/hec3UUIHZwOIYK0kpi2a0uFUhUg9j7lC2QekQK304bT7JPkCiIp+I3K
	 FpuGbK8plr9wqF0Xg6dhan7YS9m9YInzitoCx9bURX+3oLSL1lKnR6aZW+Rnm9PgT0
	 ykQZhKrlSpbsWbR5oiXWTW0OJQoH+mZ9g8FAiAO4elLLW7+67OM36vb5lu0D3CqK1G
	 TFtJ0QehggRTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F9A39D0C1A;
	Mon,  6 Oct 2025 15:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "Bluetooth: L2CAP: convert timeouts to
 secs_to_jiffies()"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175976400624.1408757.15464847653644285909.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 15:20:06 +0000
References: <20251006083544.22408-1-frederic.danis@collabora.com>
In-Reply-To: <20251006083544.22408-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Oct 2025 10:35:44 +0200 you wrote:
> This reverts commit c9d84da18d1e0d28a7e16ca6df8e6d47570501d4. It
> replaces in L2CAP calls to msecs_to_jiffies() to secs_to_jiffies()
> and updates the constants accordingly. But the constants are also
> used in LCAP Configure Request and L2CAP Configure Response which
> expect values in milliseconds.
> This may prevent correct usage of L2CAP channel.
> 
> [...]

Here is the summary with links:
  - Revert "Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()"
    https://git.kernel.org/bluetooth/bluetooth-next/c/014b7133fa7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


