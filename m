Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CE77F10
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2ISAMwS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCC47C433CA;
	Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702398025;
	bh=Bw6EW1EsoJ7H7NtO4jNbUeqkFYj9eOl6E0ArPlHZQgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H2ISAMwSBoFSP0Liu+GljRxLwc3tafwDnRlrID6bylXRQ87akr/esyivMjTdspX8A
	 J0tWIDgTPX7thWWcqGdCZ6izgXfeE7Bpkuf3y//Wr0FQ4IwkQQCOipqnWLgMKLxGPv
	 BnwCrRk7wU5+cqj0LEvkJh3Cdsoq1NYY+EUTrY7tyecPzUdrCZSSmO8jiZRk/62qd+
	 k1CLedBFLDjP/042XaiFWRVeaIhgmHyT5h87Oz61rIabxVAcwGfikU0ywSPYROPmH/
	 3YtPepssQAv5zNb9/4FPtZgJ4LB2LFfCOlz50c0e7wFHB9BP49uPTbBQ1ptU8alAgk
	 RUOCjF2zJaSkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0DB8DFC907;
	Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: MGMT/SMP: Fix address type when using SMP over
 BREDR/LE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170239802565.22444.13565680839471776744.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 16:20:25 +0000
References: <20231211162718.1183182-1-xiaokeqinhealth@126.com>
In-Reply-To: <20231211162718.1183182-1-xiaokeqinhealth@126.com>
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, xiaoyao@rock-chips.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Dec 2023 00:27:18 +0800 you wrote:
> From: Xiao Yao <xiaoyao@rock-chips.com>
> 
> If two Bluetooth devices both support BR/EDR and BLE, and also
> support Secure Connections, then they only need to pair once.
> The LTK generated during the LE pairing process may be converted
> into a BR/EDR link key for BR/EDR transport, and conversely, a
> link key generated during the BR/EDR SSP pairing process can be
> converted into an LTK for LE transport. Hence, the link type of
> the link key and LTK is not fixed, they can be either an LE LINK
> or an ACL LINK.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE
    https://git.kernel.org/bluetooth/bluetooth-next/c/d66abc0fbb27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


