Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793408;
	b=LWtPIFX+F8uw/QmEXZ+Lnvwl4Nsk7DkI7h1FwM8dqTPsQP4ysZto1MrTchl2UdIVUwmV
	 /Ngwg6m9QtIPzg0tZpkdoodSU6EyUgOll3RBYGKHuimlonfUN0x7iewXNFbtBr2hMppEi
	 Snjd36uoDdgM5P34ZpclmIKhS5JROyGK7rV0StnWI8ulr7OA2ehiHVpiMQJihwNPVOpi7
	 3P8WRPj8ClbpKNJa3sk6tpF/HvqNB+BY3B3AMf7Pm8+KcbtyJNrsfxheI2V6KmnOl/xmZ
	 r0sNt5IT71LsaxdCyVzxPhO8rHyDbpvSkUGcEPygLigdi7BV8P4R5+hBr0EOD+Z4cOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=IMKxAJTioTnFgV2kKOcnfYJ3tZQRRjdSbCM++F5BVaE=;
	b=LhuZb6pi51POkTDhxVbUf4cqco/pNBijVoVDfRD+PBzF9cHaya6Q7vL+cKs8UIgiWN5l
	 StA7bMjS1blJgzj8GJ4xw7ur+eHQwdsp+Dbcnm9mdMRT9Yet/o+rqV/bYda4CjsV+VkfI
	 YDtHks5Ys3pRPihY/Djh1e35IngxMgf4YF3yl+6gLQRt5CoHj4TFJzFLrNV1E+1jGTKIQ
	 IeP4GKaIeghUNSqnlbW35YS7vJ1iB0zrjhScpKfkp8+mGEgvek+nO54gx5JK2Hl6ASvjo
	 qF22h5SmpOHEl4HSALVo0b4/G5S6scDsBo01LtSyhfq5v/yXggEXvPjrcAjQZ0xMBHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlVzCnuS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A19606A31A;
	Fri, 23 Oct 2026 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlVzCnuS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E661F01825;
	Fri, 23 Oct 2026 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793407;
	bh=IMKxAJTioTnFgV2kKOcnfYJ3tZQRRjdSbCM++F5BVaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FlVzCnuSbMh0amDfEVVUsCnuMcnW2pIkQdyeD3xYmsVO/j3oLQNDsS7C0ScjMY+7K
	 uuhKbctsX7VAbbLir9L8PRt1Dfj3Aona0l53vEz5QvJl2oUr5/Sxczz46GKw2GCTbf
	 yAkP1iehxYCs66jJmkfVxNt/rMxGx4/zHjIEcXmVG14WyR4PrW6syV4hlBnyGrKxs/
	 SGGm1pAFiH9x6W4hdroIbnw5omfRwoakIdzwNv3E0fct9KCFgw1R/4n3NoNoe7XCEP
	 Le7MJZIJ74VZUH93B6Vi7rnVSYHAIzS7gfegpwCVHIp2vfvkI6XtTo14fjhIwzY6VN
	 r0AADJEKpf7Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5B7391B158;
	Fri, 23 Oct 2026 22:10:07 +0000 (UTC)
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
Subject: Re: [PATCH v4 0/3] Bluetooth: btmtk: fix ISO data reception
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179279340621.1294506.18194273796007140982.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 22:10:06 +0000
References: <20261022032150.2213479-1-chris.lu@mediatek.com>
In-Reply-To: <20261022032150.2213479-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 hao.qin@mediatek.com, ot_wenlong.tian@mediatek.com, sean.wang@mediatek.com,
 will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Oct 2026 11:21:47 +0800 you wrote:
> Two fixes for btmtk_recv_isopkt(), found while debugging LE Audio on
> MT7925, plus an update to the ISO data transmission setting. The function
> is shared by every MediaTek USB controller that supports ISO data, so none
> of this is specific to that part.
> 
> Patch 1 drops the zero padding that the ISO interrupt IN endpoint appends
> to each transfer instead of parsing it as ISO packets.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
    https://git.kernel.org/bluetooth/bluetooth-next/c/fa9d4ec85257
  - [v4,2/3] Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
    https://git.kernel.org/bluetooth/bluetooth-next/c/61eb283d06c7
  - [v4,3/3] Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
    https://git.kernel.org/bluetooth/bluetooth-next/c/c9d0dedffc1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


