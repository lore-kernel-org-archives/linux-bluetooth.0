Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580B153513
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799829; cv=none; b=jng4IHmssOQhOiXFASyR0xY3M4HzGf5u5fkph1J7lBGyrlT0jA0njI0oTXiuVSRsB7b0lwYLImFpgazCsTIUy85w34wcRvQV64uh5up81Dhv/Xrfg3EoSymKfgYLskXLRuwWAD4TdzMx9t1PzrI61va9yYVZDsuA4GUAHxOcbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799829; c=relaxed/simple;
	bh=smlU8gDCuBtp7jPPmCMeClCuCOErUb+LAgnra16IgTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RDMT5yvRLEtR05tN5JNIwu9QnTgMsBKvInRRgcXpW+5T5u+aa5goBwD3LABhjXtq9AMZmHQbFte96YICtS0B35CGG1MhQhI6VswY9+4/FyIxd3e2P12D83m3Ly2Xn8LO4uFKQrGK96uotnbJe+QjTlvj2vckuS+aOivoUZs//Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9hs8+7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9hs8+7T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8A5FC4AF0B;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799828;
	bh=smlU8gDCuBtp7jPPmCMeClCuCOErUb+LAgnra16IgTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m9hs8+7T68p6tJTew1p6cRuFQi48ZF1cPZ4pWn7ehHXNxcdNpco4wYDT4jD6lGxnL
	 LX19hZDs6YOfqi7LozTFUyVGv7gDrizHv5XOXR2e6rmnceCaW60LvoeHU01t0lVu5e
	 dKJJ7Y4C7qKRnzeKVOmhAaNYO5q/f6D7l02rmgFI+EhbMPC4R8NeurW4wPfdhpTv1d
	 6bfLtd/0i5g37b6Jb7Ekt9vIEXI+xMoHFizNsqVjlQyVhY1xRkkqsjvrGCZ6jeUy51
	 N+sm0MfrwlwdBGMED3HtwKdbUqcAr43I+caxZbMk6x0qsJ6qKK+AFkNQBFqHCcDqgY
	 myiR/KH3Z6beQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF21FC43443;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 RESEND] Bluetooth: btusb: Correct timeout macro argument
 used to receive control message
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171379982891.28518.15878891828308361794.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 15:30:28 +0000
References: <1713797830-24600-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1713797830-24600-1-git-send-email-quic_zijuhu@quicinc.com>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Apr 2024 22:57:10 +0800 you wrote:
> USB driver defines macro @USB_CTRL_SET_TIMEOUT for sending control message
> timeout and @USB_CTRL_GET_TIMEOUT for receiving, but usb_control_msg()
> uses wrong macro @USB_CTRL_SET_TIMEOUT as argument to receive control
> message, fixed by using @USB_CTRL_GET_TIMEOUT to receive message.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v1,RESEND] Bluetooth: btusb: Correct timeout macro argument used to receive control message
    https://git.kernel.org/bluetooth/bluetooth-next/c/927927f2471f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


