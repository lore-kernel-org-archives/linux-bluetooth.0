Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1C77F0D
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEqswQd8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4BE0C433CC;
	Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702398025;
	bh=ZL9A822sK+ot0+7LIqNl5Xq0dOOhCY16KdFNGm+GEOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qEqswQd89hZoWZTLbrx8c7Jb8pMEOpf992Mw7kb5urQJaG4Hp40w8kTgk0nclrJrQ
	 hHYD57uQZWulw2DK1ir5oesUcPzGmma9xpVLdDYS6OaJApgd3kLdVrgOl352U4IIM6
	 6y4q7V6tnZ0J8t89FKRElWDTEpLISWGBSY0zMWJGSKauc1/G1SBDNz62Q/F1cZ/h1q
	 +KgNVVqIvEvjFHGguj4+tH83/zDVI/Y+Na2FJtpzKgdFKz5rhU4AH2eml8Vn0cB43x
	 Lb7HwfBm2p07zp8oAAUOLO1JVW2e0+UAg3eblMPltzbI0lje0BNU264TT89vOalG+A
	 uPjCKLL2vb69A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA0DEDD4F03;
	Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Send reject on command corrupted request
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170239802569.22444.11101954474016641561.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 16:20:25 +0000
References: <20231208174150.1313389-1-frederic.danis@collabora.com>
In-Reply-To: <20231208174150.1313389-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Dec 2023 18:41:50 +0100 you wrote:
> L2CAP/COS/CED/BI-02-C PTS test send a malformed L2CAP signaling packet
> with 2 commands in it (a connection request and an unknown command) and
> expect to get a connection response packet and a command reject packet.
> The second is currently not sent.
> 
> Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Send reject on command corrupted request
    https://git.kernel.org/bluetooth/bluetooth-next/c/37b85190ca1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


