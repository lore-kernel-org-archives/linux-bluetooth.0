Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44D3D9E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001639; cv=none; b=PIthGJfx8b2nf9dT+hwYZ0QXRP5Lsl6PMZXD+YD1vrF76utqvUzCdP6TOx1zHNk0Fn4cCnYszOGsP08yCpwABY9yyxvemLELAViooXlRjdEoD438xJ6GIBkYJb0J6suSCinMuFpaIRcja5ark39oql/txafb6C69AQldKyDWzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001639; c=relaxed/simple;
	bh=W0mtA1/oMf3D+6umyrIs5NrcMj1y9sv5XupFjkjvvas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=epXjAxAn6XlWkEiXpT3ko5NJ/5A+ZCspYx0rtia/Z3Wz0IKEZ1ciEKmqmfzB8IMqKwUhwREatwMYIwhom9U+cPxrQbachmBzszwj2I8MTPQyVqKs/REgwvFddLBcm8fFAzMbdpHG31uxFklf8HbqBTECE89Si+zzhQaNc9GqgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rekWhvnd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rekWhvnd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F1D9C43390;
	Mon,  1 Apr 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712001638;
	bh=W0mtA1/oMf3D+6umyrIs5NrcMj1y9sv5XupFjkjvvas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rekWhvndXvr5bLAwvTs+qa8W+OgDCETbiFnbQfh9onGuggxl8hHtP6cXXYXnn8WTs
	 q77IlzwSEElJ2pg5uSVmSzjOAzEfQW1BlJVjEVJrrwyTPFui8N4e8S1G7i2p40u6fK
	 ipQ8p2wt5ZYbAkb0oGv7VPew0yReJZrK+ejLnswW4FUxcFPysJF95vt2VZiZtz7wxd
	 BnwGM26odl+egLKjZF/yf/MXZrKCkibEVJ89A+zZa3gqhLkxSrg9oJGW+u78R1U8f7
	 2AnVXjwX0tYm+UcvLPGA5iqj5DfzfsTq36JKJhrYlzaVH1CvWeXZaKDAlANWI4yxMd
	 TJ9U8rW1U3V5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91D64D9A150;
	Mon,  1 Apr 2024 20:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] Bluetooth: add TX timestamping for ISO/SCO/L2CAP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171200163859.25745.12369452892917865813.git-patchwork-notify@kernel.org>
Date: Mon, 01 Apr 2024 20:00:38 +0000
References: <cover.1710440392.git.pav@iki.fi>
In-Reply-To: <cover.1710440392.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Mar 2024 20:20:16 +0200 you wrote:
> Add support for TX timestamping in ISO/SCO/L2CAP sockets.
> 
> These patches allow fixing / working around controller(?) issue where
> two ISO streams in same group get desynchronized. It also gives user
> applications the best latency information as available to kernel.
> 
> Also add sockopt BT_NO_ERRQUEUE_POLL to optionally disable POLLERR
> wakeup on TX timestamp arrival, which is mainly a nuisance in the use
> case here.  The alternative to this seems be to deal with the POLLERR
> wakeups in BlueZ side, but this seems hard as it's always enabled in
> poll() flags so not clear if anything else than polling at regular
> intervals can be done there.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] Bluetooth: add support for skb TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/0368e609d090
  - [v2,2/5] Bluetooth: ISO: add TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/3067d73e114f
  - [v2,3/5] Bluetooth: L2CAP: add TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/e22f35ed23a7
  - [v2,4/5] Bluetooth: SCO: add TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/b7adccd0e8b6
  - [v2,5/5] Bluetooth: add BT_NO_ERRQUEUE_POLL socket option
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


