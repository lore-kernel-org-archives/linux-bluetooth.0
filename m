Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BB19D083
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765835; cv=none; b=HIMTYV9Uq+5HF6k79h1oMsRC2VG9JCNv6eKX/7WekF+MiDy4axvhQH4Gv35jS/9vF6k0+yls+++I2iySmkzgtesc30xkDmcbmyRGORzlGgfSSzZsOGZwkzoVQ6OeLhSgwUEiGqOxit4CjGOXrGXcsi1D6UCnovLYEBBVS5q8V24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765835; c=relaxed/simple;
	bh=fhsgMYuD9W4xjvnAHa27MKBa3xorx8IM9aNpTJ/hZUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TM1MfeU5jQdZEpQlgs4L82jDCV1LRykVTtVHXdC0FxQsKWr6tn0ZzAEynztXM43gn57MLoVkUb27wdul4EjMqC3pmu4jYn2iJ4PCA4IhpD2GnsPV/A4+Zd+7YvFozuY83F4pdOO/KRW2HS/6f7fR5EWXotXM0Go2s17PUsxBr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm7g3Lvz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm7g3Lvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA11C4CEC4;
	Thu, 19 Sep 2024 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765835;
	bh=fhsgMYuD9W4xjvnAHa27MKBa3xorx8IM9aNpTJ/hZUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tm7g3LvzKUUWbiX4kqoPFi+VqHcqpMuIiLGD5HHRu6YpYF4aQse/INq+GCI4umXNb
	 UzSGTfe3AexvgJ7LXQf7B7XcKzQTa2NhRmtmGmAw4TEdnzffjdEN3y1F1Fb3EWKPDM
	 TkqhvS42IPPWCu6/JA6aGyYwhaEqMvaSFX3L5RmKwuDS+l5K7eLLjM7nninJLr0WJr
	 092d52jFBw90QuEq2GB9krPcpy7FvlXwKC14WKdtRH/NSaNHjAINPiFklYWW+WAmMy
	 Guxw838gFt0NtaQNpb3pA6nYu/tf6Bw+Na3OfzWbyj5ZwnInEigAHFn4/vESRzcxwT
	 V+4XTEhVigZBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF33809A80;
	Thu, 19 Sep 2024 17:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Fix missing inclusion of <limits.h>
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172676583690.1626973.2267863670049512471.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 17:10:36 +0000
References: <20240915202320.8181-2-ismael@iodev.co.uk>
In-Reply-To: <20240915202320.8181-2-ismael@iodev.co.uk>
To: Ismael Luceno <ismael@iodev.co.uk>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 15 Sep 2024 22:23:20 +0200 you wrote:
> Needed for PATH_MAX.
> 
> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> ---
>  android/ipc-tester.c      | 1 +
>  android/system-emulator.c | 1 +
>  android/tester-main.c     | 1 +
>  client/mgmt.c             | 1 +
>  emulator/serial.c         | 1 +
>  emulator/vhci.c           | 1 +
>  monitor/att.c             | 2 +-
>  peripheral/efivars.c      | 1 +
>  profiles/audio/a2dp.c     | 1 +
>  src/adapter.c             | 1 +
>  src/device.c              | 1 +
>  src/gatt-database.c       | 1 +
>  src/main.c                | 1 +
>  src/rfkill.c              | 1 +
>  src/storage.c             | 1 +
>  src/textfile.c            | 1 +
>  tools/bluemoon.c          | 1 +
>  tools/hciattach.c         | 1 +
>  tools/hciattach_ath3k.c   | 1 +
>  tools/hciattach_intel.c   | 1 +
>  tools/hciattach_st.c      | 1 +
>  tools/hciattach_ti.c      | 1 +
>  tools/test-runner.c       | 1 +
>  23 files changed, 23 insertions(+), 1 deletion(-)

Here is the summary with links:
  - Fix missing inclusion of <limits.h>
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cd1c6b666fa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


