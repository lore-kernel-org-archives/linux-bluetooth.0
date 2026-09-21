Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B54A092E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001676; cv=none; b=b80/KWqBlOUsBHnJnS20lkGCM64Gyz2u+lWGg7F3Qkgt0stbFIKp1GEiHV72TXVmqSwLquhhVc6AYwfosuAfbXw8DvYm8gpE+npqzKN5KrMiPUSwoa4EJvmnocdkpCfEtE5a0dPLY1/uD+pqYQJNFSdFEcpV2VZRZlKDyDDRW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001676; c=relaxed/simple;
	bh=F3krtCRWv0oWT7i8MjxzEYhL9BIt7mfEIt1eK172R3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JJkyn0xhAff+/vuQMuagjC3xd8wtGzvlxuigpMqccFPnW+45c7CK97CU9hugZ4yaMXTFXt50huLveoytdnDz+j13mTcsfhotc6GAySAqOMiyki7xCpFvrYs9EhL0YmNlhvwFn0BPmYE3V+1VEN7FRE3bMqBQJo/7HDyr5YWGivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH/GFpoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH/GFpoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8591B1F00893;
	Mon, 21 Sep 2026 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001674;
	bh=wfxVcdKlQHd4bEZpGByCNt55Xa9dCtcvbudumOERUSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LH/GFpoI2Lql5jaqUdY4YkDSspufKkmnMiFO5VD1QyAF0LGMq00iN1VYOtDJ25Bkw
	 LwoTCmgknTVna7l92LWY57+kgx0PI9Z7YF9A3Ej4hZefjAIG7iOC/1xiAIvW5fWfkg
	 RjQYLJvvGgH9dpeEwnjHU3ZkhFj7uYj+QrMZwD+rCUWYi8pRVWoyiqXZ2qfoYvGofw
	 658h/Y94Ovghf1L3tCcQVWenkxxm0/hHGdDtBySwdjT4azRn4md/q/5l0bmWxMY0XP
	 ydz+DbtZWNcUTk4UFdU6+QoT/JK+TAxoAvrsX2dSpn5WB+bddAG5mjU1Iy8krZkf7c
	 RoHLH3JK9wmfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A5D3926660;
	Mon, 21 Sep 2026 14:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/9] monitor: Search the frames with a pager
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179000160589.3063941.11987296756450696856.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:40:05 +0000
References: <20260918161408.2464981-1-luiz.dentz@gmail.com>
In-Reply-To: <20260918161408.2464981-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 18 Sep 2026 12:13:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> A frame spans several lines, and what identifies one is spread between
> its header and its contents: the header says which controller and when,
> the body says what happened. Searching a trace a line at a time finds the
> line reporting an error without any of that context.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/9] monitor/analyze: Free the channel latency plots
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=482d95704cec
  - [BlueZ,v2,2/9] monitor/l2cap: Report the channel latency deviation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=381c58534a2f
  - [BlueZ,v2,3/9] monitor/analyze: Drop a trailing space before a newline
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dd86570d2338
  - [BlueZ,v2,4/9] monitor: Route the decoding output through a single function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=64bf1cefb3c3
  - [BlueZ,v2,5/9] monitor: Separate the frames for a pager reading records
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87051913982c
  - [BlueZ,v2,6/9] monitor: Hand the captured frames to the pager on Ctrl-R
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f7263b64c56
  - [BlueZ,v2,7/9] doc/btmon: Document searching the frames
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97c101c2ef56
  - [BlueZ,v2,8/9] monitor: Prefer fzf as the pager when one is not set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ad10ff49729f
  - [BlueZ,v2,9/9] doc/btmon: Document the pager choice
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=17e624d1cd9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


