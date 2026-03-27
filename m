Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19082C08C4;
	Fri, 27 Mar 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639219; cv=none; b=hOUqpnVJLYzNlJ+y5aWySzBKgxP5ar+4uAKQtGihG2sXFU/bRham4fjwKcl0gQRXX7yGF0snJ1aKd5Q7fQVj5cztBovR+Jp+ELfXgNpoOwbwrHJ4Sr0F0FcEeg+JJhOvmvc3pip5DFuo2PaSrkuyNBgF5q4mEbo7oIPMTffEcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639219; c=relaxed/simple;
	bh=4TFLwp6qkabmmV4pDdLx0wNE1lowJpMH5Wu6iNc41SU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LM0Gj94jrgesDn8pBgPXg3z5IrWsq2yMF3YfQP0kTPSKiJ1ZvxDDJroSiKWQ6gZLAZDgpTSaHR8hA+ZtsEG7JdQuvvTSk9d7NHLi3IANcfqppMBLmdPYwNhNSpAGy75mBiPbzpadZbaQXC93nnW2Jdp8QSmeXksb8WVA+KMxTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFcaOIgO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFcaOIgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E438C19423;
	Fri, 27 Mar 2026 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774639219;
	bh=4TFLwp6qkabmmV4pDdLx0wNE1lowJpMH5Wu6iNc41SU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RFcaOIgOJRyAGivsTI9Fw0unWzq/quGZoggY0+KGKTxZoYHi3xbR4mGTTHNvdiyy/
	 IRoisOKrXWfiIt+yCeDsq+ueTPiaA8JLNpKA5dZ7hNhX9DQv8Y/uJYHLsoVhhGE2F4
	 8cxVhgGYpPIHvHBUL39EUKwrSdVq/K7DDmgcKxLV5F2SFijSjRLhH/Nt5/W3xSKE65
	 6b1WN3la/NJ7P9cU/NkKP+YWPY45Ho/PX3WeW2D2GAxhsJekQA498PUYVWf+J/YwQ0
	 35MAumVS4dmibzvRCzz5Kksyog0ysc9RmGZK0EOV9qCnmcGAgk4sT472eBooxSUJBt
	 h7tFW0ffqBaeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDDB3806922;
	Fri, 27 Mar 2026 19:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Bluetooth: fix race during h4 bluetooth
 initialization
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177463920504.3624781.2332475292539034639.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 19:20:05 +0000
References: <20260327-hci-init-fix-v3-0-1b54bad4ef0f@axis.com>
In-Reply-To: <20260327-hci-init-fix-v3-0-1b54bad4ef0f@axis.com>
To: Jonathan Rissanen <jonathan.rissanen@axis.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@axis.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Mar 2026 11:47:19 +0100 you wrote:
> Hi,
> 
> This series fixes a race condition that causes hci events to sometimes
> be ignored during h4 initialization.
> 
> The first patch clears the HCI_UART_PROTO_INIT bit if device
> registration fails. This is needed to prevent the second patch from
> introducing a possible null pointer dereference.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error
    https://git.kernel.org/bluetooth/bluetooth-next/c/c6a106ff1913
  - [v3,2/2] Bluetooth: hci_h4: Fix race during initialization
    https://git.kernel.org/bluetooth/bluetooth-next/c/42ee54fcd11e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


