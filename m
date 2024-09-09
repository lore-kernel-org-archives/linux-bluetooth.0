Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC023759
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898831; cv=none; b=gk5QEETlZx+xqtn+KEogpAdyTfFf25jASLyrqdYgBLFQrbi3pUGqmiVLgcegnQocQ4UjDQ4QyzwSOEpCBLanR3wnFvZxsAcwe9Qtg1UXhSeAV3d+d8/kRwgnprrH/2KYGZXhx0qhyFk3LILXZp1X+row8+I8WmgvgmYHzFm5EUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898831; c=relaxed/simple;
	bh=ZvcYHQlxkWZeKKoVjkyEf5/X5Yy5g8vFLH9wwDZGdAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sjl0PQ+x/z6py1CVKYgDujMbDZg/y+KN6z+PnTjEFe4hHWIOw4MIYYtv7wizygLHiEW84glRSEHDhf7BS5flXcRWBh4ZsId1R9dKylykWWux92hkmKRaLUPjmo1+cv92ZI0wCiv/22ifoiUMP8AJRzHw+U1hplRJSLN9d4ZOs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYHe1E1j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYHe1E1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B176C4CEC5;
	Mon,  9 Sep 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898831;
	bh=ZvcYHQlxkWZeKKoVjkyEf5/X5Yy5g8vFLH9wwDZGdAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYHe1E1j4aSobI7s9MMjYyX9P0gGDgb1ILE+CcslFkwqQrQvKW/Js63zJZ0lo2Axl
	 mRc58R7Wk7KSu1Ic+7o8WJEsMUZbAYL4Y3iS3AzTVsvvkX8iIMwAOSvw/4D1aAhnPP
	 q6PDGCwIRVmAcvMHbwZ0kEd13uWfgWEiccZN6noIwR8/WJie3v3TKz+qBO72ebeKUZ
	 CWIILZvjkf5SYfXJCPB2RvCf5C9rThe68ms0E0tNMRL34Fo8cE5kBWM1HH60vufZOq
	 xeHcym+U5DgQkWmy9HwEwaKlauoriruEuaQnTkiQOo3Q+tKT9bg0YGpXbQRVS9dRpz
	 574qIZK1Jr85w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D413806654;
	Mon,  9 Sep 2024 16:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/8] Add support for setting bcode on bcast sink
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172589883227.3847713.4724662221187887635.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 16:20:32 +0000
References: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Aug 2024 12:51:58 +0300 you wrote:
> This series allows the user to set the broadcast code before syncing
> to a broadcast source. Upon calling transport.select if the source is
> encrypted the user will be prompted to enter the broadcast code. Then,
> the code is set in the associated stream's QoS. From here it can be
> accessed by iso_do_big_sync, which will pass it to the kernel.
> 
> Vlad Pruteanu (8):
>   doc/media: Add Encryption and BCode fields to QoS property
>   transport: Make get_bcast_qos return the encryption flag
>   gdbus: Add g_dbus_proxy_set_property_dict
>   doc/media: Make QoS property readwrite
>   transport: Add set_bcast_qos method
>   shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream
>   client/player: Prompt the user to enter the bcode
>   bap: Refresh qos stored in setup before doing BIG sync
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/8] doc/media: Add Encryption and BCode fields to QoS property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c9431fc2b97
  - [BlueZ,v2,2/8] transport: Make get_bcast_qos return the encryption flag
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f72fd8265000
  - [BlueZ,v2,3/8] gdbus: Add g_dbus_proxy_set_property_dict
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1bde349db6b
  - [BlueZ,v2,4/8] doc/media: Make QoS property readwrite
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b48d366458ed
  - [BlueZ,v2,5/8] transport: Add set_bcast_qos method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c922cc4a74e2
  - [BlueZ,v2,6/8] shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d43c209f084
  - [BlueZ,v2,7/8] client/player: Prompt the user to enter the bcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=35f2bb95171e
  - [BlueZ,v2,8/8] bap: Refresh qos stored in setup before doing BIG sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4ecfdef3b52f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


