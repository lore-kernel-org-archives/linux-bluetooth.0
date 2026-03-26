Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B553FBEBF;
	Thu, 26 Mar 2026 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561220; cv=none; b=F+Z8Equ9FKTFv9Rf81krT9YT/0V3xpC6zFaqXsvk/IwRTOEfjxIWoGL3lZ02kFqtlm8Yy0gAyV84JznD3IUa8Ip3QkIXqxP1ux9LFYxJmm7NbjWXUzTYgjYQ0VT6WPQyhMvjXitNZONLbiA74rO6RkHzQHdczIY7WXH4Av/AeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561220; c=relaxed/simple;
	bh=CbxAd6TYhT3hwZAmaE1vDTQPpzcjprgHBELD1oBFdv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XBcINFG/GdsEAXC48klFXzi+cnGaIN1PzeNUH6X41M9PM5JB1R1271tdusBhAAnTOgAfn3BZPFA4JAuTIRaqT4EStyIe0lLDUQiQkUjor4PG3xbt7Xcrbjril4HMp6vg6Bg+0xQXEVOD7Tj7SCMRrvVcaZJoCggkGupHJr2cCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4UskdpQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4UskdpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52577C116C6;
	Thu, 26 Mar 2026 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774561219;
	bh=CbxAd6TYhT3hwZAmaE1vDTQPpzcjprgHBELD1oBFdv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B4UskdpQE+CSZrk0Vdun72MYWjYMt8FUrooe5WnJGRc75z5SjeAJNmx3VyVvelQbX
	 4C5SQJc3Qnq9kutjnMQWGMxwDBErR0hPi8GNriChR8oDeu7kKoUahNlLEDTTJHzGqB
	 G6nwpMf10bt+e7NZEGbkZnNLw3CfKKLVAbQjx1z5yPoCw2PO7ZrxFhRW4GpmRbK1rp
	 7oM3Nd8f96uN0MP7QWzFRa+7TBIgVSzKQ8OjnzP287XUI0H9t0uEH9QmM3rxBSexC6
	 aRMk2IYHfP93tvLSq7KttbNgzi2yaOIcD+yIGnRN4yddO9s+JXD2MHWp2L6Z3vhLfG
	 bmYqAjVVrykBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D0F39F280C;
	Thu, 26 Mar 2026 21:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177456120578.3188441.11832842708918344410.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 21:40:05 +0000
References: <09ff4368485242cdb6bc707082fccc4d.security@1.0.0.127.in-addr.arpa>
In-Reply-To: 
 <09ff4368485242cdb6bc707082fccc4d.security@1.0.0.127.in-addr.arpa>
To: Oleh Konko <security@1seal.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Mar 2026 17:31:24 +0000 you wrote:
> hci_store_wake_reason() is called from hci_event_packet() immediately
> after stripping the HCI event header but before hci_event_func()
> enforces the per-event minimum payload length from hci_ev_table.
> This means a short HCI event frame can reach bacpy() before any bounds
> check runs.
> 
> Rather than duplicating skb parsing and per-event length checks inside
> hci_store_wake_reason(), move wake-address storage into the individual
> event handlers after their existing event-length validation has
> succeeded. Convert hci_store_wake_reason() into a small helper that only
> stores an already-validated bdaddr while the caller holds hci_dev_lock().
> Use the same helper after hci_event_func() with a NULL address to
> preserve the existing unexpected-wake fallback semantics when no
> validated event handler records a wake address.
> 
> [...]

Here is the summary with links:
  - [v6] Bluetooth: hci_event: move wake reason storage into validated event handlers
    https://git.kernel.org/bluetooth/bluetooth-next/c/3e7e7f4bdbe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


