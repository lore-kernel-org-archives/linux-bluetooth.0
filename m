Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B371AED33;
	Thu, 15 Aug 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737639; cv=none; b=So+82Tw5s01PZruaTTgj/rTIkMHRqIfNggMjMFIdVwjFoWEPa8lPp7/38MLW4Aqud2vvz04lSC9UNSkwxB3IIAB2IPUH/uxk0mTEwTXQ5zAhNNvCTp0DSLcjOlDTYChW1GeW1DUAV+qCdRUjAW2Gk1GgHVHCJ0Z5qAbofg/feb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737639; c=relaxed/simple;
	bh=YHgPWP8dpnjnfVNPtVOHCUwL+uybt9EvSIWd/SOg4mk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e1v979TCzSvov0PESqmUOATHEs5mW7SvWw80XGgjNiYvDbHTREpIM0B6fX3QdRk5aoJcPCDe0qlAzTA0u6ibULyiPmU1fQU+YUWtAaN64yZH9Hau9pwN4UPYzYQDqDC+7H0tK+FxzJrc5fKgMv+zSwf+BdkNGM6f/YTPj6YrpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcADpc/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcADpc/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB31C4AF0D;
	Thu, 15 Aug 2024 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737638;
	bh=YHgPWP8dpnjnfVNPtVOHCUwL+uybt9EvSIWd/SOg4mk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NcADpc/xYFX60sDQSpjYjzvxGSial6s/37q/1VXAWo956ISvgx5I8Jh0/fjADwzzR
	 LWSvvbwYL+3TUCVPjWcqnybTMWfcKW44cePke9Mn5AwE5S1MFXtfePaptZ2bR5D8r1
	 Gqdr/DzwW6qrRDt7dORYT+tUc+Qj/+oDPGW442hMZbaCjC1ctwg2HRoX1vUnxmzB7h
	 vSiIhUOpMq4LZCcI64IA24uMXDU3nItKXKXPUn/pCsXGDLsChijf414q2kcocfAt3B
	 UdNJy36b+3ijFUiBiciU52zgqZv0sxOnMB3W1ZbW5LrbpOD7xb0RpwxXcpYrsLZfLJ
	 8ondNNfA/eCwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC70F382327A;
	Thu, 15 Aug 2024 16:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: Add error handling to pair_device()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172373763768.2896787.3048999912671661675.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 16:00:37 +0000
References: <20240815115100.13100-1-griffin@kroah.com>
In-Reply-To: <20240815115100.13100-1-griffin@kroah.com>
To: Griffin Kroah-Hartman <griffin@kroah.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhan4630@purdue.edu, stable@kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Aug 2024 13:51:00 +0200 you wrote:
> hci_conn_params_add() never checks for a NULL value and could lead to a NULL
> pointer dereference causing a crash.
> 
> Fixed by adding error handling in the function.
> 
> Reported-by: Yiwei Zhang <zhan4630@purdue.edu>
> Cc: Stable <stable@kernel.org>
> Fixes: 5157b8a503fa ("Bluetooth: Fix initializing conn_params in scan phase")
> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Add error handling to pair_device()
    https://git.kernel.org/bluetooth/bluetooth-next/c/f2ed8d6d8aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


