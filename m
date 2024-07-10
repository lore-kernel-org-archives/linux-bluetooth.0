Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1772182A67
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621835; cv=none; b=alOehIbhTADXyR83baU96wLudOmLQ4Kt+hO77ktwU/nSq0tZlxLS+0+uks5CKwR1eeQp6LSV3d3xOOWz2FF10jVE7+8EM+LrEEJgeJ5uQEq+i5pbEuAqEhl99qrSYsLbFZBDYZ5fosS4YhOMu1RhZFoNJR2hl8MxKhBxR1wGcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621835; c=relaxed/simple;
	bh=3hM5UaCAkXTyG2iPwtvpaoQD1ME6RmqyaT3Q/F5c98A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uwFiBWi0gNAenK7B43ZyaiePre/uoEwa0IEJc6ZD4DrOVuO6/asm+acMGFl7c6W4Uc7mUABh/hcMN11NgsaQ+6qO+deeXjOBMq+jfNZKsRVBDmQvUrkXgziY/iCUQ4W2qwZiZnj/+Sv7aeJXwURu1/xpYE/rbSxTGFS0UudJF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrBRiAR/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrBRiAR/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F3E0C4AF0D;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621835;
	bh=3hM5UaCAkXTyG2iPwtvpaoQD1ME6RmqyaT3Q/F5c98A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qrBRiAR/ebblDRZHvlGqXSANXR2mYncNpTD7KXH5eu6sXrFELFe6KRtNicQP8J0HJ
	 YKsmN3vjJSxxVVU5g2kRPXhmclMg3GDKzicNwJKztcXKHZC/190J3WTOxuzA2Ghirq
	 G+h9USen6X3qqLaVCU/ERypxyRkGjIbN9TfhCJ1MGZ1FURpuaJUxzYix0zwUu3AS7k
	 7mGnfi+ml/mcZxSQX0CI2HWER+g8KJnMAty+MS04uH1S9TPttMLrplNPXFBXFfag+j
	 qUsVOYhP6rZX6nhEWmROy2XldIfT73ojewikj5AmaPov+Mo0weOEROoXdMkFwl7lVl
	 GucfdxZjYEvVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 510C0C433E9;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: add return value check of io_get_fd()
 to transport_recv()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062183532.19459.2946370413617699683.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 14:30:35 +0000
References: <20240702115138.70500-1-r.smirnov@omp.ru>
In-Reply-To: <20240702115138.70500-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 14:51:38 +0300 you wrote:
> It is necessary to add return value check as in sock_send().
> 
> Found with the SVACE static analysis tool.
> ---
>  client/player.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] client/player: add return value check of io_get_fd() to transport_recv()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12525371ef08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


