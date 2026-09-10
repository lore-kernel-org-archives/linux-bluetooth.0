Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCD585991
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065675; cv=none; b=WVhRAwLd8iyuOJDenvrqNcB3R5X/AqWRx9RFmcK2joE6Z4SEth1xRWi+Zs265CNEne3sYk79qfHzWb0a8wAK46tcck83i+jEuJB1k5Ao6D4pHDwtiyGs0DcYbCdi9SL5XauMbS+tDZ39Fey6Fktu+HfTRYgBdfnPnS7E+2kP4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065675; c=relaxed/simple;
	bh=ktsjeTZvvb5TLF+GsTeJnLAAdUsTUuNlOZ2P4ZWM3OY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k1kKDnL3Fb6ZjqcFkAFsWP1YNimZINbedhkOFXJ8cX5aRGfBpEmt1Vep68vhXPIaaKeQ8GfwU/27O0WaA6GdxBi7rdJjFgpyvsLpsw8sHDMZRhg4Pn/X5jQWaBjfHzFlvT0Fx73/zZP0tpJ+ZnR3p8r0B+AX+Rwpi90geCpYC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edBfPEpi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edBfPEpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C3C1F000FF;
	Thu, 10 Sep 2026 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065669;
	bh=i1RAgLXFcW+G9zlSu2izpiq8u5/CNCMsORjzfNUVLWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=edBfPEpi2g8ZNXB/wyvbmE9AGUboSrXdWlkD8aQG50Si8AupvrOnH+XHfIys7WrAG
	 Dzz7fCIpFi/ID/FAgUrj+yQvRKW9vz5vt2tslaiDK3UDBZdJaihy5CN/7NKSYSzqNa
	 bCNACDG49kGIrqAaEsoEVyWzW53WNUvjo64yWpXYuQDXuVLbqcrqQDniFwhdoPRTz9
	 jWAugRT8YUe/BybdWx0CWyrtGHAWl9SLNjOCbZmPs9uJ4n9DmrfOYUuiqpPv3ZBOcM
	 SJGKZ1kuBKjH7bImuH6jEiIdvo193rS621/1C1F8WL3yYHFC2XXTGXR6mLS1Drp0nR
	 +RELUN/Sym9ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 937EE380CEC6;
	Thu, 10 Sep 2026 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/4] Add component batteries and Fast Pair
 Message
 Stream
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906560638.2027917.8831170681056127640.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 18:40:06 +0000
References: <cover.1787327795.git.m.kurz@irregular.at>
In-Reply-To: <cover.1787327795.git.m.kurz@irregular.at>
To: Matthias Kurz <m.kurz@irregular.at>
Cc: linux-bluetooth@vger.kernel.org, hadess@hadess.net, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Aug 2026 18:07:59 +0200 you wrote:
> True wireless earbuds can report separate charge states for the left bud,
> right bud, and charging case. Battery1 currently has one fixed object per
> Device1, so BlueZ cannot expose those values without collapsing them into
> one percentage.
> 
> Extend the battery core and provider API to support child Battery1 objects
> with a stable identifier, optional percentage, and optional charging state.
> The existing Battery1 object at the Device1 path remains the aggregate
> compatibility interface. Component objects and their new properties remain
> experimental.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] battery: Add component battery objects
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e977e8042755
  - [BlueZ,v2,2/4] doc: Document component battery objects
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1f0812f0b47e
  - [BlueZ,v2,3/4] fastpair: Add Message Stream battery profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=738a389928f6
  - [BlueZ,v2,4/4] test: Add Fast Pair Message Stream tool
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e7963702fb3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


