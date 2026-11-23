Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464006;
	b=EuxlWLQAskOWjMR+NzMSSkdHaXeAENS6pXSixTKzqNXDSU/a1tEq1IiF9B6mUZe3pzmw
	 JQz1/E9HWgDapdzqH5WhO5j1y1XOfJFRl1Ek3h/MqNlwOovj+SAg5YxQVB6Em5lChvQlk
	 um592JwqhgnfZC49kOPLWGGZEEPA+BVRG6X0IaeE161lIOQADfv4Enl8XuTswRCGmWNcI
	 lVawijkEVCSs3zBRnVvmBUtfKnvBZGsbqH45//LkOGZNxbirVcrRnZMmmjlaVoRqD9ADZ
	 zwFIkem8lFAp2A2VcsUPSzsKEvURMrWSpje4LdJEyGu2SRzf5evzVxRUc19tk64AQkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=r5R4hf5cfxy+Cy66jVTd+1Csi3vyz5AZOLaI2RR9hWw=;
	b=On74Q2zuPPUOsp+A+K+V1fQsWw7Jq6nTmWOblD3Z8m3KUNilmekx7xJuxxFqs5kEmIX1
	 HUrzEoP/zrAF1ge5IkA0fOonK97wnwLSKIJaIKwosy52WoPc6GjxhfaMH5f3jdksHezyA
	 QesSSdiWDmKIkOFC/ARhWOGADEr/810f9oJegQRIoYcCNUTIz593qyNXt0kQnP8gpRqAL
	 1GZ6AMTIfgOwrBgyVSCGL+pVmu3zfk1/4sJAiAweDzJEl4kUhUYrVkJMaG1PpGAKFcHIT
	 2Du5WyAfXBdEH8FAIlhNISZKmSIsZTeW601TJ0ud/N+cao18Yrus+rQ83t8BDmgzelA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULBEWwwh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A493606A31F;
	Mon, 23 Nov 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULBEWwwh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D23B1F000C4;
	Mon, 23 Nov 2026 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464006;
	bh=r5R4hf5cfxy+Cy66jVTd+1Csi3vyz5AZOLaI2RR9hWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ULBEWwwhcbZzrBysQKKO4FG0TZ1MltLY8mtcu1aywOvuipeHwsbdmXxmancaosNCY
	 37B/r0Rpeia5wYFfJRSxPqtsNRBRveV+xZDNY39ALewgj4vAZyhFTvoTxPngH0QZzw
	 dCp4+vXLufsU+X4Op6MKHWS8Z8Q9bnwKpKpZNxIc8H4+SYMZycXHOKsT5VKzlPrVBS
	 hTPtbloypixzbHTP8mWOWjL4f8LxTRrAIxfJ3MjNPhVgnPcQIFboSL3aEOQEttjr5/
	 +7CH+KW+z7JYtayqXCesnjSbq25lBbuOoaEL6bnaRnBM24gcMd498yrYqdSxVd5BMX
	 JSdlsZnX7F1Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1668392FFD1;
	Mon, 23 Nov 2026 20:00:05 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546400452.3090992.2341650194008923425.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 20:00:04 +0000
References: <20261123160421.3227994-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20261123160421.3227994-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: sven@kernel.org, j@jannau.net, marcel@holtmann.org, luiz.dentz@gmail.com,
 neal@gompa.dev, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Nov 2026 17:04:21 +0100 you wrote:
> Initializing a struct using list initializers is hard to read, compared
> to that using named initializers is more ideomatic. Convert the macro
> used to assign values in the driver's pci_device_id array accordingly.
> 
> This change doesn't introduce any changes to the compiled array on an
> x86 and an arm64 build.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array
    https://git.kernel.org/bluetooth/bluetooth-next/c/ffb95458a0f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


