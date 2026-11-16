Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851420;
	b=KXllDXLRi0NgswHrImgsICm9ExMbFGqEIc2mtwqfWZNOuvp7DUIozt3C3JQF33KFU7Uq
	 fKuDCojNef6xpVRDCOtHesT3cg+qV3GUmuHwNisI4xhmmYvTxxB9qJSK7le9CuedU6RaK
	 x6sVBq1ImmbBjas47HELkJ56FhAsTjuJcJSdMzcwCq1Lu1CM/a6O1Z4Hxo4Qfutyv9fL6
	 yuRVOBCEhzABMV7IXAaEsh7/rtpGHUWGR1tr0TmgW8F1KVk+W1z2LLjb2veOLttKyRP83
	 ht0OETLjyv1+nYl8IaSpaNOxAZLZh1gl+X7ZLfI2q7I1fYhdYHz+rW42FK+sah3G+rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851420;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=lZYT1pW5XnlHck+Je3FfJIahVaHzuR4yo4rnnd/pK4Q=;
	b=syM0cJnDgGdQoULwt/mbRR11wdhNbr5+3sI6M5qJReBn/KXwh509ZXkXjXs8hiATZmNp
	 McGIBCHxgWj+6SuK0AzEb+YsIPOST5VDNpvQysk8nWrQkppCvBkNkRQo6IhjhX0rViI1d
	 gQ90kN58+QkQuvA7mgyhnlfo/nwzKiDxpp4heOhjlBKDEBC9UbOv0GuBVYpOpiMisrziX
	 X6CGFWOJ3CPricg5FP2QVOPHaWb+xExUv21MrUXDyHgUXKczsnjCfNi3b+CCwWuRRX/5R
	 wbAUc+szM3VQwMpxGmqODjjpqAUE5B+ncW6s5MaB5JqCa9eMhGo4r0aqbjas+6RQfvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhWBErF+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEC606A33D
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhWBErF+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E6B1F000C4;
	Mon, 16 Nov 2026 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851420;
	bh=lZYT1pW5XnlHck+Je3FfJIahVaHzuR4yo4rnnd/pK4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BhWBErF+7QznYze6XmOFW/A3CiKHq8u8bEowiA9JIfv/b2yZcsDeQLlrPWuSPUH6f
	 iD9+w3+mdrzYtYReOcR0s00n5lfBAB0PSTEky6aZLmPXKS3E1nKGctW+4NQMFJFbat
	 6XgeXbqRO6k1cueM08I1iie/aL9+ZDuSlPvvqNQjlO9yr/xn7pbUkuYxcKzjogzNyg
	 sPS3OScUKvVH2H3fbPX9HTBcuAthR3XOnWRucKMJdDmR2lK+tZU8o7fW+JjCCkWa9+
	 mWGIz5s5p8WqttPJsHoNAsVeDyAK35khogwZnhv3Biew/gP1Et0CfX3eeXIq72VYTe
	 6QmxTkjNJdZYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2BB391AFAF;
	Mon, 16 Nov 2026 17:50:20 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 2/8] unit/test-bap: Add test for disabling one
 ASE of
 a shared CIS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485141877.3796096.4369133802957364117.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:18 +0000
References: 
 <39244774bf8c444d7870ef0b839ccdc3fb981f24.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <39244774bf8c444d7870ef0b839ccdc3fb981f24.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:36 -0500 you wrote:
> From: Kannan J <kannan.j@intel.com>
> 
> Configure a Sink and a Source ASE for the same CIS and have both
> streaming over it, then disable and stop only the Source ASE, as when
> a call ends while media keeps playing. Once the Source ASE is back to
> QoS Configured, the Sink ASE has to still be linked to it and streaming
> over the same CIS, which has to stay connected.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e38984593c78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


