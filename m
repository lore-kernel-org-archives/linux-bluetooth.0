Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1512C497
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202633; cv=none; b=cqzb1+OsNvq0K2kHYdMJ2ievGjlMEAG34LV4pP51B+CIs0VHaKG48+qknVaYyeop/j1ARtxK+Mm+hVfLjCE9k1CmRWD7hfxgErKQfK27r47v5jJe5MHRKmvY5gMSxANj15nvjlDv5aVVZR95wByAhYniEfwVWlDi99y/O32y3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202633; c=relaxed/simple;
	bh=xL7z/YIx9p3Xd5AENgT7cZ51/XJ79yw5QLK4NtUXAH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kAprRsRYxu98gGD1kIu38y7AwctBK06+MRHZFfYT5Okay4qgZy86fpz4CE7MDYy1fCA1EB6IPJvIOeXu2evaCa3jBr8YZtahZ+W8WdBDay9tHrtQ3aAem0I2XZlZhkDIn6WttLtPV18V/onbYg9+vHakwLJzGBi/5qd9IWiXp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh3qZ5bP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh3qZ5bP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE741C32782;
	Wed,  8 May 2024 21:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715202632;
	bh=xL7z/YIx9p3Xd5AENgT7cZ51/XJ79yw5QLK4NtUXAH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sh3qZ5bP6PhMD7Rr68Os3kHkPXwE/W2DMgolhcIy66LnxpC4UsOpIhxW8TxyFP/GM
	 dCPrxAbmiS7+07MbLzSE3LGWMw7ga/3RnZAdsfEI+tEX3504GteAF7bGaY2HtiKies
	 pKz/Caw1tdbBLhL14zW2yw9uXKQiEmbcXVX6K5LN+W9r9L9j1ClF3lMaxFk7X+BzMf
	 NopWNuiOGPhWamSD9u8yMBHleZPpnMX5g+5GwxnqHCyCPoN497Ubg1TEHjKrIjUc8H
	 /J8/RoX0dJdZz/7BTOwkZ1Amqt30BVh3ocaFGXt8EMwNlUVHuIUNiSIAzXZ7Eb7Rxu
	 dDfayHXZdOprQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBFF8C43330;
	Wed,  8 May 2024 21:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/util: Fix build error on malloc0
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171520263282.5891.15915392684516199434.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 21:10:32 +0000
References: <20240507204407.653383-1-luiz.dentz@gmail.com>
In-Reply-To: <20240507204407.653383-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 May 2024 16:44:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the parameter order of calloc which causes the following
> error on recent gcc:
> 
> CC    client/mgmt.o
> In file included from client/mgmt.c:43:
> client/mgmt.c: In function ‘cmd_add_ext_adv_params’:
> client/mgmt.c:5057:28: error: ‘calloc’ sizes specified with ‘sizeof’ in
> the earlier argument and not in the later argument
> [-Werror=calloc-transposed-args]
>  5057 |     cp = malloc0(sizeof(*cp));
>    |
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/util: Fix build error on malloc0
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=449cf35032e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


