Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4C29345E
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799196; cv=none; b=Yn6yiN7w5Zpa/dLH08oHvD+hFFgj+MG3T5Ytbllnf9d5KyhCjdVrRyS7NggiS38v+SMPIjz3spdsoReroGTrec9rA24yI4WukjlvQkTjE5rpx4FIqACKuUs22acKwrbzrjqB6NF+eFwhh4Kk7/N7Ix1q4aEBksbXEShgpW/jfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799196; c=relaxed/simple;
	bh=QKLpGRaz7EmlRUlDTYf2/YyprQjwVkbcNZbb3tp0cHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CUqRgMNKzRfUuPskrpG84rhV/+KLke3g5IRTkMv86Ir26SNMJPcQ3V0bWFTm6BYjfGfjzwZBQlI5l9GxhloEJRaakr5iAei8lY73bXrR+sRu+ULi4Dbcp+jpfOi1ZEWaFwp/n/Du7sdaSwMmt1ZRJBgKAd1QA+e7zzVGDkr5Pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAqheT1Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAqheT1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E19C4CEEB;
	Fri,  9 May 2025 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746799195;
	bh=QKLpGRaz7EmlRUlDTYf2/YyprQjwVkbcNZbb3tp0cHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mAqheT1YJox07gtRIkOQURTteUzWvtICy3TwyLNjxmhii8tqGtN+tUzhJwlxxXc3w
	 Cy8do8MxF5193gnytFtkBQvgeBrtqdcewbpfkPBxXIZ7e44lKrH3FHMM/NzjEXcAZx
	 sAQKBw+EvWKuRRLExne6XSkrQmcdm+6glYg7mMccEojfvcAfuTf4PRScQUFI6lifbY
	 cAehAZMOEKuIKeHeEmnBVgSh2ZylXKYZRUTlJTjpwXSyfztbu/BThnB7niu7rIOGeL
	 kUa2fvDicBuvc3xOWgw+3FbPX55I1w2Pv3hspVcG7YAcPPqtwFwW8vUrdaJV0LDaHy
	 4O+Lsacr5HUxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0A380DBCB;
	Fri,  9 May 2025 14:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] input/device: Fix not sending virtual cable unplug
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174679923373.3627564.6147962550783807752.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 14:00:33 +0000
References: <20250502165821.2753353-1-luiz.dentz@gmail.com>
In-Reply-To: <20250502165821.2753353-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  2 May 2025 12:58:21 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When using udev HIDP_CTRL_VIRTUAL_CABLE_UNPLUG must be sent directly
> since it is not handled internally like when utilizing kernel hidp
> module.
> 
> Fixes: https://github.com/bluez/bluez/issues/1173
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] input/device: Fix not sending virtual cable unplug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ab6ce0c8f3e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


