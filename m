Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2E33F36D
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102409; cv=none; b=JAFv6qlRBPH84T9oWPlCHuN+wLNAkcogG0jD85Ay2wQU0Ht7lXJgHm05slwGGDPiD1SvSLaz1mgpp27JDq0i1Ki/GABg4a0RLN16sH0sIfonRNwT4gGuR48n0ur1MCDS+zogMb3oJungH6ybgHwVsutamfR0ZQJgi1KHHurciZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102409; c=relaxed/simple;
	bh=IJrzrIVG+1XEKV70wuvqf/2n2T7RQs/mmBd6AoDkceM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A/e3DhXWu1G8hQTr2GuHxBLwJAJQTtONC7RZypb+s/5b8KfKtCzkZIG1UV9U5AMSbbT0U78yrtd4Gv5H2tSTUpy9ipxng1DJqXkl4S75tM8NcYbloh6/FbngmaKf2uxmv4QZwCgdyP6ZimMVpmo+qr2EFVJ/MR3lMfNfXLMIA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARd8GMNf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARd8GMNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3F1F00899;
	Wed, 10 Jun 2026 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102408;
	bh=ObuxRs5dgQBmzVoNEGMao84tR/LigB1sLSx0FmMiWLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ARd8GMNf6DOd741xE7UqKCgR7J4omWIkN0Ej/vFWPtchvR7c6rfy2m3PmUKH7L5el
	 jYa8Z1diMmAM5fp5Yc9rN/KMYK/bb7Z6T/qSKvQcHQKWKM9cs1wktK7WViZD3bBxoh
	 9EfOAUrALeuzWAtk8wd/t+Uafj9yd1tud8XuYu5r97cwu8zZ1ydWQbKKedKVnmLtWl
	 CB4wj7xxcVMLIdF+k+FWCFjAbssUldC0vGj8Imp/JYVr2Hgbc8V1YSP5Bn780r3vFQ
	 FXp3oDose05p4hblc6Px5b4oCHZqeu2I79MFH3CBWFAasoTsE/ayb0pXEEcvOlJyu6
	 OaWTDotReZ20g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569D53930D18;
	Wed, 10 Jun 2026 14:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix UAF in channel timeout by
 holding
 conn ref
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178110240589.3071747.17465364670664639743.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 14:40:05 +0000
References: <20260609193222.192456-1-luiz.dentz@gmail.com>
In-Reply-To: <20260609193222.192456-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 15:32:22 -0400 you wrote:
> From: Marco Elver <elver@google.com>
> 
> l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
> the connection is torn down while the timer is running or pending,
> chan->conn can be freed, leading to a use-after-free when the timer
> worker attempts to lock conn->lock:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
    https://git.kernel.org/bluetooth/bluetooth-next/c/06528e2f5fc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


