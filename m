Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52283911C3;
	Fri,  7 Aug 2026 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141302; cv=none; b=rPVGkJSFkXfi0OyRhN/bnV0fewPx19bRav6wNn/YUDOP2xGQ1qvPgFwkQZ+IC8QBVzgfXLYuI9fQVr5iUdWfx34E3NZIrudc8Jg3odujAYtUym1605Ui47Spslq7FMUt8QLQ3dtpBvWFsoqsYvTaJHTC4h8UrFGlwvfR2CH6xM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141302; c=relaxed/simple;
	bh=NyizY53fDkdipiPCgF8r6xKlqPK36CTcLzx2FyQujR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L+Zm5g3zKBO7LbhYeTd8rM3jqQBilqNGwfKCpYcPKl443v2MTtjPx3PGDVngaJb4zRIgI3AvQTXX8nW7zxnyh77XUFG7vz+gsLA06WBYEfCR1TnVReHl7vwnF2/rT+ro4ADmXW3M1TLlptrryHwSfGImJh8k0IxlYfjCVEKlxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIG6dlYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIG6dlYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6521F000E9;
	Fri,  7 Aug 2026 22:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786141301;
	bh=v+Ba1vZskULE7rKFPPkeR3ZujLakdMkDo9yu5BnEh2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MIG6dlYu/v6fiMlSr4LorBhgQz7TkA37+cgZANDIT2GQtvhfTmCBX0izWGjMkOl3X
	 O8VOyCqpWaY05mMutrszhpcLfUFFQjgiqoLOOKQWuU40K4yFmU48PVrRJRL/uqW4/D
	 UtPk9Z5v7YEyUV92JXhFR1HVdmNsT/+qtCIebfpAnqwolU1FUJajmhYJ0xbte3XVin
	 fgDBsjvWsde/nZMhLg3ftL1Ung+P7JInw/MQzElpXgnT66wN2vHTl3iuOdP0Kvds4+
	 9Jt6dsF5lfslUEF5RNYcbLNFq1jX2PtNGVsadmmKMgAqkBNl9MCJtnFBKKi331SzcL
	 46Em7G8TEJpHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B3380CEF7;
	Fri,  7 Aug 2026 22:21:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2026-08-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178614125989.2438154.4055081864206094097.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 22:20:59 +0000
References: <20260807200215.982570-1-luiz.dentz@gmail.com>
In-Reply-To: <20260807200215.982570-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Aug 2026 16:02:14 -0400 you wrote:
> The following changes since commit 4fa4977a0d900f936bcae5cd2c510be5554e8dd6:
> 
>   Merge tag 'wireless-next-2026-08-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-08-06 12:39:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-08-07
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2026-08-07
    https://git.kernel.org/netdev/net-next/c/3a30302b9391

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


