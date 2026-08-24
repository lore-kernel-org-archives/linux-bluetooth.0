Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417E37999D;
	Mon, 24 Aug 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602274; cv=none; b=fWpryKF0D7IEKkt5HM40c3GOBW3Rc8zRiqZXiAr+ywgoFXZ2hL574tVFPeIpkkwrF664twgr+Tcvcq7aEQ4PbtHbzL+e5zd93YI6n+VgIR30XelMGfwSv85AggsD8hWtnwHGOICCsu6BAy7+5Zv1ixdPYVWK94IvZPrsSm4+ssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602274; c=relaxed/simple;
	bh=VKPzb4lI0+YxJ30IVch8jmiiv63fuB/8GY06P7avfhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CE3ZK6+JOJhu0k5x8YBoMWKoCGcdIxSR7+knskt/VEKnwnCrXNibaSf/r6cXMiqCTdc6Ro+5mg/W4nFrqq8zgQcqBJEZssAcsqPxavUtCn35KrGYjm4gDXZmAaUXqJVrnGQcXJiE1otpPGhNml01nesmYS1CgE6E61vc6jBrISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j58FmOhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j58FmOhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637131F000E9;
	Mon, 24 Aug 2026 20:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787602273;
	bh=vkabXW90V9LyIOL5oAg8rcncVvaMdxmnzoedYkhU+dk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j58FmOhfxc7zoYP5VMe9sG0a1iqrYZPuHiDgads88+hKOul8wFBOIbIdPLhRE1Fhw
	 /lEkP5mrAYipBX7LeTtUgLhHxOvS73gid5FGv6R0+dT6mQMV5AyxHz3koODfw/sL9A
	 zjCuCRBzvSKvgO8srnE5aSZJvtKYlrKv4fngv18ps2Czb9miFlqq1fj3WPJeIi7LL+
	 FvhWdQ8HVUBhkrX3Lkkmg/CO4sCU/IvZwt0l6o+yvTB1U1HvSi5zB7Px8ICyAl5s9c
	 AUSQZ4Df2U9kvrkJJzCrSA3M+2Y0Qx1qSifO82FegS231xzUy+Udqlu/r+CDXrr2ST
	 6HagHiFnpYeQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198433924A51;
	Mon, 24 Aug 2026 20:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-08-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178760222088.3098537.17413307730487098500.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 20:10:20 +0000
References: <20260824180639.3570348-1-luiz.dentz@gmail.com>
In-Reply-To: <20260824180639.3570348-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Aug 2026 14:06:39 -0400 you wrote:
> The following changes since commit 7cbfb180945ce529608e4d4e24a6d483699fab1e:
> 
>   net/sched: sch_cake: fix autorate reconfiguration throttling (2026-08-22 13:51:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-08-24
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-08-24
    https://git.kernel.org/netdev/net/c/b70b7b71561f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


