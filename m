Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733B1DDF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750831; cv=none; b=WJAVV7uHHU1JksbU7ka/09U6t/NdU3E9ibyCbCRYE9M6TMP8RXG/as1FlCrzVYrOFyF/II8W+dVsS7HMn//oRv+RA63HdlWsAxWeP0ekAocDw/2gZdIwjMQ+pvinYVcQgWUIgcxSk/zKieNwGwkhu1h3Qyn8hc+vtqxMY8X3/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750831; c=relaxed/simple;
	bh=Z2R3PVs2T5R8SIO/9btlI/z+bNOvuvBwhQnbxjFMjRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hRX2X3uFn/ThsRC0qelul6o3CrJmj1LpnbgfI14pVD3kEA/hkCggJuxyXKtM/pwMTmdgLQUJjyU0WbeBx7T78h4tdoJ7dTHeL0v+U0Dbc3xZlEmrUPLENIFhWMeD3yjoBRU8zRKVzubdyCvUmXiN8J2xkbFBsTTRy2zcdEwDnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzfCGcCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzfCGcCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F92C4AF0D;
	Thu, 15 Aug 2024 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723750831;
	bh=Z2R3PVs2T5R8SIO/9btlI/z+bNOvuvBwhQnbxjFMjRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZzfCGcCIEUZ841apqBvRwZj3du3B3QzSo/n4jFL8G6vM9ODAEdAmxVB7rqLzct0Hs
	 o+P+1Nu7RfrxsMc2Lz1+TGTQwin8YFTLiojYUjbSyszxjqqDl+z+8/5lcZSlFLC9YJ
	 mSZLYEWYTAErVgwE+hFR2knwAWzKigZMidvW7wRwU/29KlXb/cY768F4+VJUf/MqWQ
	 QyjcaSP3mv8ABZbzkhkNrxD91fl/9dBdgQt1VDtytHWVFR3N3z9ZkwbeKfxNb6/d7J
	 sOHoKFoWXlwp/n4hpYt332oujlTVd1vs93AoqsvWYRsUM5b9mFwN/9LFVb7JqT8g4o
	 hLnuR+62wBphw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC7D382327A;
	Thu, 15 Aug 2024 19:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] test-uhid: Add support for device specific testing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172375083048.2993361.11521678841465830178.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 19:40:30 +0000
References: <20240814151135.725001-1-luiz.dentz@gmail.com>
In-Reply-To: <20240814151135.725001-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 14 Aug 2024 11:11:35 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables device specific testing and switch to run
> bt_uhid_new_default when running as root so the actual kernel driver is
> used:
> 
> input: MX Anywhere 3 as /devices/virtual/misc/uhid/0005:046D:B025.0031/input/input86
> logitech-hidpp-device 0005:046D:B025.0031: input,hidraw10: BLUETOOTH HID v0.14 Mouse [MX Anywhere 3] on 00:00:00:00:00:00
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] test-uhid: Add support for device specific testing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3b7f4b4d3c83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


