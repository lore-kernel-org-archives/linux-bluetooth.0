Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422608;
	b=sdkNwV7ZktrhmzQzq/kxBlIV4Sq2AW9o8yKPsUGc+ht9Oxvq48664CdWrJAVyMhf4bID
	 V8/15XW25h2Zuiheaz8rPpBNdaBcQIV/NsKKdxY9opkf3LhyVOCfkjNeemojwZF6Dn0ig
	 f5jYo2TcZBcVx4X1QajSG9EBAFaEJaKbN56p+Z0+ilq+4CylCjEpXQmkpBmghhi2vsy0H
	 4L22So8DZ1PSWiUXzVZWyYlAipXef4jhGQ9yCAmaiOfn7AU4kF7vY0K5AqwiuPUzVYGuv
	 Mj/KslH3S9Rpqm4kPm3qGSn6878ulJTxojxYoVQgJ2s81F9NN2d3Y+iap8yeYyfb99A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PekFIsdLnYFlVmekJP0LZM8Uloi2ca7B572+nKMwfQo=;
	b=JEZdGjmIGIOpRsKHbTF3ryGfF8WuCwAIYjjy3ob5zsNUq+wIEoUujtCQ06xNFOKOemK1
	 pdMT40cdGr5Ds2/Qe+mK8Ftd+FpgvDcbc0xygSGCXRYIotn61VUaINx0bDWFDVo3X5qn/
	 MiNZHMeWNfLJSmP7jIbtUThGXQ4AXOa5N0z6fdM/jd3S8RR/ifGpmZGXsYuvXyIpCD77w
	 FGRzCaGCMyz05e+PJx3YNFaK9ojckF8tfA1xKNH33V62PN7oYhQxI1hJQ2vp/rFVrQsxB
	 cOoph6g/JD4tYWxBWcsBfiOBsYkC5A1wI0SmvN24pCQ8Deu9OmXbWqamh6oPySFanCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ga7EhEzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C06088290
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ga7EhEzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4251E1F000C4;
	Mon, 19 Oct 2026 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422607;
	bh=PekFIsdLnYFlVmekJP0LZM8Uloi2ca7B572+nKMwfQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ga7EhEzKin1nleFXgnUc8ve4kheHZL7ezYn5IRxntTYJLKGkmU99prav1WnRL9Dvo
	 Bumo96Eizk8AlEX6AvhcGDmCJAlFuhvzLYqHkyL+dHwE6VQKR/xk0MaRa7Q/G2+Z8I
	 eEQHv2/Wjs2x+R2gCxSHZsUJDNzm+z1Ly4i0xNfGFQMXGB2dqzp7WmdoHhAXjckKCk
	 Oj8MwRQwqca8RJ+VR6zdp/K39vp5BcuVq4OeXpKcWWZfzCQwotJTpKc0lmqfHfjmAh
	 OvI8GROTcTUBBpDD9ozW9c6FShocLRope2o/jBvVZQyZZY3nWO2TQXIZ/UXriWPV3U
	 z3xdf1SWSHGEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A26F3811A71;
	Mon, 19 Oct 2026 15:10:07 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ 0/2] Fix use-after-free in GATT client discovery
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179242260603.2707801.7989097154493120709.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:10:06 +0000
References: <20260930093928.360745-1-altomanigianluca@gmail.com>
In-Reply-To: <20260930093928.360745-1-altomanigianluca@gmail.com>
To: Gianluca Altomani <altomanigianluca@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Sep 2026 11:39:26 +0200 you wrote:
> bluetoothd crashes in discovery_op_complete() when a discovery of a
> connected peer's GATT database is cut short, e.g. because the link
> drops mid-discovery. Two separate bugs leave a freed service in the
> discovery's pending_svcs queue, and each patch fixes one of them.
> 
> It reproduces by connecting over LE, reading one characteristic and
> disconnecting about once a second, with a peer that answers the
> remote's GATT discovery. Each connection is short enough that the
> remote's discovery of the peer is still running when the link drops.
> On 5.72 bluetoothd crashed on the 15th connection in 4 runs out of 4.
> With both patches it survived 381 connections in a row. On 5.83, 50
> such connections crashed the unpatched daemon within the first minute
> and pass with both patches.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/gatt-db: Always notify service removal
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6cdb936ebb6a
  - [BlueZ,2/2] shared/gatt-client: Fix double-queued service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a338533f913b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


