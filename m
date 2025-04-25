Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652021882B
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607680; cv=none; b=JcP8lRW2ZJGgk+yABV9/QwSIi28qfYVBysQWFyzLL+/81tXVarnQ/Q63vP/fLsb1QRI3JIwkucWRGYq+x90KnbnISnI7as8thIxxxASoSdQCMu3Pcexl43v+cnYgacllafedOnHQLOUem5oFajQIUo9P80ymI2OIDKzGFEwNrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607680; c=relaxed/simple;
	bh=ovX83Ut+iwAvCru6L9B1e9bdf4bx3ENv4VjKBm1MD4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mfz/j2WdrRq9wNdZOHTgtONX1rg2U9ijictkDW1WHgtLha21fzEbkR16B2E3ZxNaLe9p+e3uPSuTxrsjdK5e3M7iPK6aV93dbvzyFeC791XCcRWX7dNQeegqYN/134F1NZ49nEpDwb2UkU5MT+2BiuamC5zbzXRpk/detdG05cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3/rFG8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3/rFG8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53327C4CEE4;
	Fri, 25 Apr 2025 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607679;
	bh=ovX83Ut+iwAvCru6L9B1e9bdf4bx3ENv4VjKBm1MD4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t3/rFG8k/mj7mhYfZ989vRaOmqLfpD3ffryhOa4topwxLAkeGhkM1cFLIMWkOYH4f
	 xTr5eabMjz6cvKRumSlTMTmwLINAGk/H6OTzQ6lYzvW3fmZ33KIqJTFX1FhI7vQMvW
	 0OuEWFt2LZX/JcJQLT/kOthTZEl5QuBr10pGdBeNYlXOaPRi/wPJocXOTY4via24sj
	 5MMQMYz0Uv+nPKmiH1ihlpN3vK0ngChFsLBGJLc55I6ntHt9su6wyyGFHNuBYXqS/x
	 Jr0U/EqgN+0VRUvgS4/snA3hr+tQClN54l/4f9cy9JnvXWaY4DIGL5Azkd28ifFZZP
	 SYX815GdzIioA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA4380CFD7;
	Fri, 25 Apr 2025 19:01:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Check presence of ServiceRecords when loading
 from store
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174560771773.3803904.2138994537181737272.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:57 +0000
References: <20250425144418.408145-1-frederic.danis@collabora.com>
In-Reply-To: <20250425144418.408145-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Apr 2025 16:44:18 +0200 you wrote:
> For a HID paired device, if the cache file containing the SDP records
> is not present this will prevent the device to connect and need to
> remove it and pair again.
> 
> Current bluetoothd traces:
> src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
> src/adapter.c:connected_callback() hci0 device EC:83:50:76:BD:67
>   connected eir_len 31
> src/shared/mgmt.c:can_read_data() [0x0000] event 0x0006
> profiles/input/server.c:connect_event_cb() Incoming connection from
>   EC:83:50:76:BD:67 on PSM 17
> profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
>   psm 17
> profiles/input/server.c:confirm_event_cb()
> profiles/input/server.c:connect_event_cb() Incoming connection from
>   EC:83:50:76:BD:67 on PSM 19
> profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
>   psm 19
> profiles/input/device.c:hidp_add_connection() Could not parse HID SDP
>   record: No such file or directory (2)
> profiles/input/device.c:ctrl_watch_cb() Device EC:83:50:76:BD:67
>   disconnected
> profiles/input/device.c:intr_watch_cb() Device EC:83:50:76:BD:67
>   disconnected
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Check presence of ServiceRecords when loading from store
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c3b6f4e4b456

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


