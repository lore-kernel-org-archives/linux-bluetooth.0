Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76442CA9
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590987; cv=none; b=mFi8UZxsTrMcBWJdDoCCvfxTxdzlJfEa9H9D4/oOGPNNNwgkKemkHMkSgUZTYBnYaDak4JSZPFd1cTIe9TvqphKeyfXjqtXOcdzOjGTQZfKcJ5wVWdwRghOST8Dof8Tf9+lJoFx9kAn2+uERe7JqQ1/N127eK3mm3Z/kXmnS6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590987; c=relaxed/simple;
	bh=oN1BDH/L5fGm6A6GoYKCnjc3M8h1q/WMAAja75bev58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NIGdfgC6TfZxLRhHZ+OgbuZPsm+MkMJFOBM1pIYFnKuaOTUPBtPnC8lI+Bwd3upN+31ozgsBL0Wn3BkxhOJI4/bxMG7Whwgc0UgVoEYO50rWRTZiK5kwAohkAR2joYWDj2JPufheDxvSjAYt5Pqmcbue4o3i0Hm82H0A9LgpRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HetPSlFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HetPSlFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D840C4CEF4;
	Tue, 15 Jul 2025 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590987;
	bh=oN1BDH/L5fGm6A6GoYKCnjc3M8h1q/WMAAja75bev58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HetPSlFp4flj3KiEbz5YZuqSI4A+oMK8XXXk9v3b665qiLAMR2jVlMthl1ytqUrj8
	 OkgFND2V6fgjJTiV0e11IH/xbVRO5EwjU5rmVMXPkwMNonJkdreoOcrxXteq/uu+Z2
	 UZ56daIJ5MJTfPfl9pENf+AO+k8OSfzY6vGtebj66wyfH4grfOykKfNUB60g45IC/S
	 Yeal4DKVB4oRiVPaoubgWos2Q5/ICcfnfXGiChrX/x2e7mUBI5Fr4qeguEE1WQMejo
	 2Nmd9x0b61nC60Ppa2GSrSh0wqzG40RQFHWNruqEm6Etvyi89OWxDygO16KTVANxqr
	 v0Zei+fqoSdxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1E674383BA03;
	Tue, 15 Jul 2025 14:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez v2] adapter: Fix RemoveDevice timeout when device
 already disconnected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175259100774.468243.11042910246929634168.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 14:50:07 +0000
References: <20250715-adapter-rm-device-v2-1-f0ab3cc19391@amlogic.com>
In-Reply-To: <20250715-adapter-rm-device-v2-1-f0ab3cc19391@amlogic.com>
To: Ye He <ye.he@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Jul 2025 17:28:20 +0800 you wrote:
> From: Ye He <ye.he@amlogic.com>
> 
> When attempting to use RemoveDevice to delete a BIS source device that
> was synchronized by the BIS sink scan delegator, the kernel marks the
> device as disconnected due to PA(period adv) sync termination. However, BlueZ is not
> notified of this disconnection and still proceeds to send MGMT Disconnect
> command. The kernel responds with MGMT_STATUS_DISCONNECTED, which BlueZ
> does not currently handle as a successful case. As a result, the RemoveDevice
> call never completes and no D-Bus reply is returned.
> 
> [...]

Here is the summary with links:
  - [bluez,v2] adapter: Fix RemoveDevice timeout when device already disconnected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c9977b02169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


