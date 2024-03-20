Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964403BBC4
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932428; cv=none; b=BQyxTzOdDQ9OrJYJxeW84nsqCCZZbWpCMN3XQzwwAO+kDzvCRy5R4+phxv70WcrupgWvCZt3Y93W9JItP0WPeV0ch8sXSpjBhOfeOVbQ79kbNFr35crWztJswtVjkE2Gpxz9ja3QCva38y63LOj4VvEf1O+aZL56cSs4/Y7z4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932428; c=relaxed/simple;
	bh=bP1rr70hs7+nSRbdLpdD6Du/6J1IFeEfBIvAdRz0l/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8WAemxf/+34PzvlTrvt7jptoUSzeV4uyOD0m1nx/RYyHUjcHZ0IDxUdbHFhJJBUkCHXmC/cItzxe6ItmT+Yxu34CakuFfMLC0UVYHAHacuW9Zya2aqprKCeAxLTmao0BIRjyv+Kh7DV+9uedzZ5OSahjNRuAn89ugySzqvD5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no405BKk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no405BKk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33F9AC433F1;
	Wed, 20 Mar 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710932428;
	bh=bP1rr70hs7+nSRbdLpdD6Du/6J1IFeEfBIvAdRz0l/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=no405BKkVlJFDH3adRMjKQy8NXehGHDSTJ+c88XRJnGDQoVS0fQo0dBnNLA2reeku
	 suHAPPPy5jdRECItDHSVyooT6358+/Ga+4faMV9zSxlxYhPV3hMsuzadDOF4i+Q4LN
	 X51CazfDyVCO/04ZTCim8DpmSKHcaXzBIV5jnuN+IcmuZBLVnpzN6FVOlnLbBroH7B
	 /ENlGalbEO+QW1TcaRqmAApun/C1oC2bUcE+tv9A+Tgt0Iq+zVAwaFfluIKVFe89mp
	 0S2z9hq7vCkkaJ5jlfpkmAyQuzTz7HMvcbwFK+HZS5xr94ABRadDd++bEJ7FXWu21p
	 kKDoJgC+h3C8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23E2AD95060;
	Wed, 20 Mar 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] input/device: Force UHID_DESTROY on error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171093242814.11517.2253439704285439566.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 11:00:28 +0000
References: <20240314125352.15243-1-luiz.dentz@gmail.com>
In-Reply-To: <20240314125352.15243-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Mar 2024 08:53:52 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If we cannot sent a message back to the device destroy the UHID device
> since it is likely that the driver is trying to reach the remote device
> which is no longer connected.
> 
> Fixes: https://github.com/bluez/bluez/issues/777
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] input/device: Force UHID_DESTROY on error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b8ad3490a350

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


