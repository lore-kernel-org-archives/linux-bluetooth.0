Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73BE19D083
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765836; cv=none; b=IGeB0ULvDWmZi1ZpfB9EW4AZPs1TeKt9aOpwbGh3nB6v9cHjwSIMAW3ZoH4gB+Lu4lqOUTIBkGX1Vr0RbOPl3/0v5yUd5ZMtgiaey44nNWoUWhKzFBQ4FB4Ez+dm39p+P8CcJVFhCgyxs7/vbUxZoOTv5d0md0gqjDyqB3mPtCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765836; c=relaxed/simple;
	bh=tCeGocAM1g33BqZPKqKgQdI2GVaIBKM0QKyLjCd8aKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xn8dvYPnVz+hYyVPmZdcFE+wz4GLvATHnmJmVLki3k6ptQLWHSO3o4pDe5Da/rALM8QHy9qseAXe7VGC1uDJyEUFs/umprlBjeoBcU6CTSi+8dR2vMs3dXGf+EjMNeOvi0LO9YJT/n8otb31gFMmPhcPvDJqI67yJ8xmkmwigRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc16pq2x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc16pq2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9669DC4CEC4;
	Thu, 19 Sep 2024 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765836;
	bh=tCeGocAM1g33BqZPKqKgQdI2GVaIBKM0QKyLjCd8aKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dc16pq2xrJDCi9F9Xs5NrZt5kqQs4whqmBSsLQVJHNyDsxtOOpxvwIUDm/iqBiB37
	 MWcSO+ogH7QzCD3T3Zm3eK3oIA8PdFNjZoXG62L1uOjR9WKJ4EYzNKh6DPy5IwjGCU
	 iLCatj2SruEuwbx0JVzaZcHJF+PvN9WJRyxLPGri3dfcRmgBPd/w/RD8e1U1Q9eJTE
	 oOdpd/r/z+RJcN3kB6VwEPsIRm6wLvhvL4PMRkt4/OCbBk0mDE9ywFTWotXFOHMUQ3
	 XAUSJvOk/0YE+uKQdPWhxZnhJwEs4qWKLw+drE092lBTqTlNigS3csUMSjmEIpwclz
	 R86KtY3Uij9sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1623809A80;
	Thu, 19 Sep 2024 17:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez] contribution: add b4 config
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172676583825.1626973.18153353049532522585.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 17:10:38 +0000
References: <20240914-add-b4-config-v1-1-ed57b7ed6eae@gmail.com>
In-Reply-To: <20240914-add-b4-config-v1-1-ed57b7ed6eae@gmail.com>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, CoelacanthusHex@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 14 Sep 2024 22:28:53 +0800 you wrote:
> Add b4[1] config so b4 user can contribute more smoothly, especially
> send prefix.
> 
> [1]: https://github.com/mricon/b4
> 
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bluez] contribution: add b4 config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=84d0b5e2bb84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


