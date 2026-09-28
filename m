Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2D1A681B;
	Mon, 28 Sep 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610098; cv=none; b=dR8CPCQYXfFAsv4eoM2FIm4qjvZOmBwkd0tUlSHy82P57eCKxf2PUlgVaFD3GW/25n4lq5SGa9QbgYV0YOPsZO4GYi3X5Bjb9nUmVnr1FSV382nc5H9dDuVvr3Z/3ZXAGVNjPkV8h/qLj7zXWB22He3/WW8esQ2BuD3qaFelIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610098; c=relaxed/simple;
	bh=YtZTkRT+KkFERghcrmO9yBE7MlbcCBw4KFwwn2D3gjY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HxVyTyaw8YeNgWgpkahpn1fjD5Q0l5EftrbeWEPfNdf9eBxiimSQq5kTcLUR7HCtQHdzjdLaDnia06Mr4LVXmxdidlfVlQ1gmZA/IcLb9HD6ACaalW+tUfbmExfll93X/Lrq43ZGWwzZV9JE4v9oLJ7o5lKSTrl/skfzvGs+2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEDwhQyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEDwhQyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA691F000FF;
	Mon, 28 Sep 2026 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610096;
	bh=+CCrRpAw78jDH8mpX/ibpuK5hmAos3vXUBO90Hq/QP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gEDwhQyXOqavK/A6DymGtFseRbBfNkQT0/b77gAp9K+89BW11OVIq6IvOpYOYMV6I
	 bl0YF8+TxBot/CG6HD54nrhUe/LbQSvXWNdnFwvbFpFQ65IcKh6Iay+BXx8IKlyEfB
	 Ehs18UsHLDJBkRlMsIhYXBxTY4nsFyvP3zwKJgx8ZLe0OkYXCIY7+Vy3YtODE2xsD0
	 /Jn8+vQcS31tNeT2OFrWgJitCBxmhssi8Js1S45UlEn29VRmCLgRBq4+B801oDB0Lr
	 KadUOIWahYe+bVv41QrZTSNhpcJCUjpdQ6kgTZAoLXHuF5YwgIUbJv1RdG6RxySGJc
	 8LncwyTaXYnIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CDA3924456;
	Mon, 28 Sep 2026 15:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Bluetooth: Serialize TX scheduling with teardown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061002143.4169639.3931590453704871029.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 15:40:21 +0000
References: <cover.1790407061.git.nicoyip.dev@gmail.com>
In-Reply-To: <cover.1790407061.git.nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, padovan@profusion.mobi,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 01:04:01 +0800 you wrote:
> The TX scheduler drops its RCU read lock before using the selected channel
> or connection. Teardown on the separate request workqueue can then free
> that object while transmission is still using it.
> 
> This series fixes two distinct lifetime bugs using the existing device
> mutex:
> 
> [...]

Here is the summary with links:
  - [net,1/2] Bluetooth: hci_core: Serialize ACL scheduling with channel deletion
    https://git.kernel.org/bluetooth/bluetooth-next/c/f4845ab191a4
  - [net,2/2] Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown
    https://git.kernel.org/bluetooth/bluetooth-next/c/848a7a91c7f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


