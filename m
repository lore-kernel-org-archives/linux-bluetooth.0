Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222533C064
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927033; cv=none; b=eszMtpgdRpMy69jYHYvi4ozOXCm1kon1kgg5B05c/UcEpXl/MyovDJFQ16ehAfM15x7cSzW9vWdLV1Ku4WFhG5MwGPeEIf3J66SXEBTK2WBk5RPHCQKMI7t5D+sZpadqD4Fx9j1T9yJxXEWjHkzPt2cG7rtfORy5Y0ZXCXGXFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927033; c=relaxed/simple;
	bh=8NpUkiENwRC3YzCaznRHWj/XrnldXa0ALMjNgf/tR8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qiGz9lpLKpkL02uAAbibPB3wNMdpXnFKwMlMohWY0BjS2fr6tGo1ra3be3rjuu7LNYXfv7mtmzpl9CgK8hmKK6O0x/mz22eqJ1QQooMFIPgDCdIVLB7KuSfYL2Kov0uBhOBS6xwivo0TKlQ5T9VwmACK0L1JsLVeRRWe3RdMwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixnFs0Jd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixnFs0Jd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8859C433C7;
	Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927032;
	bh=8NpUkiENwRC3YzCaznRHWj/XrnldXa0ALMjNgf/tR8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixnFs0JdcLP90gukNi737nQDY6D98+ygASvm9CoYjFu0B4gZUe+cZS37IaruwDDDH
	 d8ueQjEC+opfo2FJaBnErj/dN9lG2c2wC7/Mg3vrxhUNIg7wUTPwInYbbf7Uew0v01
	 cBo42NQx7UQ9r9cOhRrym1VFd/inhGrUuMIEfP9OZa83I2pbj1wZXQnEKtmMOS/H5h
	 eAXEBzghjmR9oRX59VZfPFEvZN80lKcyTHDyjTZ7s9KYOWyuxrDb24G1u71lj6X5oR
	 5BN+7xXg+YhhgPXHyCjuU1irkQOT8liItHZvw3mnvNygLEJRCIOm9JwIVBNQ0QbK8E
	 F0l54b0pWsdww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAE8ED84BB0;
	Wed, 20 Mar 2024 09:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] main.conf: Introduce GATT.Client option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171092703269.20558.9500026998703113427.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 09:30:32 +0000
References: <20240314101708.144166-1-sibobrenok@salutedevices.com>
In-Reply-To: <20240314101708.144166-1-sibobrenok@salutedevices.com>
To: Sergey Bobrenok <sibobrenok@salutedevices.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Mar 2024 13:17:08 +0300 you wrote:
> General.ReverseServiceDiscovery option is responsible for two
> different things:
>  1. It disables SDP reverse discovering. As a side effect, some BR/EDR
>  profiles cannot operate properly. E.g. AVRCP-target profile needs SDP
>  results to determine the peer's AVRCP version.
>  2. It disables GATT-client creation back to the GATT connection
>  initiator. It may be useful for peripheral devices, especially if the
>  peer doesn't expect them to connect back (and currently some IOS
>  versions don't). This behavior was introduced in
>  8de73cd12 ("main.conf: Make ReverseServiceDiscovery work with LE")
> 
> [...]

Here is the summary with links:
  - [v2] main.conf: Introduce GATT.Client option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6c039398fee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


