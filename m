Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBD38E125
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942615; cv=none; b=pAS/FjyC18WTeRvo+MflnxsxxT0tZKFJsCj8PdpKZSbd3CbDRpoSlg9SrJ+HE1jguabpvhAiKImRf+7wEKuB/b3zWX+pTMD27KP9lWmoiomBjWKQaAFO/B/SbmcCd41EbBEEwqurN9JuOlY/WxIZUjZERFb3owhjDnJ94fXQbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942615; c=relaxed/simple;
	bh=YgV5gpYHpAx+2JHoo61/3GNsTkLFzkiBel0g35Xv5aY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TKaYFTXRGpd7iP143MVlBHEK5srx1EW5GaopCADuRPVRoHABAhEkPsAc/vKaBYfcyv/fWSsSzA29OQtKorjFa0wySjGyuu9ODXcfMkfW9Il78ZdpR649/dp52qdMc5w296ycFrhQIWL7UwldtmC+UeZC/qMGW7wWP0+CTKTWgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvPThXcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvPThXcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0F7C19424;
	Thu, 19 Mar 2026 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942614;
	bh=YgV5gpYHpAx+2JHoo61/3GNsTkLFzkiBel0g35Xv5aY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GvPThXcXSBpdm4HCAd0nGVWUElGBYjgxAWfCb/9hO1D7IUgvfV+1SZodqS5JQBuLm
	 4wymT8hDp1KLeAUzMPRHdn1f+k11LKXC091qePhihhM926618DIiaz8Kqw6gFWHG54
	 UQt4g5S6/CiRPp3Rnh//IkA0UVPnJZWjn59QlDTd6fZi12/n6MbhT+2zUMH33yYi1P
	 5iwrH7qvLWEtRKIDuYOBa6yK1ddMrMN122jEtrjC3jFoYGJZDoWo4uzIHci/BqAzSC
	 TpZ8DTfBfEfxabkRWlA1rhX4FI5pNw9Dya55GTxp0PywajBLzn4GY8rbTIPIYLYTS2
	 uVlUectu13Rjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF239302E2;
	Thu, 19 Mar 2026 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] adapter: Fix "Failed to set default system
 config"
 startup warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177394260554.1735656.1849132373572262335.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 17:50:05 +0000
References: <20260319105457.1381098-1-hadess@hadess.net>
In-Reply-To: <20260319105457.1381098-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, ssorensen@roku.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Mar 2026 11:52:05 +0100 you wrote:
> I wonder if the original report swapped one warning for another, or if
> the problem didn't happen for the majority of folks due to command
> processing in hardware specific drivers/firmware.
> 
> Regression test added to the meson tree:
> https://github.com/hadess/bluez/blob/wip/hadess/add-meson-ell-wrap/unit/integration-test.py#L215
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] adapter: Fix "Failed to set default system config" startup warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b9a72fef5cd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


