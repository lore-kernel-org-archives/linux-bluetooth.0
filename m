Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83F1CAAC
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7/rV89k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18ECBC433C9;
	Fri,  8 Dec 2023 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702074025;
	bh=5dYtSoA/F2xJI6Ob2zZPpDcY5xOUFbEnCn+Xd2vxAiE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U7/rV89kWNzRyXMob2+DlrktacA0fNywcE1f2a+9plkvcDtJx5CkAYTje2VBzLSRF
	 jih4sBiTUgjDOwWbymQoQUNF/qlE6KdYQd/fDnyKFroTNapMC9VIYHf7mLq/51bi41
	 /jpFOl0kIzLT/VV2AsnoEYy5mzgX4kLVYR9/7ZI0hqVkqJPMExdRyHNDNzKPUGoneU
	 1YR19tIpA3aSrF1i2fpdN3SAm9qrcDVoRyOFhLneA6XQJL+y8+wC40AhuJt+Xmdz4M
	 zouIUXO7R2wrpAcQIPe3xm9mJHPBH3L96L9Uu9aa9cJG9IBBXubH81B0KmnguHU37/
	 HK1FbCqKIyilw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F28A9C04E32;
	Fri,  8 Dec 2023 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: Fix not prompting all parameter on
 endpoint.register
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170207402498.26151.16003369888215600659.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 22:20:24 +0000
References: <20231207184723.3862261-1-luiz.dentz@gmail.com>
In-Reply-To: <20231207184723.3862261-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Dec 2023 13:47:23 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When Auto Accept is not enable not all parameters are requested.
> ---
>  client/player.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] client/player: Fix not prompting all parameter on endpoint.register
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=477c41c683ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


