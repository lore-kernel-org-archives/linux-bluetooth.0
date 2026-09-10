Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11B5867E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065675; cv=none; b=nh2nBubtKzsj976L8ktd5WsDXxHuw/OkDhCj980ZgnxEjXO0Owc23+zrqAxhap9j8cYWB87sl9cs8pk6/73ZA8BYK/yWABTyV+jbfNTjnOFcQzRZ6wk8e/JV3JfPswKpHxLYFsspPCCk1GvcnQaf9pN1pUmAbrxfzuYerKhxC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065675; c=relaxed/simple;
	bh=Rg/jdj3VnEfXLiMEXA/6T4F9Xqmi+8/Kd4DhJWucvbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MbAmUfyV5gpGKypHyNEqiK/R66knvLXJwFvq7vmJlQKEErLIWV3WIImlqRN7hCqp/v0CXZfrzRNA1V2JuCB5QhGTbjjHbNWvKKRKz+KhwDZA1F5XVu4X0owSYjmV9fVxgHePJ8F2B0WStYcuadRdWufMPGGEu9ZTD2C10y3jLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiMFIS+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiMFIS+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A171F00893;
	Thu, 10 Sep 2026 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065670;
	bh=kGn2J/5cwJgRqyT1/4e+YGPvns2CO8jHLKMw5hvpsdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OiMFIS+l2gSOpwBBaEBZoW8YA73DoluKeBspXr/WiTH8WY2Ib1lioM9VYtqOIhe4e
	 /hChX+jQOSAEvcRfIP5gtrE0hI/IdQNk83L9pUvtqqDDyxcK53nz6M2wH67F3GFzbj
	 5kfqLlB8PCWbFoA1tcxNPdtCOwNxGcaQ5v1QhfHIjYZSiP99Z9c7bWpi2kiJC5ex/T
	 1/2Hsl7BHYbESEYozvKwHjPgZTQmbpFuRLU3BaB5bwlEdkmIRYzczQjkCmv6aYrCaN
	 yDIVD4MweRlCMPw7EnBXN5BaVKbLkbOBo4yilmi1H2VLlXBs2pz0BTRMYUS6sWXcJQ
	 3UPsIjI+qc7Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031FE380CEC6;
	Thu, 10 Sep 2026 18:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/7] plugin/admin: Make allowlist adapter-scoped
 and
 enforce at runtime
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906560762.2027917.10966834300247209330.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 18:40:07 +0000
References: <20260819144337.889893-1-frederic.danis@collabora.com>
In-Reply-To: <20260819144337.889893-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Aug 2026 16:43:30 +0200 you wrote:
> This series tightens AdminPolicy ServiceAllowList handling and makes
> its behavior consistent across adapter selection, adapter profile
> activation, local SDP service registration, and device service
> allowance checks.
> 
> The first part removes global AdminPolicy state and makes policy
> tracking per-adapter, which fixes D-Bus updates being emitted on the
> wrong adapter and avoids cross-adapter coupling.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/7] plugins/admin: make AdminPolicy state per-adapter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58495d652dea
  - [BlueZ,v3,2/7] client/bluetoothctl: make admin.allow controller-aware
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=640a1227d02e
  - [BlueZ,v3,3/7] src/adapter: enforce allowlist for local services
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=006aea02ce42
  - [BlueZ,v3,4/7] plugins/admin: reapply allowlist on policy updates
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=301a500789ad
  - [BlueZ,v3,5/7] doc: describe admin allowlist runtime enforcement
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=37cbd0b79deb
  - [BlueZ,v3,6/7] device: unify admin allowlist checks for device services
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=02b839af0b4c
  - [BlueZ,v3,7/7] profiles/audio: make A2DP admin allowlist enforcement role-safe
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da088621411a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


