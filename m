Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8123F36A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775207; cv=none; b=DIUQFdQPNAjI5tRwVSuUFL1qqnjupqr2LeIQsBJMchXOt+KdTnQgFfWyRTt+x6xhuuZsTI5WVucPJwwB+tbQtVKdnj3imUKw9Mhno0C7rm47PD3etuhrkOC61GU3ByD2922BaPIcGbQDwp4n7iKXjVbefESmnkZMYNqGBh33fW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775207; c=relaxed/simple;
	bh=OOw2V4zPx2gRQpODw3V3tcwkeFS0BN3fgmaFvrylOIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=saDRwb9gHSNU6R4u8GEGzI/WCLak0M+ptfR9QrY3RqDqnmNBKqpT9hS+lXwT3z42WGjaIYElEUecUopuXfXt+bqNlkGyHygsNPZl7QJ2UHHxhg8keGCfJOqcytxn3jWm7d1s4TgZ5X84KNhfyk4/jb5lVkIR7G66PxeO+5AjfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV2Wi5c7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV2Wi5c7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE346C4CED6;
	Fri, 28 Feb 2025 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740775207;
	bh=OOw2V4zPx2gRQpODw3V3tcwkeFS0BN3fgmaFvrylOIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aV2Wi5c7GnSaIGK17H88umlyKWyj3j4M/I6izeGJMwuCDlF8cGuOTaUqRr2/NbJ9n
	 kKzcZ0hYzQAHmL6ccfOHQGxDJhikLv7cEXm2/vJOezYLim9ppR0qk3ofhY3TOgoCXO
	 cmgUFF/fcgP8PYybo2Cx93cqlWz7D+kSFqn8JBUupq1mNRjybFKWdamV+Fuma+N+qu
	 Y2tlFf9xanfCtmFrsesMm3civyJvbuJLLCiDUgQhYKyMxDe8x4gAl8HB8w3uNlgn12
	 pfvA+UwM5YIkQJEam0cMll3I8+fJddmidySLL3mpcnbTvjVJkhX87Q1iYEh+1WxGgn
	 poXar6jDeM1gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B92380CFF1;
	Fri, 28 Feb 2025 20:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: Fix not starting released operation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174077523973.2271257.5770553970313621088.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 20:40:39 +0000
References: <20250228171321.3465285-1-luiz.dentz@gmail.com>
In-Reply-To: <20250228171321.3465285-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Feb 2025 12:13:21 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The release operation is intended to release CIS resources:
> 
>   'Releases resources associated with an ASE, immediately decouples the
>   ASE from any previously coupled CIS, and tears down any CIS previously
>   established for the ASE for one or more ASEs.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/bap: Fix not starting released operation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4130fe22fb8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


