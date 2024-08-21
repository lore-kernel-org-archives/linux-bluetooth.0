Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AE364D6;
	Wed, 21 Aug 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251840; cv=none; b=ZFoKOriUKMAPSs3JR7MH9KMDIhWBtkFRMBcZl/gA4hYt3LyXVYQWGXDeu1xQmJG4GjRyxkUN7dfVIEa8tX/j1DiWhiYw6qAab4llpjPhi9+AAbccEW/6XRPo8CAYcOi3G3VIYX7Hhae33wihhsIw/0N/PKpazyjkrlRwopr0qfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251840; c=relaxed/simple;
	bh=h5udfNmV1oT5RVou2y7wsYv/8AtEs7vvL4kflfEpAKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L23mS1U5psgF0X0FMdJKBCmBmm8eVave/sXMdu7B3KzZ2vs1O5Z7W5oJmJINj/mAVPLLgRicYr9ql5zTt7A5KEBp2IJJqXEahCo+0iV1/UzahdDOT4ZdDDfNeBu25LpqF1bCSGVoc/sb7wXZSx1RUk6B79veQtgPEiWoSLP2bjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDafexD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDafexD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0973C4AF0E;
	Wed, 21 Aug 2024 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724251839;
	bh=h5udfNmV1oT5RVou2y7wsYv/8AtEs7vvL4kflfEpAKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aDafexD4p+twtUvsyNHq2rdmIE64VUPFJSboFLgNHSCY2MWvGxu4zwTxRYrd6+g1Y
	 IjG+0QZ4a7HnSxcD5ZryHQeQemqEBnuMmxVHOxJeuBk4pddad1/DQkEKe9ObMexXXr
	 G2kRxGOTWhsodLqfsh/llhu/HLnHn2EGk9iaZ/pPYM7rMuZYybiI3mLSN/u4uXmmYn
	 b8VX/NgzdLIbhC6FjjP6P4hXzCYwiul75Gl2DlEIlobTLABxVaaQQT6KkLEof4yyMf
	 7CggV/z3Iij9Nl+KsbKMe3WAwI9KftrKM0EYFv+n/ot0Yj0gaynP03+k4tREZus3o/
	 lgFSmra03Bbtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712543809ABF;
	Wed, 21 Aug 2024 14:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3] Bluetooth: btrtl: Add the support for RTL8922A
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172425183899.1745569.12193647882630633784.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 14:50:38 +0000
References: <20240820062829.25932-1-max.chou@realtek.com>
In-Reply-To: <20240820062829.25932-1-max.chou@realtek.com>
To: Max Chou <max.chou@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 hildawu@realtek.com, alex_lu@realsil.com.cn, kidman@realtek.com,
 karenhsu@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Aug 2024 14:28:29 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> Add the support for RTL8922A BT controller on USB interface.
> The necessary firmware will be submitted to linux-firmware project.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> [...]

Here is the summary with links:
  - [V3] Bluetooth: btrtl: Add the support for RTL8922A
    https://git.kernel.org/bluetooth/bluetooth-next/c/d8ca95ad912a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


