Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28DE35975
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416411; cv=none; b=ViKJkuyh11TeQ10ywSnMeai3AfsoTvpgakviUp5lLvC8zK82SsXSkA5W+nGZo7tJTz+gNZTDn0aG4UxuWQ472rNCNqPPCwJ3C3NwxpSbcDlhT14wVifyFQUFBpHNQJQsublqOfgAkzE2oV+UgtRqHEzZlMTBD8o48VfueczmFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416411; c=relaxed/simple;
	bh=ZTRntTdQjIX6b+oNyGyVwged3/dwFZqAGpPfDLJKlyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TMKsOvcuzgW4ce/ZZatNrrAkTMkaGWvGD4Ur1kdKq4AB4FvT3s5LGQrT+AuMLhfYtScJOmqDhNpRnSkjdomn9DAqXBsOZMZRkCcWeRCpjuAUgSdiT0bYW/8xh1ITctekEizLBvz8ZSDu2kx0TtXdKazDlb8L8Jo3MNtLMomlLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gij+yew6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gij+yew6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367A6C19423;
	Fri,  6 Feb 2026 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416411;
	bh=ZTRntTdQjIX6b+oNyGyVwged3/dwFZqAGpPfDLJKlyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gij+yew6FxSqjzmibb+8eGIQbLtAYk+f/sglVsaCjrIAUEjBNpylnQ+dQdafYC0pw
	 UMdGc5VK8uyCQgwhSPKPmcy09npc/4vn6iWBqZ0TO1aRix7oBwVBbVDUILAn+e6sVU
	 N6ZsWyY//JyBhHyJOclsc/tdSSzsi+qodD1y80eukR5wiYbc3X5GSRJqeUjIxydZ8d
	 0wT3GCtpWwymcFcXWJ5WXbYfYYtXSvDz7mszhafYwiobwv7C0hUa5m3TKc1h8VQ3y2
	 d73u4KN4ecyHQBEia4J3jd3VnZIsEfoGgh5JdKhbS+BxPHfCYWgEAUmvyg10TCh+zR
	 FqvbHrVaZEAYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852B63809A17;
	Fri,  6 Feb 2026 22:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] l2test: Fix not being able to use -X ext-flowctl
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177041640804.1095978.516587574984714137.git-patchwork-notify@kernel.org>
Date: Fri, 06 Feb 2026 22:20:08 +0000
References: <20260206190345.329635-1-luiz.dentz@gmail.com>
In-Reply-To: <20260206190345.329635-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  6 Feb 2026 14:03:45 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> -X ext-flowctl requires using setsockopt(BT_MODE, BT_MODE_EXT_FLOWCTL)
> but instead the code was attempting to use L2CAP_OPTIONS to read the
> current l2cap_options which is not support when the address type if
> not BDADDR_BREDR.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] l2test: Fix not being able to use -X ext-flowctl
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6704b44cce88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


