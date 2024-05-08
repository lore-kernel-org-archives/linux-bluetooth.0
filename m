Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1786252
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178632; cv=none; b=cRJg0lNDy84KFgxqtBa9ELNhm0ehfV/liSb8leELQiZSZIOdgXUYLUxdBoMTtKrsRVeiM3S7dRw1I2xMMnDxwtCX59o9+aEHn9Yb0QCmUZQuQ/s+BWCRvl8qLhplp1ckQihoy14yJh46h8EO6sgUdCT/nOEaNsZI7T5TbQwuwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178632; c=relaxed/simple;
	bh=WpbmVxcwpHBrkTbIxkjlhn4H+++Cnm2XPB+QgW91nMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etEBfXI6LCb5joIOw1EALv13ZRBp/qjvVNIt6NIHre3wspKi2VU6ZKDH80IZs1rIxN43RpH/Y+5Bn3U9sSxreoiC35IxA6hPJbMxvwgOPH0eSwccXziDNM80nNWpn79wPnJhC0JN0Ud7KNjXF0yvSJBuZVG1IDx5Xy+cLl7KEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjsVJKVN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjsVJKVN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D697AC2BD11;
	Wed,  8 May 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715178631;
	bh=WpbmVxcwpHBrkTbIxkjlhn4H+++Cnm2XPB+QgW91nMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WjsVJKVN2Sm/783GBUlay1Lx5vIZvriYY+p57U/cnCpDoVxn00g+ZodRDsDz+KDR/
	 etec8Zflkx2D5qYIwg9MQ2d9W4afMYaL53HGLMi2OgxrEowLni7LfhDBI4tZ8u6lly
	 JrabKWoamrj0//6YSx5MwIt1K4pxt2SrzS/S2eB/TALjxwuwuidhWKe+m0+ovsJSZd
	 bQU5LPtFNpwXcuQB2KHhwkEgmfdACOqRjSKWBOqFwcQDcbe60iaZnl8oV/faTZY4C2
	 I9S8WZF+/XzE35innCtklLptE/7WSoW52gbSZjfLaIaQ6J3aqX4TI42tz+v4qnsU4/
	 PnKZ+uNy1LgrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEACDC43331;
	Wed,  8 May 2024 14:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Fix compiler warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171517863177.26292.12022595842469164818.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 14:30:31 +0000
References: <20240508095927.155528-1-kiran.k@intel.com>
In-Reply-To: <20240508095927.155528-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 lkp@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 May 2024 15:29:26 +0530 you wrote:
> Fix compiler warnings reported by kernel bot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405080647.VRBej6fA-lkp@intel.com/
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [v1,1/2] Bluetooth: btintel_pcie: Fix compiler warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/75f978197b0b
  - [v1,2/2] Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config
    https://git.kernel.org/bluetooth/bluetooth-next/c/1f1dda1caac5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


