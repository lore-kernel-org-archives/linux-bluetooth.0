Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851423;
	b=BkfWIc80aEGED0vgticz3mB/foqrIJ0uBazJlpWtzm2C9HTLJItBeZGIzyqHxxpIZW9B
	 +n/WRY47IO9mnuhqI/RgM1Mk9VqtWv72QI3BZphr7FpRoLKGWFUUv9dVhEv2dwNVcfBkl
	 nvpaJ1ZXus+uTac6xlroKELGATZTG+NyvWwMwQTKOUR1SBAq00BOLsc+bV5yi7wbQqlyS
	 KsdLXtSdOOa/fQM9mYonOWUKMWe18P9DlwhuhYf45o9s5HWEk0tyLHVNFWb6w0KHurKI4
	 uXGcrzcdy7vxuvNqWxdGJ0hbWcXw9fK+kWu4CazEblZ2dJNd16C5BkczQeP4slxhUIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851423;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1UURXOj1ASz3Ntn7tL3qkzvOG6AMvDC59WLDyfCN2gk=;
	b=Q5O0ynfPuOcFK8SHmb7lZjFvqo/K/RGuY90bpKo5yuC8Gb5vgHy5eaVTqwh3SRwIxEg8
	 vWnKkKBYD2Xn9QVx/p0nwTFdbO8RZwV9VGXu8bC9rDtHUvR3Aku86OtgSLirmoaJk/oui
	 SUV3XbYbDhIXFUQRJY3WC6ASx9hasTOJ2KLajOX4iTP8g0SODxa6KoGCSemX4fq1OI1qR
	 iXHrUvP9h8JUt6xazpucichT5lq4JDZerXiWnR+vqlZVG1LXctB9IYnMoL49rbJjFiAWF
	 ucZ6/7g50pa0rkJ1n1bZdjbok7WB6cNJYCu5aNWIjiIl1MYPTncVM73eTgKQTpVPSHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCH7QLis;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CC606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCH7QLis
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091511F000C4;
	Mon, 16 Nov 2026 17:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851423;
	bh=1UURXOj1ASz3Ntn7tL3qkzvOG6AMvDC59WLDyfCN2gk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QCH7QLis6lcGeAOq7gZxexW5XGKc5v3oAZhg10kv+fUVTOVQuYUqXD8hVQSBsAIoh
	 TqRzRjJzchX4PG8tIty3OGxVMmC7AbTOzJMDMcA/16eFBd6sXFssU4srLZuj/96ovW
	 dLBq66HEcsPT225rBWLeEPQNOh71tWGk8ma34fK0GWCYIjfpc6jopf3ACSUshQ/eHP
	 YTzOmrC5SxS9jhCEaMUvmA8bpsFP6iaSF3WJ4sC7AbyWQabiqlnEO0evhtXKUNJAfU
	 i3wiYxiSUASUApgM3G5X54PovDVEDU3PoX3CjU5HmjUO+dUcNNL5eLBjAd/xcW5nBL
	 Z1BYUOC/whwVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F155E391AFAF;
	Mon, 16 Nov 2026 17:50:22 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v1 4/8] transport: Don't hand the owner over while
 releasing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485142167.3796096.4868983132472691625.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:21 +0000
References: 
 <08b31b48642208e419dc10f83f6fad0712ad0579.1794349049.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <08b31b48642208e419dc10f83f6fad0712ad0579.1794349049.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Nov 2026 17:19:13 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> As a server, handing the owner over to a link still streaming also
> happened when the audio server released the transport. Release sets the
> transport to suspending before disabling its ASE, and disabling a Sink
> ASE reaches the handover synchronously, before the request of Release
> is installed. The handover cleared the owner of the transport, so the
> removal of the owner by Release did nothing, and the link, which kept
> the owner, was left owned and never moved to idle:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,4/8] transport: Don't hand the owner over while releasing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=578b16afd93c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


