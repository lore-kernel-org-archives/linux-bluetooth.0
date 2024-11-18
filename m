Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1714D71A
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966021; cv=none; b=OeDngZgYy+dqhvKFLDPmR6fGSBl7XDRKwai5O23fBHvmd5yrv9dEPKvaDClcRyjAjc7efsnzDchDg88yTbSbDNG6fByIqs3Rt6UzVvJn4e+ybTz8TOXWcecQabWBU6tcAWzm/inAulFp/5aq98SCLC/qjugRgxVjwJx7q742Ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966021; c=relaxed/simple;
	bh=ng2/NEjreEllODtZEktqXkdVRrygYA6WdbVim+uBVhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mo37pDv5oTG3011JfJ4EJdmC96OoomDB8dqPCMJ6TiFn6cJKt4TP/7mR7y5MgLgySAP1S+kRt07dKkefqpdfEtbyZRPmXt8vzJWHxKMeIyW1PZ4zT+69ZbCGB4pv+zl2vltDhKF3e4+J9ZU9pfFJt8KrQedjMFwg8XLKuHNyzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0yzT7F6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0yzT7F6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29F8C4CECC;
	Mon, 18 Nov 2024 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731966019;
	bh=ng2/NEjreEllODtZEktqXkdVRrygYA6WdbVim+uBVhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D0yzT7F6+WArQPGhn/H9GHUaUynGnV8zvNiMOVeCXMggAeJd/8zmXdffPdtS4tlt/
	 fSYUgk/9euD4nn0kuF0R2ts4g7NIWV8SeLbfIEDORF8pxcR/Rk3vTREcnALuw80Wdb
	 2obyT2odtQ5KcRvQOK1jC3GWMSS/ZkAIqp6W1137RLjmdudGq1xCBiamVAxx8yVPwI
	 TdsFbR4P5k4TtDpnnCYyhw79171E81arP16F6w2ZRfNk4hHP9KLbL+Vid0kPpZLckV
	 FH2XkDcP5Wmh6WG5kUW4wJlF3OuQLL2C9CGOTx6Z6vdAXBvl4KtlNrSxORUgqy8p7M
	 gol9zUZKaB/UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710A33809A80;
	Mon, 18 Nov 2024 21:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: MGMT: Fix slab-use-after-free Read in
 set_powered_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173196603127.4188541.2023742807080036973.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 21:40:31 +0000
References: <20241118203337.2648476-1-luiz.dentz@gmail.com>
In-Reply-To: <20241118203337.2648476-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 Nov 2024 15:33:37 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following crash:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
> Read of size 8 at addr ffff888029b4dd18 by task kworker/u9:0/54
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/4f562bec2bbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


