Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C03043D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115807; cv=none; b=F10RcBZeIdpzY6omoX9Jz4Xp45tkftIljHawViJCzOySDa+UznObv2wpkal9/KM1/yDOhDur7qQSi5oTVrzDNmPdVdSSevgWpSy/Q0BWm1AFG6s19Eu5NN0wyvQ3FqqE8bJ0KB0nBZMALcpkP3SAbOyslVnZxhT1dP0GzPkyoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115807; c=relaxed/simple;
	bh=3I73Zf6c9QRD6K13SMpy/BA8xwCC5mgVEGe1tnbZ34M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RNtAemYYY8+VLUDKpeZj+HWq+Hq4dExTJ+nYhigrBRdivFAeiAF6zyuqWcxvaOr9qX7cZwEovxyIrxk1t6b0zOa3DGTMGRB57bJumkNuj+XZbXfj18mjFXFprndq7V3/QW/Lo8+M1kzmhtqvj6hc/6mi8Cvp9NS3l9+cp5Fpylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy0jRRD3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy0jRRD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D5DC4AF0B;
	Wed, 17 Sep 2025 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115807;
	bh=3I73Zf6c9QRD6K13SMpy/BA8xwCC5mgVEGe1tnbZ34M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jy0jRRD3W1EGxoLcdJksxjE4lm/nj7AfzUzDxApEpC9ioho9FbnpO0L/Oq3GtY3SE
	 MWTIUIHWe90wt9/btP+SqbcBwOpbODMdy5dQg8h2sQW7CJ4uXx8Rgbi3rKGambhs+H
	 X5OaPhcH5AmZijm7BwYhqCRaMWQjWWFLAoc5bFEcJzltJXu+GfiLOJa9N7/9aXmr7y
	 dWzTOTG3g1gnmtDJVwcJ2mzHxe3AAcfhPhou2vQAqlImqvOcNxP2iAaQIQYJ+CJIoN
	 /D7eCGsOGFVvmeTYL8f9F2bWE/nJTZrQ/FivWt7dBk9Pf1lFceiBUmvit6/2jHEhV/
	 wrUeXN0V6GSMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAE39D0C1A;
	Wed, 17 Sep 2025 13:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: Fix build with VCP support disabled
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175811580798.1623615.10398322340567444179.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 13:30:07 +0000
References: <20250916230017.2216629-1-hadess@hadess.net>
In-Reply-To: <20250916230017.2216629-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, arun@accosted.net

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Sep 2025 01:00:14 +0200 you wrote:
> $ $ ./bootstrap-configure --enable-a2dp --enable-avrcp --enable-experimental --enable-asha --disable-vcp && make
> [...]
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_bap_set_volume':
> profiles/audio/transport.c:2275:(.text.transport_bap_set_volume+0x11): undefined reference to `bt_audio_vcp_set_volume'
> /usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_bap_get_volume':
> profiles/audio/transport.c:2266:(.text.transport_bap_get_volume+0x9): undefined reference to `bt_audio_vcp_get_volume'
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: Fix build with VCP support disabled
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c6dcf6b71450

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


