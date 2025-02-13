Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7B28A2D5
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472007; cv=none; b=lvllMSsaH6bb/JNgdJrabdS1FYFkHqMC+gvX5eOD2jZ6nk8MQsl7Jr4mmNS90Pr4r0PvXagcVF8GSiaqlqFd7rbohvKJ+h/fiaTDmTVjdeb3jDbGtiwOzxT6nbPsg7Bo60dkrsCpSAGTv9kQ1pBWcW8rkYJ34fmnGLjgtYV9lT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472007; c=relaxed/simple;
	bh=YMmJxVsFovwCDpSWc7rctfMcS4WWwTxcQD1X2iYwe5I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LGjLIrLthOldVo1PMJvC28iZO3wj4yUSVBy9kTcUzhvMsfq4KGDGIoPXUvBRKsQqOaLJ+j2ddN3OM2r7uaiM9Xm5XZ7CZUjLZ41Z5aU+MzbEaTXrd52USYZqkqdp3UhNukZjVy54uFFFY5okDN4+MmkmVDppxC4f2xFjUhDDnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwnLHV63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwnLHV63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE73C4CEE4;
	Thu, 13 Feb 2025 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739472007;
	bh=YMmJxVsFovwCDpSWc7rctfMcS4WWwTxcQD1X2iYwe5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kwnLHV63yB45vGrZVctwaodtQiI/pXAK2cB60q8RhBgmUhAHS/FVCIUd/acus+uc8
	 NGOtFuBuOkKy6aAhrryAgq6pDjysu8efPoxZvxQE6WsVIYZZrOuNhqB6Z3lgND949N
	 acuH2nEUG0XeA+OPMrO6R9+3SutCPJEh0T+jltbEGLJcmtXHiA/ofW98VHNHbI5ZzS
	 2RmPrGAg+zY09jtGTeUKExSQHTgzS+b8tt+8yzEB8MB+x7HwIDKuswTnm7RKgq+k30
	 RmXTNGzuquTNMTQHsuk26ZLpR1dJIFijGAfQj4bfLW+ZjLDTRzYzKLn9AfP5hygjFo
	 KIxdyndSrv/vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF5F380CEEF;
	Thu, 13 Feb 2025 18:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] test-runner: Increase amount of RAM available in VM
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173947203651.1333908.1366729347523015801.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:40:36 +0000
References: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Feb 2025 14:52:06 +0100 you wrote:
> When using default kernel configuration from Ubuntu 24.04 patched with
> the configuration from tester.config, the kernel image is too big to run
> on 192M bytes of RAM. As a result the test-runner exits without any
> message (because of the "quite" kernel command line option).
> ---
>  tools/test-runner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [1/4] test-runner: Increase amount of RAM available in VM
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=571bc32fd9d0
  - [2/4] test-runner: Remove the "-nographic" option passed to QEMU
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e76a4d0dc56
  - [3/4] test-runner: Do not use short-form of readonly option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=54210e0210d4
  - [4/4] test-runner: Use host CPU when starting VM
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4577f50e739f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


