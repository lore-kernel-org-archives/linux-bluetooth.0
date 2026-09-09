Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7D3C9EE7;
	Wed,  9 Sep 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982871; cv=none; b=kbUdYrkYaQiWgM6xGe+xWa//Fa39AATkT9D8mASyUqGGZ8kgicX1l13acXpQ4DeZ29ouGzuYBqm2M7L9AMp+Q5+m3kXGexYWWH03lVQymZLlKjERGSu4G/dgb/RFQa9urPMy56r2XroaTDeRDnjueOMFxI/KyhF45Fgoa1XP8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982871; c=relaxed/simple;
	bh=pB6uWTgXYvFBOzgJQPFHb5FbBOCzm5zvmX2gm3Sgnqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mSwMlnwUhEh5jKfE+dXTWlrIL4dmR7xSiPqiJdZRQsDyM3BkbHxdkD/82elySQmqifpmXmjVioO93//ZH7LfnATFlp8x5mICM9ykD0Vzt3jJrBJHfL3IdVvroj8rrm3AXO0Y8FtTPdObGjNNNe5aE07qNJw/vf5GthwOVOdW0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBlKvUfz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBlKvUfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44B71F000FF;
	Wed,  9 Sep 2026 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788982869;
	bh=7OqridpPwR5w6CLSHdMSNOqIY91sbOrBlxIPkhdnnFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JBlKvUfzvjdjbo7JshAFc4lgxTlJ5Glx9vcoUuAixohR2wb9GHax027B6OzvVNJm+
	 xD0wi3anCuVM8U6uzOInFDyE/FQxGSxkXTzsHCqGdKVbVAu3I0HvLsJaVjk3GZiMwD
	 LWmGM6uQZ9yJKAxo3dMp1B6jUo+QltXAQ/NWymVHoCeOWmkT+KJp29RAAgiB6TO7N8
	 lanNUlk0BUo0u6lSpvbL9JAFLVpEry7Z+DgQ402FGgzcS/quk6jWr+UKEec5Fu3K6D
	 4UDaNgbjyYVrovJgPeuOcCBWrau1On6XBDG0I7GaYeTvMG2RXVtW2asyoA+xWIORyf
	 ogd6i+meVtV4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0859380AA63;
	Wed,  9 Sep 2026 19:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: put the peer's on-air address on air when
 we
 cannot resolve
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178898280763.1023805.2181772004585809678.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 19:40:07 +0000
References: 
 <20260908-for-upstream-le-connect-on-air-addr-v2-1-2ae9fa066ec8@podgorny.cz>
In-Reply-To: 
 <20260908-for-upstream-le-connect-on-air-addr-v2-1-2ae9fa066ec8@podgorny.cz>
To: Radek Podgorny <radek@podgorny.cz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 08 Sep 2026 22:41:38 +0200 you wrote:
> An identity address only reaches a peer that is advertising an RPA if the
> controller resolves it on our behalf. Where it cannot, the host has to put
> the peer's on-air address on air itself.
> 
> hci_connect_le() still swaps the caller's identity address for the peer's
> cached RPA before creating the connection, but __hci_conn_add() resolves
> the RPA back to the identity address when it stores it, so the identity is
> what goes out. Storing the identity is right when the controller
> translates it on the way to the radio; without LL Privacy, or with this
> peer absent from the resolving list, nothing does.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: put the peer's on-air address on air when we cannot resolve
    https://git.kernel.org/bluetooth/bluetooth-next/c/e35544d23359

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


