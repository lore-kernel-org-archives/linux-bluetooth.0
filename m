Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16331153815
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609428; cv=none; b=Sj7l1XHgc72vnoa1IvzfLIFfcpZQ7+bPPNcKhRbydPHoCrQKT8w/g27Jhfctw+/vVVeafD3rqbSs5FcycdG4enP9lMhYDUQA7rwFCOK+CTl8nVTHNhd708+mNotUknPlNAyG3oeC/0qRGgd8ggBHkJClyy/nTFQEJedIJso9sog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609428; c=relaxed/simple;
	bh=xkfVd6YHB6IBXkZgJ66OKU6uTmF62OA8L56R6EJW9CY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nLBOQG7rZli3HCGt07PbLl+xRsgwR0E34CZE+0vjMZL9bcgv8QKyCs1++D83BeiA9xNDz4QOiX1kWlwkntBkTNCGh1dNu3xBgxqN1/g2iS1tGHUdgkW4E9j2a7zn98GueAyc5d/SQnbHI5Fxh3gvVUv+JOFvyGo7Dvj2fA9tH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heq4Lu8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heq4Lu8G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8021C4AF09;
	Mon, 13 May 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609427;
	bh=xkfVd6YHB6IBXkZgJ66OKU6uTmF62OA8L56R6EJW9CY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=heq4Lu8Grrb0awqxx+sqAcjwBhOUCnBcou3GGX1wB4Hg9vcrohqtJDxtPgY1CsANS
	 bUduXzyuxUq86CzhMyFq0/4HtgVwtSdm8yHLjb6//Oo+zO4A8D9V+Uv7GbAW/h3N40
	 9fGpiSyX0ATZtfOCGI0u1vKzZUTsONl86wdTwJVJEPD49fXfOXCS2JOq+YeFLLO0Zd
	 0PPcdh8CRLX6/yFUAxKVkAVJh47Be5eP9PqpJ4XUlsh2FCAAiVWBvWlP8tuGxhf69p
	 2zcUj3Fd1l2vH1gPZ551D3pRcVpLgcK+XSLxE8MvPuXxw0NHKZFOQDx8lEC/kEeFUr
	 d9rBrYsI+fyqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5CDBC43443;
	Mon, 13 May 2024 14:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] client: fix ISO send data rate
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171560942767.21927.2728272166472720576.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 14:10:27 +0000
References: <30fd803be62f762706486698821e9e5fff2d0b63.1715442270.git.pav@iki.fi>
In-Reply-To: <30fd803be62f762706486698821e9e5fff2d0b63.1715442270.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 May 2024 18:45:46 +0300 you wrote:
> We are sending data to controller at wrong average rate not equal to
> 1 packet / SDU interval, if Transport_Latency is not an integer multiple
> of SDU_Interval.  The calculation currently may also give zero, so no
> data gets sent.
> 
> We are sending data in bursts of num ~= Transport_Latency/SDU_Interval
> packets, in hopes that possibly larger timer interval makes things more
> efficient.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] client: fix ISO send data rate
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e453a336c404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


