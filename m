Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2A33710D
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140359; cv=none; b=gCEQ5uta71Kb0n7jUtJRZIzDbgK93cjpyTLc4aFpm1XWIi5EFFLFNySku69/8GLm93HGI19TNADarN32ShoqLB3kEuwRkoovZ+zNFXtBJ6xQ4MP2ABD6XCVZ4vA2c0lWUGroiI3qcz1d9V6VII2DQbzJnNBqazSXeknH0c4mGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140359; c=relaxed/simple;
	bh=IxsPGJ7ryoOYmiFMYgI2G73mEwGCczaTL1XY8vKGW70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PvhLbz4VMqRdvTHp6F8/NNOt36DCfJODFvfsngTuHma4wsQvPgquhE9wfgX6VmR/OIjX/+ztw+KflS7YDZxvW2mIGtAOMjNVBYVJ/jBIoeJEvTeAFWXWVxO5wEbXEg5p6Mc9Y2PpxvQSVj2OLkYEvYUMHJk2efQ6YImGLsRcQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olIkSBjT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olIkSBjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BC4C4CEF5;
	Fri, 14 Nov 2025 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140359;
	bh=IxsPGJ7ryoOYmiFMYgI2G73mEwGCczaTL1XY8vKGW70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=olIkSBjTOSxyBb3wfVMk7vx/gPsS3iSwvsFNJhGNxl6D5CgXCV32fZCOpIeIwgoMh
	 1MBQqWq6BIStlhBbIFhFDmcnNZEWldurc41Mm4o6dcUlDBWaEzDdsvw78od+2Kj1ft
	 j/8Um34VY/z/XxjXhBIfBTX3vdxkb3Zck88fB3o+XREyrsRS1Gj0Mv5Q5lwHAhSoeL
	 6oZuCv3ogQXlQR+U/0NeLTr1VEYxHDhdtD2+n2JelQw5ldPj/w/hM118d6Ap1HTJ10
	 RG/mpqp4cbpzRTRNv5Ae6olzYzvR70l0XqdIO3qTO26AvIw+h2jB8n13kMOV9o1vty
	 4YPJGaMtyA3eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CBC3A7859C;
	Fri, 14 Nov 2025 17:12:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] build: Fix distcheck while installing
 org.bluez.obex.service with --disable-systemd
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176314032808.1740925.14596822117835195069.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 17:12:08 +0000
References: 
 <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com>
In-Reply-To: 
 <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com>
To: Alfred Wingate <parona@protonmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Oct 2025 05:05:09 +0000 you wrote:
> Pkg-config variables give absolute paths with system prefixes, causing problems
> for distcheck which wants to install everything in its own prefix. To cope with
> this lets give distcheck its own configure arguments with its own prefix variable
> already included.
> 
> https://www.gnu.org/software/automake/manual/html_node/DISTCHECK_005fCONFIGURE_005fFLAGS.html
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] build: Support setting the cups_serverbin directory
    (no matching commit)
  - [BlueZ,2/3] build: Fix distcheck by hardcoding non absolute paths
    (no matching commit)
  - [BlueZ,3/3] build: obexd: Revert "Fix make distcheck"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebd6f9fefa26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


