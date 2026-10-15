Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974450390D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093209; cv=none; b=ik/CSKH7GXhQeC3D5wO9k2JSV/oUZHLwiBw4c7AthvCQ3pvlhCgCle3L9lTRsSgUi3Jfpu2Tr6EPHmcaIicY8G9HqnxZaDrPgxyIm+CLjmX4YTKLTVGx+SaTG70D3Q+JN0/2CzMz+iiEg/SyZHd5us8JKeIEO6BQ2UA0X78niFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093209; c=relaxed/simple;
	bh=tBHdwJPqQDDp/pZ8F/3DGUrqu/4ha1tFpoMnS6Fh6jY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AjsQ8eZ1nRHPkKZTNyH20QMdd3GYAiKVZb+AjDkKFJ+QNZk4G0YD8bq2BAjy9RSEd9YOfNxa9zfCuXuV0NlppAo+J5HRQ6/XxfVPqqp2GZigmZ9m1v7uvU78BzhMtRU1yUPbXfzhGuLGpt7V/QsLU2oe3SgCQZJUMc0+Ne7xZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndoMpSiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndoMpSiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AC91F000C4;
	Thu, 15 Oct 2026 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093208;
	bh=0qMuFwWHrYFTtbEQaSRI5AzCVymNn8d52OuyYMea7G8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ndoMpSiLFfGbMFWoLtMdfh0x8wJd0IUIM3SNVDtBWIrbh90wtNT4pq5fsBkhVJaV6
	 deIdvslthPKdiDWiGUQSx2BY4UnbMGM9xuEFIFS9RLz4izdQYzwNMmxC+829W/likO
	 ZMhNhpoiMg72t9lcG32ODvgIh+0IoaPrQh/PagMHWFRuH0MDB2XFBaSZfoOA06sauC
	 V/i8jm3MCuaP/UD8jk+6hED1HkEPSEQlhGGnHpuBPnzh2c/W8XVIKpWpIXimQORgqr
	 awKIIXMX+Hzn/2lEphpMle5uTtkKfzpYzA6cauNj4LQLBDevpZhW2wWk/UKOaGBih2
	 bEtq/EhTldBmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16D93808209;
	Thu, 15 Oct 2026 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix invalid Supervision_Timeout
 in LE
 Set Default Rate
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179209320651.4073732.8455195991465676464.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 19:40:06 +0000
References: <20261015153909.1870855-1-luiz.dentz@gmail.com>
In-Reply-To: <20261015153909.1870855-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Oct 2026 11:39:09 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The LE Set Default Rate Parameters command is rejected with Invalid HCI
> Command Parameters (0x12) because the Supervision_Timeout of 120 ms is
> exactly the minimum recommended by HOGP v1.2:
> 
>   Greater than or equal to (1 + Peripheral Latency) x Subrate max x
>   Connection Interval max x 2
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
    https://git.kernel.org/bluetooth/bluetooth-next/c/76e76945eb79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


