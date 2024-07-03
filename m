Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820B17BB1F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=gvooRcNJ2T9kkEGm2PVnCo1dZK/qbXVWxYYuL4x/Cn/8COMpYDDs00OAPHmOUsugvGVKw1kN3VRAaOmfLM07zGP5WQYl4PUiVtQP9bg47JuHmmJypXobJKhCOj05woNHsN904ICyB5+ywuZqAf8vnhJzhctH52fzuE1LFftgY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=+hzlrG7r5ilELkbspruLRbFwEH81WrJC/PxSh8nB0m0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a+xuG05bpVaU0Nt3FBqjDFFayeNPyaNnnd8IVrPlyECjaw/PgRUg27WAb73108/wuoJKTEP2yOwKzERD0reUNVIHhkZsIbIezPnRSLC0JUWtd8xl9zr3ov/s+Sdvloo3BbeetjcT8jcWVzcaupNTn2nRe/zwd5zrtBdg/+ZT6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdgoRE7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdgoRE7e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 234A1C4AF07;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=+hzlrG7r5ilELkbspruLRbFwEH81WrJC/PxSh8nB0m0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XdgoRE7eYr/3CXYBJE2Q6Fm3DnQAEXwJHVfat8mD1WvNGBMO9IZzUoYjuOlyQfUnA
	 V719OV+vr+whx5AuCuD2kZy14Y2Tp6ebJiJVg9UHIJO14rwS4qHuyMAmM7ckzEMyQb
	 yPsIpa99bylUxA1IOY9TipDGK8GFOBuFY4rjoTNU39Dy0HENUL5cYOJF5kiCwxCmpF
	 NqyEzWLe8fYGGFfoNaVdbCPwpdJa2ZZkWFQkyUwZ7Sbp1Kb70k8hcHu3p0nMIITSCU
	 aSZdPfi2q6wmDhiBFb4jepk1y2OdjUDivM0Q9h3SjAWwnZZSNACOJfU1HyfSao3nlk
	 0o1v3ywq11yLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13156C43612;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/csip: add NULL check to
 foreach_csis_service()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943307.18626.17806888867842673948.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:33 +0000
References: <20240702080132.16169-1-r.smirnov@omp.ru>
In-Reply-To: <20240702080132.16169-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 11:01:32 +0300 you wrote:
> It is necessary to prevent dereferencing of a NULL pointer.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/shared/csip.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] shared/csip: add NULL check to foreach_csis_service()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5f0002cc9099

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


