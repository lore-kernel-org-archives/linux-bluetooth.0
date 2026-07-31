Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55D43CEDD
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512443; cv=none; b=GcvOIwoUhtvcIkFNQrFkPABryycO0jTlq979DWdtCv4QgOMHC2lkUtXkiiWVZjKXfrrjWI2+5kRr8W3UQIr4uu+gsklF5qk7UoqLsiX7hRq+CKuj3DUBLgMgUBxLxAYOvGL5ON2cQJqmEIcCylQCxErhIIvEiZoNYb4uSSZjLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512443; c=relaxed/simple;
	bh=Y3m7MbZKF+1pTQV+WZe9WZgvNzqyMgSQ+BOelm82r6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TGUmv93J+aDnVkDPjAIBW/O08mdkBJbbpogpbaaL0JXYsDOY4m02Yfj8H7P2W9s+77j418nJULXupbj3cSv7IfGGV1jKZr03AR63M8gEiLi3TBfZQ3b2UFu00T1cEw1nhx4UNTsjgDQEPuYZdnqp7BcBNQ74Y9HIENVIj5Y2mAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz80Iqng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz80Iqng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5DF1F000E9;
	Fri, 31 Jul 2026 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512442;
	bh=lhNAC+gMf/HqngQnN+Z6iWI3XcnyJukcnkDT17UZGXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bz80Iqng+s7/S920g0L0uEByHuA68QEW0yiGHUEKXReHi+XC/Mjz7gx1XKpDUrW1B
	 XRZrCPlovCwoS796gOsGUWNHpKXs0p0mPpeeGBqM4fi9oQ8I7vtt4+vQF0dCfEh7Me
	 diLwwj0s6ArSQLwlsdnvMH/q9f/yAbBkQjcyCe57ENO0z/PwPvZ55WwJJbsxJow3tu
	 fkesX3uZwQGPYMZO3mVfM3MzpmYTjhMU6vvSJ0TU5J8GqtBagq+bC4m7Gw2ZFUbOL2
	 l/UUDPVApmXzsiPIsiX3WgI6sEmeSlO/nyQTrsQp1713dILa6Exy9lygovRj4vCoxP
	 9AFMFo6Jw8lpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93909392638F;
	Fri, 31 Jul 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btintel: Add Bluetooth SAR revision 2
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178551240514.358291.14957385574860905765.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 15:40:05 +0000
References: <20260723011332.301536-1-kiran.k@intel.com>
In-Reply-To: <20260723011332.301536-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 ravindra@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Jul 2026 06:43:32 +0530 you wrote:
> BRDS revision 2 introduces per-chain (Chain A and Chain B) TX power
> limits across five sub-bands (2.4G, 5.2G, 5.8/5.9G, 6G-low, 6G-high),
> replacing the single-chain per-modulation model of revisions 0 and 1.
> 
> - Add btintel_set_sar_rev2() which sends the full Rev2 DDC sequence:
>     0x019e  inc-power-mode enable flag        (1 byte)
>     0x0311  2.4 GHz sub-band limits           (2 bytes)
>     0x0312  5.2 GHz sub-band limits           (2 bytes)
>     0x0313  5.8/5.9 GHz sub-band limits       (2 bytes)
>     0x0314  5.8/5.9 GHz sub-band limits again (2 bytes, duplicate FW reg)
>     0x0315  6 GHz low sub-band limits         (2 bytes)
>     0x0316  6 GHz high sub-band limits        (2 bytes)
>   followed by the SAR-init-complete command (0xfe25).
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btintel: Add Bluetooth SAR revision 2 support
    https://git.kernel.org/bluetooth/bluetooth-next/c/1b16c012931d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


