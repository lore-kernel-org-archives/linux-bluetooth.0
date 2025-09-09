Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AB35AACA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451008; cv=none; b=YDV03EVFs8A0Dr7ahx+njx01PmIa+0VFMNw1Dc2FZ1VTRUzM63I0pjmtMJHgMP7UFO6nQpEfWF0If7ceqBW7GirwcRVP7XKAyuY71GkDb8d7GsxVNytkMuAHqnfAY8qD8QDbTIc5p3N3FXfpsBdbAJaIv1Vtrgx6NLguvfxIDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451008; c=relaxed/simple;
	bh=pIyV3U1B7duN8xHHbViaUozlMUjWcAx6/An2J8TqHrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQNz3w2oDkWaVuUBlZKU6iLYEUQc7Ftr29DAbfg/YMy6pMaZzwpK85G7OUED/ojTpjc3ED+eurQWlO93BExBsfh5qZoMoL+xV7bu5G16QsRl1Q7SYXApfB9pXFI4rm+g+M0w6WiO1fbIaB7PTYWnBrlIIIjSDVK+9kClxWShvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAyzfIGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAyzfIGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E79C4CEF4;
	Tue,  9 Sep 2025 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451008;
	bh=pIyV3U1B7duN8xHHbViaUozlMUjWcAx6/An2J8TqHrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eAyzfIGOjCqb8lU4WA8ZJ0sIjpxIBKkWAUVzm1/TjCkCfCwqizaUPpUFSSKWiQ7/M
	 a839N13uVyypaxWYbZrRHFCdndm9YBzAJHCPIAhf8yuE4ZjIU9kZTU5vcQtjvAtdoF
	 hoqBc7t4VpXnEGPOkoT0tLo0uMMeDvtNgmoXgQN7iT9jb+xcn2QlE50gSy2VXmT6Cc
	 addaAuUd8i0IkVKOQwkShQKluO1mfQvaECokzlEs0m3aO1VwhVhhX8YmV82JijA5Cg
	 RNiPQF3E3xwWY4PqNjZuc1zQeFzC9mlcvFvHKXwquVInxqrJbdYcR0KMFjYC/uL4Rs
	 uKPfo9KfdbpuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF89383BF69;
	Tue,  9 Sep 2025 20:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] unit/test-hfp: Fix MINIMAL_SLC_SESSION
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175745101124.813171.15633241691431049504.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 20:50:11 +0000
References: <20250905142115.942982-1-frederic.danis@collabora.com>
In-Reply-To: <20250905142115.942982-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Sep 2025 16:21:15 +0200 you wrote:
> Fix missing commas in +CIND reply.
> ---
>  unit/test-hfp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ] unit/test-hfp: Fix MINIMAL_SLC_SESSION
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=441f95a9c146

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


