Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A013290B6
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549218; cv=none; b=t0cqZL1npsv72dOsZE24EuD5FO2EW+COs86JH9udsYxCYz6GdLtStHLDm+yzcixj67zfWCZtvo3OyQYS+n84xrf91UD/naE/EjzvFDa1mx2el6+ukHrXzb0uGQoC6Hzl6bQVjQFG7L3dcIfAJ0Nxar9G8z/7e2COyhL/djR50xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549218; c=relaxed/simple;
	bh=uxR2nKRfUsCPGm57iBQPPAJLs65tA55EuPyedWunvX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cd0orWnjvaiDr1z+lCocMIdIq4tsYS0Dv944vDYeIFJB8Q4gMYYnjfcG045YBu796LcGcVXMPHJuH/2/oRt7GLNTVZNHP2YZaT+ZqbIKx+2Ip9PBoXPVtIFTMOWiB24dKXuebec0fdMzx2pFdyMF1LLwTROCFZS+Shd6FzPznxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWBUrl8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWBUrl8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02266C116C6;
	Thu, 26 Mar 2026 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549218;
	bh=uxR2nKRfUsCPGm57iBQPPAJLs65tA55EuPyedWunvX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uWBUrl8Zg0z5whg0IsdjDP6+3mGCkTlOzC46vBmcU1TQnY7xoH0wzZ3cBYZGOBin8
	 NISzn59db69xuNNBDBdgDrfWf5+U7JBKUJOuxyUxIBpmaA4rOYsc5+6S16iHPraBx/
	 bUI7SuJ9ePnbhdynSbrj1xb0VpNFUgnIWwRJNE3vbwSelYLP4BAhysa9tUmz04DJGZ
	 gtg7deBC0XJjz4sPrYUm7Oxv9m6+FPiuI3NxgMv6s7LIKVVvCaKmotfw6Q9l9B6Cca
	 LUDyUgqZ34wEMifRS9EJoAtenJipR+Nm+uFELsRES5bxBePxet6DbVPcZY1eZoguFf
	 m+YRv0xiV6JEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F4239F2038;
	Thu, 26 Mar 2026 18:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH BlueZ] mesh-gatt: Fix JSON files missing from dist
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177454920454.3119861.10982632592516507071.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 18:20:04 +0000
References: <20260326162454.1910916-1-hadess@hadess.net>
In-Reply-To: <20260326162454.1910916-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Mar 2026 17:24:48 +0100 you wrote:
> Moving EXTRA_DIST into a conditional means that if the dist isn't made
> with the deprecated tools enabled, then files will be missing from the
> distribution.
> 
> Fixes: 1f6553edd8a5 ("build: Deprecate meshctl tool")
> ---
>  Makefile.tools | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [RESEND,BlueZ] mesh-gatt: Fix JSON files missing from dist
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0d4bb4421952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


