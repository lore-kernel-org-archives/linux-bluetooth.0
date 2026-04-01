Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949130DD1F
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053821; cv=none; b=H4vNmW4WnVUFCbYTudWSPcMpE0aGYaUKjHIy/a8Dvwq2dgmX7vQf+RQM4OqHnhUl4v5pNmTJnWlI2tYAuNXC6sA9t6bbUDxnZErDOAOzuxj+oVb1NvSuxOwq7ZvIcpHgAtaPK8bnN59+mX9cmDs+HV5/VT7vD/0b9exnV6Xb8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053821; c=relaxed/simple;
	bh=Bt5QqtQ1p1kAFZ96Wh+ugFp26qOab8Eltm7tCPflaMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FKWhwww/5x7G7ve7d3KB41j624PFm9TH9b87RGPVvjPjJXE5rowQT6vH5CIfhC9PfnpWoRB7NJkpB0OTDgMEIKcCbT4scUCi9S1VStGMwmks0o2a8/jnPCaaprsjy6My4wx8Q8bpg+xScjCqerkAgpn8+4s44CZ08a7JU1qJCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4iUKpg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4iUKpg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D54FC4CEF7;
	Wed,  1 Apr 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775053821;
	bh=Bt5QqtQ1p1kAFZ96Wh+ugFp26qOab8Eltm7tCPflaMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X4iUKpg32fE6IcGDspslW5Cihlt0k+cqpI3rZhhVIsPlV0jo0ZLmFgrm/3hKmoR6h
	 gTh66NtoMMCa/JixMNJ0JwQ5IrhGW6KRwVYbiA7TRsr7MkCXvzSOuRI09kiOiR68H3
	 89X9iQLnILz74ISkotmy1Vg3PmpH8Iz2x67C/J1wpeoUtg0nqJAXGX1BPX0y0/JxkN
	 TSiBGQYw6i3Atm7UNbYjvG5N7sk9HwK+r99Ef1X2f8XMo4snL0Fi4qXWRqJ5Q8QvCq
	 YzsZYvvr35ztWB/45YlTcYCCP1BDBCiCgn0ed7Na12Gom04bzjYtdQm4KsIPvpjkrs
	 dlFlgNb9bGiYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1523808203;
	Wed,  1 Apr 2026 14:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] shared/util: Add MIN/MAX implementations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177505380454.3303791.10842549817858221295.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 14:30:04 +0000
References: <20260331213731.3895736-1-hadess@hadess.net>
In-Reply-To: <20260331213731.3895736-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 31 Mar 2026 23:36:35 +0200 you wrote:
> Changes since v1:
> - Fix MIN/MAX implementation (tests all pass...)
> 
> Bastien Nocera (2):
>   shared/util: Add MIN/MAX implementations
>   emulator: Remove compile-time header only glib dep
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/util: Add MIN/MAX implementations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=023e57342a07
  - [BlueZ,v2,2/2] emulator: Remove compile-time header only glib dep
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dbbfffe2c323

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


