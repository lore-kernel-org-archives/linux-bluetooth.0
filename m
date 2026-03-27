Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5437BE63;
	Fri, 27 Mar 2026 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639220; cv=none; b=btBDfzp4hvuVK3Dt5TW1kyuJMgyvrLMbWqJYYhk8/9wMZMIYUcYV4NNKNwn3od5gdbNOHu39iBJW5OuxUIYcnEf2eqI86/Tk+ZHnxUuMrmecFnQhzIDOcpoSGr7+T3gIQkrMuElqPDUUINi1cbj+VEpPVfAs+BRu9JocvWnLy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639220; c=relaxed/simple;
	bh=Yk4jb5zrTzB7hBTr0+e8dQsQd+Ej+ciw7EqUcQ+HyIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldIGVvHWMiU3IRHwku3r903h65oEuhtxKezrAEIAagM26fWmLHKwzrW3mxFHTrnwFy+cZWwnXQdO+vczEmyNfkk7pMor28fopN4OHp62pv54vihJH6zQHhvrRV4eX4lc0t2vaDuIBywRMqCIvVUfMtWL3j2Hdas+ldqv/9MA7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZk+KGev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZk+KGev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D99C19423;
	Fri, 27 Mar 2026 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774639220;
	bh=Yk4jb5zrTzB7hBTr0+e8dQsQd+Ej+ciw7EqUcQ+HyIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FZk+KGevu/IcgBDFzr9Goy/TGXIiP7gkfgnjG4am/VBrRyJPCduBABqJDQRvNXWZP
	 0jFwczMSx0Pms3KWAnHwmdRXvp72MEoEYBtGB3WwT1YWjoeAdVkxGzlqj4fdaUFT3U
	 CmTXO1hAzGOoOg2BAj1nNpoTtC8aJ2O9MPzVLLelbFxhyzsZeD0r6siMDp+gFR1XoW
	 03NzkuQpZB66ucNrx+OuIoI/hHi0dqDI1GMHijmZmre2pxk5Uanidu0LvpIgZWKHhJ
	 QY/nYLJnVAeDqYLYFk2HCFvxWsnsJ5XqYhudJAA/CthBt5nlq5aXhM/36E5mfvLLH2
	 jJeYmNtpvToaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD0F3806922;
	Fri, 27 Mar 2026 19:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_h4: Fix race during initialization
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177463920628.3624781.7173872994222783225.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 19:20:06 +0000
References: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
In-Reply-To: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
To: Jonathan Rissanen <jonathan.rissanen@axis.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@axis.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Mar 2026 13:09:49 +0100 you wrote:
> Commit 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during
> initialization") fixed a race for hci commands sent during initialization.
> However, there is still a race that happens if an hci event from one of
> these commands is received before HCI_UART_REGISTERED has been set at
> the end of hci_uart_register_dev(). The event will be ignored which
> causes the command to fail with a timeout in the log:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_h4: Fix race during initialization
    https://git.kernel.org/bluetooth/bluetooth-next/c/42ee54fcd11e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


