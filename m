Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65733090C2
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705415; cv=none; b=g7lv5yNUAqOXR3BiZeuuTjCdKLSTa993DqPjVpHJirLKLDtdd7JdCQMeCI4IAYFLBrnc4zc1UNAQvv/aWUT83QdAxUZbUyhI7/UWv30NafgqkA0EK9GIeW5xVLY2j1mvUcMt6W5oGHCRLcnRFdSH/4LUtmaw7pxisvTS+9s+bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705415; c=relaxed/simple;
	bh=FQJPsE72YO31fmtDk7NH5qu4EKKBomEpMXg9S0jeYtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gfyryDIIHfAmh7mxFNSiaQ5gZnE0DaTWcoRVXRmPT2Sy2c458pyz2gDkW/ZuyPXHZlP0GAK2Hl9iFbFMa+GKE61183row7SCX7W5D3uKNKH0RE5+jmSBuwY32+DgIcdZS0gSnrV6Ghoy9T1jUpidEVPbMjaAKp5JuxaisA2g00c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEloE2uK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEloE2uK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A611F000E9;
	Wed, 17 Jun 2026 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705412;
	bh=MLgV3CYbFGiBckz7Byb9L3w6T/GpJFPi1ZYunEe10iE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EEloE2uKANYz1pwB7XzVdXlXSN6bPfButP72oQth1EeklRBf3Eh4OUbzs+/K4PCGW
	 g1zDdUKWqP9lFFsug4w38ptqcSt4rYGVnUq9Pw2Rpihs+ZSRHpF62iC/YIv0uiRKP1
	 PIbhgwkndAwfuJn7Wq0/03eti4fH0pitIlROdkl37oZlnPFkZGrcqoyRcqpQYWwtKi
	 d1Ydk8QGQ0GVlVfJw/UD4lyvCldAZr1FTXHLTN4SEs4AKj3O2u6f3zBV2M2ea7jj0u
	 oxgPuhD2WnaZhiCe0ck0f5SZ6uVrev6hMA+OWRFM/OClNDtvrUQR3N69Is5GbNyQ/w
	 rmVoSy8/ckOyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939EA3930E39;
	Wed, 17 Jun 2026 14:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/gatt: Fix gatt-db buffer overflow for cloned
 db
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178170540613.1639014.3496569475203817334.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jun 2026 14:10:06 +0000
References: <20260616123029.301362-1-frederic.danis@collabora.com>
In-Reply-To: <20260616123029.301362-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Jun 2026 14:30:29 +0200 you wrote:
> On notify_service_changed() timeout, db_hash_update() is called but
> for cloned db the last-handle has not been copied and only one slot is
> allocated, ending in buffer overflow:
> 
> ==288975==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x5020000ac220 at pc 0x55f8b7e551bf bp 0x7ffcd6e9ddf0 sp 0x7ffcd6e9dde0
> WRITE of size 8 at 0x5020000ac220 thread T0
>     #0 0x55f8b7e551be in gen_hash_m src/shared/gatt-db.c:415
>     #1 0x55f8b7e5d817 in gatt_db_service_foreach src/shared/gatt-db.c:1744
>     #2 0x55f8b7e5d817 in gatt_db_service_foreach src/shared/gatt-db.c:1722
>     #3 0x55f8b7e60c6c in foreach_service_in_range src/shared/gatt-db.c:1633
>     #4 0x55f8b7e60c6c in foreach_in_range src/shared/gatt-db.c:1656
>     #5 0x55f8b7dde002 in queue_foreach src/shared/queue.c:207
>     #6 0x55f8b7e5c435 in gatt_db_foreach_service_in_range src/shared/gatt-db.c:1698
>     #7 0x55f8b7e5c87c in db_hash_update src/shared/gatt-db.c:442
>     #8 0x55f8b7f15283 in timeout_callback src/shared/timeout-glib.c:25
>     #9 0x7fc1845154f1  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e4f1) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #10 0x7fc18451445d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #11 0x7fc184573976  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc976) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #12 0x7fc184514f46 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5df46) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #13 0x55f8b7f157e8 in mainloop_run src/shared/mainloop-glib.c:65
>     #14 0x55f8b7f16116 in mainloop_run_with_signal src/shared/mainloop-notify.c:196
>     #15 0x55f8b7af46df in main src/main.c:1709
>     #16 0x7fc18382a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>     #17 0x7fc18382a28a in __libc_start_main_impl ../csu/libc-start.c:360
>     #18 0x55f8b7af68b4 in _start (/home/fdanis/src/bluez/src/bluetoothd+0x6588b4) (BuildId: 89dc89ac5800f58cc305bae57a965b1185601a3e)
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/gatt: Fix gatt-db buffer overflow for cloned db
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa8d0a2b6841

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


