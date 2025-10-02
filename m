Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C197264A65
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422615; cv=none; b=rgWXNmyhrBmQy63OgXnqaWyAyDGt54E/61JWSsLhuldv+TFC9AR40UdoJQiZX/ZdbUTd+rWRvdJRItRgNw/Pd8HvI0IgVayVvGLy1lRGhc6DrPoHCGHnSedlIXWZmmcKAFxg5tUuBFUxTuE5RzNqsLBG9UWj6NZY/9jdXW3fTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422615; c=relaxed/simple;
	bh=M7vHvRGZ8bKowPmpr8FlJm2opYwWrV4nRiAcCY5yEnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RK8p2DXC3253jpWkbrBdgQpC8xJq8UdLL3u79kbYOtF78e8h71olpGajUY5lSdAYzfNcnjjw8rc9/gEyKwyLpIjZI9FELxb32LaE9MJAufARUcE8D/6W+dLeUU9JE10eCduwvsR63+9ncWf5fY7GfzISDneacnY2epm6H/uAfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea+IcoGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea+IcoGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60B2C4CEF9;
	Thu,  2 Oct 2025 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759422614;
	bh=M7vHvRGZ8bKowPmpr8FlJm2opYwWrV4nRiAcCY5yEnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ea+IcoGNoE7ZDPoKbmgZACf/F1+cE5qOtUNlvq91+y6b6wHRZfe+pQxWnXxteHoNN
	 rzdgEbN6QhDLIfXgnCQx7FI1ozyICybLGCN71/2vsFj5b2atCd+aMaJjsJs2vXINYc
	 FfEzaKxamkYdn2HfrGLF3RQP8rQPKtRQpxeZmJodoBJHYa0ITqCuemUvQZszTTF2xB
	 sIBm32aI4Zqk/ccE2DCC5+OJPqGw2oq/ZSyzPUrZD/C0mPbBWxCvzu6MqpU3q6MJ/q
	 +pceOTy0Q/YWI5yHFLwwRBbGAxUhdNM9owlYn8PCS1yBCcEsGy7K/kh/fhHVFLWdBM
	 Wyl0L0Ip92/0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 117BB39D0C1A;
	Thu,  2 Oct 2025 16:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/bass: Fix permissions not requiring
 encryption
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175942260702.2981110.9319812400803752699.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 16:30:07 +0000
References: <20251001191352.77542-1-luiz.dentz@gmail.com>
In-Reply-To: <20251001191352.77542-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Oct 2025 15:13:51 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Both Broadcast Audio Scan Control Point and Broadcast Receive State do
> require encryption:
> 
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/24670-BASS-html5/out/en/index-en.html#UUID-dd95da9a-6ac0-3f45-7e34-13fa9e04d41c
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/bass: Fix permissions not requiring encryption
    (no matching commit)
  - [BlueZ,v1,2/2] client/player: Set QoS.Encryption if QoS.BCode is set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e55476bf6c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


