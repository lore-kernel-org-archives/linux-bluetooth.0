Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461015;
	b=PeRiDJq9h47RiII2y41pXmtlHoDY5rChUJSwOcLqCgZL+yjtpcq6/vE1XRuiTfTHW+MU
	 IR/sChnGZ0vPlFcmlkPsz5rqbKgq06AVlYO8mm0r98sbQAbgwGzCx+UtbW6IiRg4kM3Aw
	 tYqbdJTTGz/Twm1GMnQXJg1ZWYug6HcLgZrKdiW5LUcc2i9kLKJ+QB89fNJKp9UjxuJxr
	 1+Zv7PATfSwKjayxugoHklX35re4XtzSM9cx8vTdGHTKN+EMm/UDe2iz3UZx7w8qUt7F7
	 8DXM4L7kPfRQTo0C4KXp3K5C4z/04HubNIE/Qq61kgqwD0huS3L81rVRc/EjtXuV4Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461015;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=XQ9p+vP9e4sPus0WZo9MYXSO4pMcU8fsor1wMU+c2sY=;
	b=vvqOE198AaVBceEhUIXYKahbd+QhlQKt0yIjgwVPbQCQqxmM6OvTRe6FhWqxwwGbE4EV
	 68e/2oLEszF26RDpnFh74wNiYp/LayihJfy9VWM0ua11W7ndLdEA9EuleL7sktz6qKVIM
	 JR+x1MjeCPy1a0CzI2faX72Z1VuNkyW25DN5QSbWaC+7QVSRkUdolaR8gmX4FXMHN3bSe
	 oONhOxt0K3DdejqfGE7GEV0liSyrGf1m+ecfl5sK/qHWGAS26T+8aSBJKZKrB0q1sTS4p
	 iehCz7C8yf3FxAoyBw9VKPnreD7ykfoFJHTxKQunEv/QCy01ixPl++T8toMCjFV977Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jph5MQ8X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D8606A32A;
	Mon, 23 Nov 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jph5MQ8X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4308F1F000E1;
	Mon, 23 Nov 2026 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461015;
	bh=XQ9p+vP9e4sPus0WZo9MYXSO4pMcU8fsor1wMU+c2sY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jph5MQ8XftD/m6Kqw6AxsC8W4f2+xOBITNIx+pBx27NZ2/U18iU+aKEO40nxkeH23
	 JqsC5vrCTtckjCXfKP8WbHct0ZdByK4g1Nczdda1WaKcMOVibTkrAhepKZSUDIibfu
	 /cOgkZenip2ZUyF6O1E/rCoQlB9J7NqmF5nX4Xs8fuVOBYjtud2SCqY32SlMXESm/7
	 3F9UX209EYuxcQY20+lX203SL8Zovj0WPT4XoHC+RZ2TXEyHue1bJugY1P+AOYv1FW
	 PQ2S03e3F4Fw/8sX8IglSdlRJhATN86mkm+K0v1mZdORCngeegPGBgrz8ZArvgNdfY
	 XHANe/gbvvddw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A337392EE35;
	Mon, 23 Nov 2026 19:10:15 +0000 (UTC)
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
Subject: Re: [PATCH 0/2] Bluetooth: RFCOMM: Protect sockets during teardown
 and
 TTY handoff
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546101376.3063022.11282483479057094356.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:13 +0000
References: 
 <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-0@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-0@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 21 Nov 2026 15:02:50 +0800 you wrote:
> Socket notification and TTY handoff can outlive the object which made
> the socket's borrowed pointers valid. Keep the listener alive across
> child unlink and notification, and finish old socket users before the
> TTY replaces its DLC callbacks.
> 
> Cen Zhang (2):
>   Bluetooth: RFCOMM: Hold the listener across child unlink
>   Bluetooth: RFCOMM: Close the socket before transferring its DLC
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: RFCOMM: Hold the listener across child unlink
    https://git.kernel.org/bluetooth/bluetooth-next/c/22d1972f6834
  - [2/2] Bluetooth: RFCOMM: Close the socket before transferring its DLC
    https://git.kernel.org/bluetooth/bluetooth-next/c/56bc551ef79c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


