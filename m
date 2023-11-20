Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C214A99
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWPcv74p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07D8FC433CA;
	Mon, 20 Nov 2023 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700491825;
	bh=ixF67hFATj5SUbY8CWR6d8gGSjk/u3p3aDStqCWdbbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UWPcv74pxNzgWnuni3iBnS7xQ85Ohx/axgQ9ANbvJUdgC8kMD2YJZxBE5sxC53mKz
	 8kqZoAeqWmPV3gfHePBTbk3FPQoiZD/+eJlXaQhkqDL+rd0eg+WAUc0Nj4XpyfCZTl
	 Eie4g93wAqKGWJE8ZG5jAdG6+dn9YVPxdg0SnEExGGmMFKzpczFzxiodRZDn9HLeV4
	 l2Cx6xwTIclmPLnPxDSUr7PXbBMl4rMYh4TxbNIrw1va+xtwGbWGg2JH/N48SS2r0G
	 0w5DAXOKQBvAwEVkAx8/rfBmt1i+lrdU9ea+5v6CPll1SWX92gT184krWcNcKD8YFm
	 yQ9RtmPtqxnqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD58CEAA958;
	Mon, 20 Nov 2023 14:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] iso-tester: Add test for bcast AC 13 reconnect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170049182489.24101.6153640383647595323.git-patchwork-notify@kernel.org>
Date: Mon, 20 Nov 2023 14:50:24 +0000
References: <20231113153942.3875-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231113153942.3875-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Nov 2023 17:39:41 +0200 you wrote:
> This adds a test for the Broadcast AC 13 reconnect scenario: 2 BIS
> sockets are connected, one of them is closed and then reopened, and
> it is reassociated with the free BIS hcon inside the kernel space.
> 
> This depends on the kernel support added by patch
> Bluetooth: ISO: Reassociate a socket with an active BIS.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] iso-tester: Add test for bcast AC 13 reconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58e6ef54e672

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


