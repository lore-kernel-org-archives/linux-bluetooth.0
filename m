Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13E84A09
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632829; cv=none; b=eFztge+GpRwycPCr/Skt6UDIAeBePJCyzkyjLCc8CZnnn7fiuSC1Ngubfiy1DskRKZKFUEzF328e5xVpp0I6kAjJfJk/nemRLDVLpdqpF0nBQmGWMCIgdHLmP7eD3z9Q69Y4bv4rb7wfks0WmDfHokpEL/hV0zimDwEhhDuP07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632829; c=relaxed/simple;
	bh=bpQiZn0d7jzqRVV/O8D5WqV/Z3RJUjjtbSp5OJO2Bp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MkB8g1OmM7kumjdvooFh9Ft7fP7E7ckOMaNyJseiw8/klKZwrotbirFInaldrzhMa2ah5dJKob8C5NTg1uWuWUQfPVVlUe1GhLDA5Ve7AjdccS1kTCaRAxHlclTt9CGPj7UYyW1o4DdNHiDKXWyFedIVe+mivcvo8UYyJ9kLgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNy1392k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNy1392k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE888C4AF1D;
	Mon, 17 Jun 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718632829;
	bh=bpQiZn0d7jzqRVV/O8D5WqV/Z3RJUjjtbSp5OJO2Bp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dNy1392kmFpXzlmMDLGEBEtNIDXSGpA5FN3C2aKD/VYQ7Tn+8o/jH/J1d8MupA/81
	 nDR/lAkUqR37+QkTnTU/9o7WLYya8x9rfiUFifbSE+VROBpAjJjU3IbUj+HAof+Zi3
	 onAB0+l7eSJ+O9TBml3u+0RU8M/PRax+AcBYfuTpaRNxdJtDtxqEUG3zhJEdA1ZIcE
	 ryHpx58ITSswRjLN2Vg15UOBrSz3Nr9gk1ImhYEqiWNV9OnzBU9b9NuH4tFW4RbaQ4
	 0Ly7J0NmnKJLAK2ajpg+kOAse+Xc0HDsRQDA1wCl9jYnhyhdwT7Et9nDQj4ArjplMR
	 57rY1c2YlEjHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C0CFC4936D;
	Mon, 17 Jun 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] src/adapter: Check if device is connected before
 clean up
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171863282963.3187.16555705068218926939.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 14:00:29 +0000
References: <20240617075934.154540-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240617075934.154540-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Jun 2024 10:59:33 +0300 you wrote:
> Broadcast sources are currently deleted on the clean up triggered
> by turning scan off. Thix fix prevents the removal of sources to
> which we are synced by also checking if the device that will be
> removed is connected (sources to which we are synced are already
> marked as connected).
> 
> Vlad Pruteanu (1):
>   src/adapter: Check if device is connected before clean up
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] src/adapter: Check if device is connected before clean up
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ff745c2bd0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


