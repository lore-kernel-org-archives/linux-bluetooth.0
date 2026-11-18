Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011007;
	b=WvxRknL/uY+Zfb4I9SSrYGMMFaAGeEJDMitCWdE/Hy/VPx4ASnXuBsJz6qrFzZuU05Re
	 xiQVyb5OroIcwXN8LNMTMjZUX050opYRH21sjL58gIvODv7c4frn2cWnl8UT+0dmk+a6d
	 +k+Ey/OB9cvtdUXUVcSiyDblEOELWcz0b4qY1W3hplz9v8ymkIW5GvH1SO/oCQLZk6py5
	 xvAMJUv9o4FzvVuK2wOTSw/FuQWAWJyNKiV2XEFerZ4nZfO90yg3I0xD1kMGZpYuPJ+cc
	 tpxgGm/US3JDQbZldV9zmVcU24TqjTUbHEvXRiDlqwYGQb74diIxfncuD4tTJ9bBXNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Wp7Igv3RPi42fn0ygjnslZ6xixysl2T3tSPSSHZkGg0=;
	b=JILxm9Qfg3CJJopudKiqQLHRmH4hYP7XtlamcxjgDzRAD0JxMKg58n6AB3a+tJmmEg6c
	 ETuc1lotm4Q9aLrLG5kQNzrsRwHdcmHbC0TGNdV8wzaJVRmc6gik1edSDXw/Pqix7ArJT
	 wAK7in1YNjCGMeUC8nRyNTjLaB56H79QtqMhv2VpRoA40+wMNWYewG1r2ei6p9d/H0N/7
	 RoTkHA5ViJMA8hDktbx1Tjld1lKLOvSTypHELBvsNmmwyPGIbFadiQTYsLGEx03/UxNFc
	 Mze92wpYdzB/8/W06suG9KAcnlPQE1s6/avvgmw61pMbMoPR5zEYfAQwC0tGvbaT50Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IjOl4/EW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B053606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjOl4/EW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00801F000C4;
	Wed, 18 Nov 2026 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795011006;
	bh=Wp7Igv3RPi42fn0ygjnslZ6xixysl2T3tSPSSHZkGg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IjOl4/EWGqpQ4+zgZH/nI5yf4riiZEbOgVCjjH+qt1WHmc0UgZKcBEP0sWQujd5fc
	 D6crVIsTqrdJRdGL/awiU7Ak7vwPdyjhqkC6rRldxSpRSgpKRIOcUgee173Pep3yfz
	 NIbngD6mRB6Ex+jdoj/CaXa393tRqML8wL0feHAx3mL0RC+Efrzvc2+CpfhbFP4GDX
	 qLuUGElecEArY3uyPRnJ4L/9iQu6NkA+jisin7s9OWa3QH1kH2lOu269ItXM2OnmzT
	 2MoeHGqSzrd8ydY2HwdI32e9MN1q64OFt/eosGOZ5yYZzkJ4hzGIvbraj1pfHy/RzU
	 a7mn35qbJA3Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45273808210;
	Wed, 18 Nov 2026 14:10:06 +0000 (UTC)
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
Subject: Re: [PATCH v3] Bluetooth: btintel: Add UEFI standalone static SAR
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179501100528.1728928.5021407494750896247.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 14:10:05 +0000
References: <20261118115542.3167414-1-aluvala.sai.teja@intel.com>
In-Reply-To: <20261118115542.3167414-1-aluvala.sai.teja@intel.com>
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Nov 2026 17:25:42 +0530 you wrote:
> Scorpius Peak2 and later platforms, excluding BlazarI and BlazarIW,
> provide Bluetooth standalone static SAR sub-band limits (BSSS) through
> the UefiCnvBtBSSS UEFI variable. There is no corresponding ACPI BSSS
> configuration. Applying these limits requires SAR to be enabled in
> UefiCnvBtBRDS as well as in BSSS.
> 
> Read revision 2 UEFI BRDS and BSSS variables using their shared layout.
> Program the BRDS 2.4 GHz limits, then enable standalone SAR and write
> the BSSS per-chain sub-band limits. Send SAR initialization complete
> after any UEFI DDC attempt, including failures, while preserving the
> original error.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel: Add UEFI standalone static SAR support
    https://git.kernel.org/bluetooth/bluetooth-next/c/4bc12982b9b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


