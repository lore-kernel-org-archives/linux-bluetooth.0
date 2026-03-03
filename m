Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6135CB75
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552404; cv=none; b=sy/X5FpTxhzCxnJPU2S6RJMu2/htzAKZWqENiVOECWusrZ6EtBJVLzaPshlFpPAwRUBj7wyib/haBP+jpIoCwpKGotqsqc1esq6SkK7ZNyvp6Je+qCoye61O3jKx0H7inKVZOcZVGMCLyIbXcVjIRtB25CCMHK5n7BykjznqWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552404; c=relaxed/simple;
	bh=geR+e25gI8JIZXUEe54e2qYrHx3SADLCMRTGAizRizU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A6a3U9UisGh8nUENpnL+tHthwCIqUoWi3s+3qqUKfUriIiTI+aQK93DZcOjrauupC3BAbMXqj8SysYSyZFKsnRD8o80ssbmPAeuha5rRwfXGVmRfev98uuVWnTBi2ZphxenxrfPtKtRyWIlvQ1zYWRJZilz9BVvUu+JUNLu0/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7YVYgbC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7YVYgbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C07C116C6;
	Tue,  3 Mar 2026 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772552404;
	bh=geR+e25gI8JIZXUEe54e2qYrHx3SADLCMRTGAizRizU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X7YVYgbC8wJ80+D7eSzeIS9mLlu8WoPg6VekNSxZUyR5Zm2NH7bCn4mhTOhfZjcTm
	 TkIbLjiG5WyB+f3hZbFzeBa/o0Q2AbTr0OqSKI6BmOatmZtQ1WuCjZ4P2YWb117vs9
	 6869oA2MiziCSoG4EzxCfAGj5ZzX4govZT6h1isz8wS+b4Kqsp/K+my5JiJeC0tX1K
	 qUULhpMubWxt3mixsQAlp3GwGSu3z76BgPRKIo+tJXU8iszw08Z2h4CL11ai87Tw65
	 QLF9OP0heW9FdYIBbrVzWlidRV7QHqxJScl4BFUgIOog2rD76iiActGsy8F/CT7TBh
	 /KnZKxUoL+iHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF7B3808200;
	Tue,  3 Mar 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bthost: Add segmentation support for L2CAP
 LE-(E)CRED mode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177255240530.1348433.9913405371816237932.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 15:40:05 +0000
References: <20260225222345.199032-1-luiz.dentz@gmail.com>
In-Reply-To: <20260225222345.199032-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 25 Feb 2026 17:23:45 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  emulator/bthost.c | 53 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] bthost: Add segmentation support for L2CAP LE-(E)CRED mode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b138a0849ba2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


