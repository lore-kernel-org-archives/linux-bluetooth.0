Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63327700A
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329201; cv=none; b=SGVYt5IoviQi1Wb0m0s+AlARbo0ATRnTwAcdHl2itQujcKIyB1YayozMayozz3TQ+M+602wOkdOt8QepYMCrC3oN2HEJruFlS7C2Wsw6i2bmzoZUQJZMcxp/d2qWmDA4G6A3X5dPFIppHNJZZeVwrs34zXEM6NR6/VtzkqOrFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329201; c=relaxed/simple;
	bh=PO9vQWhwXv+5IL6PkPpQLorheFP7U2qnKXwDdGIvfrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H6/EgwXS4gGrKPF5iD547cK31D0Or4517Ew9dMY4xWO40USlQcWHj6mFBfP5Sn1fe3qfbyN7mr6Dr6NkeqjHyoD0vHkNYymBhWI5+0VifjPQVJLGPUEP6Ipda+aJwaBUzH91KK2uXqZNB8mramfG1rdyxt68f2Z8e1wGer51axM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMViEnPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMViEnPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEFAC4CEE9;
	Tue, 22 Apr 2025 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745329199;
	bh=PO9vQWhwXv+5IL6PkPpQLorheFP7U2qnKXwDdGIvfrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lMViEnPx0TqCA0xeoFHv/SVgb+FiyZU12GDzSYPKa1LEG/u0aKGdgZGamnwFAIG6o
	 B5RGZsZxVoSz9hbF/wIjQ5iYvJo/eL3CfYUPaaJXuy8bh8tgzggbEHQwcx/IYWtPyu
	 /awfZvSoEIbSrHYT/xJBFhly6N80TnSFl43uDKm3jpm5ohLfghH1JrpScv2g7oUA8I
	 xpZLkSPvCPlYHeIOYCzQKpBbNRQ5TSSZawGw/21d2x9P0hYXcMJGPOoz2QXT7SdRIv
	 ErzMosNNSyb/sEEc15H2EFsc2jlQlD6VDjw5FKxHxIskPZM2KxEkSVNPPcnbr1O1/Z
	 aPaZuRe0ELqrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341D3380CEF4;
	Tue, 22 Apr 2025 13:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] btmon: Decode Broadcast Name
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174532923802.1911785.9439654680693948349.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 13:40:38 +0000
References: <20250421210602.746957-1-luiz.dentz@gmail.com>
In-Reply-To: <20250421210602.746957-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Apr 2025 17:06:01 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for decoding Broadcast Name:
> 
> > HCI Event: LE Meta Event (0x3e) plen 57
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x0000
>             Props: 0x0000
>             Data status: Complete
>           Address type: Random (0x01)
>           Address: XX:XX:XX:XX:XX:XX (Non-Resolvable)
>           Primary PHY: LE 1M
>           Secondary PHY: LE 2M
>           SID: 0x02
>           TX power: 127 dBm
>           RSSI: -67 dBm (0xbd)
>           Periodic advertising interval: 180.00 msec (0x0090)
>           Direct address type: Public (0x00)
>           Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>           Data length: 0x1f
>         06 16 52 18 2f 92 f3 05 16 56 18 04 00 11 30 4c  ..R./....V....0L
>         75 69 7a 27 73 20 53 32 33 20 55 6c 74 72 61     uiz's S23 Ultra
>         Service Data: Broadcast Audio Announcement (0x1852)
>         Broadcast ID: 15962671 (0xf3922f)
>         Service Data: Public Broadcast Announcement (0x1856)
>           Data[2]: 0400
>         Broadcast Name: Luiz's S23 Ultra
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] btmon: Decode Broadcast Name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=99deeea86f15
  - [BlueZ,v1,2/2] eir: Use Broadcast Name as Device.Name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e4c1d03ef73c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


