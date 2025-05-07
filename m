Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FAF1E22E9
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650989; cv=none; b=mRJJFyOxNBt6jPXRRfieI1rnz/JhRw3dpFOC/E0G0WhxS3o30/CtrTH033INsc2AUTxgIeGI+NAeHW/cPE7OUg02MtYhaczc357o/9a6x8RFtlaepPfdbRiYkg8GYlyxM0QHEDt7WO/XyuFBiQfBiLTRlViNkKOyxNuSo+dEhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650989; c=relaxed/simple;
	bh=VfUQMRyVio2YQnZpPgPRM0ZbYD/T40ON/ecBwLReAAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=majEio33V6nGwrGNm7mvWwxW8eYCv3jop3hBnoT/TNpYDN0iS+89xxRliFzafPPwLuAc/mnK88mLbdWvUpEou+7KhZfGZioayIYK+7wqrOXX3Ztf3Ra7QSILMZnZhF/Jf5SKF7A5qLy6SpOrQP7RMa2WOB8j3mWiXl8getjvYIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAy0MNBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAy0MNBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17FBC4CEE7;
	Wed,  7 May 2025 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746650989;
	bh=VfUQMRyVio2YQnZpPgPRM0ZbYD/T40ON/ecBwLReAAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gAy0MNBMFzbAkfcDFoY/chDv1DdjlM2bQSxpyMHXMQ85wHBfg6NjKmXb7CRmV+dft
	 tVILXJDroztA9/4kP38smtOjxag5d1/V/kIxJiPaLcdEa3BAAL91ALwoy8UqsfGMW2
	 FAWipJlVJ1m++IXBJ1n3JC107xDOidN1Jy3N+54vIcontEgHzYN6OImhSyQmNKCwAb
	 DpesaJY/W48/5iB7uji0d0BdoAJh52GAp+neUJD9ojbaYXjR1borKpx2fc1Arumw1K
	 lvAIVhIwzCUccGciRPFpXRxRtl7zBUvs8yPFJkYZd9qu4PZw7uRk2ABAog9IPqV/Ja
	 maqvjSOW9VwfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE88380AA70;
	Wed,  7 May 2025 20:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] btio: Fix not being able to set security level 4
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174665102850.2360863.5235116857355206235.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 20:50:28 +0000
References: <20250507162923.226716-1-luiz.dentz@gmail.com>
In-Reply-To: <20250507162923.226716-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 May 2025 12:29:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for BT_IO_SEC_FIPS which shall represent the security
> level 4.
> ---
>  btio/btio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] btio: Fix not being able to set security level 4
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=72dddc80def4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


