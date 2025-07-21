Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8AA2D9790
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105189; cv=none; b=GL6Q5blXzEIB5wcYwXi509PHCAXZNhI753W91UeQ7khNp3rJpYhz7SARuMk5yPwzqJOakbcPJ66ZVuRqjBaT2ztdjDApqyhQOGSx1iUcKGs2fYarC/N6eh9Qq8Ty55vq9sX/MUZy0wxWNb5QaEvYgOblyRzruq4j9RWa6hhrEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105189; c=relaxed/simple;
	bh=GG3ykHM7Mt/BkPsiYPIG6gTeWbY0Mhmtubb+kWu/T80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Afs2YlNjisxSeyvhDxUwvuBzpo5ayIo7FpDUnf813pjTXNMv5fKaoZqhPlN4qRNFpN0ISMh6ShqRNFM52F6ywJnjgV2QBEg2tIsfhaenOJZ/BvYZYkUIVh/LL38M36fR7r0Nji3gugMxt+aimKC2uZOMec3fNp9Df5GQ9lSxd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZmsxw8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZmsxw8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE67C4CEF6;
	Mon, 21 Jul 2025 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753105188;
	bh=GG3ykHM7Mt/BkPsiYPIG6gTeWbY0Mhmtubb+kWu/T80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rZmsxw8BiPVZgyIPCm5/WeDxdbu80Ffl+Mt4dnyXyiiPq7hkCj60szRh6pFjbXkye
	 oAGumK2bANJ8b48znnRzhcu3gSK6V3x4O/coZB25vFXoFayDiKGG7fcKS3DRkLrK3Z
	 GO1PMl1NuajtWCIVqRJvvnhH7ivgLdXhEbKOExIv9AgU5Ftypj1MmosG6N+2oQlqMr
	 o2fFvzVI9mU1NYP1bMi1GtvKU/59DduFDJn4RjdSDzvu3yjUYEUM1QJ20fK0nfL0lr
	 XcGKcs4RYYZgM829czNQBzP0ud44dQPaBGQNsoKoasOPqw6MaOTlKLMyu+zHmN69xG
	 1F1+S/V5hPaxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0A383BF5D;
	Mon, 21 Jul 2025 13:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive
 interrupt
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175310520782.52701.10009254792730458350.git-patchwork-notify@kernel.org>
Date: Mon, 21 Jul 2025 13:40:07 +0000
References: <20250721094437.1163753-1-kiran.k@intel.com>
In-Reply-To: <20250721094437.1163753-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 aluvala.sai.teja@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Jul 2025 15:14:36 +0530 you wrote:
> The firmware raises an alive interrupt upon receiving the HCI_RESET or
> BTINTEL_HCI_OP_RESET (Intel reset - 0xfc01) command. This change fixes
> the driver to properly wait for the alive interrupt to avoid driver
> sending commands to firmware before it is ready to process.
> 
> For details on the handshake between the driver and firmware, refer to
> commit 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between
> driver and firmware").
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: btintel_pcie: Make driver wait for alive interrupt
    https://git.kernel.org/bluetooth/bluetooth-next/c/3bf15df70a10
  - [v3,2/2] Bluetooth: btintel_pcie: Fix Alive Context State Handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/b4e417d5d32c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


