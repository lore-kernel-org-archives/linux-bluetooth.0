Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABE718FDDF
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432033; cv=none; b=nd8IfGm4xXvsBLpM5/dYVJl8d+sZF+GWwkjV6BPpDWeOlF18dDpzFs6aMPT8RcgTFZdJJsyvZGU5EM7qNY4rAvEd0mfnx/qiuE6rcHe+FutsX+Vm0D8foKJqr5yLh8+fAd6zp9qzKgxOvJ8W9VHp0nFR0emV4DTvmsLdz04Hj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432033; c=relaxed/simple;
	bh=LDVl9YA7lkCdFEE4fG9wbxSmLqOJiR9Xu/inER06L1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PCzCrPEXJiglGNNltIE+uVX59Y2Fhfvqe5fx3Vis7Y6v3P1ARJQjHF/mVIpGfQW8hChBfARrLcerOR9Jj+O6vJLZts8DPChKIX8XgRIzNtnEX5oN7xbIfMF+d2Um4+2o7zfRW5DC+BQhOnIHkc/w/+TR9y+BaGzkMsJWdPfzvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV5jGPKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV5jGPKC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC5C2C4AF0A;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432032;
	bh=LDVl9YA7lkCdFEE4fG9wbxSmLqOJiR9Xu/inER06L1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fV5jGPKCJu/7Sv3Qr45Ag0+N1a/2SUNmKEm+2ord8DQkY244AZi13dJaBMKjV/6IU
	 uGK1Nrqzg+y+ianlt4EUjmYhgep1MX8+LgivZL90lGr5u4cOkuUZ9tMxWd5RPWyTh6
	 Zyaa/v5Z1hsI1LY28qz6UE+5beNS4etk6WIcxi0kzCkucSmkqkXPi+z9HeNeq95pJo
	 q3zPjfRqj5fRu/uUSWxbdkD4PTUGOuFHUk+2KFOClcFy850rYh3YR7UJzC45qtv0R2
	 5psai5wcuyntL8kTDFFfB1expeJLirsIvvhFIkB/6W9G6w2x394jlNcGBPSAb3xUmb
	 JdGg+RamAiRow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF0B5C43468;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix deadlock
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171943203277.19782.18176674708645424435.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 20:00:32 +0000
References: <20240624134637.3790278-1-luiz.dentz@gmail.com>
In-Reply-To: <20240624134637.3790278-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Jun 2024 09:46:37 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following deadlock introduced by e3203b177717
> ("bluetooth/l2cap: sync sock recv cb and release"):
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: L2CAP: Fix deadlock
    https://git.kernel.org/bluetooth/bluetooth-next/c/d8abca53bb2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


