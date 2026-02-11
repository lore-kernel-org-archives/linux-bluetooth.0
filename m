Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A54356A2A;
	Wed, 11 Feb 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838815; cv=none; b=m8YbLUhZW1AzjMJtWUT9HsnIR8zFjAYy95NLGuVRJrltV8zyDCzCjGuJigqej+BXxbOb8ZCbrA0kvekqqvqzPhkQd/YasTiSSVGr7kD5LAfCSo2C0JSQs2+w4PgxJlhNFjSs38paiBkxbSzD1g4SBa1GXhE8L5rZ1mlWffGQt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838815; c=relaxed/simple;
	bh=PWur7uL4N7a7ELfHOH7WsEqTpF8FtMWr3QSD94+Xv+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dlYigW41lTJMt6DuZCT69gpyfcL+ZHcWkhfreYO8tWaNdYeEMN2mbkf0MikFNrdP64irvOZ4D+JUnkxbsp+d4A9U+nuZ8+ZD01tM7oFrPh1QhYjfxQG0HQJ2tFG7C7dL7lyLOXRKZLx8N7LwKXmdiolgCjoJZCqwafQ8KFMPG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uG634CiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG634CiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F7BC4CEF7;
	Wed, 11 Feb 2026 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770838814;
	bh=PWur7uL4N7a7ELfHOH7WsEqTpF8FtMWr3QSD94+Xv+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uG634CiO7qluuOW1wOjlBQOoG5mkj58FiYGnNByoVKXucYq50U93xEMrHZbjFf+0i
	 9Z47IJcHJ0FyI5ejl0nGX8MDqfMJt5NWHAxkY64TbNpbGmM8+V1ESKLyQWGY5JiniX
	 PLyEzrQyiAKTuE0/gtcYAzSSgSZ4mDsU7VZ7lskKHt2TIrpm1Z1+aX34z/Q5sp/Mwa
	 CKzSFDcf+IkRBcT4ngb2DuuyowF7IDSFot6xsEMdb0fSHO6p+FoBNSWqPKHgBOO2rK
	 w6T1l+UqOyZQikYyksyokypJI7+r5xAm1HiTcSFv6zpjmdd8KjGUbFCRTubYfYLoYS
	 avQ+PS5mDlZbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22C139EF964;
	Wed, 11 Feb 2026 19:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/3] Trigger reset if firmware status is abnormal when
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177083880957.688115.17676708288116358310.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 19:40:09 +0000
References: <20260203062510.848761-1-chris.lu@mediatek.com>
In-Reply-To: <20260203062510.848761-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 3 Feb 2026 14:25:07 +0800 you wrote:
> When the device unexpectedly restarts during previous firmware
> download process, it can cause mt79xx firmware status to be
> abnormal in the next attempt. In this case, a reset should be
> performed to ensure everything starts afresh.
> 
> These changes include:
> 1. Optimizing the handling after the download function retry
>    is exhausted, a reset should be performed.
> 2. Another download firmware command also needs to check status
>    , and if an unexpected status occurs, trigger a reset.
> 3. Adding a flag "BTMTK_FIRMWARE_DL_RETRY": if download firmware
>    process enters the reset mechanism, this flag will be set.
>    After a successful setup, the flag will be cleared.
>    If the flag is already set, no further reset attempts will be
>    made to avoid endless reset retries.
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Bluetooth: btmtk: improve mt79xx firmware setup retry flow
    https://git.kernel.org/bluetooth/bluetooth-next/c/9cc9fc9bff32
  - [v1,2/3] Bluetooth: btmtk: add status check in mt79xx firmware setup
    https://git.kernel.org/bluetooth/bluetooth-next/c/458b6d8b0108
  - [v1,3/3] Bluetooth: btmtk: Add reset mechanism if downloading firmware failed
    https://git.kernel.org/bluetooth/bluetooth-next/c/73130272a121

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


