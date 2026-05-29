Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68AC36492D
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069802; cv=none; b=aHnrtHdgdggQlYSB6d899lP1sP2JR0HnqrlO+aoMkNPEl6YhcJsNuRyvztg0UIkZ3zmmsagfrBNdk+iqj5jDpVAp6raGoNn3ejOVu4cbl0iP1aNgsQGFUc9Uu8xLSLyzjCX5mavTROTsebutesStHOXOWEJgL319EJEpAXrn4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069802; c=relaxed/simple;
	bh=86zfJdZgxvCrWqVd7gA/hou9dNOczo74oGlnDuISMFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A+QtW1ECInv0gz1Y8TIBr8zoszE4fz1fxKtMjxXQVo5B75Yky7LP/81RpxxLDi2NCMQWraWknPVAY5wuHgtRF1+9krelkQzjNIKr8SgqXuZY9GURQl3L3ekuAhTUnN87VM0jhm7IaF/T/STvz3srOs940ikksaqpbNwAg0TYkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8S8/Aav; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8S8/Aav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580211F00893;
	Fri, 29 May 2026 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069801;
	bh=UD3/WL3rQHCfnt/6fqTKtcJPmx0fY3ftgqEfDLAv51c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S8S8/AavHXOL/fXoDRQ9J5zhxu3UMs8S8Wl5fZBUEsNIvxaOCthP9HEOzRD1J8ATT
	 rdN8UI1eHlL12o0dFILCfphh8+kIvsf+7lZh3RFPQD3HHU96MMtWldqAKTzjjWgF9M
	 SmQSTrtt6JpnFhbEfhr9guHH5kvgisW0jrIxofBIaH/dGI9w8GJViAUq3nHcp2aMWW
	 QiuiZ6EQOUOwBray7u8cr0BxKRKt7bYcT1ZfhLZEzhN8sM+ht6j5/EGcut0sIi69v4
	 I/wKBnKdrL3aAK5j3CXDbie42h4pEPD6fDCKItnmx49VAl69csnWNi37vD0rW4GzLQ
	 5H39/FUoVvNhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567E73930193;
	Fri, 29 May 2026 15:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Bluetooth: hci_sync: reject oversized Broadcast
 Announcement prepend
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178006980489.1863338.15123584401206019958.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 15:50:04 +0000
References: 
 <9089784d08f1afd038b4ce0df1fb89904f4879ee.1779634468.git.xuyq21@lenovo.com>
In-Reply-To: 
 <9089784d08f1afd038b4ce0df1fb89904f4879ee.1779634468.git.xuyq21@lenovo.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, xuyq21@lenovo.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 29 May 2026 16:54:23 +0800 you wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
> 
> Existing advertising instances can already hold the maximum extended
> advertising payload. When hci_adv_bcast_annoucement() prepends the
> Broadcast Announcement service data to that payload, the combined data
> may no longer fit in the temporary buffer used to rebuild the
> advertising data.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend
    https://git.kernel.org/bluetooth/bluetooth-next/c/0bc614e5e938

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


