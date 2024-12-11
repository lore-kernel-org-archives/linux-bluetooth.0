Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E72246356
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930422; cv=none; b=dnQHOJqZrfHK3xDC0DGOS4CD7nsH3wolxWb4sCfP9R/FoCQOwDbF/E4JFmHAywxznTcZH7+s4jA14NrL7Wh8yRiFqupW+vhXtgHZ5j0DhuZg7XjEBKDam9g0rlXpL9o1ZMZRjk7KLaeD6WRt1FwTwO5+V/gpE8GUjxPS9CqLM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930422; c=relaxed/simple;
	bh=GbMtDHvxVKWOcaitH7M6sX2KfcjD7FouBlcBOqtuQiA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W+3eVCmYqPj31hnDsGfsOwJzV8P1WYWcMtLKeRdyBWg/+ZaDgQD2AYHUg4u6VIliTwr5EusK3HqpsbhxaZhxDAXmIkzy/UYpefIry6pwKB+pDkqtjXQYySblVW54rlhWg9Rox/dGHYHSRrsf3IQOwSgkZVuX92KIThVinGXqcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP+tcpZH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP+tcpZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B93C4CED2;
	Wed, 11 Dec 2024 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733930422;
	bh=GbMtDHvxVKWOcaitH7M6sX2KfcjD7FouBlcBOqtuQiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eP+tcpZHuVJuJHE8RE3ID0hTgF9Y27pIQf4XhxosATCVltug/nrCErL0WqW1GZ8hi
	 zgCNAxfnLJNWtO/K0Y7As9kMOMlH9q90Um12CCXsgdDTBZ0rUqIve8JCfZrPP7z+xV
	 sqaPug6QZdTjaPcMtYCIX+IN2F6qd4pBoAd5z6I1qOlCoe13JihDiG/Y93YoYzYSNd
	 DsKNka7fgCsEwF5r2MPIPoq5xixE7S9Y5nCtxtBzDWw2sMAqyhowvd2tZJG+XgLEJU
	 3jrSAbptWbIk8pgb+d+XqR+KdbIwawAnwCMWX0IkcltNQhds3EKN17JaWzNOuuPZu+
	 cWtrZOfvWZyRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341ED380A962;
	Wed, 11 Dec 2024 15:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: SCO: Add support for 16 bits transparent voice
 setting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173393043802.1609008.4555343452739984301.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 15:20:38 +0000
References: <20241206181727.928963-1-luiz.dentz@gmail.com>
In-Reply-To: <20241206181727.928963-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  6 Dec 2024 13:17:27 -0500 you wrote:
> From: Frédéric Danis <frederic.danis@collabora.com>
> 
> The voice setting is used by sco_connect() or sco_conn_defer_accept()
> after being set by sco_sock_setsockopt().
> 
> The PCM part of the voice setting is used for offload mode through PCM
> chipset port.
> This commits add support for mSBC 16 bits offloading, i.e. audio data
> not transported over HCI.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: SCO: Add support for 16 bits transparent voice setting
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd5bbbcab77e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


