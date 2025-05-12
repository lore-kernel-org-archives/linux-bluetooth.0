Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BE252296
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067991; cv=none; b=HMTgeOo6kMPxl1C2titCfSvK5xw+6Y/5fRyGCt18RgwuxaDGUO7t+iAe9b+3LjUV/ofXEcmB551zYPefYoPoEDfiKkYYQHqT+v7YSGkmbkDfLurjoEqWIOfXtBbWB9NMMPmOrzXpDolOqmS7H5JdC+w9oURVnojrEKcTua/cdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067991; c=relaxed/simple;
	bh=vAW6F195PS6KSpdLXpIGzUJ060IXsxrOMWgvo825WME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GlpKwxwijGNfm4v/yc+3OD+RQcTiGXMUfgHOLhsf2XsF6Pf01s965Nj5wRyH6VOyqmKZn4MHTOUy5jcAwIl2qJtGowJgoJmhz6HCjRk7yYaiBww5CFA9nk1lj0PSLgHRS2jHCMoCkIAES3orf8osO/aXjdLdjyzFNENTEl/j81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goWHCbMM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goWHCbMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADD3C4CEE7;
	Mon, 12 May 2025 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747067991;
	bh=vAW6F195PS6KSpdLXpIGzUJ060IXsxrOMWgvo825WME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=goWHCbMMuPVJjQ7KNORAA6meeL5WqKcaEwg3OduRbYUaTCVPBWWpsXJQZJZv/Pg1L
	 8i6HIS7KfOx36gj46X+1VmKBsbcSjulg1RI4GMScjRyHWHtfxf0HE83QSzUwh4U+2E
	 xCQAKC1hZjl1sSS7qdb5fcX94anUVm7dsKl/KesM0YWM/N4ZL1/xDm5cZbE19LPpiv
	 An7GT3Ncl9DUDLa1cxcWxXIQ678HXPLCW1kzfcCvlaeVMxvqjMyWUavcBhNzorFqbZ
	 UYDsMtKzJDataDE0WeD++K5YuorJ/AWKlQccVbydJvkIOiJ5O3tFOMDIQyUR+na+Y0
	 xd7KRC7RgM3cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5C39D6555;
	Mon, 12 May 2025 16:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] mesh: Fix possible null pointer deference
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174706802876.1007731.13899487089897715614.git-patchwork-notify@kernel.org>
Date: Mon, 12 May 2025 16:40:28 +0000
References: <20250509201806.643057-1-luiz.dentz@gmail.com>
In-Reply-To: <20250509201806.643057-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 May 2025 16:18:06 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes possible null pointer deference for label reported by
> cppcheck.
> 
> Fixes: https://github.com/bluez/bluez/security/code-scanning/1771
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] mesh: Fix possible null pointer deference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f6f82b39d328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


