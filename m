Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029611;
	b=an3vlu6DyulgceNXw80r7PR8AlmdQS8E97V5dIDlVQoB8IXUzhdEmp0s6lmRgjPpf8kf
	 c/QO3G2U6fFQF5l2IRLB4CXLf1Fkch6a6Z6XjnmgwA4J+JrjlHd+QvwTMOb+DbMsPcXfe
	 3H/5kvtEyJLx+U1CgrFlfjbUEvqtuyrukPSC0i40svH+Yuwx6zeiYtX1igc97KyVYmW5y
	 rqfeWxfoAbb0zswf9HP09QdVE8aP1afHvPtt2dxythqjq1ggx79tzK7mgBACKMPx5GDAL
	 n/RUvQCCfDMbrhWhagupquD5cggnlHxXs5Y1tDzXH2Kmwy5w+opHmRMhQD7DDWspczA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029611;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=36qJuuCo95He2SL0cumchH3ljqhFXkxwZ+WSWfuXZ4E=;
	b=Q8dbDW1QWO+FLUbUeGp+NA/h+gThRbdjTPhVfM/1iuPmhxujXCU9bAzqVz9fW1g5X9UK
	 lIF+AnlyFhIq3TSPl+XSUYJjMVpVEIsXMKwFOZ32PcVoq7KyhiN9SeAPOoPLE0gBIHfoQ
	 tXDMaZPu9HEZAbLBkvEOOdyBxWdkECIPUj9+XnlIk/PuCOjF1Ir9/kCV181MKyywTyiG4
	 ehOnDBsqx9S2EKq9mw1j1tG5sHSVe0c+e+sR8w1RRccOnIHpmJniHL0hzGY+BgWxfrToc
	 TQehf5RQpiwkcrbR5N7tuv0dMSwS4oiXlYwUBsVc6w6zS82zxFuqWB3EwIkaiDDYloA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvHVq9Gg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F4606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvHVq9Gg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444BE1F000C4;
	Wed, 18 Nov 2026 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029611;
	bh=36qJuuCo95He2SL0cumchH3ljqhFXkxwZ+WSWfuXZ4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jvHVq9Ggix0+iPrSybvcgvgvAkNvCa/H9eZPiXe1jIphH0X1eb+htLtkqlpYqFIss
	 P+djZmWrTNZKYCsKxz15vABhI9L0Tknw4Nj/YU8wBfKS2KAvDRg7I/6pSTLlV7v+AX
	 pxVCGvdxQg40rNnVmGe+7zwIqQ6ymPCU7iNyJbv1uDBKyokJkblkwmRsvLHHitDULH
	 1L7Wc1UTusguuqZK7BmCKhNvEyOU01EUbCWSShzyJfGpx79XaQ1vw7kiobIUb6ZRXM
	 2LTp4Za3S5046ax70X2Qlbb7q7fdCGk0khoe3ZuRkhuHK0dZIIP9ods2BoobmpBbhA
	 RyKu8cWweC8lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2A03808210;
	Wed, 18 Nov 2026 19:20:11 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2 0/2] cups: Make printer discovery work again
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179502960977.2490531.1849363675431703025.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 19:20:09 +0000
References: <20261116112931.1598858-1-bernie@codewiz.org>
In-Reply-To: <20261116112931.1598858-1-bernie@codewiz.org>
To: Bernie Innocenti <bernie@codewiz.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Nov 2026 20:29:29 +0900 you wrote:
> The CUPS backend lists no printers, so add-printer dialogs never show
> Bluetooth printers and the URI has to be typed by hand:
> 
>   https://github.com/bluez/bluez/issues/2287
> 
> Patch 1 reads the IEEE 1284 device ID over SDP, patch 2 moves discovery
> to GDBusClient. Discovery runs for a fixed 10 seconds.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] cups: Read the IEEE 1284 device ID over SDP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=36bb222d5f3d
  - [BlueZ,v2,2/2] cups: Port printer discovery to the ObjectManager API
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


