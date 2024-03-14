Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7914A8C
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427830; cv=none; b=c7thfePYZP2IOhQIXWR4VoBmjuovp3AWm5xFY9bcrw0i3GusdEWy1uZyhPjNJuV1wu8b/7B3kmGIkn1vR9O6w+AIluRXu6mnnM2smUJJosUwKVA1zF3xPSvO8CTHwROUZUWb65u23EraHjY2iBpRW57fcETJANU0QEhO3vmRNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427830; c=relaxed/simple;
	bh=w3ujegH6fq1GBnLHaN94vO6JrAmJ6XTUuHrCBJAhi/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bwE39KRSoIPNRhfEfXaU89U3vyLLWRL5F+huU5RXinjV726DZcWMC8rnyMp9wLytSZS6UEck2QqPX3IsSthqeY0krYIQys+xFch/woQcPZKefh2rjPEBC9mdP9xBdR8p9sWFIbhAYgberiIROXfDnj3t0tZTyh15n1Hp6BtpQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWvU4Wh+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWvU4Wh+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D3D7C43390;
	Thu, 14 Mar 2024 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427830;
	bh=w3ujegH6fq1GBnLHaN94vO6JrAmJ6XTUuHrCBJAhi/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aWvU4Wh+ZVw0U8bbTHrHG5lVeJXyLWqf9WYnCB6jiIK2wC2my2d4fgVABYr4HLRx5
	 K8cusBeHEkOlf6N+R7NH2CUpN2Cx1XvvYLc8qQjvcRvbPUPVmiVhftqJ8YAfVdO2pu
	 agw5qhLHAUwfrGC7oG2icQOXgTmLxQ5rst/S1LETvPhR8VW+3TQGLZyygQDmauRSAv
	 tdybg+nP89frRD6abea900wKo9cXXf9bqE4IGHxR667QqWx9Wnbl4/khpOGX3+/ysc
	 9ZEChYcF4Rc9nq3WOOCbcDTv91EOxXkMghNHwzUkgRhJl+5WmCK66oBgwbCRk/pcbQ
	 P6OwrsWC5n4Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D30CC595C3;
	Thu, 14 Mar 2024 14:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] client/player: Update minimum LC3 SDU size to
 accommodate 8_1 config
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171042783031.19013.14035626803025494123.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 14:50:30 +0000
References: <20240313090359.164196-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240313090359.164196-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Mar 2024 11:03:58 +0200 you wrote:
> Currently the minimum LC3 SDU size is set to 30B. Thus, if a source
> uses the 8_1_1 config which has a SDU size of 26 the sink's capabilities
> won't match and the appropriate endpoint won't be created.
> 
> Vlad Pruteanu (1):
>   client/player: Update minimum LC3 SDU size to accommodate 8_1 config
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] client/player: Update minimum LC3 SDU size to accommodate 8_1 config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=84628e5d109c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


