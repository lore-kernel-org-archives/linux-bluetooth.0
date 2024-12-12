Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A91AF0C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037215; cv=none; b=hviDV0Dg8XGKk6h07Do4TOTwZ/KNN6ptbdUJQ/CQ7KPOE6/LEQ7jAyC093/5ChAFkt1ycCCgeECZn2SUpXLVXMTy9F6pBuzK3u15Zcl1+tR90x1CiUM8g1nl81mRZ6HxfJjg1hfb2sbp+en13hNo1o6QDbtK6Ppr/Wjinfp+YrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037215; c=relaxed/simple;
	bh=kZYnQbNH70H5w2jAlKPVjHNbe3iARUNc9noj6MmRx4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rfDoFtF6BvEkez34eRr13XIR778Lcol46Nj/K4ChvvTFGQbMeuoz4Bred0pKDkk5KBu0w/by81Y2gfUM4qt+uIQksCKQxU+m35FRUscBvyF4a0gqCBl3GvjJE4PfTsHyNKclvFnMim6ObNVgW3ITBcqswfj3dg6ny6Q1qZQlP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjdKxr7j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjdKxr7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57ADC4CECE;
	Thu, 12 Dec 2024 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734037214;
	bh=kZYnQbNH70H5w2jAlKPVjHNbe3iARUNc9noj6MmRx4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cjdKxr7jsX5aE0Zt3Dwvrvzpmsb79YK1H153mhaTXKuzcvwwiQW+iWslyKDimZIt3
	 bTyrdPAlP9B1npKkU1XVs9zFvYKE7JMyhF8pgXPfjcVHAltOJNZKG6/nN6zumKqEf3
	 2dcIG7RXsgezTKoirIEE2K6JCB/09UhLJDc/8/VuT4xlutPPgaFjJJ/6CPm3MTJnM8
	 W2kad9hOGoLSy1N/P6IY/VVVzMTjoF46J3HeTo4eOs9ZyRco/741z04kLZu8Ckcdf8
	 CUUG/sbRPXDfGv2NKgRQLFKFHDASny8UBPPPxs+MR6/U4jeRAkoQzVjpAVlXKbv094
	 U0giljhMJ1/0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34C1C380A959;
	Thu, 12 Dec 2024 21:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/3] Bluetooth: hci_sync: Fix not setting Random Address
 when required
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173403723107.2437918.12876941907710218957.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 21:00:31 +0000
References: <20241125204211.716883-1-luiz.dentz@gmail.com>
In-Reply-To: <20241125204211.716883-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 Nov 2024 15:42:09 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes errors such as the following when Own address type is set to
> Random Address but it has not been programmed yet due to either be
> advertising or connecting:
> 
> < HCI Command: LE Set Exte.. (0x08|0x0041) plen 13
>         Own address type: Random (0x03)
>         Filter policy: Ignore not in accept list (0x01)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Passive (0x00)
>           Interval: 60.000 msec (0x0060)
>           Window: 30.000 msec (0x0030)
>         Entry 1: LE Coded
>           Type: Passive (0x00)
>           Interval: 180.000 msec (0x0120)
>           Window: 90.000 msec (0x0090)
> > HCI Event: Command Complete (0x0e) plen 4
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Exten.. (0x08|0x0042) plen 6
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
>         Status: Invalid HCI Command Parameters (0x12)
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Bluetooth: hci_sync: Fix not setting Random Address when required
    https://git.kernel.org/bluetooth/bluetooth-next/c/e8e5b0502559
  - [v1,2/3] Bluetooth: MGMT: Fix Add Device to responding before completing
    https://git.kernel.org/bluetooth/bluetooth-next/c/fcd17fe2deb9
  - [v1,3/3] Bluetooth: MGMT: Mark LL Privacy as stable
    https://git.kernel.org/bluetooth/bluetooth-next/c/514e14b1a7c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


