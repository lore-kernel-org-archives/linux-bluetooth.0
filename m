Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710231DE2A0
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971797; cv=none; b=AlV6PVLzE94yTk/fz3OxU4OOJeRna8y4cXAyjOlkD//t1YTqjnXG86ptp2qwqkcS5dNf9TqDRDqu+I7KbROY9wY4WN6yHF1HV2jxifeTAGvZSeQJvBAxHfkGkfOuLpkvO6W0p9CTlacCQPD3/Pf4E0wV8b5y0QYQ+O/6NrHZpHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971797; c=relaxed/simple;
	bh=MwxtXXyprqGa+5Chg3G9+5BlISEWHTQ13NT0nAhd1js=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dUwCHMHAEa+3xb4E2jK6pOP4HydVxfaC3YaCJDpv06LkYu4rSxcH6J/KwaHNeRrvEnZZPGSiDDQpLoSKpI+NXhBktswVdTDjwyzaW02BwNoWJRp+c0kiIqgUqPFxwGuQkqPZK7UNHDi49SYQ6pDIkr8AMtKDAuuNFjEnusQfBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTaYdQj0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTaYdQj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31B8C4CEEF;
	Tue,  3 Jun 2025 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748971796;
	bh=MwxtXXyprqGa+5Chg3G9+5BlISEWHTQ13NT0nAhd1js=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BTaYdQj0F6aqFYVG9mcMib2ZZ0CazUt8KjlaWU4jUmCXoeyO2h56YWP5wUxEoy1SN
	 gf1SQZAyok5AiSdrcGIFzDRqPCFbcMOTBLFXV4do/yzM6+/I67sLfvNRbKdPOia6NS
	 Pza/0g6j+VaXD2Ef7spHis2oErumF1SFBpzxIMwPWxpIkL+70zRiyN+lxQI7jcd6FB
	 Na24d1B/p/wjYzDztdujm1MyKiYj+NvSlsXXsKq2TEHa50kYSP4ovpZhRA7ND4E64n
	 353Y2orNxLB/asXmGK6cfhWNWz1LFt6HuLrOcB5UihTW6QZ891FrCx9gYUrst3oTha
	 m4YRamUSralQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D99380DBEC;
	Tue,  3 Jun 2025 17:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc: Remove extra identation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174897182926.1598265.720579215999897847.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 17:30:29 +0000
References: <20250530184932.419785-1-luiz.dentz@gmail.com>
In-Reply-To: <20250530184932.419785-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 May 2025 14:49:32 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This remove the extra identation which doesn't really matter for
> manpages.
> ---
>  doc/org.bluez.Adapter.rst                     | 409 +++++++++---------
>  doc/org.bluez.AdminPolicySet.rst              |  20 +-
>  doc/org.bluez.AdminPolicyStatus.rst           |   8 +-
>  doc/org.bluez.AdvertisementMonitor.rst        | 116 ++---
>  doc/org.bluez.AdvertisementMonitorManager.rst |  73 ++--
>  doc/org.bluez.Agent.rst                       | 131 +++---
>  doc/org.bluez.AgentManager.rst                |  65 ++-
>  doc/org.bluez.Battery.rst                     |  15 +-
>  doc/org.bluez.BatteryProvider.rst             |   2 +-
>  doc/org.bluez.BatteryProviderManager.rst      |  12 +-
>  doc/org.bluez.Device.rst                      | 400 ++++++++---------
>  doc/org.bluez.DeviceSet.rst                   |  36 +-
>  doc/org.bluez.GattCharacteristic.rst          | 372 ++++++++--------
>  doc/org.bluez.GattDescriptor.rst              | 124 +++---
>  doc/org.bluez.GattManager.rst                 |  29 +-
>  doc/org.bluez.GattProfile.rst                 |  11 +-
>  doc/org.bluez.GattService.rst                 |  24 +-
>  doc/org.bluez.Input.rst                       |  33 +-
>  doc/org.bluez.LEAdvertisement.rst             | 166 +++----
>  doc/org.bluez.LEAdvertisingManager.rst        | 109 ++---
>  doc/org.bluez.Media.rst                       | 119 +++--
>  doc/org.bluez.MediaAssistant.rst              |  40 +-
>  doc/org.bluez.MediaControl.rst                |  26 +-
>  doc/org.bluez.MediaEndpoint.rst               | 216 +++++----
>  doc/org.bluez.MediaFolder.rst                 |  61 ++-
>  doc/org.bluez.MediaItem.rst                   |  92 ++--
>  doc/org.bluez.MediaPlayer.rst                 | 278 ++++++------
>  doc/org.bluez.MediaTransport.rst              | 298 +++++++------
>  doc/org.bluez.Network.rst                     |  51 ++-
>  doc/org.bluez.NetworkServer.rst               |  45 +-
>  doc/org.bluez.Profile.rst                     |  28 +-
>  doc/org.bluez.ProfileManager.rst              | 133 +++---
>  doc/org.bluez.obex.Agent.rst                  |  31 +-
>  doc/org.bluez.obex.AgentManager.rst           |  22 +-
>  doc/org.bluez.obex.Client.rst                 |  55 ++-
>  doc/org.bluez.obex.FileTransfer.rst           | 127 +++---
>  doc/org.bluez.obex.Image.rst                  | 100 +++--
>  doc/org.bluez.obex.Message.rst                | 104 ++---
>  doc/org.bluez.obex.MessageAccess.rst          | 215 +++++----
>  doc/org.bluez.obex.ObjectPush.rst             |  71 ++-
>  doc/org.bluez.obex.PhonebookAccess.rst        | 399 +++++++++--------
>  doc/org.bluez.obex.Session.rst                |  20 +-
>  doc/org.bluez.obex.Synchronization.rst        |  64 +--
>  doc/org.bluez.obex.Transfer.rst               |  66 ++-
>  44 files changed, 2405 insertions(+), 2411 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] doc: Remove extra identation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=52fb0d4de74b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


