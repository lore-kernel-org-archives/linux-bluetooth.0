Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728635C1BF
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100609; cv=none; b=TrizI03q4yCtxP/aK516/9WMVVAM9ygJFDA8j4BR1DPlq4UkD20MAXOdgkZzJCgH2WVyKMe6STWxsdRbf6SZH2IP/kiiZqILlVTr8YSY2qN6BLH0mheEJVfk3uItuq6qVV2arTtOCUEtX4gPa+mk1WNO46cHU254iv6CBKIy9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100609; c=relaxed/simple;
	bh=egkdDJk1kPH+DG6hBhezd6Ft6eKRlbhrzeLv4FE/cJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WthE9ngL6FPZsTD1QfqBjuu7IhJfUu/9xAiNH/Ve6fF0KnGvf3Jyu3potI1DjNyBnTZ5mQzBv1EcewtZnjsVswemI+Wx2vs7pRisIuwgSF/U5ngG2uBJIj3db5aAHhOQ0CxaZBXHAeNgNnakqbGodkdZBlqjejW1wzkMWegaWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtboSJe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtboSJe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89DAC116C6;
	Thu, 22 Jan 2026 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769100608;
	bh=egkdDJk1kPH+DG6hBhezd6Ft6eKRlbhrzeLv4FE/cJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PtboSJe9Ls2cllcUbkw/QBJYquV/mCGXZ1ggsIcwTgRYNGOIGsMkYFn++N8453zwX
	 pbXKl+tOinPHdXYGFz/8LRhPgVHWXCrF2lMh0b94us7KGp/fgXFZUIRq8SsgYtpDUc
	 +g4A8tOUpv+d1fHGoBshhPK2DVapqJkSqRzYAWXwEvphZ4K1ib9NJFzHG/72XusHwS
	 jOWphHhTotGCKju649SIJOLgChG7Sk4aANzD5pDiw0DOgVbucl/DXKiuNeEYjqMNC6
	 a0u1UDj4Qxq4544jI1VyO8l8nh9JUsRHrKJgktKcf+wBHFHfP6MiMuunrSxCNCGJJw
	 oZEbir9ZYsePw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC913808200;
	Thu, 22 Jan 2026 16:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ v3 0/9] Port text docs to RST and move man pages
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176910060535.1806518.2169700983805092118.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 16:50:05 +0000
References: <20260122091003.398400-1-hadess@hadess.net>
In-Reply-To: <20260122091003.398400-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Jan 2026 10:04:59 +0100 you wrote:
> This supersedes the "Port text docs to RST" patchset
> 
> Changes since v2:
> - Move all man pages under doc/ so make it easier to reference
>   in the HTML docs.
> - Fix syntax error in maintainer-guidelines
> Changes since v1:
> - Fix distcheck
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/9] doc: Rename section 7 man pages
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5e2bb7b1ba13
  - [BlueZ,v3,2/9] doc: Move all the man pages to doc/
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=44e3dd321e4b
  - [BlueZ,v3,3/9] doc: Port assigned-numbers.txt to RST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e93d8cd4fe41
  - [BlueZ,v3,4/9] doc: Port thermometer-api.txt to RST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4371db7798b3
  - [BlueZ,v3,5/9] doc: Port security-bugs.txt to RST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=17d407e34cbe
  - [BlueZ,v3,6/9] doc: Port coding-style.txt to RST
    (no matching commit)
  - [BlueZ,v3,7/9] doc: Port sap-api.txt to RST
    (no matching commit)
  - [BlueZ,v3,8/9] doc: Port maintainer-guidelines.txt to RST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fddcda9751af
  - [BlueZ,v3,9/9] doc: Port health-api.txt to RST
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


