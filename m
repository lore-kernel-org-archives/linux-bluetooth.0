Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461011;
	b=CE1CPglmDeFy7JM2fxDm7XI7EIxzG/oojV7FVWceeVzl7cFaIl0Lata2l+oZmRtvocQ9
	 wKBc58dZ4q/CPvMziyG1EG7eYehhIM9ElIesI1T4GwkWSCwFIa3WPlZQ7Dudi7kMAW5pN
	 VXM4aYEmWK5LuwO8JxtBEX67FxyFX+HomvFi/ojy7d5hzSLxMXQOu1Q7WRbggA2lf7MF1
	 a9AY+kCm8bCxv9WCkRpWTpg9DOZ8B+XUp3EYpa4sQw+Svrie58Q8uXL90QgMkO4mH+FD/
	 2dCv4Pc3JGqJxZt+6GPbalapTJylEFrXER3Y9q4/3/5IZJQCaixXTVsI4Se6+5cY2xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1gznRcXRUYP2iIIohO8gtElTV/7IDbBcPS1AKp7XNfk=;
	b=O/SsGBihq3cNHil3pipVttWCtYn5A65tzbRhs31y+F4KWi6G/AHgKl0iIm7EDOGn4myE
	 KGP+ir4KZzM8mnPbhMCQwtppEkTYABFibq+ftC2hwUJYBSvg6/a+cw7Rx24Wdy+P+rmdj
	 /yIhI2EX+h/DZLlEWvQjJzwNDihd/zl/xf0ovQ0sBc3G11wUhWZ5879AsbwsCdpNpzilM
	 bKgpCokg9Bde67TxLM/0c0R/CYcYcl8f0MZHCbn47AtainCwUOs46G38CJF6UHkccaprM
	 KPqlNhLhhDXZhKziOXdgbSFVb/I5xE7Cfdczv30KRYkrjSnvQtBR5ndUXxZfe21jY4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYrZBeNY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588E606A336
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYrZBeNY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5F91F000C0;
	Mon, 23 Nov 2026 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461010;
	bh=1gznRcXRUYP2iIIohO8gtElTV/7IDbBcPS1AKp7XNfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GYrZBeNYdLeChKn4s6pzw69bYZM1ZXsBWfpr8xEIIBuRlgXdjq+EDNqlyBls+w3tt
	 rCxskA9lHJUtV3ZkCuTbaSjVeP76j0e+802grolKx2TdC/3CK/8RdKoMRbsnO08rZV
	 W/T3Y9bZm5Zk2vVXfPdFTfkQPISbRHJeyJpo7YXK5/Z92bec4r67xeRQeNIlU2xaZZ
	 zgYUM/GTim8S51xtzrKdrtVByq21Oj4H1gOMhR0iCeBh8GN3O8UMQ678ovvne63k2Y
	 6Kn3Y8wToumvv+jaQn9QOIx9tzObGtYeUTiNpOD3+YKwfyC3HBV0scOHAE4hQIRTTY
	 DXo6l0DDjbtAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4445392EE35;
	Mon, 23 Nov 2026 19:10:10 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_h4: Ignore the RFU bits of the ISO data
 load
 length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546100927.3063022.13155835076768217377.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:09 +0000
References: <20261122155208.1549223-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122155208.1549223-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 16:52:08 +0100 you wrote:
> The length in an ISO data packet header has 14 bits and 2 RFU bits, but
> h4_recv_skb() reads all 16. Some controllers, for example an NXP one,
> set the RFU bits in the first ISO packets after a BIG sync, so the
> packet is rejected and the rest of the receive buffer is lost. If that
> holds the Command Complete of the second LE Setup ISO Data Path, the
> second BIS never gets ready and its channel stays silent.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_h4: Ignore the RFU bits of the ISO data load length
    https://git.kernel.org/bluetooth/bluetooth-next/c/59d19fc7eced

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


