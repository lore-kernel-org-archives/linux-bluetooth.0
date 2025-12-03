Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1002BEFEE
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793992; cv=none; b=Vx4RK3CVMm7oZTVPZHWjVkkc63QRI2ephvnQUuVRK6v9ONQ0XZ6H+7wJS0n3Tz/0Tlqs5NBnLPbn6H1KmEY7F9MZdqc5/3nMaJlxdKAHTkpFvfZktV1b1vNMdyuQwVgHpfdff/znDuJs9Jeu4vGUF11xJCXA6qdkhF2H69PSWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793992; c=relaxed/simple;
	bh=ZfkDEu+pOcCKUbDewoRjepGL/ibbxLbNcn1Siw8OFqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kwI/xcdqCl/wYbm8LzcFNutRGX5fbxHoiCURiNEBy2YtPBMaTaelFz6s9gpkFb02PjFaY5DofMRbSXJKVgmCvcyyamp9XJfiI7OG8m6n8Cx2b1avkPQ2Nz76Hy9mtafhntJMuOXfWisDw9EcRx4YpBzJ7RgUEuMHh90Tx5sVqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpsYwUDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpsYwUDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD2C4CEF5;
	Wed,  3 Dec 2025 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764793992;
	bh=ZfkDEu+pOcCKUbDewoRjepGL/ibbxLbNcn1Siw8OFqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TpsYwUDZHmAVeLyeUfp+RSi8x+s3IAklgbuSy9X0MNnZvIisZhLrTq+BI1Ni/qxe7
	 k1+PlyuxjvqeLfhCKePs+zERWO4rjxHsxLQN02ylexvffH1e6OMfzHpqFPh/4kyjSl
	 g/XheV6rKFZCIS1NF1kPSJMOoEsLyTpnmYTgYicH+WR7/f1gl81CRiF9GCu1c1EmCI
	 uaL36fGuhKRhk6mY40gFCzeHXI6LclYQWFqm8xpxTgbzGX2oA9rMTqhVvdKI9pFdnr
	 R0ONrNsOyfplqD9rzyhxy4l0eyL0T0u1byJx/xnU8SV66GoVjILf2xImHFy1Viq0Lr
	 SWzTvcIWQOkqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7890E3AA943E;
	Wed,  3 Dec 2025 20:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez v9 0/3] Add implementation of bearer
 connect/disconnect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176479381102.65731.12885610062602699557.git-patchwork-notify@kernel.org>
Date: Wed, 03 Dec 2025 20:30:11 +0000
References: <20251202-bearer-impl-v9-0-21602a82ad7c@amlogic.com>
In-Reply-To: <20251202-bearer-impl-v9-0-21602a82ad7c@amlogic.com>
To: Ye He <ye.he@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 02 Dec 2025 16:40:10 +0800 you wrote:
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
> Changes in v9:
> - Send D-Bus reply when bearer.connect() fails.
> - Link to v8: https://patch.msgid.link/20251201-bearer-impl-v8-0-f944b6f9f201@amlogic.com
> 
> Changes in v8:
> - Add le & bredr as sub-menus.
> - Link to v7: https://patch.msgid.link/20251127-bearer-impl-v7-0-9a5b06468992@amlogic.com
> 
> [...]

Here is the summary with links:
  - [bluez,v9,1/3] profiles: Add bearer field to btd_profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=930df108f301
  - [bluez,v9,2/3] bearer: Implement Connect/Disconnect methods
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4e21ebcaa5d0
  - [bluez,v9,3/3] client: Add shell cmd for bearer connect/disconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=143037cfe607

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


