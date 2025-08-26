Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760422139C9
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215601; cv=none; b=DcBqPqFnq6t+FcdZY4p1MTg9MpbvPGQ3mlAh4pp+sd5Wt1ysK3D22liXiZK9CLohIrYCz0dD8VxiJYqEtokI8UcbuM1XlXjYqGwJfsGUlVt/E1vpjFaIe1dSLl5ZquY/6Y75jzrhEnrBNdFU1fvRXz/jWxAZsU7PVEy3QxIkP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215601; c=relaxed/simple;
	bh=GtTJehn8Lf/p7glBigyII0HkBg8fWUiO5NGWGC30WYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u3JVMzZqZt4kRgQo0WO5C/fSqhgPt9wtaQ/X/HA+QOyitCCLZE4uy0IM0D29F/oITluwVeB6alZfHEAzJFmJMU5N5NFzYqIisRUu0JHyoZepxJtOBp+cvctNvz6l57bCZTdtkSEz/mWHOIQWwXLQ0AmvYDGJuzFTVP32sPeUKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9ayu3xC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9ayu3xC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40683C4CEF1;
	Tue, 26 Aug 2025 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756215601;
	bh=GtTJehn8Lf/p7glBigyII0HkBg8fWUiO5NGWGC30WYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N9ayu3xCKL7ib5bNtydqHp+mc71DXUPbSdW62MOJVjSV4ohnC6cTTZEBrng8P+gT6
	 Lgov6S02ZYykEOtEopN6d67T1g9YuqavCXVj27bBs8c+HRE4pE4654Z054a1eaTufL
	 AEUGPaePYrLWS5xMVxYuvyGBW/5gWJBpZ65Ja9jrbc+KY6Nl1Flg5+jomVqNuZ5kOx
	 5refa16o5ir+mYQclIkuTUiRoxMCrnTnpPATL194j0B8fVibFz+SOWmT8otVybErp8
	 nxAoLXlCs2NSjHrRkJXDfd57RL50CjcZRLSAbMsvOARucnbc/M5ZNa029sMUPWjbUM
	 knhbToWu7iIfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AE6383BF70;
	Tue, 26 Aug 2025 13:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] avrcp: Fix not ending loop during item listing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175621560874.4176029.8933504270003254774.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 13:40:08 +0000
References: <20250826090255.122261-1-frederic.danis@collabora.com>
In-Reply-To: <20250826090255.122261-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Aug 2025 11:02:54 +0200 you wrote:
> When a remote applications return item with UUID set to 0, which is
> against the specs (see 6.10.3 UIDs in AVRCP_v1.6.2.pdf), bluetoothd may
> try to retrieve the same item in no ending loop.
> 
>   bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR2 Rheinland type audio uid 0
>   bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() /org/bluez/hci0/dev_58_66_6D_84_ED_21/player0/NowPlaying/item0
>   bluetoothd[2]: profiles/audio/player.c:media_player_set_metadata() Title: WDR 2 Rheinland
>   bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 end 9 items 1 total 10
>   bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR 2 Rheinland type audio uid 0
>   bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() D-Bus failed to register org.bluez.MediaItem1 on /org/bluez/hci0/dev_58_66_6D_84_ED_21/player0/NowPlaying/item0 path
>   bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 end 9 items 0 total 10
>   bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() WDR 2 Rheinland type audio uid 0
>   bluetoothd[2]: profiles/audio/player.c:media_folder_create_item() D-Bus failed to register org.bluez.MediaItem1 on /org/bluez/hci0/dev_58_66_6D_84_ED_21/player0/NowPlaying/item0 path
>   bluetoothd[2]: profiles/audio/avrcp.c:avrcp_list_items_rsp() start 0 end 9 items 0 total 10
> 
> [...]

Here is the summary with links:
  - [BlueZ] avrcp: Fix not ending loop during item listing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ca209e3f8fac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


