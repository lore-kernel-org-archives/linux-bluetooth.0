Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E130C36E
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468410; cv=none; b=DO4ops/N0VIud6UuFuOt7+TMONPFMh4pY1KARRJxD6r9+PasYs5CjKhZzWErlC+iL62osj5TwEK6FDvYm3Dbrl98lMGm0fYb4t2/eHM0blNwJ4Z0VnB2/eIpYH5K9TanD5g2nwTya57DBc50yGHK3cfLcDOusAJXcZXqgtX+AxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468410; c=relaxed/simple;
	bh=rr/2zAyTOWVwVnptBriPZTHQF6D1qMwl86yJVPHHXGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FLXVhTEhq2arVYSxDT6zXjDn/2GY12nj84PDKXL5EeMoYMvgkz66hzZZdtyRu5e5t4duv1D7WqI3ddXcpgC+gxFAjCnj0EXD7TZLOY7/NSRfwErMOXlPkBQdCII5xrgBQ2G7FG3fjoqFYnM4wSRtJRN7NM5GXwP8uDO7Q/iYdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE6w29CB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE6w29CB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C528C116C6;
	Mon, 26 Jan 2026 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769468410;
	bh=rr/2zAyTOWVwVnptBriPZTHQF6D1qMwl86yJVPHHXGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VE6w29CBkM5lwDStxpFrf/x7t3HUpdKAilK4zvnbtPIk+haQKdMwhZDtXHMwLoLsN
	 meh1roc2uIwFWhW/p2VjbtMzgAb0LRkikl5XMNY+bQllHjH12vLSUb1XySscBoBB6Q
	 GOMcWTXOTlHGW1B8bnHkDHaNZNIDalCK6gz4wBGOm+74RBalZgPSC8tpMN3nE+Iyj6
	 4Q6h6JVYDNLr8HTxH7sRfdxWbOktcjSJ1DOiQ2JZwnAHshXbqYnuNS4c6i9JZX5OZd
	 zvvLxYEAbOZB2wPQQ48LPs5Qa6//v/y4nsY57YpiEbcM+0zXPdn2Sk1b1ykVUql64v
	 dy09Q6OtMIWQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D72380A958;
	Mon, 26 Jan 2026 23:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] plugins/admin: Fix storage file location
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176946840460.208829.4470689210192866250.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 23:00:04 +0000
References: <20260123164257.853415-1-frederic.danis@collabora.com>
In-Reply-To: <20260123164257.853415-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Jan 2026 17:42:57 +0100 you wrote:
> The admin policy is set per adapter, as stated in
> doc/settings-storage.txt and doc/org.bluez.AdminPolicySet.rst but
> currently stored directly under STORAGEDIR.
> ---
>  doc/settings-storage.txt |  2 +-
>  plugins/admin.c          | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [BlueZ] plugins/admin: Fix storage file location
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2d5afe34bb05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


