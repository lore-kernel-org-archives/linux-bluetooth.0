Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1B4EB38
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944795; cv=none; b=eA6BoCb3UCs1L7hYSCdaEKKFh/G9BHpZ6Ovc7JkwrQcitFLZLNuzyjBNq2NZaSMLBFI271IrEbGfelqLmBnxkbtdVK2kzE+8zKdXtOaXb05glS69WqxezS4jN1sO536d9ZE4FxhWsl68xYlhTaX+2aoIPKD6pocOgTmDdADeCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944795; c=relaxed/simple;
	bh=uPWV+4BD35kVfHCdJT4+i1uWxLY9CcrzsuCuhcbTzNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LgVm/VCCJJm/dbQYpSdTi9FoIQ2y1lQ35XYS7mmw+8B78a41U7ytgmGh8O6trefxR2x3Nzj9W2eeiULAsFeBUPHiKxnwlYn+d+cQWR84o8IUmoDWBSpTLXMF24bmbBBKTJoHaDBWkRZJMaNxkVlvJhYalozBbJ/iVarjQks7IFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQpNyLvS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQpNyLvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A414BC4CEF1;
	Mon, 11 Aug 2025 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754944794;
	bh=uPWV+4BD35kVfHCdJT4+i1uWxLY9CcrzsuCuhcbTzNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FQpNyLvS35g2LyV9KOT9xwEwIk5GLuLEBIDuuVlh42k//uImrj59t2K2kmYVEARB3
	 XbK+twTRewHhdvk8T+IXfOBNs0aRFS1f7HpB7TOT1kRRq7B8bKeihsOHt8ftCU2MFi
	 461IxPkMug6Rtwa57BuTH8aBWM8EhdmY+5GyDAmZbVp4UyxP3qyQWi4q0KrFFVa/c2
	 c6/taelClSPOcfMG3pbtAPP67Sfhl4PeEEF+bz8hrNleqOsoSBZHorb1eSfYtVbu+w
	 CyPVuBMCzm3vUGR2vUe0fbYqIl9y7Aa62zsbiqjtCsBaVFor2AZRe6rVubY/sy7ie1
	 3d8AMF0rFKmrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB2383BF51;
	Mon, 11 Aug 2025 20:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: remove bap_update_cigs callback properly whan
 data
 is freed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175494480698.1883756.10106791828422917047.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 20:40:06 +0000
References: 
 <36b28eff897f6dda6872ce26a13ddc571a7e5ec2.1754821407.git.pav@iki.fi>
In-Reply-To: 
 <36b28eff897f6dda6872ce26a13ddc571a7e5ec2.1754821407.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 10 Aug 2025 14:39:10 +0300 you wrote:
> setup_free() may re-enable the CIG update callback. If this occurs in
> bap_data_free(), the callback crashes with UAF.
> 
> Fix by moving clearing the callback after all setups are freed.
> ---
>  profiles/audio/bap.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ] bap: remove bap_update_cigs callback properly whan data is freed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bf5ec167b66f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


