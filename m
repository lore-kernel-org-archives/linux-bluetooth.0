Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143D2D5C91
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916595; cv=none; b=qfS84Su6jKyB5Dz0hkJhOOBb4jsiBZr/7dSeKCUNeL2OMz6QqhEUyn7aL7UYhP9c5Wc6ZRN1DFWcM8oYnE4GwyZK9xT75+zHfk2OzofZO6GJwzUa2zdI2GoOYNIng45e2xcfrG7Y+OcJJxIv1rb3H7M/m6hu4f3QjvYmylRuJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916595; c=relaxed/simple;
	bh=jzUBs2fZEAzTSSmEq/cFGI7zIdvs3LFV5sCXmZwC9w0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XltrMhMVCjH4kqtrNR4TFUm3kZidyo9HljYvYojQtRuBzynoRkJ2CVeDqm2XSWKXMcMFus6J4htgWCnzLdwSOoTpgfxtV2OgL8lwfYT21+Mh8pCB7gTqUO6bDwJGnzD7rho4wZl4sngGEhRCQuFLVeyDCZx8w7UtYTvF7k83NXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdGGLe/C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdGGLe/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2268DC4CEED;
	Mon, 11 Aug 2025 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754916595;
	bh=jzUBs2fZEAzTSSmEq/cFGI7zIdvs3LFV5sCXmZwC9w0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bdGGLe/Cr2sgGTbX9C5GHCaAgfHDdCAIR9NipL+IGnPiY+T3RoPc43Pl2+vBFrtGe
	 NR9386+ZY35P47xgIupmZYtV10hSrR5tyIsbpD8MIVnb5TViztwhnLuQRwRhcD1K/w
	 4dquW/cunUMLU67aQ3pESOlTPeumhIXJfqFUT3AEDdubfmeMTqgx+ibwGORgOu5z+2
	 jfqnQiDczMy5NzI3LYWUPGURWW3gQg6cRANwskC4ysSrTkfI75khSZqJU74aldB6x0
	 fKp93gx3l6O1/YD3rC0xP8eUQ7JIrmujFSFy5cncl9lfmE5OKTmLWqlQ3FFb1f+CMY
	 wLhOyUDT9cTNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4E383BF51;
	Mon, 11 Aug 2025 12:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] iso-tester: Add ISO Reconnect Send and Receive
 #16
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175491660749.1660461.8669727348218651918.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 12:50:07 +0000
References: <20250808191053.648211-1-luiz.dentz@gmail.com>
In-Reply-To: <20250808191053.648211-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Aug 2025 15:10:53 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds ISO Reconnect Send and Receive #16 which test reconnecting,
> send/receive datas, 16 times to stress test the handling of reconnecting
> logic and confirm tha POLLOUT is generated everytime:
> 
> ISO Reconnect Send and Receive #16 - Success - run
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #16...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #15...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #14...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #13...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #12...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #11...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #10...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #9...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #8...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #7...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #6...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #5...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #4...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #3...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #2...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
>   Reconnecting #1...
>   Connecting to 00:AA:01:01:00:00...
>   Connect 0 in progress
>   Accept client connection with handle 0x0101: 0x00
>   New client connection with handle 0x0101
>   Successfully connected
>   POLLOUT event received
>   Writing 40 bytes of data
>   Receive 40 bytes of data
>   Client received 40 bytes of data
>   Disconnecting...
>   ISO handle 0x0101 disconnected
>   Successfully disconnected
> ISO Reconnect Send and Receive #16 - Success - test passed
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] iso-tester: Add ISO Reconnect Send and Receive #16
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=10977abda3f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


