Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819410;
	b=alnCwkO6aWDbwrc6FmIT7WSPrZz0lD6JA1amn8K1BkYSYFjjfSH+zpgnksFF0wCH4jhg
	 AoPisQ4JqBzWn8PL3dQIf7Cwqh0uYAXOfJqLcWFi5x6NIIGhXA57gbo9uToFaLfZ42i5k
	 j1t5PtZO681EKNVltEzACqhsHpi6pth5G18yhTym95QdvjZ06ze2/w6ZgJmoUE9xfSk7t
	 d7soSUb/Ujnnes3owfHOasozDRBYHeCyi7h2xLUAjXAsId2EO9u7yVvDAq1QwUqW3FwEN
	 jRZjgvFrgBMIyQPoT8O025qK9m9wxPWJ6L2uvCSxIDIrIHBD9vfZA9xwQCin3on6xBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+sY6B9zdy5rG8XNoz7DFhIAABOGR5INjvDNmLLH2b9g=;
	b=zfRWZAU2GWscH8GoCpOTPzLCSv+Bpq9w5dyjdxPQe3bQ4Yy5xDjiMveaT/LX35va+UAq
	 lZq7QrhFEAsr271I4rByEcs+jd/ZXWysQv5Lx6oZq5NhKgmw+jZRF6jPSo+gpzxCzdYEk
	 Yk3USQIX2FEqzrYa5FOXsR8pejE2PUJJiUK2TxIx7erA1n8kh25fJDLJgMBha7aHwqLxx
	 nveN7BkVwNZrwNk4aBX5jFAk72uoNsf9mobMqK3MFFkIxqfbot5TR3Zy/5vlb80nXNQeP
	 n9IrJPTboIy3uKpj2aNBj6kOMas3z4JU0zyw7dWDkYfPjgyAkDsuG6OeierWJVR2daQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8yRVdLd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC55606A329
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8yRVdLd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D34B1F000C1;
	Wed,  4 Nov 2026 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819410;
	bh=+sY6B9zdy5rG8XNoz7DFhIAABOGR5INjvDNmLLH2b9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J8yRVdLd10rAkQR1d5ijo1AGpk/HTXbx/laJWZQTi2jYP+OGw6lcYPoVTg0C5+AVE
	 OJbcTGqpaUMRTy0n7PSAVse1D8nP3DVoXaG2A1JbNjo9K4Xd0BezYL3Cv2XXLf5PZY
	 Prp1+LJ24k5nSWSjH28tlPcC9mSz3oG0xDXvSxS5W1QzOB7Kvm+5gspMZWL/3dnwiS
	 8NCkP77o5MTHtvsw++iLpoRLqDHVFutYLZUYAMzTmx68xWKUXgJZSVygF9MtZtjsH3
	 dlG07TciwTNN22amgJH0HDbh5Ym8GUxuLLCZBtqAtoYDd7Z2bpYVM7j4jrKim8mo7R
	 JEaWmvcFcqFjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FB0380045E;
	Wed,  4 Nov 2026 19:10:10 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v1 0/5] Make Notify Multiple timeout configurable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179381940854.3059479.4187675660003846551.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 19:10:08 +0000
References: <20261103203034.3904499-1-luiz.dentz@gmail.com>
In-Reply-To: <20261103203034.3904499-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Nov 2026 15:30:29 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When acting as a HID device, GATT Notify Multiple adds up to 10 ms of
> latency to notifications since they are buffered to be aggregated into
> a single PDU. This set makes the timeout configurable with the new
> [GATT] NotifyMultiple option in main.conf:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/5] shared/mainloop: Free removed idles without waiting for events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2df553c447af
  - [BlueZ,v1,2/5] shared/mainloop: Fix idle ID overflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=833ebd7461cc
  - [BlueZ,v1,3/5] shared/gatt-server: Add bt_gatt_server_set_mnotify_timeout
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d39bf5ebc7c4
  - [BlueZ,v1,4/5] unit/test-gatt: Add Notify Multiple server tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3894749d4f09
  - [BlueZ,v1,5/5] main.conf: Add NotifyMultiple option to GATT section
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ee51551cf70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


