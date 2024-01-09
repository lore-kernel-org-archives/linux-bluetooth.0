Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDB3D0AB
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBiHI+rW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C2FDC433F1;
	Tue,  9 Jan 2024 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704828025;
	bh=yzSvpNxULUN4HhNVTu2M8cVZH0J49Xg2rsBYcpmJpRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gBiHI+rWjEaEU7xrIEmiBI2EG0MV59KyKk/PZyFoTFJtoiOUKC9z6X48PM/60Idvf
	 qyzlmU2Y6S18WYtt6KHa+22QBmLpFJ8ymYTEMQbNd7aqF93EEAjeOIz0QqpOiPgoj9
	 U/v8Fs4CqXjlkVe7e5l684UoujayRwi//sczaHYcre1F20IGSwQXtvNxR2eQKquVJy
	 2PMnPlezjEKKwjxaQh1EDgjnq/CHST3Z0892mPNRqlem7syCdvYUKoaAPehljViaPK
	 d8NRNGRe9UX5YHpkP2+UHGJ3SIT4tWmG9+ws2aIESBad1T2mKn+3k8PCRzP7i+lLZH
	 m6nmPc55BsLSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15A95D8C970;
	Tue,  9 Jan 2024 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/4] Bluetooth: Remove superfluous call to
 hci_conn_check_pending()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170482802508.21245.5348672714363905301.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 19:20:25 +0000
References: <20240109174928.488595-1-luiz.dentz@gmail.com>
In-Reply-To: <20240109174928.488595-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jan 2024 12:49:25 -0500 you wrote:
> From: Jonas Dreßler <verdre@v0yd.nl>
> 
> The "pending connections" feature was originally introduced with commit
> 4c67bc74f016 ("[Bluetooth] Support concurrent connect requests") and
> 6bd57416127e ("[Bluetooth] Handling pending connect attempts after
> inquiry") to handle controllers supporting only a single connection request
> at a time. Later things were extended to also cancel ongoing inquiries on
> connect() with commit 89e65975fea5 ("Bluetooth: Cancel Inquiry before
> Create Connection").
> 
> [...]

Here is the summary with links:
  - [v4,1/4] Bluetooth: Remove superfluous call to hci_conn_check_pending()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a7ee39bea315
  - [v4,2/4] Bluetooth: hci_event: Use HCI error defines instead of magic values
    https://git.kernel.org/bluetooth/bluetooth-next/c/f8c47ee39e6d
  - [v4,3/4] Bluetooth: hci_conn: Only do ACL connections sequentially
    (no matching commit)
  - [v4,4/4] Bluetooth: Remove pending ACL connection attempts
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


