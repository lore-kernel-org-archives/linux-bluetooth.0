Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723410;
	b=NdKpo+3S1p0Nof4O3GWwMWBa/N3dcP2cKsD5vSCXkMQdsJz5QPq/+Lexx4QoqYftVCP2
	 DqKIliOPBQ5DwDRWjVsvdd1flGKQojN0t6fXFA07QZx0FA5fxl/tm7Uo0536HkPsTg7c9
	 fh96Q42R/uOypLZVZi5gBCK2HXla3g4vxNr82H+P/NJ3T64RDspvYZcRsHnc66ytV59ol
	 gjJdDd/w/z58ZJvN9oLLWEzekrYQZ9KaqnqoS3CjRkyBbBpL7oEnzIwxI0WTtKR5aIj/O
	 GviRrWBRptp5lSLSXze+3EroSC3fI43rZzsEDL74MIVvOJ6efKoNk7MuPeV63ArlJRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=hivnJUqdr2xdqW8CKeTQAf4qqlWgnHzfCDn0xmpYfwM=;
	b=dhBYXCgjMKfbAS/B3sL04TQyISAF16HdYzdJIKXyOGkp/HkD1emz6TcGcqo5BLf29Jkf
	 WVJX2cf9y4uLgNa9FfhGQwGj7wEH7PZwWBeF9VXDKhOqxvSy0x7zEQJJd1NNPSqhACjtT
	 zDQoFoyyIpZVSsaO+wuT+fZAVZDPo0rY/dH7NLTlCdfiZwABTVsRXOOR4f2ikwSueu4NE
	 GJMEKERBPL991db0rz9AzT+c6Z1YMg7v4c9zW6aK6rpgH+azQGYqv73XorRjzN/h2+spd
	 Bl3G9dESNc3lBqx8SJSLyJqj6QX2v/oe60ljod78Jk6Ty3YjIsftrvkNNmA6AKUJ9Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEYq8GcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD8606D80C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEYq8GcY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE511F00A18;
	Tue,  3 Nov 2026 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723410;
	bh=hivnJUqdr2xdqW8CKeTQAf4qqlWgnHzfCDn0xmpYfwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LEYq8GcY4TCzuLU96a17Sqw0F9q4bCWm8kA/HNg4SGb/sC+fkbB9FMQPvjk6W8dzR
	 04vRe0bAW25EDFEWuBHzYRHidAvciDhuqnpizy3V3NhJoCrM0wf5wng28NDg94YdZj
	 0Y1OfJmPWi+wNh0UvsmI+QKQoiWFkqqLFv4Npq5I9HL4XygHWeRwlK/rZ97pL494Id
	 3sVaR5aZjkElwc31so8m/JUoPxN5791uhRQ/cQpYb8mR4hsUy01lHbBTC4mKAAx7AN
	 iBE1KKFT10bScwfWly1Bu9gsDFoGwhvyuzfIXyVi5Kg2J86o/k303EOtK6F/ygs4pS
	 /KcyMSZJrHT0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03239391AFF6;
	Tue,  3 Nov 2026 16:30:10 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v1 00/10] Run test-functional under User Mode Linux
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179372340880.1736455.17491384995793060538.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 16:30:08 +0000
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Oct 2026 17:29:29 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This allows running test-functional with User Mode Linux (UML) VM hosts,
> e.g. on machines without KVM support, together with pytest-bluezenv:
> 
> https://github.com/bluez/pytest-bluezenv/pull/8
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,01/10] tools/test-runner: Default to time travel with User Mode Linux
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=82da11007efa
  - [BlueZ,v1,02/10] tools/test-runner: Unbind virtio devices before powering off UML
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9edc135192a9
  - [BlueZ,v1,03/10] emulator: Answer the time of a guest with a skew
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92515ade2f98
  - [BlueZ,v1,04/10] adapter: Don't return Busy when a pending change sets the same value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a994cab0ec45
  - [BlueZ,v1,05/10] test: functional: wait for BAP transports to be configured
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48cff70088e2
  - [BlueZ,v1,06/10] shared/mcp: Don't drop commands before supported opcodes are read
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=084df6bd3dca
  - [BlueZ,v1,07/10] doc/test-functional: Document User Mode Linux VM hosts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2500322374e9
  - [BlueZ,v1,08/10] a2dp: Fix refusing the AVDTP connection of a new link
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=efabf8db4c22
  - [BlueZ,v1,09/10] adapter: Don't cancel requests of a new link on stale disconnection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9d498bc8f241
  - [BlueZ,v1,10/10] test: Cover A2DP reconnection with a pending disconnection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ee9c3a504ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


