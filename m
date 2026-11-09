Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240009;
	b=at0Oey3HS8HRUo8f5JsecoRkc22tvFEw6y0ke5vzh3+fJK1BhBoGKnWM2SLX/LQH9A3h
	 IVmcfTMnq5odUvH0ATeqshOKXuvWjE/PUWCfdstTJI2pNwcemGrxuiuklXXxjuP/9XSsM
	 jzJeRctAyckUQrkWuzgxCHm0trYQEeWqSP+UqutYl81I6UzIqu7NCfLeTxY2cZVsE8ZDr
	 42Ec1QFw5x59qyMtGAuy9DyTvG/p6PlwXNr84WSlapTypxzkoy56BejjsFeQRbNooxesS
	 RHz9FvMEa/vejwvIttAnibm4QJCn3+Mu4CCuY4/ASFw0h7GVL/fZRY3iCT1/NiMzjzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xNRqjObeTp/7I6It829IcrazYn0krY0ldw7Pv0J8uis=;
	b=wNMAf1NGr9CBw6aDY3GVRT3SUAfC35th1dZzf//sh65Hoceqr4+GwPla9ynd6n8ktZBu
	 Eo5bZWAoSAWSTiFEPBZgjezKveUjInsmeFVW08YHKEQgMxXJOp/cvyXT3qyKD/ybevPxo
	 HZ40Seecbu+pDElsjSrzZVnqL6VfH8S9hyqr1VC0IqNSIld4xYvY16Gti5w08mWX9IYwH
	 cS1mwL7yP9YbMdKog2N1/IYeLMI6YknXnsFVDHPudOxshYFWMorVnAKiHc+A5+MTx/0xf
	 ppRDXLxDoT3gZXs4EiSNApFkB9P9duK6GRLsWQvRo9SvmKEB6yds4s5Hxzb4AKGmBBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmkIBnEt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6FE608360B;
	Mon,  9 Nov 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmkIBnEt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96D51F0089F;
	Mon,  9 Nov 2026 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240008;
	bh=xNRqjObeTp/7I6It829IcrazYn0krY0ldw7Pv0J8uis=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EmkIBnEtPmN6EZlZAKHCQH0YJ+c8zy7rgvPBbi1ARu814PcUS3NdAAzJAHPmgK0wn
	 HCrCiNxxm9+VVOGwAPJmOxEPQTky9SPmtcH3vNgvj9y4gPwYE89mkFVv0Z4qyV4x0S
	 ObcOHm0Wfw2rVnlF+4v43ZHbSQh0hQZQE0Txef41gm76BT1BY9bXJtE8m1b/1qHbLC
	 fFKuBWKDlqiHhXx4mrSXL1bT6QPJW3+YJnBQpbxhdB9Xq5TxzWVOPPh+akYbzvIScN
	 yAKJCxeYbj2sGxPEVOw1A3bz8dsNVu9q2ufOmGUZ1qvoMMY0W5EGDC/lmWK8nzuBAD
	 AQZgSKhaNwW3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B23D3805CCC;
	Mon,  9 Nov 2026 16:00:08 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: qca: Disable SoC debug logging for WCN3990
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179424000705.3335769.610567076772554344.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 16:00:07 +0000
References: <20261108000449.2664455-1-hex@freenixos.com>
In-Reply-To: <20261108000449.2664455-1-hex@freenixos.com>
To: Hex Lindqvist <hex@freenixos.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  7 Nov 2026 16:04:49 -0800 you wrote:
> Unless the host turns it off, the WCN3990 firmware sends debug logs to
> the host as ACL packets on handle 0x2EDC. hci_qca passes them on as
> diagnostic packets, which the core copies to the monitor socket and then
> frees, so nothing appears in the kernel log. btmon shows them as:
> 
>   = Vendor Diagnostic (len 492)                      [hci0] 0.761331
>           dc 2e e8 01 e4 01 03 00 0a ff 10 04 01 00 55 53
>   = Vendor Diagnostic (len 481)                     [hci0] 11.334015
>           dc 2e dd 01 d9 01 04 00 0a ff 10 04 01 00 51 d3
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: qca: Disable SoC debug logging for WCN3990
    https://git.kernel.org/bluetooth/bluetooth-next/c/530e411a49f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


