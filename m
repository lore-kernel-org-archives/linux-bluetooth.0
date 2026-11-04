Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830825;
	b=gPe12VeB2Ou8j53sPwoXYUxsp+WJ2rN0C8i+ZEM2UuXVmuJUa/zoiCLPNWStU9JWUGFO
	 nOFxJsE7pp3dmC2UwevV+0s0l2eIY3a+PYLWlhX+1TPVmMCuttbIwkeCdmYodh3zZ3esb
	 Y9DhU6iparAefrfabqjws2NWdQuUiP35HC5DYcjA0sfcF3K0zwv3EqQ7FrmB/s2zNV46I
	 pBjQ5uMGVLHq3P9rNmbWgV3pkfNx7QoN/ArqNHFPl059G/oZEOE04xdbGZlgPl7ls48YL
	 V6QTks7gTV/Msw7THXRyaDfbP1WuVzjmkwMW5OwdUgNSnsV3gcHRMrtUWXQm52ai/WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830825;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=l26EY1ejppvc6S1xS9OtShxfLhsLOgdFFgxCGty35fU=;
	b=MgVm7qJfEGzGi5yjDBOig6y6vHYpY/DtIRItXv7BOux3wkBVlsKS1ncgUa8ITHjrquFL
	 4qLR+iG6l3kXVwZVfn+x5yxDmK//YbxY6W8duki4McyX37ynROy9NOSeJmz/iF3Z0Ay6D
	 cWy9mmnL86+NBhAVNOzoqiQpdaJkuMMVpomZD3ogEhw7filPaqOwhEBwkHySqM8yuwVQV
	 NzwLJKgWaeKFmBrwbGDFws40M8q/01H2SvcIb8tEJQf1Rws9dexLUvkRLAnzk/8kr/F+/
	 fOIqVacdY5j28LkUvSInnMmX6VIxPjxKMLYm/4Tpa/42ZJouYzO9DgxPpo+ThY9obvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aiis5fA4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE8606A326;
	Wed,  4 Nov 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aiis5fA4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBA81F00A16;
	Wed,  4 Nov 2026 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793830825;
	bh=l26EY1ejppvc6S1xS9OtShxfLhsLOgdFFgxCGty35fU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Aiis5fA41Fu9KJipr/SgQ0+UkaITBlLkJvXKq53oqxMrhQSDfjoQu1+ldh7dRge4Y
	 SQSsaXxWr1PLpWn1D8ox0hDnhD9BS0Co4mLefTqkeN7qiG2lUBumCCvegKJWEdqtiv
	 pYieOdcfbBecascygyZQK9tMy5zqO5fP+ePsDMrsDVV8NxGWlese03OArLVTkTxVRX
	 nUXjhzlg/kX13tjHoKvzroiQUvcdlSM21cj4dRB9NqYV7ElNbdkqTw60NdV7G0xk2T
	 auHzxgfYaKM7CkiKuKiiQ6IsblCnyLXlVt9ikPwEEQc/7BVPbEQPqcgAvJiorU6RUX
	 qPp0POZjhF/Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0311A38003E1;
	Wed,  4 Nov 2026 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: L2CAP: Match LE responses to outstanding
 requests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179383082342.3253812.9942140641407431585.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 22:20:23 +0000
References: <20261102124735.23199-1-enderaoelyther@gmail.com>
In-Reply-To: <20261102124735.23199-1-enderaoelyther@gmail.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 security@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 Nov 2026 20:47:33 +0800 you wrote:
> An LE peer that can reach a local L2CAP listener can use unsolicited
> responses or Command Rejects to bypass deferred setup, remove an
> established channel, or leak an unaccepted socket and channel.
> Authentication requirements depend on the listener's security setting;
> whether a default configuration exposes such a listener has not been
> checked.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: L2CAP: Only accept LE responses to outstanding requests
    https://git.kernel.org/bluetooth/bluetooth-next/c/f50b32aa233d
  - [2/2] Bluetooth: L2CAP: Clear request identifiers on incoming LE connections
    https://git.kernel.org/bluetooth/bluetooth-next/c/15a80cc8263a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


