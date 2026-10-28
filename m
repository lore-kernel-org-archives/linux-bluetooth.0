Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217020;
	b=efzWbYA6yNW3FeCfvLYyXSbY/Cl5a/dbGsPUhBvdKyltBbwGpNMYhvTADrqW81/7F87H
	 xA6/cnuG1Lt/aHPHCZRxzaLdFJeh6fAx5MzBxJFg8HlEZL65v05INAagcdA+NWD2A/RKZ
	 KzaKcqfIgojEKuf2NJtOi90huEfCtpYnN7jkbO0T8Xvq3UHyjq/LHBWzG52btss8c6yVd
	 xVyFpIrajDP6QQC7LzVqQSbcC8yi0hf6IKPdcZtJyve8HKGaAQLYiNdyEdgSi7WLlNNfl
	 7o9XxKfO7eiSJQMIE4ySp3m195LuGwkIjhx/XndhVXiMLClIYxDoRGSP/4v4XSQiZ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217020;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Oct+5Rp+NaZuwuTkKCrvO5WTwXBHeDFgsYmLkIXWGSs=;
	b=gCoYC4cu5am5llnWrj20JsFOvTqDynoPL9ZqAu8wZUSvWKIEwbWisRp7Jo1HP809GwV8
	 vP+wTRpBrJzRbAtTHY+wmmYaHiIrG4eoLU3QoeyrRWJgPtsXY9vjma4dwYRwCQitBUX6a
	 wtKD+t4vbg7JJkYDb4IH1E40KF2AeKOCX3xyfOuQKRUN/EImzoDdPaKFQ3gJEYnO/0FuB
	 2Re7p0Du3klaD3fjv9Gfm++Mq9aOYWT/+0Fq7GiVlAjesedX/8luAFk5HuAx+vZiRfOle
	 Werwg2SAnmHTqxV7yoFXuFiuhVjxg2jUWlNDAoTZIh5O6nnbsz1+RN9cPSrZsnw0xWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOxNLl+a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56927606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOxNLl+a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133941F01828;
	Wed, 28 Oct 2026 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217020;
	bh=Oct+5Rp+NaZuwuTkKCrvO5WTwXBHeDFgsYmLkIXWGSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XOxNLl+aF4T8MKSKTtaQ4dSKtYrnXCyohq1ZINfsBXmH8HThwlsWHLHgeTFB7NiBi
	 5LBRjLOzapHRYuvg+vmxQLbDwtxYurxzIm7MObdTkOAn8RCUhdcHwtbH/OkF4JEQlB
	 VX2JUaNRAmhGlrDM7u9cCEMbHzT8sfJv2JgalQzkM7ZE5KeGLBx5dc4IjdsicL7k/7
	 t+fYZMLkeENGyhbRqpbBb9qpVOnQ2HIc8TORimbC67J0dabQPpx2j/7zpdtzarjDjI
	 vaagkzazgAj5MaBXkPr6mCqtax8SPJ5ENe0gakF1v7dfvbffdPyCvDt3pHE6ZJTOSB
	 zlZpPlJy793Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073B23AAA770;
	Wed, 28 Oct 2026 19:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] shared/bap: Fix line over 80 columns in
 set_base_subgroup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179321701882.1394536.10614046807601326911.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 19:50:18 +0000
References: <20261028135517.2395290-1-luiz.dentz@gmail.com>
In-Reply-To: <20261028135517.2395290-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Oct 2026 09:55:15 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Replace the tab between the compare_ltv() arguments with a space.
> 
> Assisted-by: OpenCode:claude-opus-5.5
> ---
>  src/shared/bap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1,1/3] shared/bap: Fix line over 80 columns in set_base_subgroup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1a423e2ef3b
  - [BlueZ,v1,2/3] shared/bap: Move LTV type defines to bap-defs.h
    (no matching commit)
  - [BlueZ,v1,3/3] shared/bap: Accept all defined metadata types
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


