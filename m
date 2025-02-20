Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B5215175
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075009; cv=none; b=pa+diGzi0SwNpe7KcukQ3w8zQ0OGk014qJQNFX4gwUF8mFRgB76tCz6V/hPSrM9jL4wovOtrTiumNpIqOV9TJKwbzQC7AivDVDJ8JZ3GzgEJCTTTukYc10jXh/BfG9pc9PEeoOiKEWF2Dw969NG5/MXajvKiaATX7XTMPjJBTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075009; c=relaxed/simple;
	bh=mpPwrQxOjmsG5g8opPXukX7eM4KLzBjByPzkEKGqQt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hCUFtqRagQcLLinYLhVqab5tUw7SRzs1H/Aukj+2h5zv+WLoKH8jAZk8prZ+19Nr+bO8KIi6JiAkU/8oWUapUQ1kbcgmewMOchx59+9NAM8/DE1ch+2vQMR01QTCWmMYT/+a2Q0lrYjRNR67WTECIY/qektTtgFH2b3s5i1GVC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUANe43j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUANe43j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77759C4CEE2;
	Thu, 20 Feb 2025 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075008;
	bh=mpPwrQxOjmsG5g8opPXukX7eM4KLzBjByPzkEKGqQt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pUANe43jauSyAzg+YGFJPQUbCNMZvYbuGhXu/RfP1pJC5d+ZHxZqCQAGwBMoSKGzz
	 +VaJOLlIADnWMveQ422AQzRRb8GH8TfkNsc6Uag8DnEkszvkOMfZJ3Ea+9gH2XrJT1
	 Q9FW69NuFp2vTC+JzygQH9Kuiwv440AnR/MssYvVMDj4pJCImPNWAMRnaIqDLGi6lY
	 t3M0bsn0kbXxB4WsxAnMFv7y+Gwv/q2LrxgqZ1Ri5lyphNJu23fVZMHR5EwWmCeQII
	 /hAQrgO87BF+oUMFii6UbG8Q9DIjuhBuoaqCU2D7m/pRsPcBLLZF4XMj8ZDTdxVI2H
	 TI1aA6VY9yIYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C42380CEE2;
	Thu, 20 Feb 2025 18:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_core: Enable buffer flow control for
 SCO/eSCO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174007503906.1411319.12985847420380246592.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 18:10:39 +0000
References: <20250218214344.1519862-1-luiz.dentz@gmail.com>
In-Reply-To: <20250218214344.1519862-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Feb 2025 16:43:44 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables buffer flow controler for SCO/eSCO which apparently for
> some reason has not been in use up until now which caused sco_cnt to
> never be updated, but recently this has caused the following problem:
> 
> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > HCI Event: Command Complete (0x0e) plen 11
>       Read Buffer Size (0x04|0x0005) ncmd 1
>         Status: Success (0x00)
>         ACL MTU: 1021 ACL max packet: 5
>         SCO MTU: 240  SCO max packet: 8
> ...
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > HCI Event: Hardware Error (0x10) plen 1
>         Code: 0x0a
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
    https://git.kernel.org/bluetooth/bluetooth-next/c/eaaf44d2e680

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


