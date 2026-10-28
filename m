Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217023;
	b=VfzOms/L9RdtwgjjHX2Nj2NENKlaukn/l0IsK8Elb8TrXWGtrVLMcAf3jMdw139nr9q8
	 YG9xKj8gqM1AptDDua4IYY3mQcZM/YI67WsJ1FFNHRyJC9Lu6bp7H65KcDkqCP2mW+Bkl
	 oaMwKUTOAC95QyFTG4MCHDzwI2OGcCz34jHijATlQJ10tIgtlrUBE36G1h0HnSwO/arKU
	 F7qIhPgwg99Ya4XecvcYwzX/O3gf3u9ZoUk4VX/ItVZmsaUf7ej/Bt5UCsAJxeFby2LKA
	 NHpcS/dQdCe3MkkFN/H+Vw5YqbzE3hUex+rxvgxRVKmke3bUej8yhWXYGOR4CCHK3RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217023;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Jb0ADzkFytfS6WossXrNl23EVj2qsvIGw4AOr2fJ9yc=;
	b=hGyC/UWA+BDw6eQYdGMz7jYiKlJC9/Iu+Aws/LtjU2dShe+qW/Q8xH019i9aqz8hoyR3
	 cixam3V33m/gHfrWmWGKLwlhFRmwtKHzMXn6IyXKQRDlF8rt3ZzxImtNpgUcc3Q5Vz8Tu
	 G3GxNgBEAAdn38nG7zKsUdTxS2EMFeacBb4a9wHJ2fTlmBxf0jDU+mj8vNBpxEFSaU/oM
	 X7+8y7wmFdqeeX94QRRMseHVNuvlDy70MiHVRSGD9G+yiZyZVopl57EftzZDkUcKKgG8v
	 y2nYvKgLYOFwXPzK11Y7btPDAJHg7VceoMc0UPCkY/cXz5HK83kPWZ/eD3MQrQFIabQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWNubBSd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8A60A2608
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWNubBSd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1471F031E1;
	Wed, 28 Oct 2026 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217023;
	bh=Jb0ADzkFytfS6WossXrNl23EVj2qsvIGw4AOr2fJ9yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lWNubBSduJmzC1AwEEDfRHIGmhlX5GjEibzUFEy8iPtB0rw1bEL6OISH7TMdfuAVJ
	 AfbNaXwbysj6tS11snTcltOzWtskFnm0ZQif7sDrqqqC6V04fsGuuJDi1JW0g9EwTD
	 jbVvVeAsNuScJtsW96tsCRSMUcvbSPqhHcSlKpo9r1Ikb41tAGlxxUSNasfrJraS//
	 31xuXmqdK4N9gNonpnifas1QYtuymuziIiAXWLADn9bFDVGrOHryhyVdsEWHVWYuSN
	 kS7c0vXK7ifukUAdzmQ0U8fI5um8DIZVn2D8ccxgE/Y3DsQCV7Gz1RnqLtQVToU+fW
	 PiK8Ea5FkHnxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 072E73AAA770;
	Wed, 28 Oct 2026 19:50:23 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ 0/2] adapter: Fix Discovering staying true when
 stopping
 fails
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179321702155.1394536.16083723483237408640.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 19:50:21 +0000
References: <20261027171923.82919-1-kevin@simpleble.org>
In-Reply-To: <20261027171923.82919-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Oct 2026 10:19:21 -0700 you wrote:
> When the Stop Discovery bluetoothd sends for the last discovery client
> fails, stop_discovery_complete() removes the client but leaves
> Discovering true. The next StartDiscovery with the same filter then
> returns success without starting a discovery, as reported in
> bluez/bluez#2547 and, before it, #807.
> 
> The first patch treats Rejected as stopped: the kernel returns it when
> the discovery already ended, or another mgmt client stopped it, just
> before the command was processed. The second clears Discovering when
> the kernel reports the discovery as stopped with no client left, which
> covers the other failures, such as the scan disable timing out. That
> needs the kernel to leave the stopping state after a failed stop, which
> "Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery",
> posted separately, does.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] adapter: Fix Discovering staying true after a rejected stop
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4f3428e9df2f
  - [BlueZ,2/2] adapter: Fix Discovering staying true after a failed stop
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


