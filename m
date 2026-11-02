Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658017;
	b=rGZYG4lkJoSbOM7ja+nEsBalWuRvF1uUqTw06xZFhLv9YuAwaBew63FnAjOKElIrDA9w
	 rn2grHGl+ms4nNn4tDtQwYNJKgGsqwB2lxXkXLMk4IPTtlRR2xVlgBu1Msy4yfUqzvDlE
	 Tfat3+i0CYSmJ57qE9M0HorQlaoBIQ2ltEFSu5iDT6CxxFWzGN1tlyyBykk8pWhIb2V4S
	 of1bsrqRSWaxFG3TFZm+Jer1sGFfuTihn4ybr2N6zaMHmyfL3Uctf6QPKPnPk/VBee+f/
	 yOuJW5b18mZ3UPT3YxCut+O4csex9nwJGB50IV5jxVslziRY6KKWjVQJRjbv3c6RX3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658017;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=x2TEtBHnD88O2fic8L/tUUMf9f9U9t/ddgJN1D41BIY=;
	b=XOom+4PALhCQV/Kd9kL8V0iK83rMEKZEeMrQGF6Rp8QLxvHG0xIhUO3QadNlPTa1Myyl
	 Q7B9Dx7hTiWmZ32dfHJMHbeFk+z2NYDzIgqlCOJOxZRf82axrW6fjC7CJ3ynDBn91ajML
	 XRws5/9Tkie/swGCETcJiZLg0Lqk+Xz5CWRHQwT9pQj8unjjKj6cSmzJvzCOUgbidV2dZ
	 GchqOlSbe7xO1eEdTVTTdJ5OpNwINoEnSnUKwVBX04/NZY7iyP6J5suSXZ+rgTXZoFqOr
	 QCgSWlSzqIRktlFELMmoV8fqpFzdpHYMZ7KJeyzEOL2l3nQUY1Pt9Dh0EThyj13T76Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYqG1Abl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA057606A326;
	Mon,  2 Nov 2026 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LYqG1Abl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876271F00A16;
	Mon,  2 Nov 2026 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793658016;
	bh=x2TEtBHnD88O2fic8L/tUUMf9f9U9t/ddgJN1D41BIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LYqG1AblMkRp8mEv2PbVEpPP/EMaq+C3/RZUoVJh/cd/PxWlxjRGpAmO3AWnOVyMQ
	 Rfn+osHM3gunove+/hwZFTDrC+NW1hZX4yAYE8FH7Nd0NhtB+PApxoaUoSTqB0EcQj
	 XwattIKSr7He56UbOxgmt59PYtbh15k5YmyZfZxtFMShEFQDzKxZE5KwlNbQAj6x+i
	 kpK/5NlMBXcloJpzG3mBM0bfHzQu3GjCeeytjyo47LiVa4S6uxgUxQ8Vvr3nMkK7Lz
	 wrOTL3kRfQwFnTKDRsTWaYfFZFNZrHGfpNRDmNf+Ht4LIkUOCR+AaAhhi/nnhNZ9NW
	 T/pAQHJk7HHdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D375380821F;
	Mon,  2 Nov 2026 22:20:16 +0000 (UTC)
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
Subject: Re: [PATCH 0/2] Bluetooth: validate retained LE ISO command lengths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179365801530.694758.3065073336478186790.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 22:20:15 +0000
References: <179362071770.29269.15160948500453012976@stu.pku.edu.cn>
In-Reply-To: <179362071770.29269.15160948500453012976@stu.pku.edu.cn>
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, pav@iki.fi, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 02 Nov 2026 19:58:37 +0800 you wrote:
> Two LE ISO event handlers use flexible-array data from the retained command
> skb without checking how much command data is present.  A malformed command
> can therefore make either handler read beyond the skb when the controller
> returns its status or completion event.
> 
> Add a saved-command helper that also returns the parameter length, then
> use it to validate LE Create CIS and LE Set CIG Parameters commands before
> their CIS arrays are accessed.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: validate retained LE Create CIS command length
    https://git.kernel.org/bluetooth/bluetooth-next/c/1eb52f35fc8f
  - [2/2] Bluetooth: validate retained LE Set CIG Parameters command length
    https://git.kernel.org/bluetooth/bluetooth-next/c/ed4d302af778

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


