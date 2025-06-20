Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360E229B1E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432180; cv=none; b=H+GGy1OHUp8ydPFDSw5GQlq2VjsYmpwOj0W4KETvvnydFop58faqDUo9YuFovsKvlksvHNGu4JzyX/imMNQAkdbc5Jc2fyRS9pR15LwtN6GJ3V4LGeNlbwxNwRq6wYyWoVfILhc/p/Tsu4aH31GOWkVNg0JDiaEYQ8Hqg2LXWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432180; c=relaxed/simple;
	bh=iENKcSC/yV+TQMbljaTnEyrsMnfF+GZ1BwkxEpjGbxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z9uR2PYwrwWzlT8v+hvipli7XBg6Ien7AfstSKNosOVRl4CWy/cqq2Ys+51u8iodCLiGuwM5MtF4wwxfKAPhxgmTcxp7JAKaPUmK93fZhuazbv4ebH67CCNURLDCn8KlrqSO5+fUc4K5C/lxX+GJgfVS8kpPSZhKP7AFerPYA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUlrepsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUlrepsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1B5C4CEE3;
	Fri, 20 Jun 2025 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750432178;
	bh=iENKcSC/yV+TQMbljaTnEyrsMnfF+GZ1BwkxEpjGbxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KUlrepsH/usAa+aircI28CQo8My9CBimeV8kFcUAKMNgiQZDUv/icPJpvLLwlXivi
	 /1pSxsV/AA4igrE1D1BvojgeZ0wekjEJeUxhV1rIatwmqJFz6HyoOX0a8h1rIjBfyN
	 bgJmjBZVJPdKpkzvOlrMzjYP7Fgvox+0dwXAvmr+9SBGTs40VsxsCEpwRlYHa70PAF
	 hY6Hg22BXWY0dzMS2GlNekBRIP8+vBzWx5r+yFPdCIP41C7jwAeyKhXgXoJ03az3lz
	 wnVlDnYbpF2hB2cwNj4SnP2vGOTRhmIXpPgXpmvmayqiQqm3+GaTwX0Jr/bON8qQuK
	 Gshc1Gj8Nqlvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCEE39FEB78;
	Fri, 20 Jun 2025 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/4] test-vcp: Fix test failing in some
 environments
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175043220650.1606561.16885498494907013375.git-patchwork-notify@kernel.org>
Date: Fri, 20 Jun 2025 15:10:06 +0000
References: <20250620135146.243585-1-k.samburskiy@omp.ru>
In-Reply-To: <20250620135146.243585-1-k.samburskiy@omp.ru>
To: Kirill Samburskiy <k.samburskiy@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Jun 2025 16:51:42 +0300 you wrote:
> This patch fixes test-vcp failing on some environments. It is done by
> shutting down tester IO before test teardown and registering detach
> callbacks to ensure proper cleanup. Similar changes are introduced to
> test-micp to avoid similar problems in the future.
> 
> ---
> Note: this is the second version of the patch, the original discussion
> can be found at:
> https://lore.kernel.org/all/20250619153120.126315-1-k.samburskiy@omp.ru
> See patch changelog below for changes in the new version.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] shared/bap: ignore NULL attach/detach callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71b5ea9bf373
  - [BlueZ,v2,2/4] test-vcp: remove unnecessary bt_vcp allocation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f5a4e95d73fe
  - [BlueZ,v2,3/4] test-micp: remove unnecessary bt_micp allocation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=659fc8fa7037
  - [BlueZ,v2,4/4] shared/tester: shutdown tester IO before test teardown
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a209d69767db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


