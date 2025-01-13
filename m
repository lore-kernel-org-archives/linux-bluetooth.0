Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608251C07C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801414; cv=none; b=lz/O4emT6L1Q2FKdFiQoLzvMy6eNtQNvX6Nlpm4Bc/k+rjdvpdJDmNxR+jvXVZ5i5v5kKpUYWJjZd+sZoYvCxPQCt8KjVDo6TsKmOMbe7DuQgM5cSFYiYRp10f0iadHPg3gYVF1YGBKRwPyw16aCnL+rshthYEvs4/otNbLCdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801414; c=relaxed/simple;
	bh=S0DBF2AZLmkcq0yRGRfZvtouvm0S9EXq+GS4mUp0C0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/XxVyQW+N+f0a7OXZ3yHRVyvyijE2wpmiQN15nD3Z3XjaOIw1wquxFefF/H6hraV7Ch54UVakQIMlhQT0KF1JUgffLUydo83fJbJkIS4xgNasMnLNjqhfhGlbqoQ1f0v+XUhl+J7iXOCVc8AGtNsfcXBGFPrrCzPDY8OZs/JMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRfj2Oax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRfj2Oax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7710C4CED6;
	Mon, 13 Jan 2025 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736801413;
	bh=S0DBF2AZLmkcq0yRGRfZvtouvm0S9EXq+GS4mUp0C0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jRfj2Oaxc3/XKQvxZWiyIZhQ4p52wGOqho+o3oxCvMPX9wGbj/tbWeXA3lmwZTlow
	 tqVze4su/X43HH24dFYHTjO94fRj/7N9Ewy3quNxB6l92lyXIYDoRle96YXU7KLu9t
	 WNkK+Qg+dc47cSaLIyjV9Oc14AeXW47BKjbd/CpNOWtDIi2dTque3A2DAgk/Y6r6FB
	 nMNDfqbJTS/9K/r8wyna8cYlP8ODoouW8FH3QJbDAY96g/oSR6+Pr+wQsKS3OjMquE
	 7HLBE0fWzY+zn9lU8CBVPy2AakWDeHFBDSbTRr8Hc7LdHVTi8rt3YnGp/qpJ19mbSP
	 o7d5MLkaPSs8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE31F380AA5F;
	Mon, 13 Jan 2025 20:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] build: Fix --disable-asha
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173680143651.3628468.12634468076488673022.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jan 2025 20:50:36 +0000
References: <20250110164454.2660347-1-luiz.dentz@gmail.com>
In-Reply-To: <20250110164454.2660347-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jan 2025 11:44:54 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes --disable-asha causing build errors:
> 
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_set_volume':
> /bluez/profiles/audio/transport.c:2362:(.text.transport_asha_set_volume+0x2f): undefined reference to `bt_asha_device_set_volume'
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_get_volume':
> /bluez/profiles/audio/transport.c:2345:(.text.transport_asha_get_volume+0x9): undefined reference to `bt_asha_device_get_volume'
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `get_asha_delay':
> /bluez/profiles/audio/transport.c:1566:(.text.get_asha_delay+0xd): undefined reference to `bt_asha_device_get_render_delay'
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `asha_transport_sync_state':
> /bluez/profiles/audio/transport.c:2216:(.text.asha_transport_sync_state+0x8): undefined reference to `bt_asha_device_get_state'
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `asha_transport_state_cb':
> /bluez/profiles/audio/transport.c:2245:(.text.asha_transport_state_cb+0x1d): undefined reference to `bt_asha_device_get_state'
> /usr/bin/ld: /bluez/profiles/audio/transport.c:2252:(.text.asha_transport_state_cb+0x94): undefined reference to `bt_asha_device_get_fd'
> /usr/bin/ld: /bluez/profiles/audio/transport.c:2253:(.text.asha_transport_state_cb+0xa0): undefined reference to `bt_asha_device_get_imtu'
> /usr/bin/ld: /bluez/profiles/audio/transport.c:2254:(.text.asha_transport_state_cb+0xad): undefined reference to `bt_asha_device_get_omtu'
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_resume':
> /bluez/profiles/audio/transport.c:2290:(.text.transport_asha_resume+0x19): undefined reference to `bt_asha_device_start'
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_suspend':
> /bluez/profiles/audio/transport.c:2303:(.text.transport_asha_suspend+0x1e): undefined reference to `bt_asha_device_stop'
> /usr/bin/ld: /bluez/profiles/audio/transport.c:2307:(.text.transport_asha_suspend+0x48): undefined reference to `bt_asha_device_stop'
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_cancel':
> /bluez/profiles/audio/transport.c:2318:(.text.transport_asha_cancel+0x17): undefined reference to `bt_asha_device_get_state'
> /usr/bin/ld: /bluez/profiles/audio/transport.c:2320:(.text.transport_asha_cancel+0x22): undefined reference to `bt_asha_device_device_get_resume_id'
> /usr/bin/ld: /bluez/profiles/audio/transport.c:2334:(.text.transport_asha_cancel+0x61): undefined reference to `bt_asha_device_state_reset'
> /usr/bin/ld: /bluez/profiles/audio/transport.c:2328:(.text.transport_asha_cancel+0x81): undefined reference to `bt_asha_device_stop'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:6378: src/bluetoothd] Error 1
> make: *** [Makefile:4696: all] Error 2
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] build: Fix --disable-asha
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5f8a68d9f299

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


