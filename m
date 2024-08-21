Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC431B2EC2
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251837; cv=none; b=qg1lCzcY5gVjWmnwXPIRxNEXTUwQEMefPrm1dbCGDyODkac+kg4/Js3JR1LKryfumvHpu1oFvCOzNPQQQfGiIGq7FkAEHodnx3UDYkiQSSkhiD2iFLSl6v6fZGDRAwYdksQLiRIHg3Ytf/z8EXYHC4dx+cKJiLrDqE/yuZGFXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251837; c=relaxed/simple;
	bh=yMBBjVg3zeOksdwtOscZ7x7nLm7ZdXFaWcqSgXHrIL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JmBbSD1yl1uLLrt5sU3WYt9ti2E8y/IUhxlbDqyRcqmLEYoJG/XcSGyJfacq8216BWfgfQa3FQPsZshxGvjtZbC2C245QSptgNtdj1d8p4B6N6uWGl0mG27hrnTkb7Vx/84PhD0jfjgiSN9wQMpQXxXgPvF5YAs0PsjefCCUJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoCrhNWV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoCrhNWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00AFC4AF0E;
	Wed, 21 Aug 2024 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724251836;
	bh=yMBBjVg3zeOksdwtOscZ7x7nLm7ZdXFaWcqSgXHrIL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GoCrhNWVqIT63xITwHMo5Vd/C8QCNnG5gwhca+DHLcudZHYe7KkeiPiKrXE+kYgu5
	 HJy4VnuqDMyfYMWoXn+NtzT/D6KAZNmxCiKp7uifstZ3e3/tfjoXoPi9b/UhfqZAqH
	 LP2U1uOPJC3DJQaGfzkbQ7LhqBecIIIvso+PFPwrivmHIJMrZGb7OLWYmi+7i7aNNX
	 lgsleVwtj/17l7RdgILgje44QUYRWg2JlQK1ceFiNZVIt/NYCKimwjE9B0jnQVlIo3
	 4UvRiT6BbZYKPmi5apNs4JlqaXQVeNv2IAclnDMiu8qxJtSZE3Sa+/Gp2TkyVB75eW
	 Li86Q2S5a9RYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5073809ABF;
	Wed, 21 Aug 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] Bluetooth: btrtl: Use kvmemdup to simplify the code
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172425183649.1745569.14976866974609827181.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 14:50:36 +0000
References: <20240821012403.1947764-1-lizetao1@huawei.com>
In-Reply-To: <20240821012403.1947764-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Aug 2024 09:24:03 +0800 you wrote:
> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.
> 
> No functional change intended.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/bluetooth/btrtl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [-next] Bluetooth: btrtl: Use kvmemdup to simplify the code
    https://git.kernel.org/bluetooth/bluetooth-next/c/a15c5bad1770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


