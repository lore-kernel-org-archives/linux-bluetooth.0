Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CA27718
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107393; cv=none; b=HKg/I3+yKenkBT8W8mGVhVJ1hT1qk3dK0dggFY2ZcKyfQI/yKYLupMykhU2V215eDRohWgxJ00PR76//BF7RSm74pJXpfk38bipJh+z5WE42CRlpUMKrqTyW+dCJUJbfHouSpqt/5lhikLvlAVKv2mY3+XInMySEJPxldmhAf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107393; c=relaxed/simple;
	bh=4B0x+UBpcvMsO3VhME4ekO/lwdcUts5tBBR0dtjUymQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E17li7LS/CBcfxqva+Bog2I2RYjPPDQY2L3h7f+NDq07/9BA+ix27angxCnOn4TH77WcT0ryE4gz16tmnBQe69k6tqahFQWmn3X6c8IMXlpXdj8G2wej27diVhF6ApVS6cNO9fnCo5dHpFpyWUWGY3ZL+i6Np+RatvghTCOIRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srda+9Og; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srda+9Og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9B9C4CEE3;
	Thu,  1 May 2025 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746107392;
	bh=4B0x+UBpcvMsO3VhME4ekO/lwdcUts5tBBR0dtjUymQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=srda+9OgQNVMXuchWB26V9PxBLRAQZOQjZGrN6++jiLu29E4eZpmhjtoXIfys57ox
	 Fw79STENjBPB/hrtrhqwzB/V1chUWIQAysaga5l40rBWwvXsWsA0o1GZj25cKb4qDD
	 Lb2c5Cu+6NCBf8EpUSWLB3zbzDQS8IhU5VmtnnqrnudaowXp25p03A09JgXiWovedR
	 GHXIAl/rO4WdUkyF8Lz3v3UJRh5AXPCnKJdwBrD1/hIhqPoutt6oNH3EEZm4bVOzHr
	 +A9HdGfbgjmRpU2Gh0DoxJeZkh+uJddqeZxJjmqlO1Qac2yKri7jwRM7Dgn+WG2b9j
	 7GeogStbVQBAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEEB3822D59;
	Thu,  1 May 2025 13:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] obex: unregster profiles when the user is inactive
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174610743148.2986402.17866667159847091977.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 13:50:31 +0000
References: <20250423163343.4160595-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250423163343.4160595-1-kernel.org@pileofstuff.org>
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, pav@iki.fi

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Apr 2025 17:33:22 +0100 you wrote:
> This is a follow-up to "obexd: only run one instance at once".
> Instead of refusing to run parallel services, it unregisters
> profiles when the user is inactive.  This avoids the need
> for tmpfiles, and avoids issues where the user with the
> obex service logs out, leaving obex disabled altogether.
> 
> Luiz previously suggested moving this to systemd, but I haven't had much
> luck getting the systemd devs to accept changes, and Pauli's mention of
> elogind (i.e. logind without systemd) suggests it's probably better
> to avoid the dependency anyway.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] pbap: Support calling pbap_init() after pbap_exit()
    (no matching commit)
  - [BlueZ,2/4] obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
    (no matching commit)
  - [BlueZ,3/4] obex: unregster profiles when the user is inactive
    (no matching commit)
  - [BlueZ,4/4] Revert "obexd: only run one instance at once"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8d0dc114036

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


