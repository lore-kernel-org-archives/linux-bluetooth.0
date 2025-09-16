Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7930BF6E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028841; cv=none; b=Qm5tEXW12PvI4CPcjx9DGo3KOxwpd2j30KmkvPk4xorJUAuAhCPUGIS7v+IFGDCsJVLP0dW5Opbs99NLSc9ktBfUw/glUzPKFMbVQxXHWRWM/5cwNf5+w3MvJgIfgWZRRFSPnpeJ4p0UsGWmh1hXGnsePyls4oRQzwUkVwBn9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028841; c=relaxed/simple;
	bh=LbHbCn3rREdRjunWJf5U9JuTe/Kkf4hEDBSFvfQKV/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FhIwZ1S4jjm06OsjHbLpNbvR3o5uQCKGco6VnutBtA6mAkwva8cn9lsSobo/2w/HMEYZdey5NlTkHoX4wNIzFSrE40SNxuWSvwuMieOvBsvSRxUub/K/tvC0NIxcjZMuesRFl2tr+T792fyv2mURf2KfbPIhw2i+St3MHmsdqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDMJ/twg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDMJ/twg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829FFC4CEEB;
	Tue, 16 Sep 2025 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028840;
	bh=LbHbCn3rREdRjunWJf5U9JuTe/Kkf4hEDBSFvfQKV/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDMJ/twgNh4wCLAq/He0TF8qpVJ4fBdcEF0zVEwBIXURhxcIBqdegFgHFPNfunALq
	 mqGwXCn4GQDPYu8CQiAxSG50dAVn1oPx9cjqch2U9q5AEy6M+p28+WMpy912M90Yk1
	 TCa9BkJ/UOkNK2etwwvpehysm525YqdBvzOV3RniYIE62ScxjTR3k9D3tMg9n4KL0l
	 EZapNfx050vwvfnfRBwnPfGclS1Fc0IgtBpxGOp1eb6l24FFB4QLE6v82KM0eLAvDD
	 1oYZYXYMRreqAHvODIYAZCYwJ8OQufHyQEMeYXqGyNReQ7uXChBcXHFx6O/WGJsQwe
	 IMheOCTmX0Fzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9139D0C1A;
	Tue, 16 Sep 2025 13:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 1/3] Bluetooth: hci_event: Fix UAF in
 hci_conn_tx_dequeue
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175802884149.749893.13942003054156853189.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 13:20:41 +0000
References: <20250915161504.814410-1-luiz.dentz@gmail.com>
In-Reply-To: <20250915161504.814410-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Sep 2025 12:15:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following UAF caused by not properly locking hdev when
> processing HCI_EV_NUM_COMP_PKTS:
> 
> BUG: KASAN: slab-use-after-free in hci_conn_tx_dequeue+0x1be/0x220 net/bluetooth/hci_conn.c:3036
> Read of size 4 at addr ffff8880740f0940 by task kworker/u11:0/54
> 
> [...]

Here is the summary with links:
  - [v6,1/3] Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
    https://git.kernel.org/bluetooth/bluetooth-next/c/6b74ce021062
  - [v6,2/3] Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/b6018d6825ce
  - [v6,3/3] Bluetooth: MGMT: Fix possible UAFs
    https://git.kernel.org/bluetooth/bluetooth-next/c/3fe1be6fee6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


