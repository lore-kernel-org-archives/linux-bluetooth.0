Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7731A77
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/eHBVxX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53A70C433CB;
	Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701098426;
	bh=lF5rBCchrWJhE5TtYE7TNZ7xzgL5Qu33lGfI/VveimA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n/eHBVxX2nl+Rkr6IapQO9BxYQlCu+pC/DDqMVttrNL0Q0aferXacsbcrLqRNcSyg
	 dw44mpIz8G8rU8O1xocNTyVDS9lBBCm5zqM1sYqwuZ0DgxecJXI8NuyuVs7WLUNHBG
	 PISgkqYcwTZXsJtqm+f9TjCEmzifOskR84qZFVskX7Jiic+6vWqhiGs76znCawoF6K
	 xK1BSpQFFdvxVLGAQyw5CuBF947xiDeTBzt38EGh4+EAm0JwunUPGLyzO3CqOpEsq3
	 7Uky4luAqBGy5iw0krPofiRCi6SUb8BR45dKwSvYqqPPhCKBXYwkg6fw12Ksuc8zFb
	 iwyTNwzPRBqcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34D81E00092;
	Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND] Bluetooth: hci_core: Remove le_restart_scan work
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170109842621.13376.8835597357908552467.git-patchwork-notify@kernel.org>
Date: Mon, 27 Nov 2023 15:20:26 +0000
References: <20231122175636.866900-1-luiz.dentz@gmail.com>
In-Reply-To: <20231122175636.866900-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Nov 2023 12:56:36 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This removes le_restart_scan work and instead just disables controller
> duplicate filtering when discovery result_filtering is enabled and
> HCI_QUIRK_STRICT_DUPLICATE_FILTER is set.
> 
> Link: https://github.com/bluez/bluez/issues/573
> Link: https://github.com/bluez/bluez/issues/572
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: hci_core: Remove le_restart_scan work
    https://git.kernel.org/bluetooth/bluetooth-next/c/a4230d16e0b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


