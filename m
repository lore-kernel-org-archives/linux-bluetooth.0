Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B791DF724;
	Thu, 17 Oct 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180826; cv=none; b=CQ46aDAjoSq3ehVssKG+b66z12IYAk1ZRUfENyO6vw4986vU63iHYnai3AR3Ye0ltogU0rYQFMZ8IXIJH741Zd6JhrCVvLFXDyYEqDoGbn+rfsmwG2ePbT6/jCXshFI1NojdopvZMAQPzlxrASS5g9EYNh7stTmnVSVjIHhHzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180826; c=relaxed/simple;
	bh=5+SmKtO9XwsSwFsa5vzfgnK9rnEPhdGGEFvARIzd0SY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MDOG8qutiERh0LBtdMhtNjGFZHQqOgkmI+xxe+lI1a/lvnhswAkmiXv2FwHJaQltMhCKzBIFSjb0SQWI3wjCU/CBlHLtCeRebdhh3AM1mZQJWcdBF+g6cCLxHBQsE7ttWov+1pYP+LlXEL0tAUfj4y57IT/YFrRmoYSsGX/FU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwffI5rB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwffI5rB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9D2C4CED0;
	Thu, 17 Oct 2024 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729180825;
	bh=5+SmKtO9XwsSwFsa5vzfgnK9rnEPhdGGEFvARIzd0SY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fwffI5rBVJaJCH8qVZK+AT2j0ClIJQ+3/dNlcNUONoSn+y7LLjXqI+S7Srq+BLXY7
	 tqZ3p3U9luTX04M+QA1OEKx4MtzEvADC6qIrGm85x9uUtbIw4n/nwK6s3orCTA0Gns
	 siKhNncDZCVf2NqDE2NkrIBNABAZAsnZLpNKuTJd5wuJqlqjb9PCMl24GjNAY5K2hX
	 hMq4Bg/NrsFufvCibvYdFvzuHNsvw1X9eEV2nKs1V1bjVhXRwyuRrx7O3nKnP5WiiD
	 hkQhxU3Roa8FWYWmr12vi9SI6BFuPY6ERbSizNsUeZ2vsvOc7p61O2QHPV1mRFdQK5
	 DlwvE35jsIohQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C833809A8A;
	Thu, 17 Oct 2024 16:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4][next] Bluetooth: btintel_pcie: Remove structrually
 deadcode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172918083098.2518908.13574572072114343428.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 16:00:30 +0000
References: <20241015232212.19242-1-everestkc@everestkc.com.np>
In-Reply-To: <20241015232212.19242-1-everestkc@everestkc.com.np>
To: Everest K.C. <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, skhan@linuxfoundation.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Oct 2024 17:22:05 -0600 you wrote:
> The switch case statement has a default branch. Thus, the return
> statement at the end of the function can never be reached.
> Fix it by removing the return statement at the end of the
> function.
> 
> This issue was reported by Coverity Scan.
> 
> [...]

Here is the summary with links:
  - [V4,next] Bluetooth: btintel_pcie: Remove structrually deadcode
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f66f6498463

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


