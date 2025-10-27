Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73D3009E5
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573040; cv=none; b=O6MniA34T3O4FfnAxaED50RYq1ci5ipAX5eucRyL5M765jQmXTBRyT2UjdZ+0jk2RZaCwINeiSMLFQVlpRTmDtaSVC7/IUwaZj+CZaVnGOQMRKN0dM0tWqgmo1mGSqM6QoOOnW+GctoV8Dx1xsPZ6sIuF4tuQ/AUQaOB367oq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573040; c=relaxed/simple;
	bh=6dyDKLm5YIYTTC4P+DCB4K6AQt2vyczq/ayc5WAmd/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iFT5gWOTahPLZ1DMXU8YjI8Di14pF8mNr6qcbBf9cF7xgRKumElmvu+H/PX3SiVE4XF/ZBQfD9EHcvUqae3vGnUd3LpwttgNg3kbQ6WaP7R0P9lfYPRftz4XeQAdp1tJeTdqtPFanAzcjXZqKwh2nYOxUDWn4E8FOBKHzWCZzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeIjFlCK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeIjFlCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EDFC4CEF1;
	Mon, 27 Oct 2025 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573040;
	bh=6dyDKLm5YIYTTC4P+DCB4K6AQt2vyczq/ayc5WAmd/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jeIjFlCK5vRerhYIp2r2gvSk9foBUhdQdbnwEF1TBZbpWf1k69B/uhNUfTy6LA8f9
	 InHAM8TRrZp9dPHV97hIvEQdFDVXenxQOcHgZDG1/TLwHn4tBNxdhmXIDBNXyQV+/J
	 gva6JYpIx+roZbwhsvQHId5ZYDKDKoaQePr5fUeF0kfq8mvgRJZmfVEnvI23wNFb+Y
	 OSxN+2ixCnSryQZ5/KasuCaiX2p/iZj7jKwjLm3K3ULFKNBEChu04qjC39Y/bkwfQj
	 xgCFeteIlRywXX6mtuaPhO7u2d+OLaRQeSxzx2zAv3wL+xB5MRBZJhqu+Sb0sk/uDt
	 QEqzxE1vQMbqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD76380CEF8;
	Mon, 27 Oct 2025 13:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 01/12] device: Add initial support for setting
 DEVICE_FLAG_PAST
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176157301849.1378834.8431601223283096089.git-patchwork-notify@kernel.org>
Date: Mon, 27 Oct 2025 13:50:18 +0000
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Oct 2025 16:40:28 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces device_set_past_support which can be used by drivers
> to indicate that DEVICE_FLAG_PAST shall be changed.
> ---
>  src/adapter.c | 31 +++++++++++++++++++++++--------
>  src/adapter.h |  2 +-
>  src/device.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h  |  3 +++
>  4 files changed, 77 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,01/12] device: Add initial support for setting DEVICE_FLAG_PAST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4fe45c54895f
  - [BlueZ,v2,02/12] bass: Add support for setting DEVICE_FLAG_PAST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a5ceeb414c86
  - [BlueZ,v2,03/12] shared/bap: Add bt_bap_get_db
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3c67d49258ca
  - [BlueZ,v2,04/12] shared/bap: Fix no calling attach callback on bt_bap_attach_broadcast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=603ffaf50af1
  - [BlueZ,v2,05/12] shared/bap: Fix bt_bap_stream_io_get_qos for broadcast streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c560149e1afb
  - [BlueZ,v2,06/12] MediaAssistant: Add Device option to Push
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1452790f1489
  - [BlueZ,v2,07/12] gatt-database: Add btd_gatt_database_get and btd_gatt_database_get_adapter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bde3c34fd7ef
  - [BlueZ,v2,08/12] bass: Implement Device option for Push
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=10b2a2ff312d
  - [BlueZ,v2,09/12] client/assistant: Handle assistant.push to own broadcasts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=667db9a82a3f
  - [BlueZ,v2,10/12] client/assistant: Detect if object already contains a valid BCode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdf49338d97d
  - [BlueZ,v2,11/12] client: Add script that setup a broadcast source with 2 BIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e52f05e1d664
  - [BlueZ,v2,12/12] client: Add script for testing Broadcast Delegator
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f80a2a57c910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


