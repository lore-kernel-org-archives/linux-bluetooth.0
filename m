Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF2145B39
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887230; cv=none; b=FVzCY8eKjggcN9YouSyUrcR+m9HiGMboUKYeXab0wvf6Nw5JLAfHaAIQcerXS2uck4BGEZ+2gKjBve4FT81o6UMjSDtgPUMUUp0tADr1UsshEiDuhYq0e63DGJmDgf0G6uXKI75IFLCHT9IehMXaVHwS2ICY2SEPBF7a+9FR3yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887230; c=relaxed/simple;
	bh=EHImKvabKknuhJmhJnzVf302CvYt0a6bI/iKBlC3XZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EvRRXGP/ELaNiOIc0vk2vyNofzpfKuIGWOuZ3XKKBq5WoEg9JnioCTDDOycGvSCLrZ5rZ++0G17WsZM3UYA1NwAXJRjDwP/BLiobqHE4+RpioHMEuNWZ+1uMiJKz0u7SZhvEBB16wEmvoiNel8Ua6Ykmw/1FUlPqZix66TiCmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8OTCJzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8OTCJzE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C38C43390;
	Fri,  2 Feb 2024 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706887229;
	bh=EHImKvabKknuhJmhJnzVf302CvYt0a6bI/iKBlC3XZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d8OTCJzEGCTkm7BpZ8rhHj7hEQ8cgGaie3MPkvXXJ9FuRuLBvfIlv2e7b33VLOjJE
	 PBh5Q1da2s8iEEd+857OAH4lUwUhZgCHRR6lZvqltV7nBEDdFcRi3ZCFaXcYQFM3Qj
	 kVBVkLTiCJ3xWBp4ctQsefVgM/tSv8MvNQPWtSlMHIhnvSVtZJ8DEIq27SsHue6IDf
	 YYUIcKN8sbXaOvVtAOkMprPvkxeOyvbiRp6pC6UaTuWELG2HTTUSRFlIOHySR9RBZz
	 6cn72m0JpXfkUkQQKxXHt6dk6s7BqrEVQESe+qPX/rggXwOyeblPzASK/GVStJyp2K
	 MNfcY5a42yfHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AA2CD8C9A3;
	Fri,  2 Feb 2024 15:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/8] client/mgmt: Add missing settings strings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170688722910.29555.15645833943359833435.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 15:20:29 +0000
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Feb 2024 14:10:09 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds "iso-broadcaster" and "sync-receiver" which were missing.
> ---
>  client/mgmt.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/8] client/mgmt: Add missing settings strings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=17623000ef46
  - [BlueZ,v2,2/8] bap: Fix passing ep instead of setup to config_cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=17c1a9b49490
  - [BlueZ,v2,3/8] device: Don't remove object if a service is connecting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=59bf065b6279
  - [BlueZ,v2,4/8] shared/bap: Allow using bt_bap_attach for broadcast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b983c31d4a76
  - [BlueZ,v2,5/8] bap: Fix crash when a broadcast strean setup is pending
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=75095a9901f8
  - [BlueZ,v2,6/8] shared/bap: Fix not being able to reconfigure Broadcast Source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b4aae7f3d92b
  - [BlueZ,v2,7/8] transport: Fix crash when disable bcast stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8527a218d9b5
  - [BlueZ,v2,8/8] shared/bap: Make broadcast disable and release more consistent
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d14e0b5ef150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


