Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984023A75B9;
	Fri, 10 Apr 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837214; cv=none; b=EMTTvqR55zLsdzuvDDsLx1k73ZqhNco5oxzySBHxwa6c0U3vnvG7fstb5ah1N9PKC0Tvmbzzm3ZEQ9lSwiBQ0/KUWyIbQMsgCPk5A03A+9PmoevHhUyuY2hikarseYkCZCSBc0eIdX7Y7++/HkJB2NIqitodKio0mgtGOnyUGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837214; c=relaxed/simple;
	bh=stKy9slr3lkPEQ1A/Q6Rgj7jaZIOtw21hspJzW47mxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bljx9XjAvQiysmbktnQDkgZzDaTbJGOMdBOz8i3JWddN14rIzDSYqCyTJvAeZtjZcUsvIJR6s7CNlQI0HrFM5/veauZHMzhnFkicG23ssWoFlbg615qjyNsx9xRs9AVrMg1qZIznTJf9tXpXTv/9zZuAcon2mTyiz6+7vsDr6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHDtyQ/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHDtyQ/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F32C2BCAF;
	Fri, 10 Apr 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837214;
	bh=stKy9slr3lkPEQ1A/Q6Rgj7jaZIOtw21hspJzW47mxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lHDtyQ/L+xgRTtn+8aO/MCqaGDDcD5stgz8ms1s/y9aqtYHMjv4bGhZaON2T0Ftbv
	 6XZgQK1MmyhoaPkq4AXJv/j7iKYR8HLSXtPo5vPH4akQy9gAzfFf7RtGvZbsMBF2Qm
	 k+yNMXJx440EZyFKpdGjmCJwCAWuoZKXLg7FxGQy775N42a2L6uZkSGvgu462/99Px
	 RldY6HO0HxOg/ULp6kxqIuM5R+8TW0q+K+IPEZUaQ/oGO/vSCmu0AO7XDejPEtwDUS
	 b1SePi0QkEg6Zh05oaCQ+onyPCy0N43dX7yL03vV14lMPCuXSd4tBTMn9FKM0c3Qru
	 m2/JuFSMG6ytw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D8B3809A87;
	Fri, 10 Apr 2026 16:06:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-03-19
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177583718847.2534919.3143022997633844613.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 16:06:28 +0000
References: <20260319190455.135302-1-luiz.dentz@gmail.com>
In-Reply-To: <20260319190455.135302-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 15:04:55 -0400 you wrote:
> The following changes since commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229:
> 
>   MPTCP: fix lock class name family in pm_nl_create_listen_socket (2026-03-19 09:37:48 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-19
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-03-19
    https://git.kernel.org/bluetooth/bluetooth-next/c/57ce3b2e9cda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


