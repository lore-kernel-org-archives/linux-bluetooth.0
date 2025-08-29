Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DB3314AB
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485599; cv=none; b=Z+YmCcN7bDM6iF+Yz3NcTQvpl7Eauc79RcgBC0kWmdc5FXYTvTs2J5Qe+n+5az1KdgSlDRPRlrD1oNhuOglBwWYiRV1US/R8yAc/v6/Dw6W+R/BHG6VyNVgS7xb3LYDbwA0AYfHApHk2Ci7q3ebosI/9NDop8sGUblE+FYrOdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485599; c=relaxed/simple;
	bh=pfehsKbXeOzRr+SNS4gddY7pXnuYVG2D6jdS+wSf1Vg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rY8YV6RfkwOSO2xOZ2noMJbADCawAYM/CsZuEUFtyTP83T5Z3rjboUW+2JhfZBsM4lpI6ikuNCi8SJBqF5xYMOQRRUfqPe4t+jwc6Yfh60UPVWAZnYJuSVx1EDFsem+vlpEjq0ZKruHVMQ6Cs9PVcBlDRKQ4D6xrgVbm8q7pHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8iR7Tzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8iR7Tzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95542C4CEF0;
	Fri, 29 Aug 2025 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485599;
	bh=pfehsKbXeOzRr+SNS4gddY7pXnuYVG2D6jdS+wSf1Vg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l8iR7TzcdE99ya0d5JP9Xx9j7ubOC0sKDUaHwQDcQ/5E5L8xgRKaMokhSIB6qN+Fe
	 jBVF+LJEe+LNtOjIMa1OWAOG0R6PUctYddcwrTH+r+1TqPpfLvoLYX807gEEiJtdNJ
	 4m0CyJMRVI12hS2fQod5bGOMHQG/si5dc2WrkHCG01AYSbCw9PBcRzKohRdkFGrFRs
	 Nu/l/Usc4f9YsECMj/7/RGTjrSiBWIUA2XOsWreXdorGR9usGpeEtmUCzp9C88q+Jm
	 /iYTY+cZYlGd174NR8f3dg85c3Y+G5fNEJIf1Ce1ZQWGNGAKba0DPR/jyOLu7/18vi
	 RwCBUv2bZz42w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 989F2383BF75;
	Fri, 29 Aug 2025 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: Fix use-after-free in
 l2cap_sock_cleanup_listen()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175648560625.2276001.1665639095865015844.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 16:40:06 +0000
References: <20250827204015.3712705-1-kuniyu@google.com>
In-Reply-To: <20250827204015.3712705-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 iam@sung-woo.kim, kuni1840@gmail.com, linux-bluetooth@vger.kernel.org,
 syzbot+e5e64cdf8e92046dd3e1@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Aug 2025 20:40:14 +0000 you wrote:
> syzbot reported the splat below without a repro.
> 
> In the splat, a single thread calling bt_accept_dequeue() freed sk
> and touched it after that.
> 
> The root cause would be the racy l2cap_sock_cleanup_listen() call
> added by the cited commit.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()
    https://git.kernel.org/bluetooth/bluetooth-next/c/02925b3b935e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


