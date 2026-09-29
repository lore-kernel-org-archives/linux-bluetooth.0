Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CD53A394;
	Tue, 29 Sep 2026 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694649; cv=none; b=FOXohjry4ROqoHXbz8O0KG30kaB/dyt7Swnz8PdmHB/9gH37aeDCfqjZ7tEwaj6a4VHFzjznDtpg+7Q96UAjvISwq6zA8pck/aJY5QO6b06WE7ZdEnGno6amTXn7suhsafvrPCTX18j4g9ZbnGKupVcMIrKdTEF8Yhqcrt68BQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694649; c=relaxed/simple;
	bh=KGaZEDzBSrPvLAXZ8ZJuD45jLT75zzI5KhroxQ36amQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VhI3YhHzHHDqFwx46ZBWYVuTRliO6QPhQAgScEw66Qb842qIKmqTAXIbFI3YX8ymzf5flL4l8kG885mAlHUZXuASl9mEsZkRYTGu+zgLk86Yw/K+4QUBOEgBTHaFUHY1WgrQqWHGTTbSmWBF4Wmje7HLCnC5s/sLdsol7CAu8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R69np1/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R69np1/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1C91F00898;
	Tue, 29 Sep 2026 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694613;
	bh=WMwLrw6UsXJttOAo42mNfwX0LV4PQMLTeXxkaHq+pw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R69np1/FlrfpEMkO9D9dXY0+bU1LkKi2PFtm0NiWG2sN5/RU8iVEWJInyj9F70KCj
	 zPT8gh3X2Gn1eAuJ6qb5fZNEX1MaCGdaC47rM/XFCa3v6IZ/IY47rU7Am7UkELl4BW
	 UtqRuhP/3cJOWIhR7ljEur8Fa0x1BuCoPJ2DtMZ1y3hP+C4nRxWWUS4p9GvhtSqHNK
	 133ixDJmseu+12H1mY3J5PJRhF/zpQVWWq+8agqz0cf1Ag5NxYbY4qjyNXmAbKJ7LM
	 cCtEYmAp/xF5H0QmHP/+TS0yiuaQVTgUgMmmpBiWDMzmw17Uw6AY2JNrEzWIJXMrRj
	 EaFBNbzh/R2+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773523927049;
	Tue, 29 Sep 2026 15:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/4] Bluetooth: btintel_pcie: fix D-state transitions
 and
 PM flows
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069461202.983246.15242898200206126696.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:12 +0000
References: <20260928171003.2925480-1-ravindra@intel.com>
In-Reply-To: <20260928171003.2925480-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, lsa.uz@pm.me, pmenzel@molgen.mpg.de,
 marcel@holtmann.org, luiz.dentz@gmail.com, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Sep 2026 22:39:59 +0530 you wrote:
> This series fixes the suspend/resume path of btintel_pcie.
> 
> Patch 1 refreshes the boot-stage register before the fallback state check.
> Patch 2 distinguishes S0ix from S3/S4 and routes thaw through a normal D0
> transition. Patch 3 verifies the state after GP0 and completes any missing
> RX or mailbox setup. It also serializes the alive-context claim between the
> GP0 handler and the PM fallback so only one path reinitializes the RX ring.
> Patch 4 clears the GP0 cause with a direct W1C write.
> 
> [...]

Here is the summary with links:
  - [v6,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
    https://git.kernel.org/bluetooth/bluetooth-next/c/20dfccf8d854
  - [v6,2/4] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
    https://git.kernel.org/bluetooth/bluetooth-next/c/79463c0de429
  - [v6,3/4] Bluetooth: btintel_pcie: verify and serialize D-state transitions
    https://git.kernel.org/bluetooth/bluetooth-next/c/7ec2ab118e34
  - [v6,4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
    https://git.kernel.org/bluetooth/bluetooth-next/c/6091d2771395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


