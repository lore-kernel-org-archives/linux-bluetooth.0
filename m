Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FC20C48D
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878218; cv=none; b=WP6IqSTDfB+EhW28fMmtiJp2KrvJKLL9abtXym4+mJjw1JeFgI9XsMnJeU6Iwfa0cPd6vzHhcuj/udemCodxk0Ge7bA/QwJ9OwUC4ZOaHscB2m0zG6Ayhfih2L0hXD+P0wRaS4RQxuQa5eTSqXvhIFDwe3vlOEGyot+Gw+GwbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878218; c=relaxed/simple;
	bh=k85eXpU7A1Ol83ih7cuFUWOBMfhwLa2wuo2SWr92z3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fqjPlomYU5Vs1pFveCUH5svsvZXBHdUwndbloiKvb2fhnpzNxeRvNt0I2hS1mxJltfeRe8IT/N5KL06RJlOdCKWHlEoIkwD579FUcQXPsaGYxrN0zdl13cQgWHlYbrylh/jRe1iw1vl7ZNUTW5GGczMtUmX512SKD8C69PKmTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwB8fGIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwB8fGIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4507C4CEDD;
	Tue, 14 Jan 2025 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736878216;
	bh=k85eXpU7A1Ol83ih7cuFUWOBMfhwLa2wuo2SWr92z3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YwB8fGIrKXoHcmrzLTzum205tB5kiIqjq3NtXOIsav6yS1DK5cNqD+/J3MZtJMIA3
	 aeFeF+i9UC3Isy3EbzqYzu3it0x312yYPgMRgf3VQYnDkEZh4Wzm8hinBFYdR0cywL
	 I2cajmFDuCoq/5VLmUYwnNUlGdmIPFHxQM5M0SCL0g8xctHXKwrWRxPOTWygA2Lp3k
	 PpYVYjoogMuElDf6S3d4IpPHmO3xDrQyKupZ0NCqRQVuIl9AUA7sFaof0gM/94q0cd
	 8az6TPuC1IYmfPIpY4U6OYyRrYykZ/dnj9YK4qvppHi+yf7sR9iBcryEUVWQCQxnSq
	 tnINTTpzM4uEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1A2380AA5F;
	Tue, 14 Jan 2025 18:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix slab-use-after-free Read in
 mgmt_remove_adv_monitor_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173687823926.85489.12783213311973563336.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 18:10:39 +0000
References: <20250114174532.3263274-1-luiz.dentz@gmail.com>
In-Reply-To: <20250114174532.3263274-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Jan 2025 12:45:32 -0500 you wrote:
> From: Mazin Al Haddad <mazin@getstate.dev>
> 
> This fixes the following crash:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
> Read of size 8 at addr ffff88814128f898 by task kworker/u9:4/5961
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/1f2ae3fb1cdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


