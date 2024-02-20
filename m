Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B14133987
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456229; cv=none; b=ezBXXMNU2NLcN0DAgPUg2i9WELZmk3U/KbqgHeKCQ83Xw4XzfUoHyV/QsNSC/vERO0+mkCYdyjmVC2HPAMTW6WA93cvKcbgDgDnt6+a/uKzlh3nOsqIK3YOi6v44IhKkMOtS/Unnbh8lUfiDBFUZFI9Opt71K2HnKhrJM85TYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456229; c=relaxed/simple;
	bh=Lj8Nd7/5NKbDeX0Z7ph8vfB502/6NtRLCxBw64giC1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZFkgiGNhjIeGx7wt2b88IAXvScIkzwfz3tv369HTbU/LnWm0eTQWqnwm2hoJNo3nVsB25GHSb3a0O0kZDmUAsPJWOR/WVX1gAoEuaIcNRraAs/D8rKzOHELFa+/lkFesUVyM6Rvcb7p6ze4oKtYTsHpnoGyjgT54oRxORVJlK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISPAyA+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISPAyA+D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A817C433B1;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456229;
	bh=Lj8Nd7/5NKbDeX0Z7ph8vfB502/6NtRLCxBw64giC1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ISPAyA+DT0F89XvNil+Z1kAJtKRLCDhF9O98DcK3dpifYQCjQs7fKOrAz004AXsA6
	 /yxw4W7kgV5Tf6tbswjvwDoSTT5AWsFf33vEdqptko8o6F9L+h4DqHjzB/twpSxuJD
	 Cz68opDkqUXB4c/C2IGCAaq2F2XlKIVM8Uyb0olGIwEvourau7zQcUShZ8qzzPr1TV
	 KmWMOItU2L7q7lU4cAmO3YIapSk7qPRVLmZux/dxq7CvTuuzIvLVpevZqZIv/E9yCl
	 jh6FdKezXyUKKm3mP1pUDxBps+vWsAt68iDv4fNoY4S5OZNGYa23GWnGX3WIambIL9
	 ef+RME/mABOog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 591DDD84BC6;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix UAF on create_le_conn_complete
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170845622936.2554.13668052389155897936.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 19:10:29 +0000
References: <20240220181319.368485-1-luiz.dentz@gmail.com>
In-Reply-To: <20240220181319.368485-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Feb 2024 13:13:19 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> While waiting for hci_dev_lock the hci_conn object may be cleanup
> causing the following trace:
> 
> BUG: KASAN: slab-use-after-free in hci_connect_le_scan_cleanup+0x29/0x350
> Read of size 8 at addr ffff888001a50a30 by task kworker/u3:1/111
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix UAF on create_le_conn_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/25956d989c60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


