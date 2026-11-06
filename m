Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996411;
	b=Hbmy4xePpJ6GwmZA5G2S2b0mpr6EVay1ZS2cNQu/iyhwHTLSStOlgINB2sMYs9GvqPRl
	 CF+Rqmfrlvg+FUE0UkuQNnp1KFccF2W0OrrgMtxu/B+GvfXZdTLzMewc1dCXgIt42drbP
	 c1yeUygnB7DpLCxcfKpaAQk0Zn6ihiVBEaFvWIJpQi/Fq4UTFKnellDoNkMmApHPklM/E
	 Vx08mQ8O97zwT9SBRSbRG/en4wCmlKilCcxYenYppf7Lc1/BGqL9Hv4Hj5PvYYpU/8mGN
	 mTCNzt6BB3P756IG0I3xeoGO1jhj6iYAnacLqJD0Q7fjqaZCjqhF5f/yMGI0DomMkeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=AO2+n8gK23Koa+vRbAITmdI/tHEJFEMJAWSibYx0ks0=;
	b=dl9tYpxhZuN/u18G6a+rOwE0v3wmlmPozV63InS7kizaG/ULFxXpZ2770cLANmrvMOMf
	 LEgZD2iJOr/i4KHFUHQfsH3TUnkU9afXL+dlQmJIluASGcm/AONQn36JHx37Dy7LsYynH
	 C+QRWFnuOz6zRyccZmNYQSFLz1oGW5BbcmwtavLSZ0C+qDguMS/DFWxROt9oVG7fHkRcd
	 7CRKeYhY8tnVWqkE6GQIZKketClqswZqEpXouPLEbYulz6yvYaSHkSyKDMK2SAAq/uqxN
	 QUa9NkJiRjuKeDpmJjehdCZJ5rh+0rqCCanFNvnYKQhQmndVdQjrR2Pm1Tc6D7Xn7cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMmSEEHn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833F606A33B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMmSEEHn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAA41F00900;
	Fri,  6 Nov 2026 20:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793996411;
	bh=AO2+n8gK23Koa+vRbAITmdI/tHEJFEMJAWSibYx0ks0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FMmSEEHnDUaRomYV9Lrvz2mBY7MgjvlnEXTkGHrBOMMZXXEDpFgatX697SmFMlTxo
	 rJAfJ/VmgH4gEEcQy/GSpk2XXUWhTtqvSEObE7xrSTlCsfDegqDe72O7hgkN0VShqv
	 LFr1XRHYuO2XCM+/f5zX3g4w2Atcq+cUguZ71X/LMgm3OK5pPrnJ9/mBs2o+3yvJQM
	 /WQb1syMEYS+u3vx1RQ9LX6etW9wn0Yfy1GuQ+SCakjEmGH9626bvqo4APEcWEJzqe
	 mhtZ7Gi9NrBH1u4H1VwQDI/NNniexCuJchtN7pS/KOWQ3wprfjTugT6/RfTNYWEOHb
	 08S7vSmcr9UYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210683A4102A;
	Fri,  6 Nov 2026 20:20:11 +0000 (UTC)
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
Subject: Re: [PATCH v2 1/1] Bluetooth: reject invalid LE supervision timeout
 relationships
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179399640976.849577.17436810105504463448.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 20:20:09 +0000
References: <20261106172404.591900-1-cochcoder@proton.me>
In-Reply-To: <20261106172404.591900-1-cochcoder@proton.me>
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 06 Nov 2026 17:24:57 +0000 you wrote:
> The LE parameter validator calculates an unsigned maximum latency by
> subtracting one from a truncated quotient. If the quotient is zero,
> this wraps and accepts invalid parameters. Exact quotient boundaries
> also accept equality where the supervision timeout must be greater.
> 
> Compare the products directly after checking the field bounds. The
> validated interval and latency limits keep the products within int.
> This enforces the strict timeout relationship without division or
> unsigned subtraction.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] Bluetooth: reject invalid LE supervision timeout relationships
    https://git.kernel.org/bluetooth/bluetooth-next/c/c1d50a71cdee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


