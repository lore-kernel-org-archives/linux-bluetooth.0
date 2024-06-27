Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052219ADB6
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513631; cv=none; b=nSRt3Juy2WcXYaNzPnMVJ6UUyBZ4Ri9zTscTDqN+fKUpj+a7l3xFVAwf8O5XOj6YBmxZxWL+yvSK123Xor7/uqrmfi1s55iZ0WJSG8ihfAy05/L0qKvsZb50pwn4umbyHyfIP8DAybOdGYUhYBzDsizVOCVEp/5YhWcmcStdgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513631; c=relaxed/simple;
	bh=mT+M7+Zk5B6HczCQ9cO+sv5vva+58IO760IYVCtUZGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIG+oXyLHtzGpRpDu4Cwqs9n07Grp86pVhlUKjMRTLJ20aMI/JqE90MF+L9KrF/fkY3vq7k+CeDnk2CC53VPI1UeIxPY72mCT86b2xqDDxEVM8V6iTvju2theGU2saf/fXmdtW5H5kB9wYNgOk+sR5TMjOc7h7HlqJr3WE85OVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzRG4iea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzRG4iea"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8744FC4AF07;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719513630;
	bh=mT+M7+Zk5B6HczCQ9cO+sv5vva+58IO760IYVCtUZGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jzRG4ieacobmOOm2LJOiWCg/hxdvMNvRZLrbtMZ1kBxkN9e1EXGGsMrBDQEdNGyFs
	 c9ufYaDuyy/j18S0GKrQxwCheZWStSGG6W0odTDvd6dqK7oU1nxu1pvgt0kRkPQIex
	 1vo8Q7mW1QYcN6ZwdgPsxxtcbJeLBasnDUjEVTkS1OyVtI1zonyT/H+mUO2HFIpxyQ
	 wk7StyMTdKDqzOuZM48YvkwLXWqXKPNMh1HAnfHvF2jio+9flGmD/NlNITGxDLtYOR
	 4qG+U97gvBXHMtzC0M3KOoLJGWBaC1YHW2Hxk/NP/yI7CF3crRT+DpSdjN0nEYvAKd
	 Xrmf7Pf+A2Jeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79055C43335;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] media: fix memory leak in endpoint_init_pac()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171951363049.21304.16252465114425501447.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 18:40:30 +0000
References: <20240627130552.80610-1-r.smirnov@omp.ru>
In-Reply-To: <20240627130552.80610-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Jun 2024 16:05:51 +0300 you wrote:
> asprintf() allocates memory in the name variable but does not
> free it before exiting the function, which causes a memory leak.
> 
> Add freeing of the name variable before exiting.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] media: fix memory leak in endpoint_init_pac()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bf4ec513929b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


