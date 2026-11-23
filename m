Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461018;
	b=VGJK6t0fon0Nv0SzCmRPiM7xtUIHhgNXECLVypdo7nnpCPNrIYmAXbug3e4AALO77G6i
	 n7oUaBuAAoxYC1LjhJKc0pSdPZYP2pphmKvJWxV4Oifr+KnG7Rlh2z02Bf631Bi2w//XN
	 Kaqd7gawgsB5WREPq4gVqSN8PPymNhfOtBp1Kvlsi97TATJ5CPne6L5dIQA7Q/s2H17HH
	 S8+dermLx0ALf0MuFGdISac5rrrgKt5LW2OQy+e05fezpj0/TdOoBJpOjE2RUokGWA6bN
	 w3SiiTaiBgp9/sltoWejHdTIbIQwP0O18tVdvOtf0UDoyEeh3zc74s2JM7gXj///YeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461018;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Nepj6OZIQFgiAcB/vtysOtkJ6s1V+rikt1Oa0XdQa94=;
	b=OgBIfTNu7LYmBfmsReVDE2uzpM/nVOOLiZZs3l4lhKxDEl2PovGUd4GL3OJcJq4ZJnal
	 xwoUluq5oIdcyKBxT42Qbzw9ycPWOhg2r3l/Czy4WbUBmuWBP6Mbv9ft93lIwr0g6Zar+
	 o2oMHKuI1rr/7ouFTuVt5X2uq27Gx8ix9jtpFxWEm1OHhXG3H5wh6XLWHlOBsbWkgPnJC
	 oLU5YI/JWhsrgmBwTQdaGBcE3ZoiOaL98/javwrCENlao8vg5Qo61wV+zWxEsDzzfqVRj
	 nmfIy5d6c3rdgPRKhEFvnPYHinuKNiEAfV5cxnBSRqDXI8LmcQHGT4Wnxn7SysRCCMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEEuffKV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7D606A32A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEEuffKV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A681F0093C;
	Mon, 23 Nov 2026 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461018;
	bh=Nepj6OZIQFgiAcB/vtysOtkJ6s1V+rikt1Oa0XdQa94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bEEuffKVlLrGKFTb+v9RY4mr68YkEaNeE9w4hRCTWZjxuBQsUlgLh9/9HaNekHBar
	 H/N+36otORW/xXbzlrS59ZAqeI4f43LI5hd11xGfosEYUG8FRSDSp5R4lb7Tz/zuHQ
	 FDGHDtzBc08Naaisyb8YpFzducjOK3E+4f7xdH5aQ5Vcjt8y3Kf+51mLw+wI/5Is45
	 az8tS4o1E8n6eeV1YRnLfyOpIzP9IxZfxxrterNlhqY42r1l7ZtcwTJ9FfSHIoR+v1
	 8QW2WrUgxUuA2lcA2bVXf3WqKQOkTjePYmzEatIeAp/Ee6+bON+IEhaJ1k6nk3QxPh
	 5w0T13IlJHjRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2F0392EE35;
	Mon, 23 Nov 2026 19:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: Terminate PA sync transferred while
 not
 pending
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546101676.3063022.14593586282489977003.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:16 +0000
References: <20261122201320.2851760-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122201320.2851760-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 21:13:19 +0100 you wrote:
> hci_le_past_params_sync() sets the PAST parameters of the ACL connection
> so the controller synchronizes to the PA train transferred by the peer,
> but nothing resets them once the PA sync has completed, so a later
> transfer from the same peer is synchronized to as well.
> 
> HCI_LE_Periodic_Advertising_Sync_Transfer_Received is then received
> with no connection having HCI_CONN_CREATE_PA_SYNC set and is only
> logged, leaving the sync established in the controller, using its
> resources, without the host knowing about it. Terminate it instead.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Terminate PA sync transferred while not pending
    https://git.kernel.org/bluetooth/bluetooth-next/c/5e831a19ea74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


