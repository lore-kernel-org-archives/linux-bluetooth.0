Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D393182D2
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745022; cv=none; b=t2eGHTz6cDQWoJxBY/DYTArR4X1ukNpCAr+vQdozImhcdGF01W7LCIpII2jwUuswU5CjBlukz2X2Z2USeNm1jylMuP91ABzy575RvZNzg8atdNwiX9pDoSs7KuAiJwzUjMD+uOelZ+iCZIgc0UaaP1KiDu7S5/tazaeR3Hrr9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745022; c=relaxed/simple;
	bh=BiRBB019621rEFTkBh9anL0DYBTtKf3OTT1fOZkl/q0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OkUadyi5wWKpr1hNgKqKcX3wVqi8jRchKR92ZxNx7rr6cj0jIWpn/wAx/VWTjwghO5f6CrWS2ZKLbiyWxznqQZOe6StaZmwQQYhny+QwCg/xknNofC5X/IYORcsR4jwVcW76arhWqJbSOc1cz/ij/2socuOXkduYWrUT/qF67k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CX2yWdAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX2yWdAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23528C4CED0;
	Mon,  4 Nov 2024 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730745022;
	bh=BiRBB019621rEFTkBh9anL0DYBTtKf3OTT1fOZkl/q0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CX2yWdAx+FL9Lc7RzVkwHk1dSfzfqjHhjcn6lm1UROeWO4AV4gQq4MFwE/m5F77sL
	 uhw1cs5kWGdjvltsFrNf9p/akedX624fpTUvMoFbZYL8VdXU/W22YwyYu3RpkbfNzP
	 qmoj4TG2JTEKNaw/6ZfFRl4wF7a24zREVYd3s8ufI0idHYW/4dNWkwm9KQYE9BN4P4
	 vygKbZ2DleEADVG4sIHveNZbVIjhURE8K9euRxRCPgrnx9lsydRmPRdLaqFVYOTxdm
	 xBp+YkZs0XAaQEwZ0vMtW1KpY5jMhluzylp4jcin+0juCNJTANP9eYDlNlgmQbqvZq
	 SEnY7l3KSirEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3A380AC01;
	Mon,  4 Nov 2024 18:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] transport: don't disconnect A2DP if canceling
 Acquire() with Release()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173074503075.4163490.2204307511896366622.git-patchwork-notify@kernel.org>
Date: Mon, 04 Nov 2024 18:30:30 +0000
References: <cover.1730579026.git.pav@iki.fi>
In-Reply-To: <cover.1730579026.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  2 Nov 2024 22:29:44 +0200 you wrote:
> User can cancel transport acquire by calling Release() while Acquire()
> is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CMD,
> forcing AVDTP state transition to IDLE, and A2DP profile disconnects.
> 
> However, Release()/Acquire() should only result to transitions between
> STREAMING/OPEN.  The expected behavior is that either these calls return
> error, or they block until the target state is reached.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] transport: don't disconnect A2DP if canceling Acquire() with Release()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a14d59725ef3
  - [BlueZ,v2,2/2] a2dp: don't change setup sep when it is reconfiguring
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=664a5d3785a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


