Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6647A73
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258833; cv=none; b=mb/5ruOdfgMnR1zk0QI1Ag7lHnijJa94oU7y2lJ9iqPaiavfSgeL6wllAXqK53gj+12oO/1WLVuMpAcpEk2lwn0qUyLgRL1cdoAdfwaF2hv/Fu5PhuLouQGyFi3sjE0HIY0iAcvNdO9gmfkr0+eSj6KFmmPxv1d0nTOluJZqFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258833; c=relaxed/simple;
	bh=dMWmxzvBdBC2dSmY8WWWk+D1svBF5+6EMGsNJLEactQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JOxDgX0kMgCREDISI+691YOgwJw0toS3ft/Fg1LTohsX0vHqGD1FXU1Smt6g5i4DOTRUM7WsyWqkz7suR50nFkWGP/tW8spGuAcsrJToKtAeU1V09x3C3q9KYGFAAeYpnwwifRPxtxmuFT7oGdc6jnC1HNrMezxj3WDjKsOdHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdoExCk1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdoExCk1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC1FC4CEC0;
	Fri, 13 Sep 2024 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726258831;
	bh=dMWmxzvBdBC2dSmY8WWWk+D1svBF5+6EMGsNJLEactQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pdoExCk1Pm/P5/p8vai5lsFpOWNhwbFklGKCz9dLYsLk3TTsvpaileeX4EYDRZUea
	 4vku4dNXFRxqVGb/LrykHEh1oMMSm2jXv3UYqbujhiVbe10DoqYc1vEm+weEbxHJiw
	 C6XR4s2fmlBmD9LqFbmSkgzOWHlWCZgX8WFW4uXmQ6JQeye0m6qJ1dhZa6YYZhLXUc
	 ala9Hyggo4k0PSy2fOb8QqYwRfuUkJ3MHkvPxHqEDtkSNPhpvCC999WzHqRlp6bU0y
	 dIL0Jo+nc/48qskwIRS2N/9cY0v/p6mBTwQlWku5d0vzIo/N/SDL+6uQYwb7ioqw+z
	 e49+GKK3MFOLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1F73806655;
	Fri, 13 Sep 2024 20:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client: Print a warning when setting discoverable
 without a timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172625883275.2356446.800897243328460190.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 20:20:32 +0000
References: <20240912204458.3037144-1-luiz.dentz@gmail.com>
In-Reply-To: <20240912204458.3037144-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Sep 2024 16:44:58 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes command discoverable to print a warning if
> discoverable-timeout is not set(0):
> 
> [bluetooth]# discoverable-timeout 0
> [bluetooth]# Changing discoverable-timeout 0 succeeded
> [bluetooth]# [CHG] Controller 4C:49:6C:44:F5:E7 DiscoverableTimeout: 0x00000000 (0)
> [bluetooth]# discoverable on
> Warning: setting discoverable while discoverable-timeout not set(0) is not recommended
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] client: Print a warning when setting discoverable without a timeout
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=41f943630d9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


