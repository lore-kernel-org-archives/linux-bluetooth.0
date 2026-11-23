Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462810;
	b=Y8kcd7nWZa9ukLJpq+2DhpNGrFdHGGLG9DeS8EzdbpoF65GBGVSA6UKJbjll5a4Zrv2W
	 rg5UWT0IT5Zu9BjTJKFRuXABDL2ycX+8rQXdO/eiyt0tkN6QDERxwoiZC4jabyAx+QejF
	 o+EDTNfzMOJqLhvfV6fHIR2JGLSUs6Me5zySJxyN7IHP89cY9dxqHwrBkAv2FPV5sT0SN
	 Tcj/U0IPdjFbatyipMxMOjrXzuMWN3fERYV8DX7yCEerk7oqojdalMDtxrfG60QvKSZA2
	 V0CI3jr9TMCCsHaDhqGu2tYMsr6O6VKWjgARj8XVRUwzhq5wHkZGGPrRPauJiUwnwkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=X4Wz1fa2XgC02KtsQtm4+jcX/irOIpKPHtjUEMYT14g=;
	b=zmsMM8/qmPQCN1wPrjG3wlsD6Ie930Bdl3HRe/gE/O7a8wnSnp3ESW3mYAVxH6cZ1r9x
	 eRrve7qQ0HvlIVontw4kZPTu3RbB3ht7tMNuGzhQrtz8kAMoVze5itTOYLsQZFH9Q+W1N
	 kO+xrOIlL+Av915GCMbRrj8x7T3g1HUDJaQX2HvJai2QG4N6jXywGslaczIfa+9Hylmfg
	 sbTcZYbkapy7ZhJIwqG2LSXnzM4Ela/63HpiEaK1z8xd+mniBcPlvNEz3Z3y4zriREdYR
	 WlrtVKZD78kLByjaoJwFfnODHLQHkWDlRnuOqyhq5o85tLZOzdEWdGyVlfMOrjY/8pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDxXw2i1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD017606A691
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDxXw2i1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FD21F01561;
	Mon, 23 Nov 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462810;
	bh=X4Wz1fa2XgC02KtsQtm4+jcX/irOIpKPHtjUEMYT14g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gDxXw2i1cB8X1hpgdLmD/828zsDqlyVld+Q+e2j95I9b4tuQ1Kq4pFWTcPhDuGOco
	 oWD9Zil7foVrQNlU5GzYlvFWrDz+DAHuzGd2IhNgJiK/0PmaBwIWDW9UsykT2s2uoo
	 1UjfaaVbG9vDzkEXB+Oy5bVsJvOIA6lNO+HFSnnndeQKctIzLkhO9k9+RMvl4mR2Al
	 GyFIqmYsrRH+0DvO6RSopxuTS4BkmxsgMspFNtVa3steHYLt0oMVor3qhgY5q1fJ5/
	 v0a56wOnmjYBl7+1ziLIez197xIOhx5kZBkwiJgBVmgekSAeoMBenZQjri5SegKFKF
	 +/g6J5F40S+BQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A330392EE3B;
	Mon, 23 Nov 2026 19:40:10 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: btbcm: Add default address for BCM4345C0
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546280877.3078240.14570837249148130076.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:40:08 +0000
References: <20261122155527.1553835-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122155527.1553835-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 16:55:27 +0100 you wrote:
> The BCM4345C0 (CYW43455) on the Raspberry Pi 3B+, 4 and 5 uses
> 43:45:C0:00:1F:AC as default address, so add it to the list of
> default addresses. This way the address from the device tree is
> used instead.
> 
> Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btbcm: Add default address for BCM4345C0
    https://git.kernel.org/bluetooth/bluetooth-next/c/4f9e1dcab504

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


