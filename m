Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA174ADDBB;
	Thu, 11 Jun 2026 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200695; cv=none; b=b9cmTq6WjieXPF8Vjn6Om3jKTSgBRTaDIT18X7ddZgiF0LFbWlLQFwYMlwS+JE3wSPGkptpDeQmZwM8HD/nB6XBCnO498XmkTF2f5EdUDUcf+FldgRww4cQd3KoXXAv7/FLjAEGZ0FpjtzJEHyBnMINM+Ip53TT2zBwQXmZvpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200695; c=relaxed/simple;
	bh=Y4ma1t4mV6fGFpz6DA9EaywC1/aJFJTHbDAAVJFMOAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NYe0qQVgkvzPAZi844QirLPNaPClXyRDk1Dkhxd65vocHE1O+TA7LlQ+UFvd2CuaTnBAa6z8ceEUAoFjc1V6odoIMdPcHf5g9kMtc6t6r/LNA9MUqSoD7OkyyE6btHasY1maW1X9TDO/tiWjE4wOHpDjIg8r8D/jtQY0p9YNkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF+AGrv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF+AGrv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9274D1F00893;
	Thu, 11 Jun 2026 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200694;
	bh=h3ijUhmsVqibSQPWDJ4t0liY8RZOgaSkRxCWi+HbDko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BF+AGrv1xouiPAXCy1bNNOOyuYDrtOzA53Phy5G4Q0rBCdTQU8u3KzHiiQhXWCwFa
	 6eT8Z+QS+I4L2QPtuzM/kMKpncVARhDgayyqUijIyjfFvmwH4Ya3cfNNdgY+zbANxo
	 GSyZcqjPtbY44Z3R7E/SIzwPb7P1V/DCCNahvGa1VPQqumgjjmeGeJ/YdGWBYr68gF
	 GxIKsZMGa5B9pbv1OL0/ggs6mFanAZU0aiQaT00/uXj/ohkg6bWLx9REEIZrO07B4L
	 utyrE366eEzX55fjhiuzyl65NfgyL5uWfmqefjnpBXglqKLnjX0cETgDFpjfpTrpld
	 Mq2HU3xr+KHTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198173930F87;
	Thu, 11 Jun 2026 17:58:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-06-03
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120069163.286318.11448683421315459798.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:11 +0000
References: <20260603162714.342496-1-luiz.dentz@gmail.com>
In-Reply-To: <20260603162714.342496-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 12:27:14 -0400 you wrote:
> The following changes since commit cdf88b35e06f1b385f7f6228060ae541d44fbb72:
> 
>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-06-03
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-06-03
    https://git.kernel.org/bluetooth/bluetooth-next/c/d20da9130830

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


