Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EB33C9;
	Thu, 26 Sep 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382632; cv=none; b=a42IoO6JtrE7HIFxhdHrBKbk0zk5M7VD64s+k58p9tz8LvyigNYA4Gxn3yK0qpK128+7iQXZkj40AhoEoqv3b/trOKI9h8gSqvtRFmcNTJTXGyHuX1W0i173lPCdS/i9uHK0fp9zrRVHWbX+3QUyK/n8/jgA6j5nwkuQ+Sx0dzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382632; c=relaxed/simple;
	bh=JQxdFgmwCweBu0HFCk0fdL+4lGYfUnMWrrjqi7JcZ8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rqEYTigBjiYhNYT0f0ju9hI1XY7ETCPTmsLw1OlpwrafBMxQnLBnZP3k9DtGNKviUQk9cEbFdX/Qn/Ge465jBno0VbKl/KuIgLrAgpKzM+XffRsJ2806u12MfqktfUNPmfvVhyiBRK4KMZTAjQRBc2pB68cPzrCnHsd5LJEJckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHWQPEUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHWQPEUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7405C4CEC5;
	Thu, 26 Sep 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727382629;
	bh=JQxdFgmwCweBu0HFCk0fdL+4lGYfUnMWrrjqi7JcZ8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mHWQPEUeQZEqyPJ2/VrVqIX7IbgV/GUWDDRhxaLFbLMNUj/UKcdmJqY9OAFjmLY0j
	 eiYQxNjbpF4dDYBdlOwGzdcWHtbUArIX1LkrPtwoZZd2x2prvYJkCJyvLWPZ7uusmh
	 ZAlBmXmXaSjZMVD1XlXQP90iUOlr+VFCS5XuvdXplcggm+FOOs4kiu6ULHztZ/cTMg
	 LKKZnfFhOEMwjO4wG+7yDmTpoidBMfBMqsdM4IcsOLlsBeIS8BBahThJ8TFRf23x8H
	 t5dMuxW+SgD6ZhZVJTdQJc0pAmHe4o+H4UBF/9abEMBcOb3dQgikKRKxouEFA4oCBD
	 2TY3mMEIoEKhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4F39EFB74;
	Thu, 26 Sep 2024 20:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: btnxpuart: Drop _v0 suffix from FW names
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172738263200.1385049.5849692333167490001.git-patchwork-notify@kernel.org>
Date: Thu, 26 Sep 2024 20:30:32 +0000
References: <20240926040757.375999-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240926040757.375999-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, yuzhi.jin@nxp.com,
 sherry.sun@nxp.com, ziniu.wang_1@nxp.com, haibo.chen@nxp.com,
 LnxRevLi@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Sep 2024 09:37:56 +0530 you wrote:
> This updates all FW names by dropping the _v0 suffix.
> Its been decided that all NXP BT/ WiFi FW names won't support _v0 suffix.
> The suffix would be kept for next HW versions such as v1, v2 and so on,
> which do not have backward compatible FW.
> 
> This change affects W8987, IW416 and IW615 chipsets, out of which new FW
> files for W8987 and IW615 are yet to be released to broad market.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btnxpuart: Drop _v0 suffix from FW names
    https://git.kernel.org/bluetooth/bluetooth-next/c/0d9899d4df63
  - [v2,2/2] Bluetooth: btnxpuart: Rename IW615 to IW610
    https://git.kernel.org/bluetooth/bluetooth-next/c/394cf44ded5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


