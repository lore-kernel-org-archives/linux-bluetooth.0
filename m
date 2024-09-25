Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00385628;
	Wed, 25 Sep 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277632; cv=none; b=oPnfyvN6J0yecq3jDrHA7zdA3P1EFhqsTFE3uXYthZ1a7W96Q8ogyQ/WnCUEgHJYQS58Hhy2mMatklUX2uZEsVyR/nGlBDbsolPd/DniS0sWFkDtTcf3983+okCzZK+PtrCtn9Ux5F1LRPsD8yDdgKGczGF5utmIZY6bWRT0KfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277632; c=relaxed/simple;
	bh=EaqXusJkUoohHGHin1HsLJyIHdd1GQUMYkzDBUIN3f4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WsyEGuGM1pLOItteUPgG7DUD/D/f1Wi2WPNVjAEEvyIkPz5CV3scnOfp90+eRK3bhH6wJXLu10r0tA5U0lGpM0vmSmyID751OJD0Txwt+2vyGBf5H6oQ+wm6zTW1oqR8FuKSv52U49FZjk9+p2Zmk2xuocovVXC+Vsc9MbShp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUXNLyPQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUXNLyPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB00FC4CEC6;
	Wed, 25 Sep 2024 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727277631;
	bh=EaqXusJkUoohHGHin1HsLJyIHdd1GQUMYkzDBUIN3f4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aUXNLyPQvfXvgr0jl4NQaI4I5FPKHiiTv39nhLTXiJO61R8l97tD/quSLFUgOnhN6
	 Z8UAuMiaPc4TEIBTdBQD10Ds4sD1PXCRbSRweWn9hfpX3McW/djdnv1n6LlMBuxPjy
	 r5oLOvWVpWIA8ga4DvQ78ynwqTafNAJsGq6SlMD7gwi9eE4lOnKNvp0UWL5fjSAeoZ
	 9ssnTOhGgp7u3Va7cVqwMbPI5N0MF7q8tZOS73cbwjDnlUSOcJXaiBiajjo8h6MLAP
	 APcnATOIh2rZSMaFgc6ylXEF3q3tV/9QhZnC1LZ3O0Fiq30YopnKhEPsy6s+7xVS/4
	 bJI4jevKHcGUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 66D0E3809A8F;
	Wed, 25 Sep 2024 15:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172727763426.630403.11002256254773458657.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 15:20:34 +0000
References: <20240923085519.19074-1-aaron.ma@canonical.com>
In-Reply-To: <20240923085519.19074-1-aaron.ma@canonical.com>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Sep 2024 16:55:19 +0800 you wrote:
> Firmwares are already in upstream.
> 
> kernel boot log as following:
> Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00190200.bin
> Bluetooth: hci0: QCA: patch rome 0x190200 build 0x5656, firmware rome 0x190200 build 0x43fb
> Bluetooth: hci0: using NVM file: qca/nvm_usb_00190200.bin
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x
    https://git.kernel.org/bluetooth/bluetooth-next/c/47d72bfcb396

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


