Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716C1C5D72
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581792; cv=none; b=hXCai9s3R4lIb0TE3VdJdHlkwOcWA1CoJKbowvHUwyiQcUbR6rXpL4nzUZkLG1/FP14xnTteYYU2YS0lnB9EGOmUVk9gdPTkfEHpGbtsJpxpqrYnFW4jxJjjVrJ5lL+0aTfDGzCIM1A76HipBLnQ4UgN+pNgz/l/aKyx89XHQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581792; c=relaxed/simple;
	bh=M6ABC3olCAPJxqdauM6Gm2L0dUg3qZzZ/j24FIGczUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YpAyNLqy0AjrwvsxqBmx+vaUcFA3bpoavhzgcU8q81xwaPJjAnffr+bMK50lzAM2ZlkF4/EVUsMx7kpC8+/wfW2+1e1TrmyzYo9ouYnbZj3CqLkshuEucS5zmZPGA/NtNJkfniXQgj6/geJ1QnwhoTSut+Fla1CXH5+/ppQa81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMPGY+Vo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMPGY+Vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EEAC4CEEB;
	Thu,  7 Aug 2025 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754581791;
	bh=M6ABC3olCAPJxqdauM6Gm2L0dUg3qZzZ/j24FIGczUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pMPGY+VouM8YkdEw4tuzf2Yki7Den65BvsKq9zzZeTvzdb5YYyCdtMKV3JEQ/ZrlE
	 Op/wjc1u5o93pkHrag7hWa3pWOUziDMahHLYWoVrALUl/pyLB9td+HXutL3i8jIvPg
	 YCzdlsfg5suVKf+WTVAatsvXWFxuNNAANnUp0Uqa/Y6bKnQ1VTap0Ngik9rwMRUGoc
	 uzbIXrcepRZudTT04QFeGADDvwyXxSRb7Q44BO2WgJafyfkHDJj9cw+8zjxifSvWXA
	 0pGqsRObUzhIQFlD7bGae9oiddXDY8bZhIitDfof+WGiNWvJSxzwyqg7QQYPp6l54D
	 fok1IVCs8srjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5B383BF4E;
	Thu,  7 Aug 2025 15:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_core: Fix using {cis,bis}_capable
 for
 current settings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175458180551.3605358.14524802344851831054.git-patchwork-notify@kernel.org>
Date: Thu, 07 Aug 2025 15:50:05 +0000
References: <20250806194836.291949-1-luiz.dentz@gmail.com>
In-Reply-To: <20250806194836.291949-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Aug 2025 15:48:35 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> {cis,bis}_capable only indicates the controller supports the feature
> since it doesn't check that LE is enabled so it shall not be used for
> current setting, instead this introduces {cis,bis}_enabled macros that
> can be used to indicate that these features are currently enabled.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings
    https://git.kernel.org/bluetooth/bluetooth-next/c/3ca23aaba210
  - [v3,2/2] Bluetooth: hci_core: Fix using ll_privacy_capable for current settings
    https://git.kernel.org/bluetooth/bluetooth-next/c/c244fc08ac4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


