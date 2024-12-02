Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FF6F30C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179217; cv=none; b=B8y/3QP8/c2do3tx6DC1ORU4z+XpHpls1pFcl7QreAtTrApF2DvfUexLKYvgtEDxfYZVVBxr2MmliW5mw6ry8KGPGd8ojdiQ4O6QuRA46Pf1eN2DOTyEmUH7W5dr22q3fbiW7Vc8kqxAeNqB84MT5uKkmlc/l5Yhf/DSVdL61xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179217; c=relaxed/simple;
	bh=qCVjeEuqoowzLo/liFzsxR+QVDdYd0DKCqYq1bYrkQI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bclEvTCDizPCwoKlEiXbJe5WEOh6nih/5INCm3g210s9tZCeJbYpRL9Po7Wgwi6FENd7R3sZx6DFIiSh+PGgHDEEzOr9POFcKn3nRSJLptOxVp6XKms7y4MITvXVkjvyxD0PrsUW4hW7ysAcwOwg2FttPk6zBKBtu5XKx91Xp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxNhHjZE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxNhHjZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6407C4CED1;
	Mon,  2 Dec 2024 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733179216;
	bh=qCVjeEuqoowzLo/liFzsxR+QVDdYd0DKCqYq1bYrkQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pxNhHjZEEWDWZ8TLWSFZjOjhfUUc9ysNTFj651YCzrTYEgFYSy/CVUOo2LQa8VIdz
	 OvXkFor6lQR2dH1KxfGVw0Bet4PNo1Swnl7deXrY6/fPQwHD79pUFIBPeXoKLD1NYm
	 QA/GMzH+IyUNs4SstlPeV7oDHJySDb9086x8QD2aSYahFTNzF5VoV7BI5hVgqcPo/p
	 wN3lY7cx/fyea8ywe0Dnv+F2is8TxY6LWGyoJ8R+GrXsw80OPTHhVbsUpYc/8tck0j
	 MBXw97oeCJnL8rsT9bdJ7vlSWVi4piPG/NeC3UcdbjOxq4CpaciRivXvqgb+uTUXlP
	 CSQIZZWA8PSsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9F3806656;
	Mon,  2 Dec 2024 22:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: iso: Allow BIG re-sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173317923102.3917084.8053015231138989490.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 22:40:31 +0000
References: <20241128155405.14910-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241128155405.14910-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 Nov 2024 17:54:04 +0200 you wrote:
> A Broadcast Sink might require BIG sync to be terminated and
> re-established multiple times, while keeping the same PA sync
> handle active. This can be possible if the configuration of the
> listening (PA sync) socket is reset once all bound BISes are
> established and accepted by the user space:
> 
> 1. The DEFER setup flag needs to be reset on the parent socket,
> to allow another BIG create sync procedure to be started on socket
> read.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: iso: Allow BIG re-sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/47ebf099106e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


