Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BB8255F3F
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759434017; cv=none; b=ZhIaP7PtB5tAo8u4qSXcem/uhsymDzOBAnkGtLYP8Z3Gl1cCRR74sYcqLNS6Qz/RRwEXqsFKAaJPsvEb0OH2oXQyMeLuxdkiI/DUHZF+iQHDlLvqYFGmqbhPYXidyNoGA3URilxVH5uh7WRWop6rh+UoSwUNFKCxWl9Yfxu/HoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759434017; c=relaxed/simple;
	bh=VSRRy3hgemvwKDNm4Ks5lae6yrdyXUvwC/NfCE0jnJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SC4N0d0FrA9AvWM0wH8s0CHgleFqsAtXelgvOLh+9rzOn/w0sBTvtXqX6STJ1x9l/ezzTw3w5ZulErfTabbDrQAT+KSstqasqF2/cXxHJCf9h5WNwqOCFNjeJXHVSlXqOLi9olWKQRgnVa6ePVuxVoaU7/eYvFukkxdduzzKcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4FpbO1L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4FpbO1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD4AC4CEF4;
	Thu,  2 Oct 2025 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759434016;
	bh=VSRRy3hgemvwKDNm4Ks5lae6yrdyXUvwC/NfCE0jnJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a4FpbO1LRMTyk6nSxtlxoMlUrC65+KN+em9lNRC17QLxgJ9NRikLTTBqp6a2tDfQN
	 CejV5Y4F2DtznFaCPz1OTmUXVvHJYjNiq2FEiyp7uFhMHrtmMiBJrdFa1PuR5uEXi/
	 ee8KDJjFLG5FlkEvIJdgnhWVN8NyIa7kII37ID7McfqTzJpqBaNnORRQHxaOPOcewl
	 1lkuQhYlMpnM70o+FMOu40kFCN0tuI/ABws/pJcorfsrT5oekFbBg1nh582lfdjFTY
	 Sxbx8o13SDp3EA9OO9VKReFHTQu+t8B8aL643nRMq1U7i5oKPiASOoXKEzSiBSEvyu
	 LkqU9sDUnpEdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D70EA39D0C1A;
	Thu,  2 Oct 2025 19:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] device: Fix privacy
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175943400875.3398412.4498834307961596276.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 19:40:08 +0000
References: <20251001142738.17892-1-luiz.dentz@gmail.com>
In-Reply-To: <20251001142738.17892-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Oct 2025 10:27:37 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In order for devices to properly be programmed into the adapter
> resolving list they need to set the flag DEVICE_FLAG_ADDRESS_RESOLUTION
> but that is only done if device_address_is_private return true but
> currently it doesn't check the rpa flag which indicates that the address
> has been updated to its identity.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] device: Fix privacy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3a16c28e479
  - [BlueZ,v2,2/2] core: Fix not resolving addresses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f1fb4f95f49e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


