Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADB567A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914832; cv=none; b=Q8mtz6kyKmSmrbYvFKWLUAVYDpfz9qM+a/QmodQjlSsiifq/NWUp/civMkHEN1Sr+d5bDHvEfONprxovYUloaZbW7J3T2nsWmcvhqtrS98ipBYa5U6OCa3gPTw6fqXPuqZRiljLNIwOaNxL+wWaCB96KpS+bMssMDJVFXx0bm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914832; c=relaxed/simple;
	bh=dHWhMC9VvB7gbYKkeG4Uz+VWaga3bL0nH4KX8w5Eqnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LN/krSADxkNwkwmE77gXMRbi2X3vdhb6pd1zyBTJm//f66ibk0DOk4tzLHSPjSYXsmjfBVfr561ABQyx9skOkuDYEwuelT4ik2meDbXUMHDG8teGfJqYLwRvuAQkZ84TvG2R1BuDfvzjTk3YiiSL0FRQKz6TloX5FuyiU4eQzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yax/odCV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yax/odCV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7DEDC433C7;
	Fri,  8 Mar 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914831;
	bh=dHWhMC9VvB7gbYKkeG4Uz+VWaga3bL0nH4KX8w5Eqnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yax/odCVbpfn7v/UNb5peMLOkNhXxlQY6JO5SLhSdvd06rul0TtrWDUwNfSdgeS6B
	 xd9yscPxPvBjGk+shUUVk778NNckIAAFL99nKcab5kdcOXkQGiPaToYnW1hqTmOjot
	 n0jZ1ouDRIKysUwCcRqxHwRibXpSa1l/rN3NRgY4WFQVlBdili6qc3A+Ki0j922h6R
	 XnzTb3snWAuBn9JPGWvLNhj3KodjICuNjTI9f5CqkHUbw9GULp7RSuPKm8N3fdM1Kn
	 hstiJpGuGOWL5KTcFgjpEvCMp0yInLX4k0FJT6OlfuRx2xchOijoMX5Yt77DKRDFLE
	 EzlH2x0HWke8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEBA2C39562;
	Fri,  8 Mar 2024 16:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] client: Add scripts to start broadcast source/sink
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170991483169.24074.17936933316756402243.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 16:20:31 +0000
References: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Mar 2024 17:58:46 +0200 you wrote:
> This patch adds some shell fixes and introduces bluetoothctl scripts
> for starting a broadcast source/sink.
> 
> Iulia Tanasescu (4):
>   client/gatt: Quit shell after user input has been processed
>   client/adv_monitor: Remove shell quit from adv_monitor_register_app
>   shared/shell: Add fixes for the init script scenario
>   client: Add scripts to start broadcast source/sink
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] client/gatt: Quit shell after user input has been processed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=352e75263632
  - [BlueZ,2/4] client/adv_monitor: Remove shell quit from adv_monitor_register_app
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32e9d15a6094
  - [BlueZ,3/4] shared/shell: Add fixes for the init script scenario
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fcbea6f3658d
  - [BlueZ,4/4] client: Add scripts to start broadcast source/sink
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e9f079e8952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


