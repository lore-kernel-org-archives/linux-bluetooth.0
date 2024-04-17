Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72D3D966
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385830; cv=none; b=NWwthM1+EdjDOyMu7Q7CquxVZ4HjLdBdH5T/8cIR1i4GkDklXTGpC++NstY5llUQOiX+XTiQQMqhbIlpCqiTsIf9RENJ0rw+mAydNSDiW9BuRhDoaQfsz760sHpj67GUFV+w1EY+Q/yUFUdjqS8CyELFDuYkQLzlc+N5VC6qKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385830; c=relaxed/simple;
	bh=DS2PnZeYZ0x1u3pYtf/THK/PfPRs34m1PToKT8CG7MM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qkBKflLygkvknMG+S2lzM5QMUKYrbRh/6JS/1wIkzzDPa5BnLPIXJAsO0X1jbPCXImQu8E+HSbMxOQZjXEgHiW77n+FPABdF9fiVwWLZRvm2Z2YkZEMtHP8yQC8kIJVDdlZXVr4gVXyzEQ50GplUJVsE3Ala/busFNteo01nH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLmd7JyW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLmd7JyW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C6AC2BD11;
	Wed, 17 Apr 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713385830;
	bh=DS2PnZeYZ0x1u3pYtf/THK/PfPRs34m1PToKT8CG7MM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OLmd7JyWtys0pf4Vtp/BYh59K8a7ZHPgiAhDd7OEFsvjsCgoXOZbhgHXgBTBPAHFy
	 rsd0R7Sdusgp7Iy/cFdkaLwoF75ipHKeR3jL8cZ2KJlVA10EHLrxoNUP66nBbLMeLk
	 vZmOX0Tubba3KuNkhnCZ2w0P9UyJKJKV/D8aJWh1Cu5BM7ToEyDyv0/veLj8WKftC2
	 tVeGAg9alSzkCQZW3lgVtJ7WEvvluPLrAQxbjjqbUoxsvCQ6ea3ID9AIslN3UvwLEu
	 5Lk0WKD5S0O3ArVwbrEJfVn/pDwmLvhmCUsr+rnXfzPlLirYkaJcqooIkH6H0bNJ7h
	 j2JbixUQ44LQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE031C43619;
	Wed, 17 Apr 2024 20:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Fix spelling in monitor
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171338582990.30326.6711747350814234659.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 20:30:29 +0000
References: <20240416231205.2116175-1-me@prestonhunt.com>
In-Reply-To: <20240416231205.2116175-1-me@prestonhunt.com>
To: Preston Hunt <me@prestonhunt.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Apr 2024 16:12:04 -0700 you wrote:
> While working on TDS today, I noticed a minor spelling error. This patch
> corrects it.
> 
> Preston Hunt (1):
>   monitor: fix spelling typo
> 
>  monitor/packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/1] monitor: fix spelling typo
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=89cb88b0f030

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


