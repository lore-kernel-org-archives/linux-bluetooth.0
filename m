Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECD154B2;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0QB0ltS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92583C433CC;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704217253;
	bh=hIKLK513drqMsvsvs2EsWCsy0zymjXiuIdly14WrxVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F0QB0ltSnzwGOU5fzElDwqUgt7Chkp6DePXAd8bOh8OpEWwoQNEbvTxMei6KRcBwl
	 5CyAdJ7dfYTF4tSy7Nezku+zEv+qMuG+X6mtQaQ10yVLwPdjc2F8ebBPwvz0W2FrSI
	 zWCtXkIm51ga6q3NliJFRb/W15lGyr1+WO0eJhGpMb4O5m/T8sN2X6nfcuyLrZkOK4
	 DXG7sftjd5vDgLLR7YWkYaxPt2UjHVvDjPKyitGJPdFivHIaT8CrM0lSEgteLmOTYj
	 J2cXpnQ0vUe9w1RvYegfj9OxfjQaGVG8F4EMl1s6R+qHxCx0ZdklwfUYzD6xF44FO6
	 GfgU+yP/sd6Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77C6EC395F8;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btnxpuart: Resolve TX timeout error in power
 save stress test
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170421725348.27590.16958999714015183552.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 17:40:53 +0000
References: <20231227132927.3938396-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20231227132927.3938396-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 amitkumar.karwar@nxp.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, sherry.sun@nxp.com, rohit.fule@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Dec 2023 18:59:27 +0530 you wrote:
> This fixes the tx timeout issue seen while running a stress test on
> btnxpuart for couple of hours, such that the interval between two HCI
> commands coincide with the power save timeout value of 2 seconds.
> 
> Test procedure using bash script:
> <load btnxpuart.ko>
> hciconfig hci0 up
> //Enable Power Save feature
> hcitool -i hci0 cmd 3f 23 02 00 00
> while (true)
> do
>     hciconfig hci0 leadv
>     sleep 2
>     hciconfig hci0 noleadv
>     sleep 2
> done
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
    https://git.kernel.org/bluetooth/bluetooth-next/c/c7ee0bc8db32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


