Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A202E9730
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470650; cv=none; b=n0NlzIXQDzhUO9OjV2ADUNZXdTzqcIXzGMasWp4hKKwUj5/QKXXX7jVPFedF0z4GF6yyC9NhbJ/yUCn981SnEinB7gAfwKNcY8Y3hxk/Ip4PYlCPgbAyZRHNbkLYkn2sMwMqa/11i919eh0NgVYrRphST6TrZcSbdfjewteNjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470650; c=relaxed/simple;
	bh=wlgSDxHJCRT08TjrUxEC9kEt91Jc3/QdMK8e/qHQ7yI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PbMRd7izKN165xVHgSgR51CPBD+EXznyW7FB70Cd8OP15eO6iwD0VtHIAxcg3kSbtwqwnHtOfR9iSmPn5RV3oRDA+MzpaMCC3KARIEiFAVuuH9ZoHtT9qJPnJFlaReSXvIoOT3UPt75cNZGfkzm5RQc/3pYDF7VKksI7wwgIj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbMk8yRX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbMk8yRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C8BC19425;
	Wed, 29 Apr 2026 13:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470649;
	bh=wlgSDxHJCRT08TjrUxEC9kEt91Jc3/QdMK8e/qHQ7yI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hbMk8yRXPfE0aHXqP5V+YbnIIpPaIr4AWD2yHkaJJ6ejJ+h1P74BubPr3/aVFQIPA
	 RJV+Fv3jiLbhYVRv5k14QRQwkQWhDl9NuzxQrycWHBF6FNKnQXYynpMlVj8s5y4ztz
	 aGzeoBD1hT94VZzQPJ1nqrm2Tl/e7+QLldDN3FZ9qt59UsilBYJ1CoUSo5uTV7g2Tb
	 0D7Xjjxw3G/mtsnFFaNkgG4TTdrdBMRU8zOXg6sgpEVF27MnIQnf8MxnZ8kPkXTq5O
	 EzCDrrte/Ht+z60ejPL9Koi14q5+QAXIqQfz13ZLKURX/VyVh4OuLta+Vkxjlh2GfZ
	 FzOAcSrOfawSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D027393079E;
	Wed, 29 Apr 2026 13:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/2] client: Add public broadcast advertising
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177747060530.1976007.11765363530218158354.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 13:50:05 +0000
References: <20260429074605.11774-1-raghavendra.rao@collabora.com>
In-Reply-To: <20260429074605.11774-1-raghavendra.rao@collabora.com>
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Apr 2026 13:16:03 +0530 you wrote:
> This series adds bluetoothctl support for staging Public Broadcast
> Announcement advertising data used during LE Audio public broadcast
> qualification.
> 
> Patch 1 adds a public-broadcast command to the advertise submenu. The
> command stages Public Broadcast Announcement ServiceData using UUID
> 0x1856 and supports SQ and HQ presets.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/2] client: add public-broadcast advertising command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5dc2d7e3334e
  - [BlueZ,v5,2/2] client: make advertise.name use public broadcast name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=278f3439c45f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


