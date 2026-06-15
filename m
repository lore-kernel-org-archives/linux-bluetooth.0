Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9230D3F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547611; cv=none; b=Q5sZ0G9Q7KLIKJmDTLn3iqs8I2xxeZySkrwowM69kBLbzOeeIqXoSMuDzr2a9Zp2AaQg2U9Kvbs6mXOtVUc5PtPptB9xdZJo1oBb8S1j1NL+Q+Lqy6JyciZpxPR7dc7K9mA2AseH8Gmepz2ja+y5x9pfQaD7c9U2a6Rff+nWQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547611; c=relaxed/simple;
	bh=//ilhwSaxrKI48m/S/iQ1qb3lxvNo4UhV+Uj0hCMBQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kVzcXky+z4/haPSTJxe5TIjLuJvr5oyh4gfbGlW596AYWJlbvWSZLD9XL5edm6juwQfDjqXKlSRSeojkG1hFTUKQvAr4EigLXwB2ZIMPhIOtnA2ip65qm2+8kQ8b82cH4pNNXN0/4vnrnrR/1HE3fflHq0Y+5BPD12nouy4j8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQnE2zvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQnE2zvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EC21F000E9;
	Mon, 15 Jun 2026 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547610;
	bh=qbv7SG73nhxSZBhIWD+HYlL8z+bKoKjJzEJi81hZK8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kQnE2zvLjfbYSXX/e/T+IswYhYVb2OGSC0vZAX6qh2KYCIJby+yLBmWPHJRBf6krF
	 AtXcgcJWbyrI0A95yPWPRecbyM9m5+goGioosMgf0C39fednhzVCqdOfz+m4eBZFeX
	 N2bbg4JS/tAohgEL0YoHReRUg9ki1oTc/M0KWfAQrX8uzxyKLn5D3XQmj1y9tWc+u/
	 URNS266K9ZV2UwP1XL8+5OMjaP6CgzkNU/5btm28Rs5bRz8r8GxEScBSlQdiEqh9fc
	 jTbd4YHkXmTH/dEbc01rbZFiuFy+5o63u5STVEOgwazfpHvuMoxdu5kWWBb0v2j5Lo
	 fwrx3sF8TkQNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568CD3839A06;
	Mon, 15 Jun 2026 18:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: 6lowpan: Fix using chan->conn as indication
 to
 no remote netdev
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178154760489.235436.5189666063896910775.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 18:20:04 +0000
References: <20260615152948.776154-1-luiz.dentz@gmail.com>
In-Reply-To: <20260615152948.776154-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Jun 2026 11:29:48 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding
> conn ref") don't reset the chan->conn to NULL anymore making the bt#
> netdev not be remove once the last l2cap_chan_del is removed.
> 
> Instead of restoring the original behavior this remove the logic of
> keeping the interface after the last channel is removed because it
> never worked as intended and the l2cap_chan_del always detach its
> l2cap_conn which results in always removing the channel anyway.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev
    https://git.kernel.org/bluetooth/bluetooth-next/c/d35e2950daaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


