Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050812;
	b=y3dXw8eQYRpcmx8FLW2bBbR4QktXTY/Iqzxs9z3s+u+YqRCtB96JfSN+9yhGuaeOgfAC
	 bzGFyF9tzRWJrZx3h+camndPvwmPZlXNvDdHm9LFxkshuN13nhWtwVl5+Pw0YP0ANF7p5
	 3ol5ZAQqlHSb3JBpP2cb0HQH0n4U0HSpa/6+OQP7MPCyxahbBIng2popZ633h7z6hGdWM
	 jcRs9em5zhMbFanf+jmk+iqPHzXVesr3rYRRFueANNShL9ab8LLt4NqlKkkguFqDmNwCe
	 le4gyzSytrHHoivlM511fedVV2mxTT4jtySarrtLYmHvcVjIw/wWByDIdmmke0FnoSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=146tge7Dt+FPRE1b/ofUpOPhkU8RIgNzlYaeo2nqC30=;
	b=0hiUJnWM+4i/LUvrzwjf6YvEpbjN5okyj72Pa7mag934nu0wEXEIjLlrRKnKzjFLtrSX
	 ILTJU+gefY8PlQL8jncM4uLbTJgKcq62CHu2H403npw3jnRYFG3mBhmpGd2pU8wTh7JRC
	 P0MDjkUFro9aw8HhwI2vJAdz80b8wAxO7bfGKdwxI93rhHTnIj3ap2w+YmPmU+ZuD2kd1
	 IbclQ9+b/c2I9qrNaVVh5Eyid6J88zKDVuPh+h5orMmIOkjalOxJ2pfpdH2LH4quXmUlM
	 yyTDpDMChatBizcUdOCSnYF6h+0kWl2ObdmYZo4laoquNpMcxyQdF0TF7hJrMsPqx5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUbMngy2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4898606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUbMngy2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893301F01828;
	Mon, 26 Oct 2026 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050811;
	bh=146tge7Dt+FPRE1b/ofUpOPhkU8RIgNzlYaeo2nqC30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UUbMngy2kfvq/3TD+H8DNV0ZCK8AbrHnn0oEsCQiC6fd5WscTwttezLEeWG/gYB0T
	 b1RPSmXhuv3IvCnahzT3gD8yfKK7p9TNkInVbhlMjsQ2oCrwT66DIc5g+KGnMJIb75
	 SlnPhqs7heM2eeRktort/IybPDo0gHyWY/kbBpaEtDsgrWnEk62w/8tyqyjptQHrHb
	 wk8sCJchHQFwSNWij30poEuVIKr08hl4Y9yw8G31VSXjxs5kPJmJ8u9Of9imt3nB7m
	 ctsk29z5Y4BxzDBM2slTwbl07mConeY4fWWsiPoJ3XT9VyYo2f4wY7yQ9CUc7Cacx0
	 fRfBMywKo3IuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8153A3AA80E9;
	Mon, 26 Oct 2026 21:40:11 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ 0/3] Promote the bearer interfaces to stable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179305081006.3403508.881301264378000551.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 21:40:10 +0000
References: <20261023223708.76232-1-kevin@simpleble.org>
In-Reply-To: <20261023223708.76232-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Oct 2026 15:37:05 -0700 you wrote:
> As offered in the Role series, this marks org.bluez.Bearer.LE1 and
> org.bluez.Bearer.BREDR1 stable, now that test/functional/test_bearer.py
> covers them.
> 
> The bearer interfaces are the only way to connect a given bearer of a
> dual-mode device. Device1.Connect picks one, by default the last used,
> so an application that only uses LE, such as a GATT library, can end
> up with only BR/EDR connected, and Device1.Connected does not say which
> bearer is up. Today such an application has to ask its users to run
> bluetoothd with --experimental.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] org.bluez.Bearer: Promote to stable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=892d1885af48
  - [BlueZ,2/3] bearer: Promote to stable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b25019027d3b
  - [BlueZ,3/3] test: functional: run bearer tests without experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0bf49270d44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


