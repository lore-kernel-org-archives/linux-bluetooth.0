Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E737A822
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576008; cv=none; b=ZhtI9Bgcw7IjIOUpM3ITvm4I9a9ibSfONFim5sUe40OlPTGJcKutXVlqcqemmSqenuxKaB5ck11cuvdrXf4P+oznZWpOZB5vZXMTAYfBgx3xNkS2F4WVsLNShy7CarGLk2nmgHfPOYJbAYwaKl4Vk4EbtmIWMvxskL/oaOYtGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576008; c=relaxed/simple;
	bh=rXUT08JYb+f/m+sKDtlOn76xAXCrHK5VK1h641/Jbzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oaERJHBzj1pb0Rhwyq2j8sedqrPlA5L2hrIX1S+lH6Al50GErgMylQk3WgZYh2hbcOOXUJlIuEeao9kDcefiOw5Gbqw6UrKOfSK/krsXW5JWeSJdA/XUEDaL0Xs7uofOyKLcB/HKXR964CxOHLvFmmhyFKf+m7KZ6QukRHLmnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuC73Rxw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuC73Rxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190721F000FF;
	Fri,  9 Oct 2026 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791576006;
	bh=SYBaxt1+IRYlujcMTZL5/JpCHipblzObpp8aJLYbEbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UuC73Rxw/zj1jZnblAwpSwod89c6lSbnQfXqAOVXSpNlMO5oYzL1bMwFGOunvfWIn
	 OtHzGbQYdhwtoMtq/votHbI8XAKBP5a6ttJSBNtF+Ixk70sEpZyZvZJJ9JwZSqbm0n
	 IUsZ025c1DYmFR13A9Ua2Olndc0n71gUwDZQQwaYMj71O4yOpf0iEbOsil9GGKe5Yz
	 Srtv1UXo39GqEGYLRpeRqHg4yY6Fnftqipfnbg/Y7PwRU1XuPuY/lUGkLsQFNpQyGH
	 zn2QuJjKXjhAJ0OlJhm22xVKS0GixB8tCgf35Hw/S2K8RJpU5B5kjklL7EhBx07+Pl
	 repWxwubeWBng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1552392627A;
	Fri,  9 Oct 2026 20:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel: load unlocker.sfi to allow
 unsigned
 firmware
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179157600477.981840.7983819101524117703.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 20:00:04 +0000
References: <20261007124721.2521956-1-kiran.k@intel.com>
In-Reply-To: <20261007124721.2521956-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com, ravindra@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 Oct 2026 18:17:21 +0530 you wrote:
> When an unsigned operational firmware image is needed for debug, the
> controller requires intel/unlocker.sfi to be loaded first. Without the
> unlocker image, the controller rejects the unsigned operational firmware.
> 
> Support both firmware download flows based on the unlock policy advertised
> in the version TLV:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware
    https://git.kernel.org/bluetooth/bluetooth-next/c/964430c03896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


