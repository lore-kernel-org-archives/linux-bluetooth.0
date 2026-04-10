Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043C3DBD71;
	Fri, 10 Apr 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837220; cv=none; b=gm0FvGAQNrFU2V40m4NMeSVK7kYC0LWgUPC+LyX+9RN7Lh4OOL+en6QYLRM3X9LFsjwl9ZEVHcKBUKH0au41ZpMIfBj0qA65XGIOPpBeOpBzhcUeEUiceXVIuYhIXv7y4/gLpoR6YShYDk1lkW1eKA9cNgVxeX/v9Oae2Xwtxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837220; c=relaxed/simple;
	bh=gDVUzSQEJ7258c+nJSVFbnKG6DnW+kb64w9kEfWKOW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DYNUzCgqdLaqRT+V1LsTzgl3bwF4C+WLGE++FPYWpp4nBPhNUPcaTC1L4SLZ4hTG0vuaEmwjo0plTZBLdt5gf2XZOvgIRZixM92MkrKQaWwkwYXtwQIaR7erFXkO9BPLzHKrd2hgEaCzSEzr/Pl1Jpt4RTI21NFsUxNt8uGKE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHb1lwk/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHb1lwk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A514CC19421;
	Fri, 10 Apr 2026 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837219;
	bh=gDVUzSQEJ7258c+nJSVFbnKG6DnW+kb64w9kEfWKOW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHb1lwk/3GWtOqdH/m5MqvNI9GvP17HeMWL2s2B/p6/vQktuX5tNJn+OaiGRZ4dXC
	 +Erx1IPBgRWgK89c4MoP7qkw9y5/f5EqcCNdl0uPp0zpuzRHG2ujv0UWxYBgg9mwrP
	 DRBZKNYyJlCgjjpwlm6Y4cgibebzJMAPJcbqDl8EvJxl4IwvvcdWoBxU5UT45B8b6e
	 RemLju/nrALiZvAYzi8y7IvOzJTVyhGbWid4l5m5bo/hTgH5A18xr9U0oT6pKyrzSw
	 P2eFnRIsngPEvFOLI3Zh5f5IQJ8AvNBgGLn2MasyEAcbkXI26UzkGDDYcL8tdLHNZv
	 CQfzHn7bFWdPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD6C3809A87;
	Fri, 10 Apr 2026 16:06:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-04-01
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177583719431.2534919.11683704772155829682.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 16:06:34 +0000
References: <20260401205834.2189162-1-luiz.dentz@gmail.com>
In-Reply-To: <20260401205834.2189162-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 16:58:34 -0400 you wrote:
> The following changes since commit 48b3cd69265f346f64b93064723492da46206e9b:
> 
>   net: stmmac: skip VLAN restore when VLAN hash ops are missing (2026-03-31 19:45:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-04-01
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-04-01
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d6be7070e90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


