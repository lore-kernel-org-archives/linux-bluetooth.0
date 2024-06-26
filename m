Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FE18A934
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432033; cv=none; b=Yk4ovkJqJTNWMOQhPPqEfGeqOmeE6Q/WFGRUTNpZTRFMlXrxp4EQBycatJUMN5WmUh7xCmMjLfcjeIlHFvkUmZ+b3H3v4yEAgMTaxgNxT3DMlpi2MHxIbZdTdIUhVkGrdWvVAFxt61jKnAOvHb8gqp/DDzHMBrMjSMtKVbwEASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432033; c=relaxed/simple;
	bh=2lDfysLwYPADbz+I/sdreREXgAWnC3PSng9GnwbZcvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J0YaLN0UJjdtk0LNWDwhIA0CfruWsfGy1DS2QwjSWC5tpWKZ7uAFCC3HcEFKXis2JlvycUuy7Z4BwmJy0+hT0vjocMNrnsPjTaS5bBKpJ6U7XyTui+xCHn9Gb4RkCRRFpTfr4Gm8IIkKrZIvNO3YWtT7dKdzcpL+hXylWXv/cmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5BAsYIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5BAsYIb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A86FDC116B1;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432032;
	bh=2lDfysLwYPADbz+I/sdreREXgAWnC3PSng9GnwbZcvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j5BAsYIb9mgr4VXe5CfwLDRKNda3etRkqnOF2E/Mphr053YRSY8UjfZ++G3meKJQY
	 EtEcaq6Cig9g0JQ2TBRc5HJnboFE2/ZSKXKnxbjg9hFK0wE8MdurF4WP8rrtPdIAvu
	 uXJdgyYbsYNdknunpl2gRNS6J8oIVyQc1642uH1PzKcjNCB49dTScoqINYPEOhaOtJ
	 wsWXZN/6OCl7jBgaYZrgtvtWJ6u4Nziwc9XeVGMSEIcgbo3cjYTSPH3Y8YDG+L/gCT
	 xAIF+ujq8Vit/ZmQGebLFwi4EudW3qpXILYjimrSFqeISeXPcmgy0fDGhkpn2Bzc2H
	 NogD8vWUV+IZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D110C43468;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: Fix double free in hci_req_sync_complete
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171943203264.19782.2973026511208479721.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 20:00:32 +0000
References: <20240624144911.3817479-1-luiz.dentz@gmail.com>
In-Reply-To: <20240624144911.3817479-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Jun 2024 10:49:11 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following race:
> 
> cpu1                       cpu2
> ====                       ====
>                            sock_ioctl
>                            sock_do_ioctl
>                            hci_sock_ioctl
> hci_rx_work                hci_dev_cmd
> hci_event_packet           hci_req_sync
> req_complete_skb           __hci_req_sync
> hci_req_sync_complete
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: Fix double free in hci_req_sync_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/bdde736f4d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


