Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFA2C0F81
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255629; cv=none; b=l2xClqHrBbHDwNDcnaCLF5Dq8SmsCFryS9CTQG7qet91YHj/qOYudvEaUKOtA0voqgsOy3IKfLhFMA5obvQSoohL2BfKWkgFSDXdxpYBmPWiqLEtzOFiNwsOJNtMWSDthvMV56j2gS22T01dK2SaCYnFtR8rmByxhZ6cBIGHVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255629; c=relaxed/simple;
	bh=BW8l9vtekbrq+WsUXy6TeCseEek7wsxZmkJMLOf/Dnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kDls2gGh6YQyATlDI1Sn8TilMwUbQrb0/r+X38J3HYVqw500vqQry8o87WtQBoBzadKfh9urSmx6PGhakr2prjkz4TSMprUsY+mFSYF2M18BhKv8XU0LHSr1d4ZJHiXifjxkGrKPcSOsrGo/32KmKY+rLyLzYCVk/g+gjbAYgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8l+w1mI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8l+w1mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB39C113D0;
	Thu, 23 Oct 2025 21:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761255629;
	bh=BW8l9vtekbrq+WsUXy6TeCseEek7wsxZmkJMLOf/Dnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q8l+w1mII8uNDTsLnuIhXGfuK8ymcGlsMOjqAJVF2Lqog+e/Qh0mNlNSgJiqQZJZK
	 9OCdpLAOON1OCJeO6O1pf62uV3q8E92o31ojL7xC0cLS8Ml1AQSk7Rsu1hb6ZfSjH+
	 IqRuOGuvYQymrHBgQVKmHD2gqYkuaUn9U0R3eLZ3rELCPa3//Fpw/XF8T6ywYCuMTK
	 +rKZ1N3IxDz/qHS6UzxjMH4+bVV6PDn2KC6bMnHy7lKHX1lsNt927zmQ2VBglIqx6G
	 lA/eMmtmbN+SH6+TXFd1VTGb4HTgGBYiha8JAF2g3i2o2MF3lsa/I3k59MURhNvr+o
	 CalUvsYQPTX+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE17380A960;
	Thu, 23 Oct 2025 21:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_conn: Fix connection cleanup with BIG
 with
 2 or more BIS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176125560974.3260295.12869326879844121323.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 21:40:09 +0000
References: <20251022202941.1537413-1-luiz.dentz@gmail.com>
In-Reply-To: <20251022202941.1537413-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Oct 2025 16:29:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes bis_cleanup not considering connections in BT_OPEN state
> before attempting to remove the BIG causing the following error:
> 
> btproxy[20110]: < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a) plen 2
>         BIG Handle: 0x01
>         Reason: Connection Terminated By Local Host (0x16)
> > HCI Event: Command Status (0x0f) plen 4
>       LE Terminate Broadcast Isochronous Group (0x08|0x006a) ncmd 1
>         Status: Unknown Advertising Identifier (0x42)
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_conn: Fix connection cleanup with BIG with 2 or more BIS
    https://git.kernel.org/bluetooth/bluetooth-next/c/990c0549b5f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


