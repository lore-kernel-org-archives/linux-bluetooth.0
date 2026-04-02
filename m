Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B535958;
	Thu,  2 Apr 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151623; cv=none; b=SHk1P2lBumfyKoe+qUF6FWg40EoFvlFRqappWacavxVpjmw8lLBvEXFpr0kimrXJQIfy/uInXm8sAcAsRg1O2N4OV4JmrRSc6tDNz0HGYOaKG9tJN9qKJoc1ZRbpX92J7at7eAibwTZOenre+C2RCFydSQ6wQoDVhfnP7Li8L84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151623; c=relaxed/simple;
	bh=2Ih1uDz4O0iFf1lYLW3CFXxJLt5ipTa2ca2c3ljYgxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XFXw1fqyG7Z8wDRHNUiKQQ8IZqOmR6ghZphV0QcOXXVWAqS+D7QcphOUiHM/5gbpPY9DLtvew+dHqnH9zI4TIhdp6Tg88YQeiES/cmfW8lz6IR21z9mQXfTYbSDeDDBoFzujzYiiJg3bMxSz7zeya7ysiJI94zuccUTbw4e/NLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toXQsY2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toXQsY2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDB9C116C6;
	Thu,  2 Apr 2026 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151623;
	bh=2Ih1uDz4O0iFf1lYLW3CFXxJLt5ipTa2ca2c3ljYgxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=toXQsY2vax9qNTIkaHzaP2FTVBhrXee4S+qVRkq7FCeJc4lPyQd5jK/RvqGh9CJCn
	 okN3zRhMzv2XSk57pvJHR/3ANV/8lj76i//iLCF6AkBCHKqOTyokRK0JL9MUeSinKQ
	 iLGldQ8kSQXgPTwoamp6WmyXTEO/4/K7vTW/1UxcUWl2IOVBkfHHGdEhhvNdUz6pXV
	 p92wDyKUj6xHeDduecZ99nkiuxjAFigwSS1KvVDhYUduscePUbBAJNKqdb2zVgWV1k
	 +Cx/xLOaoUBP0G/J2JGtCHzxD/ocL4d1i2A8Grj6P5rib2VpS2GS4MyWtR0VMIg69Z
	 l0fyH28cu73sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF643809A08;
	Thu,  2 Apr 2026 17:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add VID 0489 & PID e11d for MediaTek
 MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177515160503.548768.12254874190365552604.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 17:40:05 +0000
References: <20260331144532.10697-1-nercone@nercone.dev>
In-Reply-To: <20260331144532.10697-1-nercone@nercone.dev>
To: Kamiyama Chiaki <nercone@nercone.dev>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 31 Mar 2026 23:45:32 +0900 you wrote:
> Add VID 0489 & PID e11d for MediaTek MT7922 USB Bluetooth chip.
> Found in Dynabook GA/ZY (W6GAZY5RCL).
> 
> The USB device information is as follows:
>   idVendor  = 0x0489 (Foxconn / Hon Hai)
>   idProduct = 0xe11d
>   Manufacturer: MediaTek Inc.
>   Product: Wireless_Device
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add VID 0489 & PID e11d for MediaTek MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/3966e67cdd70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


