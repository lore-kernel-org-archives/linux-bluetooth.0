Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87351DF72E
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184798; cv=none; b=p0sOxT9JDta9WlvPbFX4YY+X3anUWDo9h6VZy9uM+vOmByDlb63xYBGuSjTWWbEZ4RU0cp7uDu86rwgnWBGwr67S8UVo5uxz7rhUEM58RA+kvbKF3JhK/8WC8VHg3HRsh0fayVHa/jDvQlgNG86sut4lX/tAB5GkB5M5pnbUwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184798; c=relaxed/simple;
	bh=t2sLSUpOM/9UcpaTfsyEmeDZqwLFFjN020Qia6011nM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fdZKy5fsByw1xTR+cCkwjpGGSyfuy2F0EBooOGUYmDhyCHM1s/aXqef4PX0ZHxoOfGp7WTAKpOZfRSDwtg3aeO8Vb7nCPrY9IJDNV5oZj1rGZg0Pb4UHAcvkMBKudAhGJrAAy6sJoOZpUTYMTn9Rty9pA/5yM51G+huop5tSVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDnStgGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDnStgGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545AFC4CEE8;
	Fri, 28 Mar 2025 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743184798;
	bh=t2sLSUpOM/9UcpaTfsyEmeDZqwLFFjN020Qia6011nM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FDnStgGrUvXKYX+0wSWLiZ4Sm1fX+H7TOBqpAR0ihHNN2HxVXGoo+s17tRI42G1C5
	 xFGC1u0Si0DARY0LuwoJR6xvXaewUa166s9vz5FbW7yKxhfBeAxD6Xpy1Ai277yAdQ
	 dGg7X6i3EN9h3DxJcguv3NUWIIdCJnj5F6ftKpUtTYEeBwf1ZMBxrdIU7hdOc0SYn0
	 2XyeijT/bgr+vA1wrcyW2S+NRs8t8CWQlW3yQF5Cuom44fKvR3+0oWqoE4uEavgzuF
	 42X8MkFh2sJVrQ5ZF4JMi2sOuV9nMEaJdHZ21HsRUtnyBqzwSQwyBHFiLRNQgfsQvV
	 2bWOtjp7xJXZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD683805D89;
	Fri, 28 Mar 2025 18:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc: Add initial SCO(7) documentation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174318483477.2915158.11769934039967023008.git-patchwork-notify@kernel.org>
Date: Fri, 28 Mar 2025 18:00:34 +0000
References: <20250327203006.2936448-1-luiz.dentz@gmail.com>
In-Reply-To: <20250327203006.2936448-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Mar 2025 16:30:06 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds initial documentation for SCO sockets.
> ---
>  Makefile.am |   6 +-
>  doc/sco.rst | 260 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 263 insertions(+), 3 deletions(-)
>  create mode 100644 doc/sco.rst

Here is the summary with links:
  - [BlueZ,v1] doc: Add initial SCO(7) documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8ebb0ff11785

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


