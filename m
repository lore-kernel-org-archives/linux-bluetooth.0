Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD72D5414;
	Mon, 23 Jun 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705791; cv=none; b=Wv3eNjLaJem0fVUj1FzCUQ7xL7fl20SLcKL3vPUsXcqgDfD5W7saQ2eLxJkYgvO0ofMPo7jRq9REMlxeUfXcZyaWDIBRVi/Mwh2puRlUJYBYv4MWhTmDF6vFmjonodZUjuWgkf+MJkhnFR+0U7zeLZL+JZaTxAgQq71UrlNQs1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705791; c=relaxed/simple;
	bh=Z4ryaqpooRwv3rGF67NmFW1oy2GEoQ/vH4BOtQ7bvcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uJOxB+eth+OgofmJF27hf7jFNdNzCi7JMpT91d7v5UJshgzO6dVnOHN5PruDyaNn2B6zEFDIrp7iZXcb5qEKEVeGfHIybujZgXtNLEqI3zNP+qrwXxxWmL1VtJwEUv8dNGSWCHNL2ZXeejy06kbxtYqraOwoz+6WaEj4kxNbDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2BbiC8w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2BbiC8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC76C4CEEA;
	Mon, 23 Jun 2025 19:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705790;
	bh=Z4ryaqpooRwv3rGF67NmFW1oy2GEoQ/vH4BOtQ7bvcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q2BbiC8w+SlXnWE84V8jEYo3qtON838QBOl778RjOaZHhYiw7WD2o5UKR0glJVbPR
	 WQngxhC52wRkHXhrgaVMqEryR92GXU2+rbnBV+Vy5fp3/HlbNd8LMfL4SbSZn0ERHT
	 q6idH/QDzegWSRq+giNMWIRk39I+iHQEvoiOymlzYgQLQXFmGRssCckri2qr/ZaxFy
	 T2BsPVNdxgWh13F/uf82huPdUJQMQ+M9XQt3MbrjekzV4P3lSfn+v8alBflA0ZOPKC
	 tjpX2E2o770YEWWYnHwzlnQ4bIhyVCRbzFuHMbcF+fsqd62kBthm68KmZvYPcsNiKQ
	 aB69aISQ1ucFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4E38111DD;
	Mon, 23 Jun 2025 19:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Bluetooth: Remove hci_conn_hash_lookup_state()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175070581776.3268784.5701408359871931670.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 19:10:17 +0000
References: <20250620070345.2166957-1-yuehaibing@huawei.com>
In-Reply-To: <20250620070345.2166957-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Jun 2025 15:03:45 +0800 you wrote:
> Since commit 4aa42119d971 ("Bluetooth: Remove pending ACL connection
> attempts") this function is unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/bluetooth/hci_core.h | 20 --------------------
>  1 file changed, 20 deletions(-)

Here is the summary with links:
  - [net-next] Bluetooth: Remove hci_conn_hash_lookup_state()
    https://git.kernel.org/bluetooth/bluetooth-next/c/542f4736837d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


