Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A353033E3
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508027; cv=none; b=ZL9sMajxWsgpcgORiVzZcw025D0BlaUvgW4Ju5MNUqhLdACIGr3wm2Tbv0bvaZaegTvj1Dr2XJtZ68egwXpd4lbXS6KqqcX5UyGMOe1tFNbTF4MRwgB/tnPkyOJil9fEKj3VfYrkkDZBfJCHGcKLmJF1mXcYdx14nRkZhBZ0jB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508027; c=relaxed/simple;
	bh=sy1C9upncuhBQxXyTh+Rxtpwh4Dmu08rXywqClXyXnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m0RjvVrgEApHl143z7tgIAA2uDN9yVx7kktQpJjDPj2MiqbhvQfCKM5S7yPGBkzeYFFZCwewbwSuyQstUFwFrrSlFhP5OdS5B+xRt93ecz8773nArrNhIhreNcCgII6NI4+B6z5zuoT2ifF2mG5NqIhnymuXVOOxx4hCsLhKWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwpzYMMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwpzYMMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD8EC4CEF7;
	Mon,  6 Apr 2026 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775508026;
	bh=sy1C9upncuhBQxXyTh+Rxtpwh4Dmu08rXywqClXyXnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PwpzYMMXS9Gr5L46w86KOpDB2MXe9c16ns3eNUT/gVTGDRThEXneCM1dCp/WFOd4h
	 jOIyU5KDK7gCVDDCv7dAZSlOXbH9GOFaFoIfJe/kWjVujBSmNGFzTByx2pCGj92dAm
	 BF6HyALoFXXdTdzgk7w85U7v5mPdKfyEqFQz4VkkP+zAS4qUhvEvLDtC40w4oJiT6r
	 MkLGP3x+wYFTp25QscAVDX2s8eGTLMayde+u+ZXH18J8eaxOsqRV+N5LGExeG10XKG
	 I4A0Mtq07TOuNk9lgoCX4RwsvEJGzKlDITdYE54N744K2zBEBNcNUv4LCFoLJWwtyC
	 97zhBsxazXV2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE9C3809A3C;
	Mon,  6 Apr 2026 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: l2cap: Add missing chan lock in
 l2cap_ecred_reconf_rsp
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177550800529.3255428.11613093006473846876.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 20:40:05 +0000
References: <20260405154741.7051-1-phx0fer@gmail.com>
In-Reply-To: <20260405154741.7051-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  5 Apr 2026 23:47:41 +0800 you wrote:
> l2cap_ecred_reconf_rsp() calls l2cap_chan_del() without holding
> l2cap_chan_lock(). Every other l2cap_chan_del() caller in the file
> acquires the lock first. A remote BLE device can send a crafted
> L2CAP ECRED reconfiguration response to corrupt the channel list
> while another thread is iterating it.
> 
> Add l2cap_chan_hold() and l2cap_chan_lock() before l2cap_chan_del(),
> and l2cap_chan_unlock() and l2cap_chan_put() after, matching the
> pattern used in l2cap_ecred_conn_rsp() and l2cap_conn_del().
> 
> [...]

Here is the summary with links:
  - Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff4aaa2d1db8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


