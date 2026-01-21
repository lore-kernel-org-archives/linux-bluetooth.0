Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1233DA7ED;
	Wed, 21 Jan 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032210; cv=none; b=PMEGyyWRigXl9IIl83gd7D+Bg/a0KvY4p2kTPUfiumcROTLvrIBx84TwYGhQ6+Xj7B19sGp8u9nzRdih4XIFRAas47UqB+PJ+pJbFLAUDfq+SB6JNdDtg1U+r/RjDzd2QG6Glz8cyrgc2U/7c5XxnkkL0F9FluXh47pxeVdCqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032210; c=relaxed/simple;
	bh=G8n4t40/jMYP54IJD8VZqKkeu58/fEOhY/RJ8TNMEl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MmwoL4ukQuopCplMt762j1/DYFSuHcS2CUmDgDbNeruAV9fA39rYdFdMcfK5qdEFSpMz9VKm8lztKErHviGsyn3mePHMUEHIASNqrPQcdEutZB058bZQqXayfzrEWd0RPjvMG82prLCmXV0MHJNSSt/DCL4zibifnA8sn+WnT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmd9757O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmd9757O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4896C4CEF1;
	Wed, 21 Jan 2026 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769032209;
	bh=G8n4t40/jMYP54IJD8VZqKkeu58/fEOhY/RJ8TNMEl0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hmd9757OUtpZ3NLeo48+cKutLyGc0nVlZMRmByWcl1Vxj94bIuJYR98vl+aHOCUtX
	 i3RsmjAaphTVsbPQPIHHlRksTfuzPKz5+BxZlHPaBkYVjrZptmi/u/iKVoUAbjJo3q
	 GsxyC550GWkbI+h8zsfENJabgK5+TeB3R/hmZ5eA0fM6mdZElhBuAEk37NvsE0e6A4
	 ujCTodfVmG5xVVnXzTzg8T90PHpnfrXZOsAsNfqqb6a8WC7uDEeoFVwU19RAkPelWL
	 c5RUk/0jgWlCOJNKDq7FbzqiaSNJePAwuo6IY3gs4T8ynAsj4xXVTVxhquMQN2NZXu
	 7j3wUi+GFlXqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CD23808200;
	Wed, 21 Jan 2026 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_uart: fix null-ptr-deref in
 hci_uart_write_work
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176903220634.1456135.14185600440761441438.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 21:50:06 +0000
References: <20260118120859.83680-1-s11242586@gmail.com>
In-Reply-To: <20260118120859.83680-1-s11242586@gmail.com>
To: Jia-Hong Su <s11242586@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 18 Jan 2026 20:08:59 +0800 you wrote:
> hci_uart_set_proto() sets HCI_UART_PROTO_INIT before calling
> hci_uart_register_dev(), which calls proto->open() to initialize
> hu->priv. However, if a TTY write wakeup occurs during this window,
> hci_uart_tx_wakeup() may schedule write_work before hu->priv is
> initialized, leading to a NULL pointer dereference in
> hci_uart_write_work() when proto->dequeue() accesses hu->priv.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work
    https://git.kernel.org/bluetooth/bluetooth-next/c/1d8551ecf806

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


