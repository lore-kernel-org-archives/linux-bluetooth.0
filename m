Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576BC563280
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998417; cv=none; b=gffTelhWav3gGqylzv3dqgZweTrpZI/qUdaW4oj55jK0AsaiJAD53furV6jKsjJ3eHwswkc9iNY0ehSJOj2mrJMNW4yMP6OgijnsXHL2rRfeItIoLr6CXNZUd6kJ13BtPqnDo2QCl/y2WZSM1IvqVBSHzdsurf9f0ifg1OTYoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998417; c=relaxed/simple;
	bh=lVCEG0RKrf99cmK90o53f4VPKV/Ma5VQknYoj04POJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JYkm8SRUpeUUDe3li+S96sO+ztDl46HjKmxUE23bWab9KGghwZBsZdJFaU4oRVZi+begpIBOg1tQrWk3YkMF9cxGLW2XwUDliOGi5AqRxaprTgDIkQ3pdascxGKj4zUe22+u1oZ2uyfwicX/2fK6+VGoLhcKE3f+XMyU8nLiK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjV0mDbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjV0mDbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECBA1F000C7;
	Wed, 14 Oct 2026 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998412;
	bh=n/7L9Hx0fZBDpofN2V6SVnORXJ6cNq/pMofdp+QEdFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PjV0mDbNCM2uvWmBzhBG+JFKY773a38Jlt3qhc62DXID9MYXfyFeBrME8bLPj3Lte
	 aiF0Qu4Gqj5WAMEQBPJKSHtmzc1XugCf5+HyWI2QIQ3PKXG48gQBOpYNW2lw1JZ3AZ
	 OdSwr2daGi1PrKG8BQryGrBGeq3lhGH313WapXrCusZyPGi4PNDHDmungAZ8k/rFGo
	 tgNYqn6J7yyS1FcOS/B47+YA8skjStqkdxLdALQqgtw1M6RabtUY7qkLeN3PKahzt2
	 RovOQriCkxcFvt+lNCrllfSEvuVohlMnni2EklpeGZA2+E//yCgV0HPgWv1aWOr/SJ
	 CI5vV5uUMZ2mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772A939FD335;
	Wed, 14 Oct 2026 17:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Reject signalling responses in
 invalid
 states
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179199841101.2868755.9541484050072201773.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 17:20:11 +0000
References: <20261007144717.3832330-1-oss@fourdim.xyz>
In-Reply-To: <20261007144717.3832330-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 Oct 2026 10:47:10 -0400 you wrote:
> A peer can send configuration messages while an
> incoming channel is in BT_CONNECT2, before the
> security or deferred accept gate has completed. A
> configuration response can then promote the channel
> to BT_CONNECTED. Configuration responses can also
> act on channels that are closing, and a late connection
> response can move a disconnecting channel back to
> BT_CONFIG.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Reject signalling responses in invalid states
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ff5a6d955bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


