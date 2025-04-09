Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CF267385
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209596; cv=none; b=Z4S2aJgfCeQtaMy2aOcqs6tct87WzTfWim2C4l6JlZxM/XONMXyQBP47FYyPmgwNS3c0X+aYKQHj2pqFQCqyjAGrieA/R0X3CdpTjNOmDwgGg7R5J5QwZIWvvI3F2jEA9S0/nyToDf5Xpyi9QrVkZtpjEiuXEMUgV39uE6OzTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209596; c=relaxed/simple;
	bh=WSV178NSNFb3w33aY/pQTkVmrGx5tcxdg0+rC9AlA1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xyncs292edsULBgKhM/yYJCn1rF2gkvRfrGh2DsFGiIYKe6Z0GLLcw4hSpdW6lKgGnUrVbiHeyDxjsIVuejsT63xwDeBJmq4Eju9AyxDZ1pQYlRaZuTM8iaEbI3Kp1f/mol8A/Qakc2NWA994sfb7nFqMwkQN+S+I3A/4zhVIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImdSIRde; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImdSIRde"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50AAC4CEE2;
	Wed,  9 Apr 2025 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209594;
	bh=WSV178NSNFb3w33aY/pQTkVmrGx5tcxdg0+rC9AlA1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ImdSIRdeD7aUi4Q26vYMuWm6pUoF6Kz/ac3ZNe46CSPmsCeI1gDUhyIZrtUUEeOqk
	 eAVlUpuVSWm35rVExQbK1arVV+BkhcXROvk0FwlA5B4nl0//QDn/rvbW6UnsOqK+nG
	 Zg2C4hIfDWF9GWtfkqq1QEyTnxpbZ3IsPRFZ8oIiFHPAY+K+cgd6h1jJW51jhUjX/A
	 UjHNkHYsYHCiZXVipthCocff6aFrx5fOiir/Hl8Gi7vG8XFFCJvrYP4H2RF6LLy0dU
	 eMt84TbmB8Yur8Nbywdn1QWn72YR6DhUIfpwhghQnbF4G1uewAawKrq0+bUGHl4Kdw
	 YjRa/mIN1ElTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9085F380CEF0;
	Wed,  9 Apr 2025 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] policy: fix HSP/HFP reconnection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174420963250.2845819.13289870998224229498.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 14:40:32 +0000
References: <20250401020221.119615-1-yao.wei@canonical.com>
In-Reply-To: <20250401020221.119615-1-yao.wei@canonical.com>
To: =?utf-8?b?WWFvIFdlaSAo6a2P6YqY5bu3KSA8eWFvLndlaUBjYW5vbmljYWwuY29tPg==?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Apr 2025 10:02:20 +0800 you wrote:
> This patch was regarding to https://github.com/bluez/bluez/issues/1069.
> 
> The previous patch did not fix the issue, as I was testing it with Apple
> AirPods Pro 2 and it automatically reconnects HSP/HFP after A2DP is
> connected for about 25 seconds, and I assume the patch worked for me.
> Some other devices I tested did not exhibit such behavior (Jabra Speak2
> 55 UC).  This patch was tested against both these devices, and both
> cases with NVIDIA GPU enabled and disabled.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] policy: fix HSP/HFP reconnection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b3d49f4e030

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


