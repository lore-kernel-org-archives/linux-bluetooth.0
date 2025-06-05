Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AB27C864
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151197; cv=none; b=WajNlI8rtZHUNFcfj8t845r9QjynLfCGHN0f8DAzmklVbmPkGLcGqRFlbWzUOoFEZR7XJ0+IqwyD2S49jGB/dHLNtsWIywMM+CRzSCGAQav9N9bezM80KMLV7i3dJsepvoGvFM0kDqb+Bq6Lxy6BqaqdHMbzYJ67I+VywQQvXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151197; c=relaxed/simple;
	bh=E8yK9iDwAd4oI4XHlYkta9v48E7sZuWgE2iT9axYHd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ts1tYQzX6jwlVMu4OaRbr+HwDbeyFzR/T5M26mFR/Yc6VBH0nfo3c5jApMHygdOxi+VvdKfwcfoSlk4/WuSKnrRATebRj+nTOXIIFsXLBjXlWIUrnFi/aEpVOTE31oaTYpDMs8ewOOuNF7S2LMI9OiDkXrtRkNYrxYcoy9niYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag5/rmhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag5/rmhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE92DC4CEE7;
	Thu,  5 Jun 2025 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749151196;
	bh=E8yK9iDwAd4oI4XHlYkta9v48E7sZuWgE2iT9axYHd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ag5/rmhj1Qn0StqLfS2scPB4NCSrlF9cKUyWAWINj2HW7jhG5eR6Gee+JYweOrBSn
	 WLh9vojAmViYWTZqEOU8xTw4dXvOFjIcCVJ8tnmtuVRKTncucUlCYQ0gryiL+uCjvz
	 MwU7+lMq9scUugVTlSqZ7oj6Y5p94A7x6CIX4FviZgwdf9yyIpwyJ2W7kG00rtmE08
	 7YNiQ0/XxCeCLbie4HNoc6fdfjDO8Q8IpQlorEE7yyWCMv9OQPSgXBeFEElf00ajQX
	 Vb7+jJoW7N7WOuDSbatMjpD0gcTDhfZ8yfqYNvEyBadURbnvP954eiuiypPhaQ8L75
	 1r6gdavqa5zlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE239D60B4;
	Thu,  5 Jun 2025 19:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: Fix NULL pointer deference on
 eir_get_service_data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174915122875.3205310.8740710645862296239.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 19:20:28 +0000
References: <20250605152316.807664-1-luiz.dentz@gmail.com>
In-Reply-To: <20250605152316.807664-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Jun 2025 11:23:15 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The len parameter is considered optional so it can be NULL so it cannot
> be used for skipping to next entry of EIR_SERVICE_DATA.
> 
> Fixes: 8f9ae5b3ae80 ("Bluetooth: eir: Add helpers for managing service data")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: Fix NULL pointer deference on eir_get_service_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/8dfaf658a378
  - [v1,2/2] Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance
    https://git.kernel.org/bluetooth/bluetooth-next/c/7615e0c7b24a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


