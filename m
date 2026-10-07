Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89B4DE72D
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398410; cv=none; b=EU4Jj2sfDcws3F22r55UhP/fcaI1rnWjJy0ZwlOtn0mZsUMynCdjTT2ZeXD04qExW7cVfa5G41a2btZcVvLR04RVII9TeSmNbcpiKo3NbGpf78COqYe8/PB6KKMDaFktvXWY9BDj8lr9hJWsc/HGZNk1V28eSOBaepr5pOqnxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398410; c=relaxed/simple;
	bh=YlOL02R3cAJBK/o/S/boF64Sd1t+Xx9OlfOeKGUBBWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=otjmQeSBOsAyWXyVvvDLwk70VEeaeI4ajXabRwKGLaRsLR1+OcdHaj4diDX+fIiBSlwn7GQwV5uR93I+6duP+lyGJYJ6Yuqn+AjZDD2r28NxmJE9zXHa7ZA1tp9vqCN1tpZzj33l6QR1TR120cT8UpX5Cye8582/SjPBnXRyE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqzdYzkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqzdYzkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428B21F000FF;
	Wed,  7 Oct 2026 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398409;
	bh=BkCTPTae1EbfXG1smByckaFGZ/D35SqFaUiKqX701pk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WqzdYzkSojGx2SVQ2y5qNASobu1zkRoYiLqy8AgTcmPhWe1wcHl1wUrztvq/iqUpi
	 x27ZnGhB0FCIhsspj8PPGvsa08rzhKp6FAiPRuJ2RZgjVUEic3Tl32BvsISx1nk639
	 m6hK4yi9ivC72ETHeh2yWwqocte3qDB5kheBZRxK85h1NOtVv3HtG7B7wd3fy5Eugu
	 jGGtf5754+vCOc+34zA17VtiCPiSnWwjdtMUkSM91+dQg2NGecIRwZZCwH3tgV40ot
	 btMtb7Zq+uKVSecKAdfVt12UXrETp+0cfHi1PDr0CvIE89FOmwWIOxPTLXXgKdUz6y
	 5C2E+NvHIXUcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4073808209;
	Wed,  7 Oct 2026 18:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] transport: Preserve Release on late BAP ready
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139840777.3650240.1957954919500542671.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 18:40:07 +0000
References: 
 <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
In-Reply-To: 
 <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
To: dt <derektern@proton.me>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 18 Sep 2026 20:21:51 +0000 you wrote:
> From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
> 
> A late stream-ready event can reach bap_resume_complete() after Release
> has queued Disable. It then replies to Release with an Acquire payload
> and drops the Disable request ID. Client disconnection can subsequently
> free the owner while the Disable callback still refers to it.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] transport: Preserve Release on late BAP ready
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d852faf0b1d1
  - [BlueZ,2/3] bap: Recreate stream IO after an early Enable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47f783ff5ba4
  - [BlueZ,3/3] test: Cover BAP transport release and reacquire
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


