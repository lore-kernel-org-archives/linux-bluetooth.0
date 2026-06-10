Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C1428472;
	Wed, 10 Jun 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106022; cv=none; b=HJZrWXzOze443NtMOAaklfIQ4scsTaJlzEFlFvphhrXT7BW1H9KLsPPguu8rmgOpD1Czm0P2wR+/+OjNjHC2H53MEeiOZJwR1X/8T9h6uIl1fU45+kk7sxkgXQwORGCefO9KsOFaEni5KmSRyYvDSIPehMpwCT2ujzelITUO6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106022; c=relaxed/simple;
	bh=gu4iU++7GqNGUJqYG6IFAahrXVvG1sO9jgScNZjHh5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uLTvP0sLt7axD3DgJTOz7fqcmYK2ohcMIakwDEctc483v5g3yVC0qeBnYB3Mnmj8t/PG6tx4I3yPAgckD+aiVt2kmcRtbhrwuzZf0WpWbdGwGijslkBa/U86+IJHhoIlYFrU7lZcmmcEqEKlnwFR8o/XKFCn2qeod9GTPapZ04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST7GA2o1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST7GA2o1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449041F00893;
	Wed, 10 Jun 2026 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106021;
	bh=DdG4OYLut3oP5ajPGmF0j2OCgj26HOUQFSb3EHFXNOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ST7GA2o1QaD8WILovdU4favYhL8gX4Wc/xGYujsJ7ZlmJlXLnrW/Db41zzl7vYC4x
	 ya/SyK4+AyfxfgIjLNJrrFbiyTJ2X5ZVON6/smXzjjn80w4ZM+qX4oAA5I3dLXo+0a
	 6K0Svq+O21iw6N4kfuXW5HT6iDIvtdGaK3JwKMRuf12k6e9TZChnjV0iX49KZE6Qzr
	 pmde3iPaPC0cc9zrz60m6NhmrFCHJ5wH7py368Sk9yc7eUleeMy/3hvxFo/Y0JePQN
	 OPrqxakCqBToxhz9mo8hSNUFF0ulM9qXP6zQXy7TTGcMVDoRNWJLsyP0bnlZ9PQyRm
	 uJE+IOfoLM9Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568DF3930D7A;
	Wed, 10 Jun 2026 15:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: validate connectionless PSM length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178110601888.3101197.11028793216503319042.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:40:18 +0000
References: 
 <20260608235705.1233510.fe2269cf0103.bluetooth-l2cap-connless-short-pdu-oob@trailofbits.com>
In-Reply-To: 
 <20260608235705.1233510.fe2269cf0103.bluetooth-l2cap-connless-short-pdu-oob@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jun 2026 23:57:05 +0000 you wrote:
> Connectionless L2CAP frames carry a two-byte PSM at the start of the
> payload.  l2cap_recv_frame() currently reads that PSM unconditionally
> after validating only the outer L2CAP length.
> 
> A malformed connectionless frame with a zero- or one-byte payload can
> therefore make the parser read beyond the advertised skb payload and use
> tailroom bytes as part of the PSM.  A VHCI-backed QEMU reproducer
> injected a one-byte connectionless payload and reached the unchecked
> read.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: validate connectionless PSM length
    https://git.kernel.org/bluetooth/bluetooth-next/c/801f756504d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


