Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BB42188F
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817814; cv=none; b=CyqAvRVLCM2OI0CutHHSFSD9KUh0Y7oyT98dLpMIbwd98jfNG7esjUpM8gl20YQAYpajlgIAa+9lGHXONE6nmsp2V4tLqHgA270uXJZbytDvXY8vaJ2rZ+0TVZ3b2KN1VQH7CF0ylLktkokUAo6lt7roNoLO2fCFueeKi8lq+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817814; c=relaxed/simple;
	bh=bs2O3/4H3c00aDtw7ngO9OLX6r/VdQj+pIKF9WBuwP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LrdAuTgnkyRAIDRn+SXOSn3JHCuU9jFHkLn3wC7Qulh0Hac3k1dONDdU9vKTGgzhMqN0nod9q8Cv0wbIjBj6vj1yJNi+LaioV6AhSSLSD3GewSwN7TxTkKCpEaHN1CpdFq/YILAL41CpiaScfh3hrYX5OIsTdzgtT/J692FBV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+E7OEPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+E7OEPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B481F00A3A;
	Tue, 26 May 2026 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817812;
	bh=T5U2xw8CZtjhBApb2seLoPFGj5km7/kPy9393eioCKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S+E7OEPlg6W6xzpCe98YSqH8vuwpZjYjZCoqWANOqqiTIBCy3T//7djNPmsbl2hTv
	 vHU69TaUbesEuzluGJD3KXvOikTgH1SEBHPkHDTDrF8fLs5L+6cKG2Faqp/NrZr3et
	 gmOzS8luEd7tf3xFGrociipdKexE9E4k52BPVkXOG7HWxP5I4KWG4jDC4HElMQ0JDb
	 dutH5GQKfl6drO3YAtZViuZBRr2VwtEJgMKXG3yMFdTHMcO4ylnMvUqGZIicR3fpQN
	 9UxIOcWff3PoGUvHebP7WAySdGcxRh4KSh8NP/ROR+rXbpsCqq0E+cmuCpc7C/GoQM
	 j9SU9+77xxImA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BDF380CEE6;
	Tue, 26 May 2026 17:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluetooth] Bluetooth: l2cap: clear chan->ident on ECRED
 reconfiguration success
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177981781839.3917724.6787409743685668457.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 17:50:18 +0000
References: <20260526105152.78178-1-kipreyyy@gmail.com>
In-Reply-To: <20260526105152.78178-1-kipreyyy@gmail.com>
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 May 2026 18:51:52 +0800 you wrote:
> l2cap_ecred_reconf_rsp() returns early on success without clearing
> chan->ident. Every other L2CAP response handler (l2cap_ecred_conn_rsp,
> l2cap_le_connect_rsp, l2cap_config_rsp) clears chan->ident after a
> successful transaction to prevent the channel from matching subsequent
> responses with the recycled ident value.
> 
> A remote attacker that completed a reconfiguration as the peer can
> replay a failure response with the stale ident, causing the kernel to
> match and destroy the already-established channel via
> l2cap_chan_del(chan, ECONNRESET).
> 
> [...]

Here is the summary with links:
  - Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
    https://git.kernel.org/bluetooth/bluetooth-next/c/3149687089e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


