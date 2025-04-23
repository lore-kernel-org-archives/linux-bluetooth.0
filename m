Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFA253921
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441390; cv=none; b=G0JEsEdnQbe+g1ggbNsg2vzwlZlTfGM37u+6E+1O4LIP0OJrNMYrDrXhZ3A06a93AXWbVpYSlmJ3HdB4uMhQpa0yEq0g9RFl+Ua8pa7q+uc/1Koa4ApNjuwoTxfPC8iHui+5qV3BOxGJ4C2oqlZOC5HBM/CTTKvGiZbkjNW8xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441390; c=relaxed/simple;
	bh=TxyC6tSS5XM6EXInNqq60NE8TUstdxoQr6WelIXMAMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CEdEHhkXq1o66LMtcwsaD+xzXCrenRneFL0gxTFDKePnTvdQaowTaHMq+o3cyZ+OeQ5azJKr9HT2PB1U93mtNqaeCSlQV46T5ZAkLRbNLLEhnm9ycxkqV0VlRKL1DCM9ACWXoGoyqXnALkQe6lpXT46hiTaZkT1M0Iu6j2/apnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgECcbwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgECcbwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6DFC4CEE2;
	Wed, 23 Apr 2025 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745441389;
	bh=TxyC6tSS5XM6EXInNqq60NE8TUstdxoQr6WelIXMAMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TgECcbwIYYp1hVr5QtjuRG5iOtQaz5kB2oMNRZe29R7U1urgF1CZtv8pGsseQ+5sO
	 cDveOIJ7fvuslG3rTNehRs/+LqEqQGhLMcQxgYCBJlYy/YJ8Mj79WxpLgdq55DqsNY
	 4SLlWUbKRNrWWbjkUC9sL3byK5ti12gDOBGpBsPwQG2WtTiEssN/jtpYSxgYMDgMTJ
	 2kuLEUbTrH6A2I5g3XjKpY8S2Bohp/3+m7/w2fYSBWfc6QDRMRnXsu4NUmEDZqwJAY
	 wgJcTh1v/x35CY7Xw99xCMYBVhYwex85pv5vPNwLUSOKfR5vjOkozh/EpKuSKs2/IO
	 6tnfE9b9D+L1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3E380CED9;
	Wed, 23 Apr 2025 20:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] audio/source: Fix crash on authentication failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174544142825.2763533.17807350064210916292.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 20:50:28 +0000
References: <20250423092027.230229-1-frederic.danis@collabora.com>
In-Reply-To: <20250423092027.230229-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Apr 2025 11:20:26 +0200 you wrote:
> The AVDTP reference count may decrease under 0 if authentication fails
> and avdtp_unref() is called from source_unregister() then when changing
> state from SOURCE_STATE_CONNECTING to SOURCE_STATE_DISCONNECTED:
> 
> src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
> src/adapter.c:connected_callback() hci0 device EC:28:D3:0B:3B:7B
>  connected eir_len 33
> src/shared/mgmt.c:can_read_data() [0x0000] event 0x0011
> src/adapter.c:bonding_attempt_complete() hci0 bdaddr EC:28:D3:0B:3B:7B
>  type 0 status 0x5
> src/device.c:device_bonding_complete() bonding (nil) status 0x05
> src/device.c:device_bonding_failed() status 5
> src/adapter.c:resume_discovery()
> src/profile.c:ext_connect() Hands-Free unit failed connect to
>  EC:28:D3:0B:3B:7B: Permission denied (13)
> src/service.c:change_state() 0x556200cee6d0: device EC:28:D3:0B:3B:7B
>  profile Hands-Free unit state changed: connecting -> disconnected (-13)
> src/device.c:device_profile_connected() Hands-Free unit Permission
>  denied (13)
> profiles/audio/a2dp.c:a2dp_source_connect() path
>  /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B
> profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=1
> profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=2
> profiles/audio/a2dp.c:setup_ref() 0x556200cf3760: ref=1
> profiles/audio/source.c:source_set_state() State changed
>  /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B: SOURCE_STATE_DISCONNECTED ->
>  SOURCE_STATE_CONNECTING
> profiles/audio/source.c:source_connect() stream creation in progress
> src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
>  profile a2dp-source state changed: disconnected -> connecting (0)
> src/service.c:btd_service_unref() 0x556200cee6d0: ref=1
> src/shared/mgmt.c:can_read_data() [0x0000] event 0x000c
> src/adapter.c:dev_disconnected() Device EC:28:D3:0B:3B:7B disconnected,
>  reason 0
> src/adapter.c:adapter_remove_connection()
> src/device.c:device_remove_connection() connection removed while
>  Connect() is waiting reply
> plugins/policy.c:disconnect_cb() reason 0
> src/adapter.c:bonding_attempt_complete() hci0 bdaddr EC:28:D3:0B:3B:7B
>  type 0 status 0xe
> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> src/device.c:device_bonding_failed() status 14
> src/adapter.c:resume_discovery()
> src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
>  profile a2dp-source state changed: connecting -> disconnected (-103)
> src/device.c:device_profile_connected() a2dp-source Software caused
>  connection abort (103)
> src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
>  profile a2dp-source state changed: disconnected -> unavailable (0)
> profiles/audio/source.c:source_unregister()
>  /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B
> profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=1
> profiles/audio/a2dp.c:setup_ref() 0x556200cf3760: ref=2
> profiles/audio/a2dp.c:setup_unref() 0x556200cf3760: ref=1
> profiles/audio/a2dp.c:a2dp_cancel() aborting setup 0x556200cf3760
> profiles/audio/a2dp.c:setup_unref() 0x556200cf3760: ref=0
> profiles/audio/a2dp.c:setup_free() 0x556200cf3760
> profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=0
> profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=1
> profiles/audio/avdtp.c:connection_lost() Disconnected from
>  EC:28:D3:0B:3B:7B
> profiles/audio/source.c:source_set_state() State changed
>  /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B: SOURCE_STATE_CONNECTING ->
>  SOURCE_STATE_DISCONNECTED
> profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=0
> profiles/audio/avdtp.c:avdtp_free() 0x556200d2fb80
> profiles/audio/a2dp.c:channel_remove() chan 0x556200cf5400
> profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=-1
> profiles/audio/avdtp.c:avdtp_free() 0x556200d2fb80
> 
> [...]

Here is the summary with links:
  - [BlueZ] audio/source: Fix crash on authentication failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6c582e7e1360

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


