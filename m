Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658020;
	b=ArFUj9WADH5KBewxVK2nWDtiylW5zxz/9NlYkZ1JtN/nI22R8m+lGN7R6Q1D32isRpfR
	 crJgEq+zJk4/r0NrjvSwDpV7kE+9yZsPZYYUriiugK7YZP4ChcVMztL3Dy5R3cHaH/rBX
	 eDkvnkMK+wZbKspPy+tLGrg5jGQmu8NyRuUuS0NNDYTY1J1G9oCnSeHCC7X4Ke/OgDUdb
	 SxO8YG7FrWpFeeALvQ3XrRXkmpBqr/fmYKPrhZcyr3cgfKWqeXpIIJ+9m3R8n3kB+Fu/o
	 BcuZAzuJO+xF+jHQt86ztMFjHl/Gzw2RuHhcqd5NRYxLh5Lm/cbgkXY7D4GbFZz5/UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658020;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BMRhEfkrJ9jcifhfiPRu+qK8RujFhLdNVfi0Q7x06OY=;
	b=ouvY4ZJaGlzvTvJW4PNwkmvgJqggSIkqgF0z/tTUR4Byr3zqmn2xBYk6T5HWu3/d3IUV
	 ScjNqKgKXOJ5eu87asTM25BfVBzNUHG/P75QT4Rws4UbvQCcDkPqDiyNDg66duuXWCZWQ
	 26Y9mmH/G8vgkwKDyB4TamRQOuUgG/3ri2IR3RLDjC6pa1hZs9B0bFbC32OZDENSBtYW3
	 OAqsLWjj8WcgRUEKHJoZlw4howgTdwR2cqvpxSjZovKXpaxfoXOEAXT2s0N8aJ7lbXUUo
	 Pl4tPnJ6m7u/yWiCWIPkemdfypsSySO13klBRrEHQp8Wp+Ht6tD201U9axAP62qz9Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqmw8lso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C64606A339;
	Mon,  2 Nov 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqmw8lso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8812E1F00A18;
	Mon,  2 Nov 2026 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793658019;
	bh=BMRhEfkrJ9jcifhfiPRu+qK8RujFhLdNVfi0Q7x06OY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yqmw8lsoUjkYVPxFbWuJvaxWGTTPc5/EgGzuckzjR2Fl6F2Ufr55v+X+kpfXBelVQ
	 /iEc9tQ1tWUN2pcCUq66CBVDNZ0oMwLJ+DAi9fRZ+g47ThFlqPaOICNyxS1UZ8M61s
	 s3oCH6dcInVxyrV2U9HU9GXVI2+WqnsolHe/xKcCDDbquF8n7s7WiyhBUimDOhUTS8
	 olXgUs1tcZb0M1nJ/jL/Gnu/iZKwMuDL2++nUn0/L/WHAmzKbEUGopeGFI1Odfzp18
	 J5g4UPy8jlZUf3NNthCzUPB3RQNYlUpulUsabgcYDOPp6x5jWAkyM1/1lfP7PO/0Rq
	 zPT8cvBP0KWnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D309380821F;
	Mon,  2 Nov 2026 22:20:19 +0000 (UTC)
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
Subject: Re: [PATCH v5] Bluetooth: MGMT: Fix discovery stuck after a failed
 Stop
 Discovery
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179365801804.694758.16698757063901481997.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 22:20:18 +0000
References: <20261102170000.62469-1-kevin@simpleble.org>
In-Reply-To: <20261102170000.62469-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 Nov 2026 09:00:00 -0800 you wrote:
> Stop Discovery moves the discovery to DISCOVERY_STOPPING, and
> stop_discovery_complete() only moves it on to DISCOVERY_STOPPED when
> stopping succeeded. When it fails, for example because LE Set Scan
> Enable times out, nothing moves the discovery out of
> DISCOVERY_STOPPING: Stop Discovery is rejected, as the discovery is not
> active anymore, and the LE scan timeout was cancelled before the scan
> was disabled. Until the controller is powered off, every Start
> Discovery then fails with Busy, and hci_update_passive_scan_sync()
> skips background scanning, so devices set to auto-connect are not
> connected anymore.
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
    https://git.kernel.org/bluetooth/bluetooth-next/c/60b10121db60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


