Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E13F0A9E;
	Fri, 26 Jun 2026 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472617; cv=none; b=SOo1m07Ta7PuzMje3fHs9EIdYe9qqYVo1gcSuke81ANqtBiaL4S1HsVaA2pU9o6aTqFRIH3/EHeGbcBgf1/ancbHKS0njO1I7W0y6tpCNbBNE7UaiPlHFU6HfY6OiNxMqdkr1k1y9g+3+yvigepkdxPfTgEdl7HRWTgpRun7oYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472617; c=relaxed/simple;
	bh=Nl7cMtPstdlaaejuhtbkN6dn7vpsK1tkXK9IuQMctbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NgSHaBQS+6q0r2RvD3OSZPmcGLcteCJ5HO09HvrH3uxc6Pbyys1UuJllPgCyh9V6g2ix0sIcpDCdaTK07l/Ylqu9xiuP0b8A8KNX5QQFWEb+CqiVFbcSGTxdatQcyMJQr9WLyL3Te5h3eBqT2JGJY57o0u1Hzm9R8PYN7kewpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhRj91kB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhRj91kB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92851F000E9;
	Fri, 26 Jun 2026 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472615;
	bh=veEDJvwPp40fCC7ZLty5rfju7MJ+9apiis4vMby2PrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fhRj91kBzCQwiYWIttc7tx/5NFmAj1PmbdADxIKHvXCuRqSLobJRi1ttT8ZsaS8x1
	 GxCCGiRsx2oOgWRfofUMGtxe+f461b98iz4min16ReFeo09/eKLK3c2tM0iQ6Rk9N1
	 7vRTxYekHF0yFcnvvatNyVhoMjzzk3w1qbl3sIlDcChIayiTUeFCot2LONgSGkOj/V
	 OiPVN4CkVU9F91N3aVj1iBT68o7o6xurqsOhiTnEWB8ZEGgZf88+uzTZbwulhjBcks
	 2sPJpEh0IOMXIVhM9wT5FbOlgtDv9IPntgFzD5b9zz6yloQN4/x2QGyfr5PztaWN6z
	 WXG8TruCp+XbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BBA39389EE;
	Fri, 26 Jun 2026 11:16:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add USB ID 13d3:3625 for MediaTek
 MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178247260252.3816447.15187750698312349130.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 11:16:42 +0000
References: <20260625083230.300651-1-monesss315@gmail.com>
In-Reply-To: <20260625083230.300651-1-monesss315@gmail.com>
To: Gustavo Evgucci <monesss315@gmail.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Jun 2026 11:32:30 +0300 you wrote:
> The IMC Networks MT7922 Bluetooth adapter with USB ID 13d3:3625 is not
> recognized as a MediaTek device because it is missing from the btusb
> device ID table. As a result, btmtk firmware loading is never triggered
> and the HCI reset command times out with -ETIMEDOUT.
> 
> Add the device with BTUSB_MEDIATEK | BTUSB_WIDEBAND_SPEECH flags,
> consistent with the neighboring 13d3:3627, 13d3:3628 and 13d3:3630
> entries which use the same chip.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add USB ID 13d3:3625 for MediaTek MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/ddd25808d4c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


