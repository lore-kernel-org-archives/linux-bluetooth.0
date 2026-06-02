Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE73890F9
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420804; cv=none; b=DqU4dBKbtLdLMGtl3t6/wHSzf1FI0/m/Yf306vi+WzxlKCpbcVAb00iNpjjuf55eXAbQYloSApABonyXEtqQWUuPZaj2F/uO7WFT4xfEk9uMpkvfqF6dYUq4jl1sD8F984cofOW4GRhEvNQifTcY+dWSdGERYP7ZT8rD/EFVDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420804; c=relaxed/simple;
	bh=12WABPcS8wb7HNUTpjrDE+GTqnqCQau2p1Q2SHKg16g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P7y2DmeoldHgGjSflC/IOXJjZeDGS2XKZDffKPYOC2L2RZLDdqrfPGbwPSpe4KnIp9j9lzpzfeYY7tR36nQYPRIwFdhlhK9QHuPpH1q/0PFb7y5Un+IumXvFLtYmCKKGzak7yIk1diDLPyMN6tvobYziFgpioWTaf58vq9RCjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0OkUlUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0OkUlUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721731F00893;
	Tue,  2 Jun 2026 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420803;
	bh=Ngfoqq1mmdnPTvKdTgnLz0x1Ql4fw2a6a6NdleEuaNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P0OkUlUewE8Z9Quel3USUHDSxK9VjsLgBDZpIGImSViDSuQisKuXCH/kZTMi0m+OI
	 +2waJ03gfsWMnCQr2m4zo62CPVVLucSPkf1msztw16+jAPxbXoh7yhWSmOp7UAlK7n
	 yAD50dnKohHHG7QipUrn6l32BoXSjM8NH16w9IO9Z92VOZFHXneGbjQeP/+PlWcP8N
	 kswu0kUiuvzJNfFIi8KZ+FSJZQRE/9R5yM1x9oeyLI/zWBPz8W83WAJ6yuOlRIlBgf
	 nTU4gQvolsSpSk0qEztNN+gSPH9T9Uw3rBu50MQKozo32oOBFS/brKXnktE+q+J0RU
	 guh8E1J2ZHXng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BB3811A69;
	Tue,  2 Jun 2026 17:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: ISO: Fix not releasing hdev reference
 on
 iso_conn_big_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178042080516.965718.5337358505754203460.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 17:20:05 +0000
References: <20260601204157.13923-1-luiz.dentz@gmail.com>
In-Reply-To: <20260601204157.13923-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Jun 2026 16:41:56 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> hci_get_route() returns a reference-counted hci_dev pointer via
> hci_dev_hold(). The function exits normally or with an error without ever
> releasing it.
> 
> Fixes: 07a9342b94a9 ("Bluetooth: ISO: Send BIG Create Sync via hci_sync")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/59e3efb116d4
  - [v2,2/2] Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer
    https://git.kernel.org/bluetooth/bluetooth-next/c/e13696f42ec9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


