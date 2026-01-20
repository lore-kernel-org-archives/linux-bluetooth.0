Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF833B6D0;
	Tue, 20 Jan 2026 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933210; cv=none; b=Glk/5GdYYi7/OLAu6cSRhe0+b+D3nHyovYds8s2WoVv7YEhO7c29zUMwE7eRUgDUiCXtD54JOHjfUxe4YtZbLPH5l6N51ORkURe/xh6tXfDs/CaTCYgxWVWwY9629mBKG6tjO58KCWh69Kox9bRF/IFDDYeO20uHKonNRTv2we4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933210; c=relaxed/simple;
	bh=PLkKmfTSH76hV0ENegKwimGxcy5rze/TomhWxwCkcB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bV5cxazgXo74wHtNwO0q+KCe3+QksWlAoYTztw3ewiCMIJ2VcFNE4JUDJpjJl9MY13JMVLmj1CDEIx5bFabi35boeltxRh3Pf+doB9cQ9ft1jTA0lHNrWrMcjSZzEaBsDmiyRevpjOXtqXHChgSzcN65vTYv6ycDyWzXopcuiZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+X+Xl3c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+X+Xl3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ABFC16AAE;
	Tue, 20 Jan 2026 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768933210;
	bh=PLkKmfTSH76hV0ENegKwimGxcy5rze/TomhWxwCkcB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X+X+Xl3cA5PHpKIv3uTxbS7mS63/bc6Oih3DCjmtZZnuW9qSOPNrtT1GImKIabsN8
	 CKruXFKMLJ5oKsF1OatkI+1obZ+8NhoC4Pz42FHGSbb1ePJ0GViXSpwuJp59nFyciC
	 kdpADCItSD2kWV1MfkyiewvocL0u5uCsHdJ5QKGeZeEMj1eaTJZlLYfiM0PqH+5smQ
	 o//H2G/+YNccgXIeNikdvZ/KrOBEdDtHTYJD9THe2wxfkzI0SPlF6kMYt0uvq5oFDG
	 Qr+u/Zh6j1h+A+A9qhCBTdEAoZkCYI+6hj/8Q5y1D3h4nIr88HhwbkG59YdA53Yo52
	 PApvL9STQgGPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8AAD3810935;
	Tue, 20 Jan 2026 18:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Remove unnecessary check before
 kfree_skb()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176893320759.555371.3361610552363578782.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 18:20:07 +0000
References: <20260116080703.379903-1-nichen@iscas.ac.cn>
In-Reply-To: <20260116080703.379903-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Jan 2026 16:07:03 +0800 you wrote:
> The kfree_skb() function internally checks if the skb is NULL,
> so an explicit check before calling it is redundant and can be removed.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/bluetooth/btintel_pcie.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - Bluetooth: btintel_pcie: Remove unnecessary check before kfree_skb()
    https://git.kernel.org/bluetooth/bluetooth-next/c/c170a61739fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


