Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941414;
	b=suA05oXadIPQpWde6gpJDeGAMnP+tcbqnxYDxt2btimg1Nrb4DV9Yk31AuTXUjZvm526
	 vvfJJkH9weew02BzX40iRjCov+g6UJR+YVdn1D5fQ6BH0CBqZaG3Uq9MkOIKvrWA7Yx5v
	 NNz1Do3wsvemiDRRDE8J7vwdWlk3mPwIC58pM83vD9+CE0V1k+V2cqBw3slIKnPOh787s
	 5rRI/+GD/6tD668S6NKDrS31l1RxllINCBUUVB3MfnQpyuEII/0mApMLkwCYR0GzJ/FJb
	 aHskgGFbAmWz7yyRvexxuq8puDU/aGv3rI9j66BoPYfo6EShX6btz09ymVPdh/dk81Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941414;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QxzREoDXRU8UXLM18HXJinaU3FjQibYCOqYsQMrJezo=;
	b=S/cZLaUhiDDOQjJ7UXpWakLYI+xMZXu8g3Isf6SP5elRfWSxKeGdNusaGlSWEOddEiRZ
	 E4bExkuypGqhrHzux/Ki+TcRp3KZBdzThFOycRlAGTq/PsigVqEAyBZI5T1BGizpNMEZ/
	 4hJewF3FNUUVxb40eEhnVo2ee2M3tbcqNKVT0fa4d9M2/6MuSlrZZAuXG53goQ2hdXn5P
	 cGTBZ+rC6BHjoJYL4NQLT6JSFlOXFFUpPYvHFTgqAW7Di62IWfDjwW75Tzkqsw65K0l+E
	 L77Z2Abd38+vOcwvGhdLIBhMi4qAR80Ch+KkrwxxdnY2CclY6iixhEkNVzBxHZzxncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlRzSe7g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1737606A33A;
	Tue, 17 Nov 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlRzSe7g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF00C1F000CB;
	Tue, 17 Nov 2026 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941413;
	bh=QxzREoDXRU8UXLM18HXJinaU3FjQibYCOqYsQMrJezo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RlRzSe7geL9EIXsMFSV4unw8ZCDToRTUU1aWDw6SbUZgNVjSoMQvOuYMo21t5tjjg
	 V/0peS1kKw40LUbB5ZtHdPwegOAXmmfS7k+nLUeSX4a52kYEvS8+XipzjkSb7k3ogK
	 qA+LX/AqyXkot+U/lTwb2O6ksvrocDHpfUaz1jrCZ8XXcLlYb9RjDNA0mzdWYl/Xmm
	 wFmkeqEQvjr/ZuZmzHTplxf38DseAnEiz9oJdCLKApdeo+2PUkAObdSr5XfgDyqMYk
	 00cTdrgzWu1kyNz1iqJmL4W5zloEhhUnMebpXuDJwMgSaaI4+v92DOTX+OrSIhtPJ8
	 sU9wKFGmsB6iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45BB392B1C5;
	Tue, 17 Nov 2026 18:50:13 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: btintel: Don't log unsupported debug features
 as
 an error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179494141227.761488.17080097216959438759.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 18:50:12 +0000
References: <20261113222024.1123279-1-hex@freenixos.com>
In-Reply-To: <20261113222024.1123279-1-hex@freenixos.com>
To: Hex Lindqvist <hex@freenixos.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
 abhishekpandit@chromium.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Nov 2026 14:20:24 -0800 you wrote:
> Since commit af395330abed ("Bluetooth: btintel: Add Intel devcoredump
> support"), setup sends Read Supported Features (0xfca6) to decide
> whether to register devcoredump. Older controllers such as the 8260
> and 8265 reject it with Command Disallowed, so every probe logs:
> 
>   Bluetooth: hci0: Reading supported features failed (-16)
>   Bluetooth: hci0: Error reading debug features
> 
> [...]

Here is the summary with links:
  - Bluetooth: btintel: Don't log unsupported debug features as an error
    https://git.kernel.org/bluetooth/bluetooth-next/c/b05fb50e255a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


