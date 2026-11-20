Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195207;
	b=lgRCg68aSWJeG13YaintU60A09AUEwhlnYxlDbH8C45RiSa7Uo5+KAsH+unJ66U4xukM
	 lY+QikHsIlQDYCMnFT6DG2/xDEO2rGD3OgHxaAJHCoxRl1kH+OHezXAPqnMqt+/5n/oqG
	 4q6K/JMAw6acYRmr5Gth6j5ztmBdOf4BCmp0GBF1bFv7JaEpnlTNZdRSuZqX7L7rayJAI
	 QFfD8CDX6LQrVUqqgS3WtWCt4Mz4ed0YU2hyjg+GROWLmcZGmD9Zmorkt4jv1AwfFtOCs
	 98Ql9g/7oka1PwBYA6fjEDsvF7edqNcxBDCC3a2DgCPsZcU9FL2b77shcRJKEf+GVDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=stbY6RyBYX0J6lQyHoEKH3y5E24DblkhJDBPRzo9SDI=;
	b=qrW5gekGn1OvQ+jfwAFGZMcTV9sB4UtOBsZLgO4Q8O41Mt7lbsUeT5C56rLzijSV4Hgy
	 C1mAc0i4Y1ZcDb7VOpFZT0qSbX4xtfZtjuMSic1nQqLcdYpH1c1Xo4YJA5g9fC34JQkhl
	 VHFuaYFuUTp80wKP5D7Fy1S7GcY7NNnUPoK70derkYvoIvREszT3JBly4LQUv9Jv2aYft
	 txEzYFM5txBQm+FLBW0UeaYusHYK4CAC/APWz2t2PCkpYcsVKEcrcjaVZKFKWZy54QpvF
	 K6IzcNsxzwghtScfNKxhM2SsPDfMXgyzC7n9Azf0KMr4S0+yOpIE/T9sUw4KOJgBXMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0PqarrS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF3606A320;
	Fri, 20 Nov 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0PqarrS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FE31F000C4;
	Fri, 20 Nov 2026 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795195206;
	bh=stbY6RyBYX0J6lQyHoEKH3y5E24DblkhJDBPRzo9SDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L0PqarrSZ77qq1IRI+M0p1GXieOSuZLf6CpmHdd7W0rAC4LFcXS7PgJu7mqbAuj1B
	 gfndqnjC/s/G9k3zqZheM6THqmHhoJvaR2Lv4YBrfqGW6qs4CvcdCv6xReFsrb53np
	 iGTxOJAr7IB6FyH9A0t2bdHnO/WbXgg30anxjKeyNiICRdU2FCfI+S1Vz+UEyc1n6m
	 keg7OzhAcADdaMdwxtRk0/wLGZp3Z5ALacHvzMpalkgAgvU5FR3qTuSxRKE1ilV8Dq
	 lmf7rVZGC5z6yKmYIglnquyswDddBR+MFiQ6GOsGxoEacCwFUB9MhBXC2yzrhYnzLG
	 kbTfXKl2xBBdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775763809A88;
	Fri, 20 Nov 2026 17:20:06 +0000 (UTC)
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
Subject: Re: [PATCH 0/2] Bluetooth: MSFT: Only enable the advertisement filter
 with monitors
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179519520528.673037.13658094971187951302.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 17:20:05 +0000
References: <20261120-msft-filter-monitors-v1-0-8192f0c0791a@pm.me>
In-Reply-To: <20261120-msft-filter-monitors-v1-0-8192f0c0791a@pm.me>
To: Thomas de Gruijter <thomasdegruijter@pm.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com,
 howardchung@google.com, mcchou@chromium.org, apusaka@chromium.org,
 luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Nov 2026 02:13:34 +0100 you wrote:
> On MediaTek MT7922 (USB 0e8d:0616, BT firmware build 20260724) LE
> discovery and passive scanning find nothing, because msft_do_open()
> enables the MSFT advertisement filter on every power on even when no
> advertisement monitor is registered, and this controller then drops
> every advertisement.
> 
> Patch 2 only enables the filter while at least one monitor is offloaded.
> It is the first user of msft->filter_enabled, which does not follow the
> controller when it reports the filter as already being in the requested
> state, so patch 1 fixes that first.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: MSFT: Record the filter state on Command Disallowed
    https://git.kernel.org/bluetooth/bluetooth-next/c/75d6b9d82c35
  - [2/2] Bluetooth: MSFT: Only enable the advertisement filter with monitors
    https://git.kernel.org/bluetooth/bluetooth-next/c/4a8f9b7fb4f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


