Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D44DC523;
	Wed, 13 May 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693463; cv=none; b=WKiRWTVT67JjmjxnTiQJ4o/q0j6NNFbN2FQm3eUYkgSDR9Aj+DXx0D4f11fG9xbyzw2DxSKwRwiX/JhlSoHo7w9duRtuXbWD0TmZpQnUK6fFK+Bc+PcK8Y47Xn7v04Ej1h1/Jt8Q5azESYl8Q33H+EaDnT2Td4MZV9LIrv+Cowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693463; c=relaxed/simple;
	bh=fX1Z6P+oKoXAjVnhrkpbOAzk/HKql/6El7jCyQQTAlM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l+jKL2IJHhsAwQuqkEIKV4FYly6vzKBvCdFolkkKzLB3CWZWdSgkXipD7hQEMmr5F8QK3l7cJ5p5zpuyx1AvwUVUFnhKXJI2+E74NB/aMtoIp8/80KqZokZUv3WVzEFkzb49qoAK/iTrX+O1PBRC2u0Tm8BTTy6+oih1TewkaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNPJoJ7u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNPJoJ7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A25C19425;
	Wed, 13 May 2026 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778693463;
	bh=fX1Z6P+oKoXAjVnhrkpbOAzk/HKql/6El7jCyQQTAlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DNPJoJ7uuXIIdi/XJTn6IurJ7Q9YeCT8HUhmvoCooFRDSwBzfTup+pUMAyq84zf4o
	 Z37C+RT3YVElNFYuxJI75uN62cxEQiGeNkF5x1gUu5KBUD5bQRHG81W32kssrbCrd6
	 2+Pwhjxgc26gfdfHjmxLEOM2fQ+enz54ofDzF66wh3bQXRaDCrt+flaNx9zAamghQE
	 JYhvUY+HXpnyJ/o7m/4G7vCfM72rdSoRyv+SqIi/IT+MFI6GhtyLRW0Y8/gLHJAcYY
	 23F2x07X9cRxd9CGytJye8sRBOlLZMrOjeoIwMVrrtqHZv1WuP4GgYt6z3nvcWGDUA
	 G2mbq/sFQnn0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DD1393023E;
	Wed, 13 May 2026 17:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177869340829.3749256.4493884006374055340.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 17:30:08 +0000
References: <20260512060318.3288273-1-luke-yj.chen@mediatek.com>
In-Reply-To: <20260512060318.3288273-1-luke-yj.chen@mediatek.com>
To: Luke-yj Chen <luke-yj.chen@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, will-cy.lee@mediatek.com,
 ss.wu@mediatek.com, steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 May 2026 14:03:18 +0800 you wrote:
> From: "luke-yj.chen" <luke-yj.chen@mediatek.com>
> 
> Add VID 13d3 & PID 3609 for MediaTek MT7925 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609
    https://git.kernel.org/bluetooth/bluetooth-next/c/ae3ff17c6240

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


