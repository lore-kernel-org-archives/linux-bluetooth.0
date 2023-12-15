Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670033A8D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZaQGjR9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2360C433C8;
	Fri, 15 Dec 2023 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702656026;
	bh=9sVGji5Epvw1S7eapYLpbTwoM5al5bNEOTgtt4SOvO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZaQGjR9c19TdkTCnv0APKaXz+aNXo1egGCrRP7PaLlFtS/yNUuuC7uUtiLzPISea
	 ZYTRnWNS32VuCDe57So0v5RHvOYzpMn/qiu3nEqDZTxZFg3LQIE4qquNZBt58SmRpj
	 7dp9GH+j+i8D/5FbgjqUJse4bYhjOVup+vuQ1ubrJluk3CJbvRbkpNXJJoxWKKAwH8
	 wBSqWuFaaHFbrGrjDSp+A0ie71kaF6RppZv6HTIynoQRBL+puTtRx2/4wB67+vRXBS
	 B41ZfAFv0e/SPJx/qJsYC8cZ/C7+0XehuDRDLZyHCWt5ubJp2YBLkipGXeZj1Z7ZgP
	 Hy58XOrL+8RFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC0FDC4166E;
	Fri, 15 Dec 2023 16:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: af_bluetooth: Fix Use-After-Free in
 bt_sock_recvmsg
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170265602589.22720.8309217075489314107.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 16:00:25 +0000
References: <20231209105518.GA408904@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <20231209105518.GA408904@v4bel-B760M-AORUS-ELITE-AX>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, imv4bel@gmail.com,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 9 Dec 2023 05:55:18 -0500 you wrote:
> This can cause a race with bt_sock_ioctl() because
> bt_sock_recvmsg() gets the skb from sk->sk_receive_queue
> and then frees it without holding lock_sock.
> A use-after-free for a skb occurs with the following flow.
> ```
> bt_sock_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> bt_sock_ioctl() -> skb_peek()
> ```
> Add lock_sock to bt_sock_recvmsg() to fix this issue.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg
    https://git.kernel.org/bluetooth/bluetooth-next/c/63b55655d30b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


