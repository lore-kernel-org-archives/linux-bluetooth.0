Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264937E5DE;
	Tue, 11 Aug 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479063; cv=none; b=gzDx1s6Rx14AhQQ2jVRSX4N4WwjA0jX9OnZhM58kH7RABfRreiRNgQGkwM9iCpLoxRkpL4IcYDaP3yMRQdjOu/8CxS7odOW1D1G5nL2l5YUpwthkZUJvbAPYVVqaPrY/k5SPXtOZpfylQvfF92ms04i89x8QP4tCHMl6TA+v4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479063; c=relaxed/simple;
	bh=HhbpanG5fb7ggiwW169cpw/oo/Qzwp/A8l3XvR3hfgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oCRr5XbSTh8b7X/LRgL42lw8mr/47c2KVIRpHgnJp/+r5zMOtU0HR3hHSyJG6FeBRIcVdcwsLCC6/OVfC/2qFZnTigVodr280QRLB9zDaB5NzZ8yiT8RPR2E7AkVv06+ibW+byFMWn/5IIk6u5anAlGGFVqfMAB0rlEf6D6U9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPPGlYBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPPGlYBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E501F00A3A;
	Tue, 11 Aug 2026 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479060;
	bh=q9F9qg+mPJEoFy9wbjWkaj73Xi0dNfyTxNYQGtBqF3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MPPGlYBKFg9o3fTqBFn7IC+WaM6D+fCI1MP2gGFOSc1LTU6weKs6zVMhkjhWlaj1B
	 0iVBZ0Ss1oPMtPKsS+W+7iwcakgMAi3X7wXOqAQMO2P4RZ2/IVtVA/gGigupTMCFxx
	 PTDdZcIrgIvMGD/L8//0yx+b9dddmhIRrFfHA8Nmab66yIq1MKkswqR4kambMaqanl
	 3Bf0OMzTNjj7Dgh0GNnvf0k+IlT/Bt9FAah4DmWH+cSXq7rUBGl90ZLO/Be0zggQBc
	 mBSlJMH86wz8VpoAuoPgM8cdchhmBIRw8zPppQrZ8Yb+EyEHqYs+FwlVnUc4UOhiTN
	 X315QxadFsi/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FB3809A0A;
	Tue, 11 Aug 2026 20:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmrvl: Slightly simplify
 btmrvl_process_event()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647901638.1134064.11068841351283919495.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:16 +0000
References: 
 <9fc342cc7dd726868216174cd83d196d1ca18f94.1786280385.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: 
 <9fc342cc7dd726868216174cd83d196d1ca18f94.1786280385.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  9 Aug 2026 14:59:59 +0200 you wrote:
> In btmrvl_process_event(), all error handling paths except one do a direct
> return. Update the only one that makes a goto to be consistent.
> 
> This does not change the behavior because ret is known to be != 0 when
> 'exit' is reached.
> 
> This simplifies the code, saves 2 LoC and pleases one of my coccinelle
> script that tries to spot erroneously mixed goto and return statements.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmrvl: Slightly simplify btmrvl_process_event()
    https://git.kernel.org/bluetooth/bluetooth-next/c/b2d457736260

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


