Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB5B79927
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400227; cv=none; b=OQpaMnXaOdMzKye2UQa4XcwBeKUift+a343W8sAlbxnm1GnYmZGpMfZ0r70yMO5z+vuEe1TrWx6gT+XmZ7lyXDsjZHiB1SkCZYw9p9VhiUqJV3yPGAeLlc1gZaj036x4O+cMnC94QMSDZO9XHlS3p91dXrH6HlSP8EZ+RZgBvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400227; c=relaxed/simple;
	bh=i/Ch4TPyhHEIrpntM7t1LxCHg8z0bhqGY8Lb6dAsvf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mSOGKqFq+7QoF9Bj0OyC1/dwcGkqG1qBzE5I0D8jzVJT8oXuUnWOpfBzvvhvt03+sihKrrKHtE9RZs+f88Tpd/TWCfg9OkPkt9iT8+uBWMYpduuhLJMZMNb6O8XE7KhoKgoETUnO4eg1qgUOCmO8vFY8Jao1+bNZAvSsjcA91hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSUCh9E/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSUCh9E/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C351EC43390;
	Thu,  8 Feb 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400226;
	bh=i/Ch4TPyhHEIrpntM7t1LxCHg8z0bhqGY8Lb6dAsvf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lSUCh9E/dNQZBK/tUWvVkVYnijLWt82Nl3nrT9kOA9K0XcvpmEJjSnFoVqwxJTfNv
	 rW/NAxF4MWMBKA0zrjk25YHBMpiQmWOmChZdRBLl93uiX3WMDw+WbqMimwOnvoop1o
	 wuYXn9U8z8eC0UJ/aYEAn4q7e4F1ixuT+XVph62vSt7YpTMMHNKCN4FcYyqkyJcl3M
	 7aN24LnRdpP8g3L2Z/BIbsNF74CqGRBf1qSCjqz5ZmWdemtb8ez4JpmGSuHyErOc5L
	 bNGdrBpp2fgJfqWGQ6vbi7xm8Q+Lb+p9GK5gGt3GrroHswHEgdCzPyF/8x3CmRloAg
	 J8SEGQxaIF22A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB426C395F1;
	Thu,  8 Feb 2024 13:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] mgmt-tester: Remove High Speed test cases
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170740022669.9267.1983690787157211720.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 13:50:26 +0000
References: <20240207161724.2906072-1-luiz.dentz@gmail.com>
In-Reply-To: <20240207161724.2906072-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 Feb 2024 11:17:24 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> High Speed is has been removed so these tests are not run anymore so
> they can be safely removed.
> ---
>  tools/mgmt-tester.c | 63 ---------------------------------------------
>  1 file changed, 63 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] mgmt-tester: Remove High Speed test cases
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5135613ce057

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


