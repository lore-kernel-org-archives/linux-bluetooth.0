Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA21B86D8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551782; cv=none; b=cbT7OYkAzf6iQd4RYkKMuYBX+r0RvErnXy7kJRWJCUgakWVWrS8ac4nKA64ocGdiucK/rhZMXcK6aKzJAXMffLQomhgU6wvE0BP4KmOJoTMMBYhtz0C4m9tjavv1LrIkoAXrXWNt5Bsd/YuRxsVhMyiT6HQGUc18towzulcccCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551782; c=relaxed/simple;
	bh=lItXaG64kxCEMk5zqy/cEN5R8jy8udFCPQPNo5QUxqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cA4VGHkAjFP5A9P0GXdzPM6mqXtRahxHIzcoF5IwtvbGhNqVZJsFegdrD0GeJfPGb7WiRbVx/s0UQF9OYh8zZTrFYSFKZCT/pDXOkOTfbOeIbNJl7j/nkmIESZ4pjmT7KAFutWzAbowDrGzq3wniSyE2TKVPANHMsLW31H1zr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxIIrfzf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxIIrfzf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A3DBC32782;
	Tue,  9 Jul 2024 19:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720551782;
	bh=lItXaG64kxCEMk5zqy/cEN5R8jy8udFCPQPNo5QUxqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hxIIrfzf/Dx2ql16O4OTVC8T5ueaGRcbo1vSJE+HGW4gVnmPqmjPPZIKeLsmVEm6q
	 2bED+7A4xUeV8L2OtnDXjddvezazyWmnhBNEaW2E2Of3Wm5n9EcsaHIOJCrbK7XXV8
	 m96M0W1PDYz7W7UOQ0RiAbBzAEA3GX32Z6Ux7I0h3/i9Xhzpa5/4nHHKFs5Ma/DXcr
	 qpNHf2VFTBoxv3OOg4L+deGLQaxOVt1GSuOdOUjxpZMnUQhUHfDK/LYjK60AvVGeHn
	 JUFilj0TLGYS4e36Rz8ZHbWohe5Ntf0SpQyQ+JS5mTgrN0Y4/YvBtVAPXf8P5lnPrs
	 mKpBVDS2WDhCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0485EC4332D;
	Tue,  9 Jul 2024 19:03:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] bap: Wait for BIG Info report event before creating
 streams
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172055178201.32169.12599597951238542702.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 19:03:02 +0000
References: <20240709085903.125001-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240709085903.125001-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jul 2024 11:59:02 +0300 you wrote:
> This makes it so that stream for each BIS is created after BIG
> Info report is received. This ensures that when the stream is
> created the encryption field is correctly set.
> 
> Vlad Pruteanu (1):
>   bap: Wait for BIG Info report event before creating streams
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bap: Wait for BIG Info report event before creating streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2748c60a2c6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


