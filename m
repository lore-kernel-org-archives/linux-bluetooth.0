Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865F20BB3E
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923822; cv=none; b=c4KUmBSmDq+aWdFvCkvEx25RActyLEArOBgLTsGlBrSr8G2G+IF+9AKCvPZm9E5w1LGkjX5RVpc85NWGFo3JiZH+K4V1fXIjZunZX10abjyymZGv96u37y1inJQva0F1jAfK/iJIVfP1h6/ZanvTIm0b6fRsKDK6sX0dxaUHSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923822; c=relaxed/simple;
	bh=LC0Qu5o3z1R1D2bNYjdktwKrXOml7u7w511awn+XMnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iRtNyda5PGk5JT3jTpcYFT5ueooNUBtPxEB/R61fV9UWTkkZdDQSRYjxm1WjQT/8ux6YHp7tgtvHJ68AGMuZJHkhSpEJcU69QsYGXhnGYEsgG4Wtu30JQ3SzEf5pPKAjbhBXnGfG+pJcnpnpa6ZEku5pgO3552tFNeWoGMmtKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arQc3OVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arQc3OVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A3C4CEC6;
	Wed,  6 Nov 2024 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730923822;
	bh=LC0Qu5o3z1R1D2bNYjdktwKrXOml7u7w511awn+XMnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=arQc3OVZVT43wxo4GNzPcolJKK1fi72650uL7989aVXLqWKD9s2aElu2ONaGwY90V
	 ReGjW8lqHs/Hm9VqRDPw2ukCXmNiSkJkEyZRfbTmmtlOzGOYoTqO8TIcuBvnakX+x6
	 GCvcRByoMEO0JR1xrvto6aSO8vbWZPHz1UQzjJKvlqE6l/cIFZL5msf+N/DBZNljV9
	 BU3QkgTvNjaZe15G08vc+zu4/fBL+4CqtJH6bcm5xIghIORVxLX6kEBocg42sOXXq0
	 gZhGhawP3Nji2LGyAnyJrLSxYMni0c4eBPMd1/k6Gr1Co9fggWsQV0xKeASKIufb1a
	 sR9/fCeH+r0/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34E983809A80;
	Wed,  6 Nov 2024 20:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] sink: Fix transitioning to
 BTD_SERVICE_STATE_DISCONNECTED on idle
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173092383101.1405455.17094778852665148801.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 20:10:31 +0000
References: <20241106154917.64459-1-luiz.dentz@gmail.com>
In-Reply-To: <20241106154917.64459-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Nov 2024 10:49:15 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the stream transition to AVDTP_STATE_IDLE it means the stream has
> been disconnected, not the session, therefore
> btd_service_disconnecting_complete shall not be called otherwise it may
> trigger the policy plugin to disconnect AVRCP in cases like codec
> reconfiguration.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] sink: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=469a75ae182a
  - [BlueZ,v1,2/3] source: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2aade568ce77
  - [BlueZ,v1,3/3] a2dp: Don't wait to reconfigure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa118e965b02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


