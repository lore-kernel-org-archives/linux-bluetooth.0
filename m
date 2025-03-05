Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190E256C9A
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208400; cv=none; b=cFd3eEPhfW7vPNuAlGpaHz7H5OSLTE08hdR9ohfbYzoYw3i9NmXs0TPy42LKUuFrUGI8F3nNGACYD8qW+dxBcrv7bGBXKApHK/oOuJv55a490JIvr0sO+FLRmDafbSkVUrZIdtbklLJA16B0ZYtHCH/hL8imnwjFMhU0x+nINw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208400; c=relaxed/simple;
	bh=G6pZNkM9/9dp44/tM4w58bEZftYkopxuPzb0j6ZpiOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cxBqPOdHSGQaT4u+mgABcIAd8ZnItlfLNDK10W8SyMYp3kZck2NTjwKaxDEJSZMR7fAPSsLtkXQgWRRJazi0qW/Zq5gbuckbX6vtVdL3J8n/+h7sfGy2ld/wppDNdhreKAkp//b9TxF+S3GlSu8GxiLSqAvLyjUI6gePZsR7WA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcXWr3u5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcXWr3u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97194C4CED1;
	Wed,  5 Mar 2025 20:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741208399;
	bh=G6pZNkM9/9dp44/tM4w58bEZftYkopxuPzb0j6ZpiOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AcXWr3u58FKbXnIuVlnSW9z3gSQqL0L/iwSRgPeX1Z05+LsTzFzOkSqOn1uz5Cpq9
	 dCgNYAQ9Jb5KQGY9fLQwbjPP+vJ5mSyX0eHA2NYI//QIBaDBE6/7dSz6i0+NYSii2r
	 gQmbeseAtkxpmOJ7hR9lzNGdDpxmUFiY8FM8OiQvf5IBIYT4BZey4ypF47QUqoOL6f
	 X+vrw/2V9s2jMfTZR02RvB8Zh5foMKxu5Ppmorby7YKD+5udXHW9+NAtsKRN+4otE4
	 Sh0rBY9bpBG2X0B4sdI1OgqyYOy+iuyr0n5GbFJf9g7GucCGuj3IHW1xc1Yj4AioZ+
	 lu/H+dwYf6WRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB27D380CEDD;
	Wed,  5 Mar 2025 21:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Revert "Bluetooth: hci_core: Fix sleeping function called
 from invalid context"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174120843277.1022404.14036397392528307493.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 21:00:32 +0000
References: <20250304153934.112156-1-luiz.dentz@gmail.com>
In-Reply-To: <20250304153934.112156-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Mar 2025 10:39:34 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This reverts commit 4d94f05558271654670d18c26c912da0c1c15549 which has
> problems (see [1]) and is no longer needed since 581dd2dc168f
> ("Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating")
> has reworked the code where the original bug has been found.
> 
> [...]

Here is the summary with links:
  - [v1] Revert "Bluetooth: hci_core: Fix sleeping function called from invalid context"
    https://git.kernel.org/bluetooth/bluetooth-next/c/8da76b2ac810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


