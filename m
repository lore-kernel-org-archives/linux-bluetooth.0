Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0561B423B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038819; cv=none; b=Lw7C7Svsn2fIDL1MAk03wmADDnevE4Uujx1Ug/Llf08o8pYa7DdCGCYEifTuGbHO23x7HbF4GoOzXdQUjaL7EVlKr6vlo6unpOiS70wt/6LxJKpswZ5cComDqZ+VHgXycClQQfZXo/hEJUgglexJ+giuFxtmPKwL47jN5no4HyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038819; c=relaxed/simple;
	bh=u/mkyBcyJXS+N78lodsFixaeaHwTDml++B2F0WLaUgE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rv9AXWS73zcSRlg1R5ScQlYMKHADXmq4MkSuAarH9BM9hFd2+Z67p2fx+lNn2GlWppjGqAGYQVmxEV6uKzdBh4WC6jybWW6UwulHFfiHyKmKlKxhGMP+BV/oJC9rDxYvVDHv5bx+Jh96HILxsJbg47884ZafWP7qQ2o76ccmljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu/YD4tX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu/YD4tX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8206C4CEE7;
	Thu,  9 Oct 2025 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038818;
	bh=u/mkyBcyJXS+N78lodsFixaeaHwTDml++B2F0WLaUgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lu/YD4tX3MACxh7H8U/u6r3A9+wE/d3x4cZT1imc2zxwBV8ijSpMFu1WjteDRZwBM
	 vYIIrgedS70T8Aen0PnkxTAsoNl9SnoNi39GB3pr3+vygUpQw2lYyXnWsrHx3ag9pH
	 RBA68H0qOIYi6fxr/Z+/S1lby7nYmVqpHj2QuzZanodN9nzFKc1ydkh9JO6jcq+FJO
	 m6rnpVJosDHyloDUZAzhRTEXlItywlVxL3fAo2GNbY6QZBSXQkDpeJnndZQ/RVGewh
	 fZd5VjLcQ+OOredrcwxRWrmHn5py6F2e3ujVDVqdWoI1y+2O1ptXqcfqSnj5ae4+Nh
	 3q2JZQX++E3Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF273A55FA1;
	Thu,  9 Oct 2025 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] monitor: Fix instance where BN is printed as
 PTO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176003880675.253496.15861307699859710689.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 19:40:06 +0000
References: <20251009162111.221677-1-luiz.dentz@gmail.com>
In-Reply-To: <20251009162111.221677-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Oct 2025 12:21:09 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes 2 instance where BN is printed as PTO.
> ---
>  monitor/packet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/3] monitor: Fix instance where BN is printed as PTO
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1067426bec48
  - [BlueZ,v1,2/3] client/player: Fix prompting for bcode when one is already set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=411e3e0e4695
  - [BlueZ,v1,3/3] bass: Fix restricting the BIS indexes to 1 as assistant
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4be24398f9ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


