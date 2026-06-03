Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF437DEA2;
	Wed,  3 Jun 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509013; cv=none; b=OcIA5ljzBmDSiXsmdbUOZ1qgiVmp06mkMHjNDQCBQG/YDX+qG2fcSkdPArC1hIA9yzUw8OsUBzahlXVjpwiwbVPz+s91V70pNcoKa9tHTkKp2EKLrKGJBB2e3RzZTfX/A0zxwlDXUQZrFUPo+hRHErgP/IdzbK/VYCQrcxkNfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509013; c=relaxed/simple;
	bh=MTpnMfbQKMXf3qELnFi6UZTFci/QGXvafhy3ujmGhmA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GnE8Cjy1SZ6Pw5/CIxkWZGs5PZcAJuuZOp+/lOvW0IPnhgo21JJk84Khu0BWf1x2VK5bxfTWS5dDVPDE2+8QuN8R/eP9OO8qAxzRlymPHHE4iZFLYWuKwytEZQ82rXkguZSAeVTIvC+D915c51QcxfPcbsTdj7mJTRsCdWCHkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTzoTF7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTzoTF7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D81F00898;
	Wed,  3 Jun 2026 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509011;
	bh=wrzOVnS+X13tXKUjZu1rFaIumJnVPw+bRqGM+bZ2KoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gTzoTF7iyjzmSk19M+GJZPuzAL1JSSn9JqKteKp1sC4eqiBvds9gzoRkjBC20BMvC
	 75oAR0+yxzHdwTjPCzx342nc2t3OZ6YaYLPdhWnl9P5q1D1xY6fsIyATsKys7a3Qm6
	 du7qekO8L1KEc+Hnput9mhcTDCJZBEASDKtP75qPLtyqxfD9C+4RwwbLHTmWI0w18J
	 8DKg1GBn36T6b9hLmj3BKxPgLcekR/XrQNUTs31rcgjqeUEIrPelN4Lybs1Tb18P8q
	 nm///H8WsHu/T/F1VM2IByaaQ/sb4XXRotGHxu7fHQ7SuOKreb/n/sRsiaypO2zfzc
	 IBSfU3bkWsrRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B2239308BE;
	Wed,  3 Jun 2026 17:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 17:50:12 +0000
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
In-Reply-To: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
To: Rong Zhang <i@rong.moe>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 03 Jun 2026 02:38:10 +0800 you wrote:
> These NICs are often reported to lose their Bluetooth interfaces, i.e,
> their USB interfaces suddenly become completely unresponsive, causing
> the USB core to reset them, only to find that they are no longer
> accessible. A power cycle is required to make the Bluetooth interfaces
> recover.
> 
> After some investigations, I found that their USB autosuspend remote
> wakeup capabilities are so broken that they are precisely the culprit
> behind the issue:
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/247570151789

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


