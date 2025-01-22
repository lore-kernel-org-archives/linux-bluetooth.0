Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790011C5F10
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577811; cv=none; b=shJ/0uUQCAxvdnBFefGC+joEk4kLB9E8Nx+YqNg5oFl/Rzfv0u93fu8z2ENVPsMLXGPJXOyudCC/3UIsOQ+b82rLY0VFt789nq/aRGPIFa1i9QU1MmFN2u2yIOiCQJM9U/Uy8/L8w4xSXA5MUe4zfnrjB8g/SKyE6zpgTjmhAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577811; c=relaxed/simple;
	bh=DuNVNpezuTu+iMWu+YmnSv5G1WWRy903XJZGVZqJWyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LT36m9ovjYuZMgJss4v/GBYy1TvPbjs5gddlxX+mNFsHuDpWrT6WEo6Y3nNKFMRuI1g+7e4WPkJvJmiG0QmUBNnK6EGEBKoTKQHPAzyvbE9UT1WGgEWoEjkz2aGIWcjwIJOv8zT5kX7KZ5B9AXGZN9kxmLPGY0Q2rqvbRlLhCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM+DOkZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM+DOkZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC433C4CED2;
	Wed, 22 Jan 2025 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737577810;
	bh=DuNVNpezuTu+iMWu+YmnSv5G1WWRy903XJZGVZqJWyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bM+DOkZfqLCu3kI5SamWoXViMxPR3Hr9J1XX4zFs1gwgUZoMCTmDP6baBY+B6akj+
	 Yt81SYpN2Swq2Sc+fueVczoDjNdwUn7sWPZPXAsjR2JB0heOTEHGp8cusSYRTo+OhH
	 HyK9N/lwzwTIXIB5mw9h5gNPIJ1KXXzv5UyQowyy+V4aiDI13CBFDzrTkgeMMN8Jo+
	 SAijDQ4Rc3qkH8a9RGEjoG1OpnBAucUyBt0fw2QK9M5Gx8fDSAzM8KIt+dUzp0eSdN
	 26XCd9PVTMxt6UiC+eABPJpos/R/ZsdNSH7z+1Jn4OAqKnu/sp0nNClgRL5JTUhqHU
	 FwsbMq7bBoY5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE1380AA62;
	Wed, 22 Jan 2025 20:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/5] connect VCP profile to MediaTransport volume
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173757783530.808999.14960404075924959991.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jan 2025 20:30:35 +0000
References: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
In-Reply-To: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Jan 2025 15:43:59 +0100 you wrote:
> I'm already resubmitting, fixing the problems found by test bot.
> Sorry for spam.
> 
> Michal Dzik (5):
>   shared/vcp: add API to control volume on VCP client
>   audio: connect VCP profile client to MediaTransport
>   shared/vcp: fix memory & connection management
>   audio: fix VCP connection management
>   shared/vcp: control volume when acting as a server
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/5] shared/vcp: add API to control volume on VCP client
    (no matching commit)
  - [BlueZ,v3,2/5] audio: connect VCP profile client to MediaTransport
    (no matching commit)
  - [BlueZ,v3,3/5] shared/vcp: fix memory & connection management
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=53d3e2c5d0b9
  - [BlueZ,v3,4/5] audio: fix VCP connection management
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=49c53595e50c
  - [BlueZ,v3,5/5] shared/vcp: control volume when acting as a server
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=73b251b8e8f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


