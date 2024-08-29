Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C971B1512
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947229; cv=none; b=HrpZtdLePESuLVsO08O2CofZQXp8aSpiEadhk8VsATAQgbse3DLd8ui2hZSZO0+6+StP4KEfh1w9DAoXY9xYacpjrZQ5s1hYqn/RJaYGA82aeYs7sjk5hlM64ERn/zOLwoJhAVLCsBywOFAbiBrWaYkfeSf8OUkDHCOBknqo9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947229; c=relaxed/simple;
	bh=o4oYoW0nQoK0CdDgKJX9zO9evUQsVEAbTkTV/u9+nSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s5XRBNFVEjp4gk38UDIZemV38LZgVDoCpfk6fM0rTJg3Fc2I6pDXua031yjfGTnLyWDMNIE+0CQc3HkQIEryVMS0fKgMnbFE6sWheR+MfbOkiATr/BdtH3NyFwBvayA5xWs1N2QuaBgiylg3ureXXRUc3N5i+ZRmXcHW3fjWCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqfNSy7s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqfNSy7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A618C4CEC2;
	Thu, 29 Aug 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947229;
	bh=o4oYoW0nQoK0CdDgKJX9zO9evUQsVEAbTkTV/u9+nSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KqfNSy7sZkB3kgxdvKHjvfimNdbektJLU2ESzNEUUsalE7w1xiJhYEYJIrhf8tJUM
	 WUvFb2CihvkVF6qCfkUAv2O3m0twWVAkO+PDNMpx+IYHuRsuMMbEhbKO+HOX/nP03v
	 3xR8Dgc4u8rzYL9b8MKPC0U3/it/Gfe6YcXbXAPuiWPMtJbk1aH7ko+bnqEfGluvUc
	 ctu6Ukfb5ZrMY9JWDIfpB6RXGn99bCZIF4VhPc0UyTUWm+mcDBwAkB//PPPXA9V/dj
	 CICYOBsSMz6PmDWoNs+6MVcx/3UAu70Xn7Jo79sgAYsAbmPUVg4qaMOd+/O2BBPZMC
	 qgZZtHKxgdgLg==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6EDCD3822D6B;
	Thu, 29 Aug 2024 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Revert "Bluetooth: MGMT/SMP: Fix address type when
 using SMP over BREDR/LE"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172494723043.2004244.8894234300227929231.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 16:00:30 +0000
References: <20240828181051.876598-1-luiz.dentz@gmail.com>
In-Reply-To: <20240828181051.876598-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Aug 2024 14:10:50 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This reverts commit 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 which
> breaks compatibility with commands like:
> 
> bluetoothd[46328]: @ MGMT Command: Load.. (0x0013) plen 74  {0x0001} [hci0]
>         Keys: 2
>         BR/EDR Address: C0:DC:DA:A5:E5:47 (Samsung Electronics Co.,Ltd)
>         Key type: Authenticated key from P-256 (0x03)
>         Central: 0x00
>         Encryption size: 16
>         Diversifier[2]: 0000
>         Randomizer[8]: 0000000000000000
>         Key[16]: 6ed96089bd9765be2f2c971b0b95f624
>         LE Address: D7:2A:DE:1E:73:A2 (Static)
>         Key type: Unauthenticated key from P-256 (0x02)
>         Central: 0x00
>         Encryption size: 16
>         Diversifier[2]: 0000
>         Randomizer[8]: 0000000000000000
>         Key[16]: 87dd2546ededda380ffcdc0a8faa4597
> @ MGMT Event: Command Status (0x0002) plen 3                {0x0001} [hci0]
>       Load Long Term Keys (0x0013)
>         Status: Invalid Parameters (0x0d)
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
    https://git.kernel.org/bluetooth/bluetooth-next/c/4e76e85acacd
  - [v2,2/2] Bluetooth: MGMT: Ignore keys being loaded with invalid type
    https://git.kernel.org/bluetooth/bluetooth-next/c/c858dc985d70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


