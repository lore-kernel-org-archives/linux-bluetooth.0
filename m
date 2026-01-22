Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983D38FF0D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098815; cv=none; b=JQx3/ytVdjIE7fyW3bu2iE64+mmOGLMaqXcbeHOXYmWaRW2F8bWvqWwENHciSjEXfNqDH3R2KvifTr+2+3UUmT3scDKHDAQyVsF4p9rJoIJWs+Hf76vbY2FMfcobf33KsIT76ao3/bjse8RUI+F1hIs5veBC/5Hmayvynmb71T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098815; c=relaxed/simple;
	bh=e4T0XOBpwzqZ8Ue3S3Iop7s47hHStivGlB6W/vE6ngs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cSezM6ZJlx8mJkw8AcqvwIHB8LQiJS3bJ8R4JS1ehrHxGc0KLrFcY8HOMLhvApScquEBZ4NR8SkCZBsLRRQH4p08sWqkurV7Pv3NHtSbJnnshptNqcDegxXUk6S1wwiylfFMmAAOrVdAkQhmRcNE7RvcCzrEV0mF4aoE5qU6Efk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpMQdExw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpMQdExw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9915FC2BC87;
	Thu, 22 Jan 2026 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098814;
	bh=e4T0XOBpwzqZ8Ue3S3Iop7s47hHStivGlB6W/vE6ngs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rpMQdExwETIV+qenJhqMUAdQC6ZegvC2XsFXFg/0Od8p9ysvpV8yMLH+cFxDjTA2b
	 MxPhAVsTKoqgYV9P4+U4Y4AmrC5SbMQl4mOsw/V7upWUvyeqrqL+vIq2w31fcujlEB
	 XraCzwdaSJyYDvK4Ad2xsPeC9Njkxe4g+VFSpmhGNcNQdpfepZbcQuV4lzuMZclA/A
	 FWfarM+KPpiRsfn4ode2LBg7mtvBUi9YBuQqJtA4CUP5Qa8Ex06Vn4+ZPUT3QiZuQx
	 cfSEitYYXBka23SXM/xgxC+NEG91QWVTfoxWhpzxyrUb7Hd7iD3iYRs/Dmqcpsenk1
	 Ohw9Fld51ySnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EBB13808200;
	Thu, 22 Jan 2026 16:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: Fix bt_uuid_hash() crash
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176909881109.1793166.2346543037511239157.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 16:20:11 +0000
References: <20260120163614.261494-1-frederic.danis@collabora.com>
In-Reply-To: <20260120163614.261494-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Jan 2026 17:36:14 +0100 you wrote:
> This is reproducible on Ubuntu 24.04, which enables libasan, by
> calling org.bluez.AdminPolicySet1.SetServiceAllowList() method with
> an array of UUIDs like ['110c','110e']:
> 
> bluetoothd[9975]: [:1.1435:method_call] > org.bluez.AdminPolicySet1.SetServiceAllowList [#468]
> bluetoothd[9975]: plugins/admin.c:set_service_allowlist() sender :1.1435
> =================================================================
> ==9975==ERROR: AddressSanitizer: unknown-crash on address 0x763aef383ee4 at pc 0x648113f85064 bp 0x7fffe4db4970 sp 0x7fffe4db4960
> WRITE of size 16 at 0x763aef383ee4 thread T0
>     #0 0x648113f85063 in bt_uuid16_to_uuid128 lib/bluetooth/uuid.c:35
>     #1 0x648113f85063 in bt_uuid_to_uuid128 lib/bluetooth/uuid.c:73
>     #2 0x648113e90459 in bt_uuid_hash src/adapter.c:3891
>     #3 0x763af2700a5b in g_hash_table_add (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x49a5b) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
>     #4 0x648113fa7232 in queue_foreach src/shared/queue.c:207
>     #5 0x648113eb69df in btd_adapter_set_allowed_uuids src/adapter.c:3924
>     #6 0x648113cd6f11 in service_allowlist_set plugins/admin.c:165
>     #7 0x648113cd8162 in set_service_allowlist plugins/admin.c:382
>     #8 0x648113f97564 in process_message gdbus/object.c:293
>     #9 0x763af2f6f553 in dbus_connection_dispatch (/lib/x86_64-linux-gnu/libdbus-1.so.3+0x18553) (BuildId: 47829078e4267099473c6cf5f5742f16ccb2644d)
>     #10 0x648113f86d47 in message_dispatch gdbus/mainloop.c:59
>     #11 0x763af271440d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d40d) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
>     #12 0x763af2773766  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc766) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
>     #13 0x763af2714ef6 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5def6) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
>     #14 0x6481140bf9d8 in mainloop_run src/shared/mainloop-glib.c:65
>     #15 0x6481140c0306 in mainloop_run_with_signal src/shared/mainloop-notify.c:196
>     #16 0x648113c93d58 in main src/main.c:1550
>     #17 0x763af1a2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>     #18 0x763af1a2a28a in __libc_start_main_impl ../csu/libc-start.c:360
>     #19 0x648113c96854 in _start (/home/fdanis/src/bluez/src/bluetoothd+0x65d854) (BuildId: 4e2b98c227059c308efb311ffe5b023d60e142ac)
> 
> [...]

Here is the summary with links:
  - [BlueZ] adapter: Fix bt_uuid_hash() crash
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdf82c79f8f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


