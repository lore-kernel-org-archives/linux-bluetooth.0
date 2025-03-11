Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195B25DCFA;
	Tue, 11 Mar 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707599; cv=none; b=phUbCG8+AzVJ/GFTuVHb7QsLMpYJ1mG//6WXoY5ueaSD1zsxxXsZ4sbhacwoT4up4lpRsnX0mDBr17dlCFz6p8m2fDAAXmS/h8ToP8vaAhyoOBuq0iCXniFTCtzbCXpcKyXiWzBCHrjUk0Q26RSlGmf8BHt46pVMDvknrqu6Awg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707599; c=relaxed/simple;
	bh=0xS63COg9IolEiawfiarzZAPZOEOB7gam7z/7loFwdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBgTp55J19GSUuNWyOxUthKb2isamotdfnT2lOaOlyP0VKYMtUZWbXDWapNpC5eH7nM11COkfoRLHGuTxhnhv4lgikuY9WWKfCbvh9l/4v0kPruVUEpilURkPYrgPR6G62nEt4lvjq4IjqLCCIdgdovQ6yX1DrBPsmM2Kj34E4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRFiBvTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRFiBvTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0DAC4CEE9;
	Tue, 11 Mar 2025 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741707599;
	bh=0xS63COg9IolEiawfiarzZAPZOEOB7gam7z/7loFwdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LRFiBvTQ5HlRY06f7s85fH51/CsBWh3RvPKKdSewOjyY4ZCf3Lr/zAjyrMQFlT4kt
	 JSeFqBcFqiqEGANcvGvarsnj4MkALW5sBlhL4xqgBDvR4A68oh5aB159y1nRO1PkgW
	 T31iZUtREkwphJeyBRI5a5MbPU5sbIFfmGS4XGa6VPDGT9R2D7To5Z3xpbfdie2HyM
	 bSYad/lZXiQMRbdb/Rw5yqnLpgCsmVEIIqLV67v4xNwLznmxkImRacViCVHT6LNZah
	 w0qRYgRDLSgMdCRvgSzvzOBH4AyThmgXGl1GdXIQMNnlnG/NyKzo+UEW1jyTq1A9Ww
	 YARAbvj6DQq6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE002380AC1C;
	Tue, 11 Mar 2025 15:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix error code in chan_alloc_skb_cb()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174170763351.128681.166862015675971254.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 15:40:33 +0000
References: <2144b990-e584-4f77-a3be-5987b56d051a@stanley.mountain>
In-Reply-To: <2144b990-e584-4f77-a3be-5987b56d051a@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jukka.rissanen@linux.intel.com, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Mar 2025 22:46:56 +0300 you wrote:
> The chan_alloc_skb_cb() function is supposed to return error pointers on
> error.  Returning NULL will lead to a NULL dereference.
> 
> Fixes: 6b8d4a6a0314 ("Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/bluetooth/6lowpan.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: Fix error code in chan_alloc_skb_cb()
    https://git.kernel.org/bluetooth/bluetooth-next/c/3144ba2a70e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


