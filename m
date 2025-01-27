Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6838DEC
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990606; cv=none; b=tvPr2LFF1iKX10Ntf0rvp5TjGd12UjEkX0Sv/EoEaGqxJPUrHNp+GJps++brX7NXVsc9myOOBY/aIYhBMF/+b0DZm34YAd/LL3Q0pEqiETAO9MwVG0SBPIcPcW5HiG3aaVpWyoQ4Y0tyvB/x8rdmd0ajrH1t3IYUZOe5IdtBURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990606; c=relaxed/simple;
	bh=GBhTYUHGlqIEZv630k3vR/jY+N0czVKhnU9JYsxtxM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NH8EfLGa7Q8/NX6R3v7c4DVaq1DXJbJgpziDbxjfhRfIgSKHKsjG7dTxvW5rvymMOJvmWWYD3YyH3M30bQRkYFGPXiHnyWrpNUPQPE5xl9eQykxoEaeNxt5pjJnLA+0qJivwlig1EhS43AarZSNe3VLRFEWGVJTs7IzMhtnAEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1S7Rdts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1S7Rdts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE3DC4CEE1;
	Mon, 27 Jan 2025 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737990605;
	bh=GBhTYUHGlqIEZv630k3vR/jY+N0czVKhnU9JYsxtxM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b1S7Rdts1RZQDhvpyWwnz9oY+007eocrIFlEing70GUiSCeZhGHn2GlOfYRHZxODc
	 5VZA5QHJha7ccZoHqleS0B/S80N2Hl7z4XWd4Pj2AwG3zsNsU/ZaauiyVqaiMEZNJb
	 xXFcwbCokARLB90CePAyQPV/MUB0tcnMCLtJCC4SCBv5GtadvWZZywE/lIKtziwWmY
	 me8oCw3L7gzrSh2WaTLbK8dyuvt1183wfdd4Og/DCme8PoX1FI8ePLy7XAFABErCHm
	 bdYLl0E4yJetbBOzlV/qO+cCYhaRx7Thf6rXDpmEb+t1/lUUxuUAk6B0CVptU5uhk4
	 WOPlL/AupSPrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3452F380AA63;
	Mon, 27 Jan 2025 15:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] avrcp: Fix crash on remote player changed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173799063100.3128680.685095842597742889.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 15:10:31 +0000
References: <20250124110331.1003810-1-frederic.danis@collabora.com>
In-Reply-To: <20250124110331.1003810-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Jan 2025 12:03:31 +0100 you wrote:
> bluetoothd crashes when the remote player changes while bluetoothd
> is waiting for avrcp_list_items reply.
> 
> profiles/audio/player.c:1597:9: runtime error: member access within null pointer of type 'struct media_folder'
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==825871==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000020 (pc 0x602bb0fffabc bp 0x000000000020 sp 0x7ffef88216d0 T0)
> ==825871==The signal is caused by a READ memory access.
> ==825871==Hint: address points to the zero page.
>     #0 0x602bb0fffabc in media_folder_find_item profiles/audio/player.c:1597
>     #1 0x602bb100cd3b in media_folder_create_item profiles/audio/player.c:1877
>     #2 0x602bb100cd3b in media_player_create_item profiles/audio/player.c:1928
>     #3 0x602bb107eae6 in parse_media_element profiles/audio/avrcp.c:2605
>     #4 0x602bb107eae6 in avrcp_list_items_rsp profiles/audio/avrcp.c:2706
>     #5 0x602bb106892f in browsing_response profiles/audio/avctp.c:987
>     #6 0x602bb106892f in session_browsing_cb profiles/audio/avctp.c:1028
>     #7 0x73de85b1448d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d48d) (BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
>     #8 0x73de85b73716  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc716) (BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
>     #9 0x73de85b14f76 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5df76) (BuildId: 461eff2b4df472ba9c32b2358ae9ba018a59a8c5)
>     #10 0x602bb13a22a8 in mainloop_run src/shared/mainloop-glib.c:66
>     #11 0x602bb13a2bb6 in mainloop_run_with_signal src/shared/mainloop-notify.c:189
>     #12 0x602bb0fd0257 in main src/main.c:1544
>     #13 0x73de84e2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>     #14 0x73de84e2a28a in __libc_start_main_impl ../csu/libc-start.c:360
>     #15 0x602bb0fd3124 in _start (/home/fdanis/src/bluez/src/bluetoothd+0x5c8124) (BuildId: 367892bd0501d74713dd7341977abfac1b2c5d6a)
> 
> [...]

Here is the summary with links:
  - [BlueZ] avrcp: Fix crash on remote player changed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fac78ca5dbbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


