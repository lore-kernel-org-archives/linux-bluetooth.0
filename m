Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD983DB658
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942812; cv=none; b=c8JI6ncuw6IZ0lkMSdur1uAnv+hk1B3TqKLkIY0xf9cG0FNUFWucEeVeJWh+O86qQ6LG8fO2oPP0tcryQ4LXfxPZOQli2G6x9Ff2m5DXOVn01MNViVtKx96nyJatZgdZxFiw3q3lcXfWD6MBng0NnNQzuQalDndJVabEprZdeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942812; c=relaxed/simple;
	bh=VgEjbatpYAcLxOcfC3fnbtT8JNqnOA/nkpfBGSJgeoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dW0Xw+VY5Z9qBZPqqm3mu1BHqZrMYOhuz8720yiOGGv6F7LQLZVci44n4dK5USmsTuzFM/W4yo1UUqfSf2Ccb0GLOKKTulcLNnDTZgDW/avJAUh3gveeBTPH8rm/1y+9vPnrOu0lfnkT2ze/gOVwImLePIF2ka3fFFExDSRZZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp4F58wD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp4F58wD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A15D1F00893;
	Mon,  8 Jun 2026 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942810;
	bh=J3io2Ii+XgM2oTAFQrq22sQa2eUY4dBXhk316zQUi1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mp4F58wDK+nstL8OEMUhB7AaV4Xk2oEpzL8bI3tfyGzA1oMTx0am/hvzxrklypFgu
	 7HqoNIDW/Lza9qrcqT+DXXTmRIKjirvBci/xzgoHgAwExs3a0zTOoqbC0lH3iNxDwN
	 MqftrHrSujVstxRjrJ/z4Mo1HkETWWe3aPEuQWRPN3StoKa+ljeWwrKq74gDk8jqo5
	 34CGFdbanX4dwEy+sfn2D90rNddBWk2vjK+lvRezRqRWk235HuVlMCw11juP+o0QDV
	 XEIhTDVFogVS1PXog62FiJ2itDxu8aoFhaEKPr2sSmBroLnBrN9L48H3xhvJ89bGXA
	 Zl+GW5X5v49aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5680A3811A71;
	Mon,  8 Jun 2026 18:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix auth_retry timeout not being removed on
 reconnect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178094280888.1611786.13253152725240385215.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 18:20:08 +0000
References: <20260608112403.3720840-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608112403.3720840-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jun 2026 13:24:03 +0200 you wrote:
> timeout_remove() was called with 0 instead of the actual timer ID
> because auth_retry_id was zeroed before the call.
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] device: Fix auth_retry timeout not being removed on reconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ca747652dc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


