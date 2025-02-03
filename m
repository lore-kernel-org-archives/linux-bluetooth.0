Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01457210187;
	Mon,  3 Feb 2025 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618815; cv=none; b=qv9VycFBDRdZqN8426DWJv/9hrPiqOJZiDd7GU1vmQRdPdXmhm/N4GNh2Y2xGahNUwzaXbRB+Z4iARkClGHQoxGyX/flQ6OVcp4tbhcNZJeb3AU4a4aG8Sh1i/5FHHBsTto0hzIJgrapg7WtdWE7lUbeh02FxrWI8e/gV4Dux3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618815; c=relaxed/simple;
	bh=WJq3XnPJz/jA14AyuJACDWt7VaQ2f0A+QY9EV0Hk05w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QVeb7d3mVICC7vGrvoS7VHc9cJmoZKFgjawaNFYbzh1OrfB6rdR49Uq8v+TdNDGfiUryhvxOD0JAAu4gmELt5FKuTRmHR7/8EGWkgC5NViebJUoIXwysC1c7KtiiYZ2oXlWFuyv9rR4XrNvCqXqIsDb0peVicGgDI4Sn+MUVJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChV0xYgw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChV0xYgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611B5C4CED2;
	Mon,  3 Feb 2025 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738618814;
	bh=WJq3XnPJz/jA14AyuJACDWt7VaQ2f0A+QY9EV0Hk05w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ChV0xYgwsk3IAXDtrvdnrvyO6mc7w8khL0AcaRYEoMP9/5bxFaurNEUe7wAUOa7d3
	 xzbAjbrbzgW6CA+kPPV9ozwJIyPKOpK5dATGKk4yEwjCZKaDi241HNCDGlCLta8Psp
	 eV1bjLK67N8BLB/PKM2EuByzThPxzy862Xuelb2wuTcAgpUeMPPei07TvZzvObi84y
	 e9ySbrkk9jsz4ADQvIUIkXMIwWI8HEmmpPYr0vJwsYVwxetfRNGQM2ajHtpxrF1kLG
	 hTcvoCXPPWFnrr08/rY+4Ac3hedLBedAHLHAgpI6ac2RfecSE+5gIMw9f4uI1BN1Fv
	 vA2BIssVRfxKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED6380AA67;
	Mon,  3 Feb 2025 21:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2] Bluetooth: hci_uart: fix race during initialization
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173861884154.3508836.6443423049193135714.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 21:40:41 +0000
References: <f5ea6c5c-1904-22a4-72f2-d4050878dd26@gmail.com>
In-Reply-To: <f5ea6c5c-1904-22a4-72f2-d4050878dd26@gmail.com>
To: Arseniy Krasnov <oxffffaa@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 1 Feb 2025 19:24:31 +0300 you wrote:
> 'hci_register_dev()' calls power up function, which is executed by
> kworker - 'hci_power_on()'. This function does access to bluetooth chip
> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
> be executed before setting this bit. In that case HCI init logic fails.
> 
> [...]

Here is the summary with links:
  - [RESEND,v2] Bluetooth: hci_uart: fix race during initialization
    https://git.kernel.org/bluetooth/bluetooth-next/c/c411c62cc133

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


