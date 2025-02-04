Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489F220694
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709409; cv=none; b=urVP90NvL9bvGMajXWDTaHlPcMYaPqPr3/K9euv/oVv8VNZbdbQIvwQygrcVND+TjUIxPD7cXQsR9QKaa53t0sRelc08jjN4jhBn6r6T4RZBm//jBmHsMq97ZVXfwcMnexj+61jryq3wHqwJCGnlyABwqe+bRJ6+p4vrPEtEqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709409; c=relaxed/simple;
	bh=9gtSQmjz4Jfhl4oaITwxbrXJMxAZV/KMev9PaTyHwaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RgWKCuld8g23dYQv12LroLH4XrxxTAyB73+OU+VKkDdbhi00Ssy61ySrfea4olvyzQpFkOiLP21zIk68d8bZrm5liXVRSJDmCL1r+HRGIw5BaOD1h4iHxPORD/bXeKekaCpSjUdIETquu/sl0H4ILVpZx3+UZ1pkM5Jr+ujKDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P52L80oA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P52L80oA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3302EC4CEDF;
	Tue,  4 Feb 2025 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738709409;
	bh=9gtSQmjz4Jfhl4oaITwxbrXJMxAZV/KMev9PaTyHwaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P52L80oAjYXc+nqBWoAyvEBUCovZ5ATQeg6iyC12ADug7x1J3n6MNdJ7m7LVVg5ly
	 tTxgJlYF2TgvUZXf+4rSmhR2zI8DuCnefX4M+E0O2IPYnUv9AtoLSeoqa5gZZYt77D
	 urbTI4hwTltgDuM9hVhcveEnNaEyyyNA/2wt18anbzcm9O1PjlUcwUX4Manwdbh8Vj
	 iz+ySC6NxMDc8hMteszdacs2/fDmUzaOf/4N3CU/cP8wsrWjcZe/eV0t8ybaGNZVy6
	 P83jNrycM5M/R2Iib9Kx7BZrt7LbBcCMhk2zJQDTYWPCa0gi5D1oH9QwC02tp3zD2c
	 Iu3/wDY5UDx9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE162380AA7E;
	Tue,  4 Feb 2025 22:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] mpris-proxy: Add mpris:artUrl support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173870943624.172153.7815659979300581943.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:50:36 +0000
References: <20250204154020.95539-1-frederic.danis@collabora.com>
In-Reply-To: <20250204154020.95539-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Feb 2025 16:40:18 +0100 you wrote:
> This commit connects to the bip-avrcp Obex service if the
> org.bluez.MediaPlayer ObexPort property exists.
> Once connected, the Track properties update may contain an
> ImgHandle which is automatically downloaded, then a Metadata
> property updated signal is sent on org.mpris.MediaPlayer2.Player
> interface.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] mpris-proxy: Add mpris:artUrl support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=01a5a268143e
  - [BlueZ,v2,2/2] mpris-proxy: Fix infinite list items reception
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4bc8660651f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


