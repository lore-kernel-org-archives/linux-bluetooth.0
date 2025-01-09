Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC58221DB5;
	Thu,  9 Jan 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439402; cv=none; b=iP/vMsKQKC9OhhILQNGhXGcXgn+iConC2A9kPaR+/qRXLHbE7EHL10Eprl1LOtqIFdU5HLXAU0FckDjDCSMJCAWfDffW3HB64dz4J1HNja64j39V+OYmOVur3TDC8jF525EjKp+8KDCK37B+YOacblQL2I99UnPubo9jKL4ayuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439402; c=relaxed/simple;
	bh=zliTfwCcr8jXv+rqxfgc6tzoesG1RFYZ/cFqIddMzm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WEpL6b6FU4NJsxRQFaHVYUPnZY1FgsCBA6yhyenS5zvGLZpsrhNyCu/CSN7DDWriI+wGBFBUg3XdTkcljFQrgIbSSWN6PqtbPlCFv1wdMpqNqvZnHBHm6hFn19cn/+Z7FGFf1vtrQkhMNlmhQfc/dkr47XUtrzAl7k1XFNQW+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvIZpqRV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvIZpqRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783ABC4CED6;
	Thu,  9 Jan 2025 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439402;
	bh=zliTfwCcr8jXv+rqxfgc6tzoesG1RFYZ/cFqIddMzm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XvIZpqRVWOcPMZb1JkMc9yOM2l8STchi4bJMk1YsF/fZS4zdrNJ+Y0jWwjVtU8+37
	 TtkHiOdBNVwZjCcJYeCUAWVIrDgplr4ddgVz97vLk/vEFhWn1boAwXNOjpDedBhHZI
	 m09hZkOsOV+b8UdX0N+LzDjZTrPaTzGtsxSUE0ExfOBgX6YkJV/zdOCTg7GAJXLx71
	 5CsG60Opk0qe9kT0/v9zgLXp7vmJNztvJVfLUbI1aguFp2rlE2+/ybKE22CVopaR/D
	 4JYNtJENP0KgW7IsZfu/5XRrvMAPY0//0qAYEeCHSlLKM1X6O8igzDOVc1Zv0wlpnU
	 eJyRuulpQIR0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E26380A97D;
	Thu,  9 Jan 2025 16:17:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173643942423.1375203.4066539140879168020.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:17:04 +0000
References: <20241227092046.23304-1-hanchunchao@inspur.com>
In-Reply-To: <20241227092046.23304-1-hanchunchao@inspur.com>
To: Charles Han <hanchunchao@inspur.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, christophe.jaillet@wanadoo.fr,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Dec 2024 17:20:46 +0800 you wrote:
> devm_kstrdup() can return a NULL pointer on failure,but this
> returned value in btbcm_get_board_name() is not checked.
> Add NULL check in btbcm_get_board_name(), to handle kernel NULL
> pointer dereference error.
> 
> Fixes: f9183eaad915 ("Bluetooth: btbcm: Use devm_kstrdup()")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()
    https://git.kernel.org/bluetooth/bluetooth-next/c/52d2af107592

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


