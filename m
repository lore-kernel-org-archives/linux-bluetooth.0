Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB319DF47
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725832; cv=none; b=pq8bwlWlxn6MaHsCEpM24TuLHY3/qJ8Poi0FMS3+31bJlzObi5uXO7GGatjq+LBUkpxgER/2fV+mx0dw+ktQH77T8+r6qnpGWSWol8EfHNAQJybKIN0UhGYbQL07SliT5rT9GgnQTzFhDq92JWd9YNi84aH3Nn70R4jKVL6tZ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725832; c=relaxed/simple;
	bh=IiY6jYyVVrg6cUdyYvl4A55Mh/miW3UHIqgqPh/8C7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DouWF9KscuXYwTiPNhMswHWk1TLVpiZwI4R0q3AcZmFrHW9xrOlWp+2kNzPueHCP9e357wVYPx1PCpb6NGF8XKSXrTXbMcwrjewDrHMQnvQzvNmizJ9NaC9YUZI0/qu65z3PMg69EcGv26xGbR9/5autOlL9NODcOxVM/1kOqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVt92QqS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVt92QqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36864C4CED0;
	Mon, 30 Sep 2024 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727725832;
	bh=IiY6jYyVVrg6cUdyYvl4A55Mh/miW3UHIqgqPh/8C7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YVt92QqS8yFzB5IG5kLfLMTm7B6UlOWAJnGDBqUpTrIUIC9kW9Xk1k7nQgGWKcOns
	 skdCDa30WJMDcOHUZvU9thoNhHELHqphuG7nOFe/DY8dauHj2WsqXHtL+K3veM6J4i
	 gcr/3YULvmVIbSFntpylWp9OlsNjrzAhZqcurpSPV7EHn9apSiYdjnm7uLEdPCoGE6
	 MvKAFAWBQtbPQ6bRKtzgsWYCz/V/E2Orap76x2Gr90oYGZhmioIRJ8MNDR8ibCTPf+
	 yPKX/JD7r2+CIVVmLpQU9LqhsHDMIM3q/Nj9QfXUgqffgFyN7+cGGQkO6Rw1ImEbtE
	 zXxKM+gBW9uxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D4C3804CB9;
	Mon, 30 Sep 2024 19:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] client/player: Make endpoint.show print all
 endpoint with no argument
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172772583499.3906813.3223207110054807166.git-patchwork-notify@kernel.org>
Date: Mon, 30 Sep 2024 19:50:34 +0000
References: <20240927195416.2527923-1-luiz.dentz@gmail.com>
In-Reply-To: <20240927195416.2527923-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Sep 2024 15:54:15 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes endpoint.show arguments optional and in case none is given
> print all (local and remote) endpoints:
> 
> [bluetooth]# endpoint.show
> Endpoint /local/endpoint/a2dp_src/sbc
> 	UUID 0000110a-0000-1000-8000-00805f9b34fb
> 	Codec 0x00 (0)
> 	Media Codec: SBC
> 	Channel Modes: Mono DualChannel Stereo JointStereo
> 	Frequencies: 16Khz 32Khz 44.1Khz 48Khz
> 	Subbands: 4 8
> 	Blocks: 4 8 12 16
> 	Bitpool Range: 2-64
> Endpoint /local/endpoint/a2dp_snk/sbc
> 	UUID 0000110b-0000-1000-8000-00805f9b34fb
> 	Codec 0x00 (0)
> 	Media Codec: SBC
> 	Channel Modes: Mono DualChannel Stereo JointStereo
> 	Frequencies: 16Khz 32Khz 44.1Khz 48Khz
> 	Subbands: 4 8
> 	Blocks: 4 8 12 16
> 	Bitpool Range: 2-64
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] client/player: Make endpoint.show print all endpoint with no argument
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95c15d2ca02a
  - [BlueZ,v1,2/2] client/player: Make transport.show print all transports with no argument
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eda123dc6d8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


