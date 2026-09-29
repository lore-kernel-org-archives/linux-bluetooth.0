Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC542EAD15;
	Tue, 29 Sep 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643615; cv=none; b=R4TuGFhYLdYClKcQ6B6nCLya2Q6h65rLyTLA1b88LrrWZ60FZWGIllE6ueVvEeaac+EAqLW/soqJeTCwxJ/v0P3HqX6Sqzpv5ehwryy66JyHUcKvXCwYU6PGP/WSv5zotZfBeZeFtfzrH311SevDnEOrx3op+1GCj4S3+cLtIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643615; c=relaxed/simple;
	bh=gkalNelW/D/0P3Ly3PJWns2c9Izn8LTjvaT89Zl3BZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GnEaEHZ8esbxbLxZKfXAfjblF2tJmLUJ1h98JsuEs0Qcgmf7JQARcvLETvccv6EL+w1dHggWgX+MCtPjBTLhLndr1RvSl7IMQokfvF1Cqh5tm28X5jX+75UhgiWArn0E9pndbbU9y06AaPLbQD83XPdBuuC9oRRtK0kP/pUVkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6OOJEFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6OOJEFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D7B1F000FF;
	Tue, 29 Sep 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790643614;
	bh=l7o+SthR0IG03K+lwiN1f5f7Rhh/++PQDpOdzUajsdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b6OOJEFjMf9jhmEawYnY0KNx/h4pK9lyKJmUgLMh2ecoVTpBhayCiQdEFRuVnDp4+
	 bfrb3LapnniU7LKO9jv7XhQIOzxwiL73GtjIXI655VnhZ0cBSlG8cmCj76N7Woh9U2
	 KpiHpS/GQVK3/DoUXJg9l71NroKeC+0s2w8QtSeocIp5Jqs66OMPt11cIj+yfV2JOV
	 dI1tnf8xhWLYnLQkeZt9akZ6C459Iw844vzhvCVY3GH9vjEngU2PdTVC35kN1tMGdH
	 mZ1eZ96Nb1KfB8d2gnoofFu9xCgyMQTAUV3ftbdurFH8yUfCRB+7V08SN2j029qbrl
	 AU+DgPWS6VBEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2C23924FED;
	Tue, 29 Sep 2026 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-09-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064361278.199999.16060652770128006151.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 01:00:12 +0000
References: <20260928152919.942973-1-luiz.dentz@gmail.com>
In-Reply-To: <20260928152919.942973-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 11:29:19 -0400 you wrote:
> The following changes since commit 6d91041bb38b97e2feb625123cc0529d7b83a0e1:
> 
>   Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame() (2026-09-21 09:37:20 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-28
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-09-28
    https://git.kernel.org/netdev/net/c/382cf9768987

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


