Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851419;
	b=JclwsykTIqTTWbEdZ+FuqcSEcXcN2YvrlvaQPPHuhVo5+KpHJFPJY1crOgG1p1IycY5Q
	 JcbyaZzWjgMdqREKnBYqyw7KqU8SFyI3C7z3KJjcnxoCWZbLaqs1VH7SBGJSkIaYQue01
	 g0H1o0guHFxTmPfgZh63UXynuG5NuLASAj9f60Q7forgd2JbxpXnp8eOBax5Dpt6N5Q9f
	 6J700lVGZ0fNU+SsNmHV1y3Gk1YqOHQkhSn2f/gMsJnDfdzy14p3yFJNLer1EAFuH7Q3U
	 qFfexRLlwzOvd/VX3KDda9a5+59GLKo3WMaPq8cm4Y9Fx+OPU5JNungRCDRPr4oDN5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851419;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0e4Czq5kKdVxSbA0ahWMoZS0g17+YU3eBRHgABMNESc=;
	b=sLmXh3jD9dnjopU4g361GdVS0Nexvdi4+n16X0PIulzR0vIYDZonNTIFZua6MbpYwfLe
	 qjT2nCtqUdZeSQzI/AIPc6U7A068MZZwXl7o6XBKZN3gB9Bd8yiu1dZLENDxBI1igEhN7
	 GLRCBG/rK2ZiRWVXOdrEh7nQY33BKIR5l6XXTkzBZ1HW4rAZ+AaJRIxqDgAUDjfGmonZH
	 0if4Nhd0tOYIYCbnn+K5OkATNMqfopMKpPX/czm1cNVbb79iOQusvzOHNcRQZ5OCyzoWn
	 cvFQbKiQ/LrmUqRrp6/M2A+bsHMwMa75dzmQotSM0bTVtdJKX74vA1mOnPf9ixN6u5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpTSXD+Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE80606A331
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpTSXD+Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8771F000C4;
	Mon, 16 Nov 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851418;
	bh=0e4Czq5kKdVxSbA0ahWMoZS0g17+YU3eBRHgABMNESc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dpTSXD+YSYGS5BlZk6R4xukix26/TCTuNKSXHHjBA3llP4BfOs7Hb0N+t2fjc9hvW
	 Zmw2x6I8cBUPWqPK+nXYCl8n5LzkHK/p1Un6SnNPl2LYortfBPaHdrGbU1A5VsXNSm
	 cuTw9GyY7X9w+Flcls8n2Gx3fuJILzTAFEQ49W3xyCIsRjrBWJTT9ZruDZ9NrzfOzd
	 EuVyBIbDnlPDIBgmecS4kXBhZPX3N8CnKamsFAotoD5GMpCpJEO5nfDG7TbV3wN48j
	 tV5dpDnX7jKIhNNfPqs6b01I6WGZoxl122OcWctgNFPDbvVDVJZ9iRyOw19yEm172A
	 T20+Se50dL1rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43F5391AFAF;
	Mon, 16 Nov 2026 17:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 2/8] unit/test-bap: Add test for disabling one
 ASE of
 a shared CIS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485141727.3796096.1737586946533361372.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:17 +0000
References: 
 <3eeb1d44306e1c3833788460706ae2fc9803f4ad.1794414122.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <3eeb1d44306e1c3833788460706ae2fc9803f4ad.1794414122.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 11:25:25 -0500 you wrote:
> From: Kannan J <kannan.j@intel.com>
> 
> Configure a Sink and a Source ASE for the same CIS and have both
> streaming over it, then disable and stop only the Source ASE, as when
> a call ends while media keeps playing. Once the Source ASE is back to
> QoS Configured, the Sink ASE has to still be linked to it and streaming
> over the same CIS, which has to stay connected.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e38984593c78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


