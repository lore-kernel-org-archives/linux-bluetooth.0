Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584E175A66
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377418; cv=none; b=nVrgmTgTFbX0H/MIoqI9ZEjJD2i8LBJ4Z5Fec7jpUisRSy7SWEHtfNzZTw3B1wNMRJq2q2KK2MeUQGKWjaLdP/JzAEWXTX0tnJmxjckuCT6JC4xskY6ktCqQf/40efxV3RChlKD+oXvDvZy7eqgGgM+8JzvIlb6JNrSaxaqGHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377418; c=relaxed/simple;
	bh=8QCog0wEOgNNzfZyBsllDlqalskqMei3mOYue11m9F0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t3vRcORa9ZGyWmXZ1rmk9vJSuIXG+f3s60hXa0GYTKT6jEQoL0l5RQKH+Qj1wgmxKLnDV/I5NAjWlvvZqWDf6mzozjv4nrpeGR5Jk4RgDZUQ4m71s8R+grOlMgC4ooi7LWLkHlZDzmVZe8mNspWmD0b2skYl7wIRN8f2f1qFq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCDtdm+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCDtdm+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8101F000E9;
	Thu, 21 May 2026 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377417;
	bh=z1zANa9xePQpc5dxO6gs1c1TJ5eNJjrFI+rWeelPoN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dCDtdm+OPH+76UHbaIjeishTsXua1K/9ZLQKDEnaiRW0jTcWJ4mJY8VZam7Xrq7gi
	 1XyghgCV0LFw0TOeRC9Ti3+MLYjhoAITyRbMejhEKK5m/NL1tcUt6bRjuU7pRB7fQM
	 Ud1PDr4wV5SDQXz4gEG7dom6Qq8eobQB/+th0neowQxhJCvGtUDlYwdkX8TqjmYYgx
	 KaGpRpHC5A7cghdDQ1XkIkDkrSzq1vOSz6dnfq1L62LEYvQBX/6ftDD2cQax07amjE
	 JAez4bbGCf/kgzA0nbfCIP53T0wrzFwdlDUI6gP7yyVGxD4vq2zlSs0a0n+MlDNGNc
	 G5Uz7KoBJ8D7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398C3930E02;
	Thu, 21 May 2026 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: fix chan ref leak in
 l2cap_chan_timeout()
 on !conn
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937742713.384060.6353314036524937573.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:27 +0000
References: <20260521023055.3272712-1-oss@fourdim.xyz>
In-Reply-To: <20260521023055.3272712-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 May 2026 22:30:36 -0400 you wrote:
> __set_chan_timer() takes a l2cap_chan reference via l2cap_chan_hold()
> before scheduling the delayed work.  The normal path in
> l2cap_chan_timeout() drops this reference with l2cap_chan_put() at the
> end, but the early return when chan->conn is NULL skips the put,
> leaking the reference.
> 
> Add the missing l2cap_chan_put() before the early return.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/628669434306

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


