Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D373DD532
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370798; cv=none; b=FqaKAuGn+2ssHLt6dwxgI/CQxqVsaUoa1ZlVGwMEhGKBTLCZ5nH1+fefOs3N+RlADNNhb1HL7NivWhPnU+jSnKyhuxw4iBbcEaRIGYrSy4+8mfDIh3bRZetn92JSfVwD60aMLXG/GyZn6CJGMesoCdx7/hZgVrriRn8DtrKMZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370798; c=relaxed/simple;
	bh=ELuEtOOBM3SkvPeapwIqPB78XWvp709u+RBxGzhwwEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OFzjjEpc9KE01OOGMwMmonVeZah6xIrOXLXoCc+hqHq012Et1CTkcfQa9H+PbYNb5gz6GbrZ7DHhU7Zf2jShtR74NKZu4kjhK/96G1NYPnMOQD3SxRJ/ZLGc0qmKzH/KoldWLrvJ6Ak8qUldRL35I+lfZWVA4jnRYCIE+D4UB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOB1U22o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOB1U22o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9741F00A3B;
	Thu, 21 May 2026 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370797;
	bh=hf2IxvcXH/wh3skdQ0TzVoSzL/0fnH71JpZUUH0/Rm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oOB1U22oG5amgpGVvVuTzL6tAv/8pPysiJPXHAFNHF/NPMQEKRUNuT34nG1q028MP
	 n4tI3Uhj4XNJk6avLulrK46nlWDxSmMfBLJ7kdGUPx0GwVOtIW5FHQjTPnrsNXir8E
	 z1Xcik++Sc5Nfn6PpF/aSXXB+DXMA8TddniCm5ZwbLkO1vLwXddMEE2P+5VncnphWy
	 p8Txfnh1P4o8yVz8Lhf7VviT5gczTVQTCGrlfR2ffUIta9H+u3S5z5626DmidTBFQF
	 zrSN4GMo20/DzRo2BPrLAWR5EJhuVQSixqXBmnqIikwn6ZD/CJrc2MHHigerOdjnWJ
	 zdScxyP2ozplQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197103930DE3;
	Thu, 21 May 2026 13:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/bap: Fix unused value in qos
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937080686.318149.11082502260395458608.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 13:40:06 +0000
References: <20260521032815.1845-1-kx960506@163.com>
In-Reply-To: <20260521032815.1845-1-kx960506@163.com>
To: michael_kong <kx960506@163.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 May 2026 11:28:14 +0800 you wrote:
> In bt_bap_parse_base, PresentationDelay is parsed but not written to QoS.
> ---
>  src/shared/bap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] shared/bap: Fix unused value in qos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=29fb17c909a0
  - [BlueZ,2/2] transport: Add support for obtaining PresentationDelay in broadcast QoS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fd25b4b1e596

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


