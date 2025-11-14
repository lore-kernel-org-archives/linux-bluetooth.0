Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C33370EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140357; cv=none; b=gazE1cQNTkqDFA8/o7H3zKGtkSSWgMxy72/vzbeLG6tnD8JSHvlCzty9pq6Q6VwAhqLJrXAd7/hPGAmFvNgvvM5qv5bdBp/hV5VD1NbvQArCtQxcZI0qm7izWh/tUfD9fY7VktrfLcSvjtcGTAmb6NbBDuf078UBDBjnuIuX5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140357; c=relaxed/simple;
	bh=tazmg3sBGwa/6eyduPrd+dqTyvGgw8eato0YI6lwTCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bvpvSGSxTpgwDz63Fj9HtRY8fu1u+TnsWA9eq2RFio4uCbbGRaMmv7VhmC20ztihEaDT4LT23Qlx9xMmVSmPefXU3I/hwDOd0HAlnb8KjsyYEzovLQhCabrJWyQUKu0hbqDpMnTLeK9j8BJXrbX5pfPVfmxLQZpIv3a4NdabR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRavRkoE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRavRkoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B0BC4CEF1;
	Fri, 14 Nov 2025 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140356;
	bh=tazmg3sBGwa/6eyduPrd+dqTyvGgw8eato0YI6lwTCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rRavRkoEl9OrMGkfa5Z5/jYN6FTi5HAAAyQUouBIEobDSy0ra7g9//f+mt+kwZlyc
	 TFvIJq+2OCa4fTi6gKTP/dEAXLI0HT0XndRecQLhSwIgV5xkVDwrgLDMLxmfv5JnC5
	 Aao8BZmtC04vx774oi0DiI2EiuEjupY8gr3EYd5xInf2RTI+jCcB4enPlN5Iq8hCSv
	 2BEu/3glB3KiCU0H/iYR+uz8/L4w/fzZSgXapKWPkdMyjgzjK3Xd+Xv1HlmOqU/Nlz
	 LRyixea+A03/Ney3lWAAf552O0B5W2TZvKO7IgVeEKEJ14ScpibKh5klA/ystae6Hc
	 tP551x7NHdd+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8553A7859C;
	Fri, 14 Nov 2025 17:12:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/hfp: Add simple 3way calls support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176314032549.1740925.17204930037815149447.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 17:12:05 +0000
References: <20251112083150.54641-1-frederic.danis@collabora.com>
In-Reply-To: <20251112083150.54641-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Nov 2025 09:31:49 +0100 you wrote:
> This adds support for the AT+CHLD=0 (Releases all held calls or set
> User Determined User Busy for a waiting call), =1 (Releases all active
> calls and accept the other call, held or waiting) and =2 (Places all
> active calls on hold and accept the other call, held or waiting)
> commands and the +CCWA (Call waiting notification) event.
> ---
>  src/shared/hfp.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/hfp.h |  15 ++++
>  unit/test-hfp.c  |   5 ++
>  3 files changed, 234 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] shared/hfp: Add simple 3way calls support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9b4bf2917a3
  - [BlueZ,2/2] unit/test-hfp: Add tests for simple 3way support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=300ec5a46f69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


