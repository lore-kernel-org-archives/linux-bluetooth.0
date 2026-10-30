Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368812;
	b=bWF3b75XTE9VXTmY/BHQMwDT4ZY8t1/d9vQnZhVXdSPaE2p2PbRNnBS82Cdm/0Tqkhn4
	 8eMeGUDgzTqZltVcCWT9LIKuuxBwtOghWgctAJVMGL7Xx3tQ2bCiOKBVPnONiSINb7Taj
	 XezsLKvegxgqBmne8YlChy1IdedRoHvHwR0hBuWaGw6MdHwjLGty43iQwhBTHmq1k6LwG
	 RCwoBpcObZnn5RtpVoeFk8u/xebJJgjimMZ7PnRzJQVO3MxHY0f1WjGfjwtEkmLCvMJ3s
	 HROBUha2b+9i1WOppWM0uhNaNyM+dCzVHRbNGd9WUQ0RPk7l2JG4UBMzhyvelcv+UXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jxiJPiS+FyVXqYg01CNFt26Q4gP0Sg2O88ZhesBKgJ0=;
	b=WbW7CXp26DeDZfUPEcXjaX27pLLpS6vbwwoUmLIba01fR/0wnp4tB/KBcW90vAIuNUD/
	 PewskkD9+ouICnb+LjOKwUz4YmOEknFBGbjjj6yvotfeNQz0lr9FCwByE+HUFiCXiLJHt
	 teMBBKRak3P2DQtiz2FQBO96Mh17nnnF6rVT5MePFbCaj7tKXGpIGiPaGwcH0w5j58xp7
	 JNr3C1vdNntnAUBIoHPZjSWqd09hCxeFpI/RmpBuci6Lilux45xnzMC4em90z7//KjuUt
	 JyRvScDKIrKe7hmcx/fytE/8eYLhSlPVxUpCHqN9qb2IUXWfcOOwEJr8kHOVIS37EWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8bYH50x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43238606A321;
	Fri, 30 Oct 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8bYH50x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F731F00A16;
	Fri, 30 Oct 2026 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793368811;
	bh=jxiJPiS+FyVXqYg01CNFt26Q4gP0Sg2O88ZhesBKgJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O8bYH50x/wboQFr9ls0elqlKJM26sydSWdpoDJ5Efag8A5MZS1wK7DAHQyncSFLiL
	 wRKHuiSdS2Ue5vgjz1EmX2A777abhp6YJeSL9AlsPyJuMBcXtjKXIC9A7/cTyY3+tU
	 ycJu8SJGaH2bk6HoPVh3Ta0EQXoTmupugX6fVZR7p23DnQyHeP7kjWS+ScehQVqzU6
	 /s4SpjwYJRzea+avpLb/454NuvXzkK7UqCwPCvVfBbl/oIk5pFM5aNblysEDNDshhX
	 NjmXBpfnAyyRTYb6sb9TrDqcCXZgVu4wRtWOzLP3gl22kkYd2elg0q0m30E8y6wVID
	 ewcKwQ04K/ilQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA32A3800465;
	Fri, 30 Oct 2026 14:00:11 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: btmtk: fix error handling in
 btmtk_usb_isointf_init()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179336881029.1091505.9199301543471972912.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 14:00:10 +0000
References: <20261029224022.1233751-1-ismailtarim7@gmail.com>
In-Reply-To: <20261029224022.1233751-1-ismailtarim7@gmail.com>
To: Ismail Tarim <ismailtarim7@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, chris.lu@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Oct 2026 01:40:15 +0300 you wrote:
> btmtk_usb_isointf_init() submits the ISO interrupt IN URB and then
> sends the vendor command 0xfd98. If that command fails, the function
> returns an error without killing the URB it has just submitted. The
> caller then leaves BTMTK_ISOPKT_RUNNING clear, so the driver treats the
> ISO path as inactive while its RX URB is still in flight, and
> btmtk_usb_suspend() skips killing it. Kill the anchored URBs on this
> path, as the URB submission failure path already does.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()
    https://git.kernel.org/bluetooth/bluetooth-next/c/215ef299184d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


