Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CD191473
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819233; cv=none; b=shylYUsi13lqUxXZoBodpKez8yZui/Pgt5qFRUSrGVayjljRiKGJYAfWCd9tmiqNvKyinJ20hUYx6YnDtzSaxvUJnz8xdDbz6emz6tNjIHe6CA5Our6TENUbzX0sNj3nbxAz3gSPXHPFqihbzao2r68Bg+3XRM4FEOl2qqOlAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819233; c=relaxed/simple;
	bh=urKIeWI/CeAcrU/W3V6oZRDdzcFIw5g3idNchr9SLow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SOk5Q8ravB7OAsfy9gX620kgDYANeigjoAv6mQ73npFbZxRb4B/19RAIIPp94/cH8Y7bL7kD/EOhVj+84G/GsC8QQd6IBnn7WrwX/t+CIHnRijOpJ+Z6jtWlk65J5iTI24e9Cw1AezOocXEDd6sqBKlItau4QAHl5JGEgj6wIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TN/a9MQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TN/a9MQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3090DC4AF0B;
	Fri, 16 Aug 2024 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723819233;
	bh=urKIeWI/CeAcrU/W3V6oZRDdzcFIw5g3idNchr9SLow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TN/a9MQLSasH5RPfse4vlWCXGWFDADfXU7ulXODrLiwk8n/r6TPPIbnES1qorx5eM
	 pMbR5vixMzc71vB/6swGxdyg7AMcfNbS2tbY56elF0YwMu/EGSCpYop9AnVBW+VIVI
	 uCdzb4M4Nq63fUQEuAlZjs5PdZR+PWWkatEVxBJn8bIYGIMGkwYMShOa4euURy6XY1
	 Sg/TbS4dO5Cm/Lm99low7lXKe08pwLEaCMdO7vNCDDKm9ta8wpHo19HELTEAsSti9J
	 PJde1QUSRtBxlodgdUQS5u5BBrGN4ApBi1aQkzpDNJ09NfiVgqgrCwNUFb42IXsKBq
	 YHiehIU+/rhmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0038231F8;
	Fri, 16 Aug 2024 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez PATCH v1] Monitor: Complete missing fields in ESco Connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172381923251.3538529.1721430196095780662.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 14:40:32 +0000
References: <20240816131145.Bluez.v1.1.I6eb6574a1f0abd21e735618d5e8936fd230a4fa3@changeid>
In-Reply-To: <20240816131145.Bluez.v1.1.I6eb6574a1f0abd21e735618d5e8936fd230a4fa3@changeid>
To: Howard Chung <howardchung@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Aug 2024 13:11:45 +0800 you wrote:
> From: Yun-Hao Chung <howardchung@google.com>
> 
> This implements the missing fields in the ESCO connection setup and
> accept commands.
> ---
> An example of output looks like below:
> < HCI Command: Enhanced Setup Synchronous Connection (0x01|0x003d) plen 59
>         Handle: 256 Address: 00:11:22:33:44:55 (Google, Inc.)
>         Transmit bandwidth: 8000
>         Receive bandwidth: 8000
>         Transmit Coding Format:
>           Codec: Transparent (0x03)
>         Receive Coding Format:
>           Codec: Transparent (0x03)
>         Transmit Codec Frame Size: 60
>         Receive Codec Frame Size: 60
>         Input Coding Format:
>           Codec: Transparent (0x03)
>         Output Coding Format:
>           Codec: Transparent (0x03)
>         Input Coded Data Size: 16
>         Output Coded Data Size: 16
>         Input PCM Data Format: 2's complement
>         Output PCM Data Format: 2's complement
>         Input PCM Sample Payload MSB Position: 0
>         Output PCM Sample Payload MSB Position: 0
>         Input Data Path: HCI
>         Output Data Path: HCI
>         Input Transport Unit Size: 0
>         Output Transport Unit Size: 0
>         Max latency: 13
>         Packet type: 0x0380
>           3-EV3 may not be used
>           2-EV5 may not be used
>           3-EV5 may not be used
>         Retransmission effort: Optimize for link quality (0x02)
> 
> [...]

Here is the summary with links:
  - [Bluez,v1] Monitor: Complete missing fields in ESco Connection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=29d4540828a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


