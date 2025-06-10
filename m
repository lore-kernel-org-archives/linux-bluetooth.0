Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A912620F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749583200; cv=none; b=j0w9FWOVzy1yK3v6skuSPjBZnDJNpLcmJX85PghRBUNGRYTIPapafFCC05MTMb37qr6SBFd3dERQmkeCtLithYhjBMwAQIpVFnWetq6PfWqiw1UohdKEx1jv1r24VzPs6rLQwcpFrG+sGH0PnJwDpVXPDEmFAefTIO3aR6HsdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749583200; c=relaxed/simple;
	bh=0SFrYdyM9J/D+N9I+ypxgSCtbtLL7OsW/zvkyvDGnSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GcJa6gfTx0pNKkBGlqdo02cS6LjKw79kh6IQzpEa87Yd89NlKf3BsV1MEBumXsGR1VqjlpINqYdLphMPxfhlXVxh14C8gjtBv407n2T6okDZe+qcAZWp0sA3ITs6kiwU6Li+4zmNhWLyBZCI2ioRLKzzL8w9szgr2vFT7YQz1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUn+X4Du; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUn+X4Du"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BCDC4CEED;
	Tue, 10 Jun 2025 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749583199;
	bh=0SFrYdyM9J/D+N9I+ypxgSCtbtLL7OsW/zvkyvDGnSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GUn+X4DuJWPM32mfT7Dc7RDJdzgZHZO9so72jL1nSudPWSrIFp0R0v/QrthVd6/7J
	 qbim7obeCGiFsqQcLZ4bSLqerCCa4tKOIOMiRLc3dJHtmQ5tnrepafCCls/qKD/nEK
	 cH0ODOWfNBcB5tYPfXEJXLpplPOdEwURF4pr8gQ2snnzvD8avIjTfLRIf2DqzVmhOn
	 wHpdJzti/q+s8QJJfpc1tiwte7mvCtvHnQMjuqZILaDNza4sfqPT63Af+8cHCBYycV
	 aCLmv+Fe7F8WLJvHsE5ZJhVYsEFxpMTKneQDLwSFxsd3Tv36anq8wtRiTlc9Z79Fd0
	 Z7E93uW+PqguQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A0039D6540;
	Tue, 10 Jun 2025 19:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix broadcast announcement size
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174958322998.2576109.1517070081696382706.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 19:20:29 +0000
References: <20250610134231.1021846-1-luiz.dentz@gmail.com>
In-Reply-To: <20250610134231.1021846-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Jun 2025 09:42:31 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The advertisement data size of broadcast announcement is always set to
> the maximum rather than the actual size:
> 
> Before:
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix broadcast announcement size
    https://git.kernel.org/bluetooth/bluetooth-next/c/1d800f03516c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


