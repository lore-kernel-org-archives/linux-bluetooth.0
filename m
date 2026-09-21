Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A04B0488;
	Mon, 21 Sep 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999883; cv=none; b=MsJhdVdCsO+7/j4qyrHHNAeAphWf6KSlX+oPK5IKYF8M/87LZtVeffQXIB4VQnqU4HM30kK0L4lP7389wbtea2dIMk7oY29xBMMp/aq6MgK5KObWVNbx/VlWspcdqj8bc1OrQlXbC4x6Px1kNHroKT/MCsvFr9SqbJN6UEqObZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999883; c=relaxed/simple;
	bh=2YbJUZd8yIzR+p1ZuEANAnX/XFTDEhZBWoa/utXDp+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mXM7NnqoBeY0gYpGKsgDjiVsoLUH2AIK01x4X9YAQv295VxrMVFDcbtpUH/ZmtHBhyXweA0JPoDRRS2bLZpZmDWVGsTE0oBj9N28egvfXZ5yknft8dipK9jRANw06Y78gsH2F1TfdNDAKImnEhMQM57SwbQAi4llib25qAqo76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6whQGOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6whQGOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02D41F000FF;
	Mon, 21 Sep 2026 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999881;
	bh=RepeHptdXKDnqSvMgePRbujYJl3fXe53/jKtaMCblxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W6whQGOf4aeOCrphSLvscPTvAzrPT6GnppymRZtSD0rqTR9ukYDJ5ai3g+Im+hHmO
	 BlGbFU24XVZRjiPZVAr57OOaMV764illZKflAbpegoY8wSZquYbo244o4g3ZTqodoJ
	 Tnu9XbMimObTvOCTwWFhCzZre4za/im1G3i75ndrfK1AHHjMaXUCv8Lajmz5GmFZ8M
	 Z7AHzyJ7YmgSynQvavh046JXc4Vgv/HxjOmNraKiEFWh1CD36Kahy0BwcULEHllx7O
	 /WRL2/oNks94TA1u5mA5ROccOCuTf9P88zKRDBqTndr5vMLoJGFmaOA1j4QQkrQsJ2
	 oFpcGSh84S2zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393A3926659;
	Mon, 21 Sep 2026 14:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: bnep: fix out-of-bounds reads on short RX/TX
 frames and control fallthrough
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178999981314.3047822.6059852336450565758.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:10:13 +0000
References: <20260919221738.3708655-1-benquike@gmail.com>
In-Reply-To: <20260919221738.3708655-1-benquike@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 19 Sep 2026 22:17:38 +0000 you wrote:
> Fix multiple out-of-bounds reads in Bluetooth BNEP frame processing:
> 
> 1. In bnep_rx_frame() and bnep_ctrl_frame() (net/bluetooth/bnep/core.c),
>    use pskb_may_pull() to verify the BNEP header, control type byte,
>    filter count, and extension headers exist before reading them, and
>    return 0 after handling BNEP_CONTROL instead of falling through to
>    Ethernet frame submission when no extension headers follow.
> 2. In bnep_net_xmit() (net/bluetooth/bnep/netdev.c), verify skb->len >=
>    ETH_HLEN with pskb_may_pull() before reading the 14-byte Ethernet
>    header to prevent an out-of-bounds heap read and infoleak on short
>    AF_PACKET TX frames.
> 
> [...]

Here is the summary with links:
  - Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0ca020cbb9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


