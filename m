Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456811;
	b=mqHW/q2JDqrcatVL7hvB4CzSn7Vi0CzxCYmweUV3CBfQYPuL27/e4k8JHbJBYNLXLGll
	 vFWNO6aTHDEkQSCaRM1fuLbywo3w058f7ZB/uk9/ygKPFk19nCx/Xok4mxc4NM72sezyO
	 2eig6db/QNihXMEUJ6pmY/W3XKzbHewo+A52X5Hh35vlZJc8IR9vbBOCnimfYDxtdHz73
	 ZLjLSSZ8/GxzGy7wyVhV98uhAHdaxUuQ3H3RGBCeYhtsobLP9xGFL0v6+cmvU1qVVZjg4
	 2UysFfztoFIxenocz9HxPZrYdmtjUJ0cedarkzA9WztEq7yI8Kg3D1CQDzaE0P0tGew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3164FF+GU1SLcsO6MzvNeitcHV8hWmmqsj1HcSgliFo=;
	b=VVA0B48aFkVNi/USnmBEtgpQqauUmmXr08f6AkE4DY1rCAN3mJaLR1CAElbPGoSrZW0n
	 MDpfrg68n/TdPTZvrLzPiOyTaqnpwzmvtVvjvYQ8esBYcAh9A9bP2DcMsfwaFTdPEm6k/
	 QzWmJs+Wpq4xd1FLYqUh2hccO5WXp7yJ1rdmEwpOjtoXIRwFWyC3BgB+ecCapxD33WTR6
	 eFwePUbfSZEzq4OVFf4jeOmxaIe/MZjQMV8JUjbwiouNYJ09LCZvxVreYNzKQ1O5ZkVgU
	 Q+D7kX7YUrJ1U5lhC+GUQq6qph35l0V6UreJcblRwpIhKVWXU4mT01WVPRURGhw4ARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwUsA4Ul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B4606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwUsA4Ul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4292F1F000C6;
	Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456811;
	bh=3164FF+GU1SLcsO6MzvNeitcHV8hWmmqsj1HcSgliFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nwUsA4UlGeFVPgMow7Yp+BFlLD1xz9nCs31RqxiHs81lf0ci3mG/mwC2roCEkTWfY
	 OISknVxrzeJGMv6WLYxR+Ifl/88jz+gh2m9930v86M35RIYXD2/inUD6sWMbnFvAc6
	 fBYsgqom1LJ6WqEAac00tk/MZuwWWfV3GygO4CtV1qMTzM5bgbR/y+dYSFL1F/H/Wp
	 jfP9RcdVoBtDpcg3qgZobO31+k7sSrvdyUZe3HTAXSzNzJOGe9pM6FG6S0s4/Xu046
	 j7cYLMEQhC5RTNYstfoiSnBrpfUi0JevEaeOe3hG2cb3uMxcKiLGnB7hDhKDcWfXzv
	 TAo119udQ0C1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A30D392EE1B;
	Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] avdtp: Fix error parsing from failed delay report
 request
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179545680977.3023180.10492649728549711152.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 18:00:09 +0000
References: <20261122103851.681782-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122103851.681782-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 11:38:51 +0100 you wrote:
> A Delay Report Reject carries only the Error Code, as the one
> avdtp_delayreport_cmd() sends does, but avdtp_parse_rej() parsed it
> with stream_rej_to_err(), which wants an ACP SEID before the Error
> Code. The 1 byte reject failed its size check, avdtp_parse_rej()
> returned FALSE, and session_cb() treated that as a broken signalling
> channel: connection_lost() released every stream of the session and
> A2DP disconnected, only because the remote refused a delay report.
> 
> [...]

Here is the summary with links:
  - [BlueZ] avdtp: Fix error parsing from failed delay report request
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a50541f3bb5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


