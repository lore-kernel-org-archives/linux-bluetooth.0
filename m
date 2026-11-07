Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085208;
	b=kreXH+dmeIe5Qz2VwLGo3HDv9kKpnAZOGfONfT9Jta1ycSgk0Nc6F5ZpeuOiPMMm0Q9P
	 P6I7+q6/RAmECcPfj7m6vqrAQFTJ92SygKnLM+Z+DLpU2KxAL+T+BWXMpxuCmA2w7/LFL
	 BwppQuY0/Epv8UFvFUdXYt10s7oZDpb8h/uqJQaldAW59WOr5c1k54m1+1e5OVlHiaEaO
	 Pd0oAwgia5CDGyzJ4QHnL59dTdVHHoCnOC2wxypVOAOWcT1SBqHJwOiGvi4J7YKEvcE4G
	 kPu3bsdovEabbQqnoasqSRx3eQ2FDpLNfmwpLgz9lFtWVI5+pe7D6BHj1HuioDggolA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gkwIK5wSzj3qdY2TJiMVEsubfd+P6gqQ6AD7LIZIFLM=;
	b=21JzcRyc+rhlkEVp9/M2F8NA/EdgUPFoZZgQdxtwWs7TshYy8uNXSC7ifxO7ry2We++o
	 eawsiHlr4D6RIoyAqIKvgWoXJzKJJ0HWm1sO45NSLi65B2Gnjnwo/tWbIKzjFXMoN1AV6
	 bHIwOouGyVNQVJ6t6Ul/Rba93G1iZooCu13woXGJXkFaINx369gH3NDDL2uif8o39+1oc
	 U5JWAQUXnQw+JTXJholOtMjFwcVhvkcafoaFp5jLoSKN4rjs6KKgVoXazS8GYZTKcIp9j
	 rS0R16QH7+7g04frwcdPvGxIcBJfeEJCKTCW6jGzrgwOdq2NwPl9OXr4yS05+lfsvKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSCkpj2S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A48606A32F
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSCkpj2S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BAE1F0089F;
	Sat,  7 Nov 2026 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794085207;
	bh=gkwIK5wSzj3qdY2TJiMVEsubfd+P6gqQ6AD7LIZIFLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QSCkpj2SL+/1QKPtghB9NBVwmxeVbRMNToNwmUFYnYk91yx1YdLpM0BtP7FGaLodJ
	 AnWaOeie3Xn8iQ9VuYPW8g/J52HLxsSxJLgOHIiE5CgmxvKjs1wKbXIOsuBicrNacf
	 REt+lOwwNYF9jUCbXv30FisDnxMbYAi0Su7+uewrViGPNNmC68rpok6Eegwa9QLlkc
	 fRY5EPWxmyPoQq53FUBQIJ4zEaG+YDw0b2U4ACHIs6iP4NOlkwxtgAU5YHLQt4uVDz
	 apXWd85lLv3VH+kKjw8Za4EPIyrVxWil2aFNgectvM+MDfZPLHpmciFk+DVAkN/aSd
	 eI4e4qE7R8ozw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B246380821F;
	Sat,  7 Nov 2026 21:00:07 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v2 0/8] Fix handling of malformed GATT PDUs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179408520642.1337848.1745297927626770621.git-patchwork-notify@kernel.org>
Date: Sat, 07 Nov 2026 21:00:06 +0000
References: <20261106183350.3155282-1-luiz.dentz@gmail.com>
In-Reply-To: <20261106183350.3155282-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  6 Nov 2026 13:33:42 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes several places where GATT PDUs received from the peer are
> used without proper validation:
> 
>  - Read By Type responses with an invalid Attribute Data Length could
>    cause a division by zero and out-of-bounds reads during discovery.
>  - Notifications and indications shorter than a handle wrapped the
>    value length to 65534, passing data past the received buffer to the
>    registered handlers.
>  - Read Multiple Variable Length opcodes were missing from the ATT
>    tables, so the server never responded to the request, and the
>    client response parser did not advance past each value.
>  - Database Hash and Extended Properties values were read without
>    checking their length.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/8] shared/gatt: Validate Read By Type responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=02acfdbe0374
  - [BlueZ,v2,2/8] unit/test-gatt: Add malformed Read By Type response tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=730d0138bf30
  - [BlueZ,v2,3/8] shared/gatt-client: Fix handling of short notifications
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2d41b1aab0b8
  - [BlueZ,v2,4/8] unit/test-gatt: Add short notification test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea2ab6628b8d
  - [BlueZ,v2,5/8] shared/att: Add Read Multiple Variable Length opcodes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0c2f60273e63
  - [BlueZ,v2,6/8] shared/gatt-client: Fix parsing Read Multiple Variable Length response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3b15e6d5bb70
  - [BlueZ,v2,7/8] shared/gatt-client: Check value lengths before reading them
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bf1fd8831d56
  - [BlueZ,v2,8/8] unit/test-gatt: Add Read Multiple Variable Length tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa4f5ce97c87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


