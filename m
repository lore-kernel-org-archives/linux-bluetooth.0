Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EF3E6DCA
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579008; cv=none; b=p6meZ/g0YmknmiSaKgnVymoeIrB/7Jk9wHlToFOH1mlRh+Ia9g/rki1Wt7ohkxIRsoT3R2oBkFp0BUzJb0IyRZNw0mSIrbzHACt2rLRP6dTWhQS+as9iJVEVmHu6CH1rUnzwH2S5mE+7Hnp5MascbwT/OO7kNyQW3TLrxbmOFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579008; c=relaxed/simple;
	bh=PT9pxe40yk5TJLm5Qnl2sKJijIQUaIOcqXUBLsF2DmQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hcoJX/Y4wQGw1BF/5VPHiFelDR5AQe9+ioS41xcZzghGyYnSbW8I0vKJaQUV4Df6EfHbC2uaCcRVLM2JwAXe/oNL6yinCk51TBOXu6EfjtKXxCpdiWYVpJy0RjLxmD0wK+HlFWpg/D6aj1bvoA4R0wmt4/R84ePusMxrHn/aJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3NLN3hT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3NLN3hT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FBE1F000FF;
	Fri,  9 Oct 2026 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791579007;
	bh=dLFaypiJFixX7xHaC5DLxNzfBoYq16ghpHu3BrMbjUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X3NLN3hTFS6n/CkZUhWhh/AdvNXXxKnDMRVin0o1iK/Bx9g++oibvu6RdtN8DyF9U
	 2NnHeSlQ0KxFlbhoV84CRYcjzTMAA95kPSl5hxgSPV/V9c8/heQb+7ouYBTut8xpYk
	 uAH0AKpczI+eKRDasPeQKRPY/nWOlzHp56C8kcmst/sqFjeYRIl0BbQZ940NWfY4sT
	 Qd9HyR5wcyt0rDtKjDeKPtVuIggY7iW3V/CH1+y1h2N/cPwO0l/apteNsGPQEQmL1e
	 Ph1QJ/YY0OGmlawo0dJqCEkaaFgyQf0MlKGCq3SrIT5YTclHBvji7sEZqoeYNNIOkJ
	 9cb5FtAN+Jflw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F164C3926382;
	Fri,  9 Oct 2026 20:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/5] Add Role property to org.bluez.Bearer.LE1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179157900577.998686.6559169203209957987.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 20:50:05 +0000
References: <20261009180448.29117-1-kevin@simpleble.org>
In-Reply-To: <20261009180448.29117-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Oct 2026 11:04:43 -0700 you wrote:
> Applications acting as a peripheral, or in both roles, cannot tell
> whether a connected device is a central that connected to the adapter
> or a peripheral the adapter connected to. When several applications
> share the adapter, a device object can appear because of any of them,
> so the order of events does not answer it either.
> 
> bluetoothd already tracks this per bearer from the Device Connected
> event. This series exposes it as a Role property on
> org.bluez.Bearer.LE1, "central" or "peripheral", present only while
> the device is connected over LE, and prints it as LE.Role in
> bluetoothctl info. The documentation states that it is the link layer
> role and says nothing about GATT client and server roles.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/5] org.bluez.Bearer: Add Role property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c31e9091e646
  - [BlueZ,v3,2/5] bearer: Add Role property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=76890c8fd325
  - [BlueZ,v3,3/5] client: Print LE.Role in info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2515706490c2
  - [BlueZ,v3,4/5] doc: Add functional-bearer documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=926bbc5dfe29
  - [BlueZ,v3,5/5] test: functional: add bearer tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ce448a8a7a3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


