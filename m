Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2836271A94;
	Wed, 29 Jul 2026 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285665; cv=none; b=gypVhoSJnfeBQ6TfqvnTr4nt/NYILOzaFLckv3kHB2vcqSun7KbGY4fjFhmP5gP0qhFhjq+1vNFmck0wBJpAiN26Icv4qJDXMN314DX3Em3IanOpMVBX91KAdTv20XP0eKub440SHQ6mldJJwvsah5C3i606etfnSCDZ5vGoxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285665; c=relaxed/simple;
	bh=NRtgR1zjCOAghX1Ahzyssszlvo2JQGQUZJv6IQz8uXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n8WR53KxFWpEaiDVLF2bMQumxh8nK53aIcFedpCXzNX2zRKvgYFfBN17zLcLtysCawrI8j/rMAhrey+7Py5hBECXlbVuSqmU2OCv1d9cTSCcq/YnXUsmDTGUyFraVAO31eMA1NrhHYn+rsW6fnLBwL7o5yaV8/j17l1fcXTiJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKeIccZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKeIccZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFFB1F000E9;
	Wed, 29 Jul 2026 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785285664;
	bh=zdwiH4Pzt2gpIpNaSlP+DgYYxGSpLDbfO1StAjYyqOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gKeIccZ4XcEpgUNAo9NtqiRqgKNdMj2tGS0gJD6KO61MWYF3OA527VR3XcydW0PCu
	 MXtPxx1glPRYZQljeEAXXyaIIB/KwXjFidR0J5TWwMRV8KkEt11E+jbEvmkPULa3o3
	 BeOXFz75J1nwupQEyT8oafv8Cy2SnJdlfGoYfGH1YmQyvddKJMUSeoB9M1RY2N5zhR
	 s03a6hMk1EPWuTMDiHy7ek44NE020A5voDA8GTzZkDFHR/ukzuLi6F3/H+rjmU4ofS
	 DMKdLOLsS9lQuvMSB+RzMOCVHYtsC6El/hT4n5ylXqa0+bYfKT3DWFuqrgvYdQN0V+
	 GTkUdhrn7XGtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B7E3924A56;
	Wed, 29 Jul 2026 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-07-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178528562865.2383814.13327563581193824452.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jul 2026 00:40:28 +0000
References: <20260728201527.2456032-1-luiz.dentz@gmail.com>
In-Reply-To: <20260728201527.2456032-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 16:15:27 -0400 you wrote:
> The following changes since commit e095f249e2209674f6366f6db0383a2b96e19239:
> 
>   net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller (2026-07-28 15:53:49 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-28
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-07-28
    https://git.kernel.org/netdev/net/c/0408e7f6f6a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


