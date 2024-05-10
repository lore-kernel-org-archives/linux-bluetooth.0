Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF54EAF6
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359832; cv=none; b=VbygQqxmGsyd4jaWUNdxQqVehVierFPB5bLoyQva79BPM3yp+mb1cegOozPGzHAq/AvB+lqTlnf1rURw/k+Nix0v/rYMzq5kDWeAeX6ReoI1O0vUysnRg4prI+yDv2auHb0IBbzOCTCesFG2bz9VV1iWql1bur7ntwgTr7D8eA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359832; c=relaxed/simple;
	bh=ZVSR0bWGATJ8w5J6s3RM90XdJyB1PVGaHpBgv1g9FAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MkGuKvgtpRrxxjGkDVljo2n+bE+OvlcE7ftl3reXOmEunc6tG1ldl0i21JQZ8RIwjmYb0pUWCJbJjKeWR47rM445cwGJLmXg6YMgHdsLi63PckZ36e9onPpJJjo67lAgarFSNaUrE1kAo2lRWpA+Sjr3gcCDxWrRr+MvK2dgy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7JJWJQi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7JJWJQi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B02DEC2BBFC;
	Fri, 10 May 2024 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715359831;
	bh=ZVSR0bWGATJ8w5J6s3RM90XdJyB1PVGaHpBgv1g9FAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b7JJWJQiT01BLcEOT/RkqlE3X7tW+JDQRGSnMe4YIhvRMt1azSdrkU4GDzYynWrQQ
	 SODoh3pR3tDf6iy7WcidV2XYtJUSnW9ydnVCGja4CNmzan4e2ee8MvIdZMAkvBWmVj
	 OB7/NnSB3DapeG9Pe58oJNJhABBNV6XIBUy3V0DVQMulRf7dDvj+aHRKHoGJ4KyErz
	 uWVBrYVgop4w7tv29FBY0qDv2VSUX9acAZs2CMzAo7RBsNHlz3y87DsJN9L2P87SJd
	 1yi+TC2TzcUbjaccPafDAuVlJrTUlYoMpa+7pT+TT21gz8++6wSjmawQYBTcJmaMLd
	 DeSEQPoeA22Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CD82E7C109;
	Fri, 10 May 2024 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/4] profiles/gap: Some code cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171535983163.10656.3025150081041498038.git-patchwork-notify@kernel.org>
Date: Fri, 10 May 2024 16:50:31 +0000
References: <20240510150938.1492169-1-luiz.dentz@gmail.com>
In-Reply-To: <20240510150938.1492169-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 May 2024 11:09:35 -0400 you wrote:
> From: "Felipe F. Tonello" <eu@felipetonello.com>
> 
> Just removing unecessary function and code duplication.
> ---
>  profiles/gap/gas.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/4] profiles/gap: Some code cleanup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1cb5708fe7cf
  - [BlueZ,v3,2/4] src/adapter: Added connection parameter load/store functions
    (no matching commit)
  - [BlueZ,v3,3/4] src/device: Added function to set connection parameters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d391bf4cf320
  - [BlueZ,v3,4/4] profiles/gap: Added support for PPCP characteristic
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d6fe19bccba0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


