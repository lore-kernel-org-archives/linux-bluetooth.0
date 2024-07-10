Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991271E502
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621835; cv=none; b=Tr1CIwqfKnr+/2s43QSea9rSlZeKicMw4Qw95bt6uVv9BNAC5wAxPXj4LFBli3GAX3oBoYWrgRpYGS2tRkqWkEa9dgUYXSO6iiAX6gJXzsaRFyiUW593kZJQh4qG5jDDwxb0gtQpKUKO4qiEUU7FJSg7nQtZ9ZxePClpznKM7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621835; c=relaxed/simple;
	bh=gzLxXSlJdNIhfidFbaBhjrLtwUi0ANoqpt3trwT6zJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rXtcZTwv8ZHNDQ5Sta+ArOZ7JsO1tMbyZi+/mWk68ewmpGqTftke1xbIWse0jCv2DKF/StQ8FPdK86L64aJOsvUGVH5g1C57j9/f6NFBZNWV2Nvuxs20ppmSKHDrNMAxssSlz3xcP4RtQQ/zibjkQNkEaK6k7clnxk5gWs85bzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr51xazF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr51xazF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4180FC4AF0B;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621835;
	bh=gzLxXSlJdNIhfidFbaBhjrLtwUi0ANoqpt3trwT6zJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hr51xazFUVPLsioXYVaKAYfcirGGSqzVdRmw038qAP3BGvGMqzYp8VvVEpWaPf4pt
	 MZf3WvUpLsDcdxMsh+YOmX3EDvffKD2vx/Fp96rTgQmXHk2snlxstlMivQilhllOHb
	 Ecn3Mue+BLmTcb8cPmTImy+ak2zDSrRFKVEltI26BAC4dlf6gv6Swh3lnECrHJDzJf
	 u0BV0qOkKEXJxk8PSugycXMQ0rV8gCbZjnV/foTlNOn0xFTiU1r80ZL5JDshGod5jv
	 R03SYnwp0iHeeCuRw0Ep5HnwbJhk8nifMc6nKcLYklft2kBPpofzUosvw4DqiUt66x
	 K9OTguEQsxGJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F114C4332E;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] fix errors found by SVACE static analyzer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062183518.19459.12961676067036459891.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 14:30:35 +0000
References: <20240704090756.31351-1-r.smirnov@omp.ru>
In-Reply-To: <20240704090756.31351-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 4 Jul 2024 12:07:51 +0300 you wrote:
> Several bug fixes.
> 
> Roman Smirnov (3):
>   shared/vcp: prevent dereferencing of NULL pointers
>   client/player: fix the order of args in cmd_register_endpoint()
>   shared/gatt-client: add NULL check to discover_secondary_cb()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] shared/vcp: prevent dereferencing of NULL pointers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ffc08dd78d6
  - [BlueZ,v2,2/3] client/player: fix the order of args in cmd_register_endpoint()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cf3d80a01f1f
  - [BlueZ,v2,3/3] shared/gatt-client: add NULL check to discover_secondary_cb()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a45038dc1e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


