Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F336DA14
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169060; cv=none; b=N2x6rWnZO6Fw6pCvJu/tm0yrj8qxoPRjZkH6XZbcJ7YcCC1WP9Qni61PB4E5R6sWzgg9tFTzknSkGfO2qMeUHFq35pmYH+XrddMRv6ZVlb8rM4NvA8135lq65XG5bEnA1RvQBecmdH76npOvBTm9CnTKR1kwrJ8mzPosI7P7kFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169060; c=relaxed/simple;
	bh=kMdi9l/exso7kEWXC+hg5K8Bc3Z+Bj5yf0wpEGgJikc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dnuqqopRMEl9vsEBvwK9LHhXindM9WxBLGoUFuka+3GirNs/385Hq4FoqqL3Ev7EYD+q20KBfg+VhQ8nko+P3lqySrusAoM3HLNCvAfkxWygKt8E6BnzC+QQVtxah6MWGO4iO87pU0uGZrH5xvBZZhpjcYjhiKsw0715M965E5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HubPCPj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HubPCPj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B581A1F000E9;
	Wed, 19 Aug 2026 19:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787169059;
	bh=zVffwJ8gWYNpKIgpnJIuS63+JSn7weiR4EL5OAcIyRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HubPCPj36Z+qkXmcD9nHatkoSK0EjrScjCty33SO+osXRSUQ1VIvtflboNmP/rux8
	 BsyJy8ECWT1I+6J9YDiT45JZBMxbRILo+M8EGiSAaMdaVZBmH+nq6dekga8KD6OLJO
	 h7kiCxt+abxn9jiwPa9JJvLMwlGcfgbhU5kKGNOYT3WjkKqamIVL3j/YhlgG3nGoOg
	 4oU3/bn8zF7RhjElSQa+9tyx8QbESMiKxi59EJyFkfCnDg6QcjjPNPbaCWyxVwqDjd
	 VhOmJsuxw3BJJCXH6wOn5P6MUP14nN+JV2kOnXB1HwwjvxF0FTy1OVDyk5TbyBVFA6
	 zvYAEbZYwn2wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09543811A47;
	Wed, 19 Aug 2026 19:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] avctp: Fix typo in comment which contradicts the
 conditional
 below
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178716901028.3669166.13010335698995727322.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 19:50:10 +0000
References: <20260818105827.600893-1-hadess@hadess.net>
In-Reply-To: <20260818105827.600893-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Aug 2026 12:58:21 +0200 you wrote:
> The comment says "If the request set a callback send it directly" but
> checks for whether "the request did not set a callback" using
> if (!func)
> ---
>  profiles/audio/avctp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] avctp: Fix typo in comment which contradicts the conditional below
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=44f6fbc4e3b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


