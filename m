Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023B322B
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Nov 2023 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkuzDake"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0F0DC433CA;
	Wed, 15 Nov 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700008223;
	bh=QJ9fgS7t64sO2LEwig45odUagq9LR7jbH4v/a8Cw/NM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fkuzDakejYVslclk/oGoWo+vBslnxbzwYJrFfphZ60jlBZKFkmq3dVFfro9tyQrLn
	 cus+v3o5L50oBFpLAGob7ugVjL74tqcJ7OLfOOkQY/iz+GCpC3JKeXKankCeSyhIyY
	 tHayNHlHNszFUqErGYEuIITacnnt1wK91baK5tVxRmtYt0w3Ovcd+mhcZLyS6S6q6V
	 Vs7buWcssJ5d98/+C4u2ytusfIM2FM5NOOp05c1371x6Svz/CRbhWdgmryvLqt1zvB
	 i/UwGIMgMlCxryd/cU0U+5yzAtyLz4CiGY71GA4TOPYWiHtqwfQR10dtFHBv0RFD7G
	 YsV8jKvVaegaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C7B4E1F660;
	Wed, 15 Nov 2023 00:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] media: add Retransmissions in SelectProperties QoS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170000822343.23786.14552210447514942883.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 00:30:23 +0000
References: <f1ac6b52c30e002400c2a0dcb20ead18899695b5.1699992657.git.pav@iki.fi>
In-Reply-To: <f1ac6b52c30e002400c2a0dcb20ead18899695b5.1699992657.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Nov 2023 22:11:52 +0200 you wrote:
> The server preferred RTN is part of the server supported/preferred QoS
> values, and should be passed on to SelectProperties.
> ---
>  profiles/audio/media.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ] media: add Retransmissions in SelectProperties QoS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=14dd4a75ceb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


