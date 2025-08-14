Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F512E92DD
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175794; cv=none; b=U7yNXnccyuKGWTDrzk0dyIUn/rxRAiwV3YFkuIdp0ZIgMQQgkLnoy1TZqDvPsce2fhuUw7MM8acBZ5oe2HA4aZgGud4YK938QLgu7abu9QhV5zyCGsZ5BM5i+2X1Y+B4k4TlWNFtGBUM+k1s5ELYQDd7246dGMYdyvHklN1K+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175794; c=relaxed/simple;
	bh=c7LmjnF49xCnKP23rGtIvBs0Aypdh+liWhhJ556RCjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ty8v2kF9phVS+l8VFCRvYsMCjPcO0aR8AGEgy2tGjOhBY+KGi7kxXSdgbBIMj8/iBAfY6irZMSgN7Z/l3nRDwPI6fJq/YvTzR3ec3GjWUe5k0DG9d6PPwFiFzjWDDq0Oh7S6kn7eWC0iRU18T96m47VALheja0ROqNOyXgr/H40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjXyR0hd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjXyR0hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF74C4CEED;
	Thu, 14 Aug 2025 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755175794;
	bh=c7LmjnF49xCnKP23rGtIvBs0Aypdh+liWhhJ556RCjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZjXyR0hdzN2Dq+ONpAUdDRWvBXxwyuE2+m1davC++Xz4aFTF9h1M/wO+zUmZy4gJI
	 AitSahOnZbuqU9UbQF6iZNAA7epPhz9GU+dE0L9is1615IyoiDm+FMvqO1GxrSDPsx
	 qWuqV/yz6UQTp5e+zrf10Ocy2ZMI2hbd8gbQCNTHUwxeZr3yTnG7yHiAB2RVgZprhM
	 JLq17MOQm1ys1uw/4N6BqWpV50+rvfYoL0ezzDqThTsolpnocGR9owGji2ifeSQdjm
	 OJ7WlRQrxGTjo7ia9WMZTH53HzSpqcdQuE5ao3+sf3OE8GflWbmAjzZ22TLbELndtr
	 dB515fX1zqPuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB23039D0C3B;
	Thu, 14 Aug 2025 12:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] mgmt-tester: Fix tests failing due to missing LL
 Privacy
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175517580576.276737.3047362216407221885.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 12:50:05 +0000
References: <20250812212227.1541519-1-luiz.dentz@gmail.com>
In-Reply-To: <20250812212227.1541519-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Aug 2025 17:22:27 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> LL Privacy setting now depends on LE to be enabled first which was
> causing the following tests to fail, so this removes LL Privacy from
> the expected settings:
> 
> Add Ext Advertising - Success 22 (LE -> off, Remove)
> Set Device ID - Power off and Power on
> Set Device ID - SSP off and Power on
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] mgmt-tester: Fix tests failing due to missing LL Privacy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8a82f19c5c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


