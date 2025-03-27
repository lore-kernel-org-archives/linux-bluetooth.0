Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA547E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091801; cv=none; b=FzPEOCNJ3cM1mhDJ2JHZ+RuINJC/rUEXWkgeMCxpbTUaTqe6PVF1BKVS+EZ69E6VnXq6enWQn+KSMAIgkz6I/op5q582dq5VBTEXpNGy52vJdjqczYMur9kjjwHUtkWuHBIvnN1cwb4pT1rkCPU4MKC1TvEraWOId6CUxxExPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091801; c=relaxed/simple;
	bh=FpZBCGQkNik6M4fa78yYO9j3YM5yILwiWVT+hr5IpIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IRUeCRwsyQGYpKJ6g5PqmCvMv5tu0WSsQYG1b6iqRyFOFcF3w4KHcOuBblLksLr/4XJELMnUSAsulcnnRnG3FHojpLjAiF64piAoQvnI3gTT58c1t8OYEAF39j4jH99rrwhWduC1ObwmF1L3oOpfChhblL6Yh37pzyDs6tcrQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI7L8UNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI7L8UNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C83FC4CEDD;
	Thu, 27 Mar 2025 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743091800;
	bh=FpZBCGQkNik6M4fa78yYO9j3YM5yILwiWVT+hr5IpIw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bI7L8UNvghogwhqD9lEIq+eXkqrSgbsk5/FUSrPmOc1SsvW3FYyYz1Mp3iQl9BH+9
	 wXofF7ajyFL4vPO1yu4w9/P8xpG0COFmjqy/U8VmM+xKLH/6Y5KueoHaX9i4+NkMTc
	 cRId9Yor3hTez6xllX0t07bQEl1FjGiCGI2KvOUVqOGTfbf7RJ7v/Bh6SB4rc5YFKg
	 008NLUx6aBeyaYhRqV3Nh6wekgPUYZuctrfNaKvy/ptSUoclDk7rIhKi5O+YrLTNyF
	 ZE7/A3WmYyp9NEuPB7Wj4GO3SAb0YSlkg3nqomOyg4QcdltyJmU15uoH4dVBbYAhTv
	 BbgJzmq7K6OCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35D1B380AAFD;
	Thu, 27 Mar 2025 16:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/5] device: Attempt to elevate security on Pair
 while connected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174309183673.2118203.7453810546669382002.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 16:10:36 +0000
References: <20250326193133.2718934-1-luiz.dentz@gmail.com>
In-Reply-To: <20250326193133.2718934-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 26 Mar 2025 15:31:29 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This would make Pair act behave the same as when the device reconnect
> and bonding already exists.
> ---
>  src/device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2,1/5] device: Attempt to elevate security on Pair while connected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e2cece67dbe
  - [BlueZ,v2,2/5] device: Make Connect and Pair mutually exclusive
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1c2ec29900e4
  - [BlueZ,v2,3/5] device: Use btd_device_is_initiator instead of Connect message
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=45b61a10bd0a
  - [BlueZ,v2,4/5] shared/att: Make bt_att_set_security never downgrade security level
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ac1f8dd88a46
  - [BlueZ,v2,5/5] device: Elevate bt_att security if bonding is in progress
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5df9521ce4d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


