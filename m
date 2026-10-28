Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217022;
	b=xLlzfGBrYoKVvQEWzdXTpbWdeSUtTY5Sch1sZEwT38mrqTAQxD0H33ZFbo/58wW6XSba
	 mHcIz73Xu5tncw7GD2lWrGEUJVWpWJkbuLCX/872V/ugXf/fxE4WjM3MTWyp3C5Ax4SD1
	 ioE2hq9eEcAxMVELgJD3JzTgacOV2Lb3BOyGf11dKQk77D65AmcDNt1dl4DPs2zA7l4P3
	 PM/DQm4m3LKiabZL+lExJDuS8egg7vSHONAC3JDgQMio/hxQ6navM0CJ9KeergZoMA9B5
	 tT00QBSjSsNZsgUIOAb12y1Xz1cwlqXeRNM4NNhozesZM2TyPGglKtrcY2Q1WEyud5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217022;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=hyRErXTquKsuhtJlr8zzLss0mtFs+g2kmUxEpzLS74s=;
	b=020zeBkbTIELHPZ8CUEwViTv/2DJWv23b5yEth6KZP1e4g+LFL7sUSQhM4Ivq1aTrDdY
	 O4QAYwCF8AzuvQd8how2eT0a9q84zZoyNer+wb2ET49nsfHlOjB0sdLR03OxEgZ0QrWlh
	 o028FVt9Ov8QkimeC2gJdpVmK+BBbsnvaX/ulPGycBM+QuOxubKKwRiS7qK12zZ8a45kP
	 j05cz5DOEqQMoY1DVszniT7gdBoDWhJCuoTgjDnPUdLTj8i68+B+hJn6dcV2H8zi0p2qg
	 5dcZXxUFP/ifEZc/QWN0hQ1T6NI+buDfWtv5y7BF66DfmoRmDBH4eM9ZxsnQlDh8j7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJRLK+yu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6017606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJRLK+yu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C42A1F01825;
	Wed, 28 Oct 2026 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217021;
	bh=hyRErXTquKsuhtJlr8zzLss0mtFs+g2kmUxEpzLS74s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nJRLK+yu/XeCV+Y3KNM4KM0y6Xz+srRHF1bN6VVB4gN3yFYxVrtHXzVihhRgobleP
	 KVuw0IV4FlAnxemeLpyS5mqC07jz7/wiTsY2wbH4H5sIIPcU2bm+Pw1i3cM2qoVOFg
	 f6EwY8oXkwvs1BUAHHaeibjXwDH0LdW53FCO9ZntDU6PcLlDAIv008HETWih8CyFt4
	 0t+M6vfQnRd29XgjOduadBn9g9Y2E5RqF5p4yVslkkHsDNxEByCuRO+WPRp2uZc8MF
	 QY2jbS8Re4e6dw8X19Af8TwSRIfWOBTlbDoope7TyrInVghBvHQK0dCqF2vaoWq5Cj
	 UGzkaxHc3y9JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 814B23AAA770;
	Wed, 28 Oct 2026 19:50:21 +0000 (UTC)
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
Subject: Re: [PATCH] adapter: Fix Discovering staying true after a rejected
 stop
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179321702006.1394536.2604695616484204299.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 19:50:20 +0000
References: <20261027160852.54689-1-kevin@simpleble.org>
In-Reply-To: <20261027160852.54689-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Oct 2026 09:08:52 -0700 you wrote:
> The kernel rejects Stop Discovery when no discovery is active by the
> time it processes the command, because the discovery ended or another
> mgmt client stopped it just before. stop_discovery_complete() then
> removes the client but keeps the discovery state, so Discovering stays
> true with no client left, and the next StartDiscovery with the same
> filter returns without starting a discovery. The client that called
> StopDiscovery also gets an InProgress error, and "No discovery started"
> if it tries again.
> 
> [...]

Here is the summary with links:
  - adapter: Fix Discovering staying true after a rejected stop
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4f3428e9df2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


