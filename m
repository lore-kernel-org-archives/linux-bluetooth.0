Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A51D5CE5
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569783; cv=none; b=ckOlwtWmX+3nRf8HmWUxy485+Pw/pQJesIDng1P+MQLJILCQDI6G8NAlIn19Ypf6Vgoi3j5JrLFzZO9jGc8WyOfNaWydb/3Xx/7a5fgS4V0mdwU0RoqjGfIN86aPOACCaN3GvCkBRtd9kVr8iamBRMuBcXTeMrovck38mn0plzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569783; c=relaxed/simple;
	bh=vpjl1KYiwOrSUAYDHqIQT7lQXtZOZ3uIQJiMlqdLB1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c9OJyEOWCVtLhLRGg/EUzn5BYVsYBoPoYbenGURSVx/1PLcFSNxHll3R9e4mfJ2etCtLv6jwTb9iBQwdWfk7wXdhuV1hp6JcQ8LuV6KSMNV/iNOdj9OIOVulahaMvZLT5OwBfabtEjDug+2DUyns9PsYAgMVKurTumodSmBsFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp2DSOSZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp2DSOSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428C8C4CEE3;
	Thu,  3 Jul 2025 19:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751569783;
	bh=vpjl1KYiwOrSUAYDHqIQT7lQXtZOZ3uIQJiMlqdLB1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qp2DSOSZj6uIbpwfMwFBf/wmPpWgenYKnlWxuJzrwtasV1MRIv8t8ZGg4MMtqcS01
	 RPv869EJZtcIl8NlffILKBb0nyaBznE0wrL3w/zpoKqi+SBngyxA2vcsZzbgRaWHGd
	 EL9MGaIIQabIBF8Cx1lKIFmJFQQgUPLvBOrpwFYbeJlkIggQyd4pxiqhux1K1GrUzB
	 L55EpsokEfm6gSXf+rpgksR0lyohJLmRIf3T9ZoFdMQ/wTdR0llMyKiu//3NtzsYqm
	 dNNcXZysXziVECAdAmhlRLXXSFt3etP1ZT+jD9uG2nz5CcQgmwTw/zfko5IFWUq7MJ
	 9JeMbkQjp7+0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF2A383BA01;
	Thu,  3 Jul 2025 19:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/shell: Fix not calling pre_run for main
 menu
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175156980751.1591867.11090871012470645240.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 19:10:07 +0000
References: <20250703173228.1815400-1-luiz.dentz@gmail.com>
In-Reply-To: <20250703173228.1815400-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Jul 2025 13:32:28 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When calling bt_shell_run the main menu pre_run was not being called
> which cause tools with just one menu to not work as intended.
> 
> Fixes: https://github.com/bluez/bluez/issues/1319
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/shell: Fix not calling pre_run for main menu
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=655421a96263

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


