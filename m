Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461012;
	b=IP7OF/OH8XCnktKoYerlrjcM6iHT1Ab5Tg839lRN/KrWEJmcfgJ94ALmkvQy2kKxAlIj
	 /g2g5yooMyPnxWaZK/AQHWb0YIRKVJ0KJ8rgU272xNGorEAFxjM175bm8LGMcLZGueq2F
	 wSaxVIR1TL2zS4suu0NqcVyIfstbbxsJCIr8q5uy80asXy3vtou+QVxYWX3FqI+D5hvHp
	 9SAJbT93zSCly5tfW7XjibKOMFSjPZ5gpWZeKtBszndfdAIPviN0HwIUISyDzvMzI6pEv
	 5LpfjZmS6+bQYjTLRDpji+idOtfhC6B5mkGoQknhWjeHlOtvlf1TOKg20GHGFdLcnPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3dFdAOJw6LgKjKdtdO9qeTBR8PDXj1lmZyWllPmEF4Q=;
	b=5hsrLCqsU+G22+tWWOEvAEYuRT5JV3t+u9O2TPMaXTG850tWNfsC30+E8clvm5Rr1hoq
	 Q7Q4eH9AEr10RxGiE8H2mASR0noTVsCN94yTYJoH1waLtq94kqCngqvQ+LoOpiBpUAcKi
	 MSKkYgYHrn1Oak94DPzQBaJ5+QrSPRniGgxFIMjYpXYBr7pWiW/Q2cM+R2RrN6OrlqDBN
	 fhEuySBCCCv7RBnWY/ZDYbPw9Bh52YBzajBI6+x3RTURiiP/K8srKtCigwoa08pOZT43g
	 hJw3yQuReqGzhhZuqXsBn/xkdsQSUtBGeorkaS7QhRt2Q7B6ATRsglbOtIK/AsCjFLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GimilVR8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAE606A331
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GimilVR8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446F71F00A19;
	Mon, 23 Nov 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461012;
	bh=3dFdAOJw6LgKjKdtdO9qeTBR8PDXj1lmZyWllPmEF4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GimilVR8L4ZuCJMhBHqz5FYU13+ed9QCO+2cTkD30XO865RpxsVDYgdJ6EmbT6V4J
	 dmoLG5JdZAYRwsADG6YdTxq/cKIHgpaN4/O5nS9RZouoFrqCpsVGibivW8pVHJKbxV
	 6nUap04izClYnNXlf0yf8MEOBk6Fi1cM9Nkv7oAc+WQHGZABPQZGS3u+0nHXHCfwFM
	 iYIT9lG/J4JhCUAwJ2Rs72V9Lihb8HrG232A3K90xUf6lQhhAC3rFFVFJfcgIXypl1
	 2vKVQPXqxY1eioZjSr0+geAsaxRtARTUNcuVvkEtxZgTQcs6xW+ttF2LwL5WSm0LE5
	 B8e6F+MT7lcbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2D8392EE35;
	Mon, 23 Nov 2026 19:10:12 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_sync: Write the default page timeout to
 the
 controller
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546101076.3063022.1483348650610357584.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:10 +0000
References: <20261122153450.1532145-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122153450.1532145-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 16:34:50 +0100 you wrote:
> MGMT Set Default System Configuration takes a page timeout (0x0007),
> and Read Default System Configuration reports it back, but nothing
> sends it to the controller: HCI_OP_WRITE_PG_TIMEOUT is defined and
> never used. BlueZ's PageTimeout in main.conf therefore has no effect,
> and the controller pages for its default 5.12 s. A page sent without a
> clock offset can need longer than that, so connecting to a device fails
> with a page timeout that a longer setting was meant to avoid.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Write the default page timeout to the controller
    https://git.kernel.org/bluetooth/bluetooth-next/c/807f90650d22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


