Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835EE1A9B22
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097221; cv=none; b=jno7T30PkHyTnVCo4J0d63jNNtrQ2iqMR81pCgsVSfqiQlINeVx8ahncIG8wG3zu2JWfVyDi+s0sIhvSWQHhvRUYOSmOENXbYmT05TpCGVYe5O1RJSDd/n5am30iqVK2ewKJejgfndV2KTff4lawxwvrXrUI5EAh5Cp8nJj+3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097221; c=relaxed/simple;
	bh=x7TcwC8iITf2ANSsGV7QXAZRWCaBRyR+5a+urtBztJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TSplKXpTRYppD11KsMuNRM4lZR6Y48AcIzDUD/l/FlmDRxhqpfMgy/Ry1tMF0UwL4V2YQZcfVRIok3SzCU+fC3HZkGq+zNMzTq1T8zNO1sujgJUywq65wWr65awsFHDzCQE6bE0bJ++rM2Sj8q6d7JBg6eoRsGVguy599DD93JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r44vZ65A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r44vZ65A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10570C4CECD;
	Fri,  8 Nov 2024 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731097221;
	bh=x7TcwC8iITf2ANSsGV7QXAZRWCaBRyR+5a+urtBztJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r44vZ65Abfnk5btVdRXNNa8+p2E3fu50AXg+PIPGl/PF+rlCY4ReraGdEGtPwooKZ
	 r/Q54PeazZZZoXmPVaaJEDPAzbCjfRou6HwLY7U1L2N1YjKGF9m677FpwONu7NAkua
	 /TfAqT5r0ebUZjowXhjoKooU1pOIhrHfg3gvu5bjClO7efWlffOBq785EgSCOHrmJD
	 ghtA6yz5jIaa8j5GwUUYD/mg61T+M7dZTX0KW9C5bg5wzgq6Xuz5lEWdSD52POM3F0
	 wZJCvdZ1BxNcpkvJ3G8WKGWDhUUxWugS0bVqWmIa93+qpnffLh9bboIQzHCBXJCOLt
	 g4n1mXPUBfJYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03E3809A80;
	Fri,  8 Nov 2024 20:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] avrcp: Fix not marking AVRCP_EVENT_VOLUME_CHANGED as
 supported
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173109723051.2754484.1793745834161407733.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 20:20:30 +0000
References: <20241108181921.309039-1-luiz.dentz@gmail.com>
In-Reply-To: <20241108181921.309039-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Nov 2024 13:19:21 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If avrcp_volume_supported return true then AVRCP_EVENT_VOLUME_CHANGED
> shall be marked as supported.
> 
> Fixes: https://github.com/bluez/bluez/issues/1007
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] avrcp: Fix not marking AVRCP_EVENT_VOLUME_CHANGED as supported
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=de1b3a5ac399

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


