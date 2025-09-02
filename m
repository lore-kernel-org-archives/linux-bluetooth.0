Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22C156F5E;
	Tue,  2 Sep 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830002; cv=none; b=kRCxe0PR3P+9ilkO4NOJdpr5FOez440AAvPqWrQ/38mTwvW8lDPo+PDlfq71aJ8o5Bf37l9Hh0koGK0VRU0scMloeeVmJX0KMCrnCJrAMoBDbQwHRZTNujcYSabBuSGDX89FcgsWLJsveTgFsqzG8jTXkMhncpFbBitHPWDpN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830002; c=relaxed/simple;
	bh=uR6ooEkTfiD1ML/5tcd68skbsYL3bPOW4q+hFyEKqcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpXrbDXv/kvdJrDfpbwWOx0afyanWwmlCzMRzjYJIp8IRgpC7arP07mu2UZUcCYxSQMHthZO/HOfaRc24CchMwEqxD6NQ41M1PvEKXkabU5HVRo6Yh+tHFoBAzaqBnhkN1zXkrsGj0xNA6eyCgQrFItEC+itUhFODytY/oubX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQQibLyV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQQibLyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856BDC4CEED;
	Tue,  2 Sep 2025 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756830001;
	bh=uR6ooEkTfiD1ML/5tcd68skbsYL3bPOW4q+hFyEKqcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PQQibLyVN0V6e3yasdOYS0LVKnBGYlkSYi65+QPeCLXceZtyqZEjWD1RJeIDb2lLY
	 YaYUcXStaTbrFsfkeRhr8VOBF94d05H30JnklQhD820pev/0BSkeaUKktBG5VQs9wF
	 qTBICCh6D6l5Ul84+hYAzlVBVxmk2R7csjWgwLczNhGpQRq6QJac7yNxstlCRtM0RF
	 4Nkjej8yLIhXGidIPCk/tqwSS34cy6ARi/3J4ADoMvWuB7hYWLOpxD2vxHno6KHTR8
	 bJ//7Mj+CjaTGZXrkLIxQPYH8Zjxf7Q9ZG4RaNHVQqojX6wu7Y9f39hdGP0gbQphWo
	 yhadePuPvi6nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34408383BF75;
	Tue,  2 Sep 2025 16:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Fix build after header cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175683000705.361492.473758022048124463.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 16:20:07 +0000
References: <aLcQsE3x9o4BzXxp@mozart.vkv.me>
In-Reply-To: <aLcQsE3x9o4BzXxp@mozart.vkv.me>
To: Calvin Owens <calvin@wbinvd.org>
Cc: luiz.dentz@gmail.com, pmenzel@molgen.mpg.de, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 oe-kbuild-all@lists.linux.dev, marcel@holtmann.org, sean.wang@mediatek.com,
 linux-mediatek@lists.infradead.org, naresh.kamboju@linaro.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Sep 2025 08:43:44 -0700 you wrote:
> Some Kconfig dependencies are needed after my recent cleanup, since
> the core code has its own option.
> 
> Since btmtksdio does not actually call h4_recv_buf(), move the
> definitions it uses outside the BT_HCIUART_H4 gate in hci_uart.h to
> avoid adding a dependency for btmtksdio.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Fix build after header cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/16ebf6c26de5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


