Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7E4176C
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363632; cv=none; b=PoLJNavwF0pgZxC1U19IHHBveNy5rk+xa5DGw/icdsCoatbK539UrRQ7KC/3DS+B1q3WymujZJ0fwe1kqyUjEC+8twVvzKrPpRVXTd9IYy00lJV429RFqCSvT2SmLjMw8nxKI1L9aNVBt/5iwUFurPW02Ina/BQo4F/15jnB8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363632; c=relaxed/simple;
	bh=OKfEqJyBdKa9703sYv58onUBKqo4ErGkeQdUjY6hksE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iWzxAOyAZe/pZ8Vaf8HYzqBWLqXdCG39fKN8zminEu5oGu9NEupADDBci+ilq3IfRDk2Ol8Pn+OcbwEU6y2YRQZTs1RI6BKnvJcEtXzDUm7RKHc2DFcIskwW0Nf+QkDeZUT17vRbyOs8mI0Ry42H+pMzg48/6w7uRyBpMaScr3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akbS/tu/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akbS/tu/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D7DC43394;
	Wed, 13 Mar 2024 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710363631;
	bh=OKfEqJyBdKa9703sYv58onUBKqo4ErGkeQdUjY6hksE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=akbS/tu/3fkm/36NpWO/sl9MTiNrRACGe8PkXZzPJLKjZlQ+RRap2MaExS0vn4Tr4
	 nZNNhiUu0aOcwjU3LD/iTLC9XRXZnSFQYOIrUWrjEQ04BuQWSWwTjygmrBoh7MTpLF
	 zHJlO2mC1rMfjPm0X0OEH+uBsi3+lA1ad2+NcZ/LJdSHRjxls4ArEX2ne7CfJFRsIG
	 golvYpC9PQFlmUpD4bt+hiUbb70rhCZCb/9fxheK0pjAuo9wha77yn3UbAPUej+Gsd
	 NN1o0mf/oVMANE91EpLsxKENIKsoWQxH7Dte7MCp4C/w93PNzQ7BVfZRy/JWWke2r0
	 3eLVyg7Pktk5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 776C2D84BB0;
	Wed, 13 Mar 2024 21:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/6] client/player: Split unicast and broadcast
 presets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171036363148.351.6183402925919088516.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 21:00:31 +0000
References: <20240313194400.1397477-1-luiz.dentz@gmail.com>
In-Reply-To: <20240313194400.1397477-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Mar 2024 15:43:55 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Although their name matches unicast and broadcast are not actually the
> same when it comes to RTN and Max Latency, so this splits their settings
> into 2 presets tables and fix the values for broadcast.
> ---
>  client/player.c | 115 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 110 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,v4,1/6] client/player: Split unicast and broadcast presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e35f4583421c
  - [BlueZ,v4,2/6] client/player: Use macros from lc3.h to define presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cae922c63bd5
  - [BlueZ,v4,3/6] shared/lc3: Add definition for broadcast configurations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47df60e8b21e
  - [BlueZ,v4,4/6] client/player: Use QOS macros from lc3.h to define presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25f42cfc4653
  - [BlueZ,v4,5/6] client/player: Cleanup broadcast QoS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3ad367874630
  - [BlueZ,v4,6/6] bap: Add proper default for broadcast setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fffa21d084ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


