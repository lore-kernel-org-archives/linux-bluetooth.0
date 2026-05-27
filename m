Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A363B47EE;
	Wed, 27 May 2026 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915005; cv=none; b=fufksgPkhUwaORx+wicjTDHW+bgAXRrlo6xyfxGmUzSbc6k5h4rLfT6w8CUyXCtqncPvYabgr70Ihzew1s19warz0F4Up9wcbi0QQ8K+znDnT4ei7ixgQt9kyuK/jPi3IqF+iaC0AosGpmE61e5he0lPJc6SF78/RLsID08+weY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915005; c=relaxed/simple;
	bh=0Zc6ynCc3MW7OzzTYYADDZa0AItiSMtGgRFpXNSh7QI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FjeO9PDUIR1thBTWoakSbBqYP4avveH/UUJmCt8Nkrd3jJJEN0sQ9TIs0p8cP4K7dhBwaBkp4XBjITI/GDsilMzuagciCwh+52lUPPU3pF69VLf6YqeuEjusDmCCUCpufX80EZYnLAxfrRiB/YdFwJh10H/lX3LwmLfv3uYAHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isMk+Rm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isMk+Rm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037AB1F000E9;
	Wed, 27 May 2026 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779915004;
	bh=4HrSTPzVAbupRQn2BdHOd55PYRQRC6ugU5q2tjipzno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=isMk+Rm1d2P837exL/PlOryCLXIjn3UCKrmcPHBag0Q0CLh+cDaTPCNkMIeNC03Tx
	 lyJas4G/B0TKSx1t+EXWQXPMgdEwn4bygmF0WZ1i7PnywHIJxmGR84PIAzYXi3cAaK
	 /6azLqPsvto/UG4ga6lm4sWQc5OvuBRxEVyo/olvUtPHvzTrmbgMAjKdEtLtDUxZS9
	 1Ri0fwKec4LKh/IN17OBYJWUIslmsUdd0OwC3BiRCJPKG8+nPevjI0FGovSn3OckkB
	 psSV1R5w6NdEXIVn3mrrxOz00tJYZFetNr2WbxGy+4HFG8MMPsemqN2INbTLQr4k1E
	 fr6xk0n9WPZVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B50380CFEF;
	Wed, 27 May 2026 20:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Bluetooth: hci_core: Refactor HCI reset functions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177991500888.647444.6136442905244401368.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 20:50:08 +0000
References: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
In-Reply-To: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
To: Heitor Alves de Siqueira <halves@igalia.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, padovan@profusion.mobi,
 schspa@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, luiz.von.dentz@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 May 2026 10:50:56 -0300 you wrote:
> Dear maintainers,
> 
> While investigating some warnings reported by syzbot on the hdev
> workqueue, Luiz kindly mentioned the possibility of reworking the reset
> functions in hci_core. A lot of the work done "manually" in
> hci_dev_do_reset() is already handled by the close/open functions in
> hci_sync, and those also handle missing functionality related to LE,
> discovery and advertising.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: hci_core: Rework hci_dev_do_reset() to use hci_sync functions
    https://git.kernel.org/bluetooth/bluetooth-next/c/54f93846b7a8
  - [v2,2/3] Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
    https://git.kernel.org/bluetooth/bluetooth-next/c/db6e813f5789
  - [v2,3/3] Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a92f90568cc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


