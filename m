Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D551E0B9C;
	Mon,  3 Feb 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618813; cv=none; b=i0J+Z2SHwY35RRTnM/LaxcIrDFCF5Iio4Uxy5JLKpWrzpODoRIV8328ZPya/BqJkp9/jW5Zy0MABKAMPkN8m/BPIY3LM68RTDNYTD9XgL/X24+XT1BZ1bZObJqtt7IWQ5RMIlgDHZQeLFRi88OH/7E+20Dw2iXpUtfW1K7zZpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618813; c=relaxed/simple;
	bh=Q8oevkDV9v1Kv2lz64f1recfyAtDwFniJXyxBX5Ny0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MLQ3/V1iPLgzrlVn16KkIrzXyWEgZ5vYhU3vVZ2p4pULCCQCL03u2/toEtZoZJSA0GApZUNxa7y/D4XMeIuJiq1f/bRWIDzI9S59iwCX4or9AFkA84KNyPkzJSnPV+Q/z/w/YM0oZ+pymB8z0u2Dp73oYJ48SKgl33DXYCvPH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1/76JBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1/76JBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3241AC4CED2;
	Mon,  3 Feb 2025 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738618813;
	bh=Q8oevkDV9v1Kv2lz64f1recfyAtDwFniJXyxBX5Ny0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a1/76JBHmYAI2oyn0uF3hQ7IJA755OrwAHNqJIrYsQEaxw4VyC8Ws1r/J2vdPsSlC
	 TJ9KcK4UqNlwzpVOaMFBzKEACARYftz1nlFEDHFtklRbAbOJvNbOXZYJ89a6KefCBX
	 y86WKKyUCl4Rn5SovW4L2XeRV3FFa+iknsbB+I6u2nDks8Y9Dx5oRA5xSz7ucdtxpa
	 XmKDVRlLXFxZ3s/52MLWqIsfPUCyndfAvsNm/lBGySPRohE4Pn+w0zZSN+m7jDnmHf
	 giFngmvPUJJ98MPNQTFDlYa36shsWulLrxTj/R/yTcFoNHp8KFIXRcC9w9LCcsUKdV
	 KDiQiVQEmD6gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712DB380AA67;
	Mon,  3 Feb 2025 21:40:41 +0000 (UTC)
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
 <173861884028.3508836.1017363008098820182.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 21:40:40 +0000
References: <3674b7a9-109e-19d7-4db8-02e9a724c314@salutedevices.com>
In-Reply-To: <3674b7a9-109e-19d7-4db8-02e9a724c314@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, oxffffaa@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jan 2025 21:43:26 +0300 you wrote:
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


