Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6562155C82
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008397; cv=none; b=QKjyT+0lNojTSKEnQ8Id4uNUQGEo/GnLGm71g0Pz9xq+ugrvBC0rEU38NVoaorCdbfRvek4ie3cEtWH9Kh0dyyA3Lk3fdUjtsYS851HMQeyNaCTEcYVsh6xQXlQomzcT4ljf3RatP4xnWsXb91A5+Apdlc5v5ED1VABCDRt1VI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008397; c=relaxed/simple;
	bh=1srZqnHzy67Iki3N4ikPRr+AXnhAvG9a2JSQVI9Zit4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AzWTJbFATM+/10BPluFkawMYj12vFO6i0oT2TuuRuWvpT/+/lYy5Why3+OkKK3OEuo7G+Za2rzx8Cw8/KbhwbILYRiwCCTWAc2Vn9c958+SYHgx4TntcSZMOt3+CCgWr5IuXUM5XcsvfgVeT5R7goAHM9t61X/qM4YKeUnDSUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+0/Kn64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+0/Kn64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633E6C4CEF5;
	Wed, 17 Dec 2025 21:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766008397;
	bh=1srZqnHzy67Iki3N4ikPRr+AXnhAvG9a2JSQVI9Zit4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m+0/Kn64THMI1xkpfoKfK/OW204Lmx2WDSKwFD6k/iFR4hPwlofB2OJkRJ2ebDbQS
	 NUkKnZIai4eMWqB7/CGNOzjAcVXABSon6uDkFbx381hZnCFDBtS1WksT529L8/a6pb
	 mzmpRbyfzItU/WYSSTT0grPCXPZtyNfZn5JWSnvDlTKc2zdn9kYz7aTqQS0lpJFZQN
	 6GctiQdpO5JSntx74xpHqrSDkqapncbn0JEe2iMjH0B5TiGG9Cr1ftKVGnJBX0ihS/
	 RZEJJNK5beU1Ujp4NIzAS5DS4ce1yMtUqPaH/p1vgv41YSPZnUp1DCnA3EFZc7oqov
	 Ck0UkH335FOBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79D2F3809A34;
	Wed, 17 Dec 2025 21:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: Fixes for BR/EDR connection idle timeout
 configuration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176600820727.2253459.9475186722693535159.git-patchwork-notify@kernel.org>
Date: Wed, 17 Dec 2025 21:50:07 +0000
References: <20251216092011.111208-1-ssorensen@roku.com>
In-Reply-To: <20251216092011.111208-1-ssorensen@roku.com>
To: =?utf-8?q?Stefan_S=C3=B8rensen_=3Cssorensen=40roku=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Dec 2025 10:20:08 +0100 you wrote:
> This series addresses issues with how Bluetooth BR/EDR connections handle
> idle timeouts (entering Sniff mode) and exposes the timeout value to
> userspace:
> 
> 1. Ensure the active mode timeout is correctly updated using
>    mod_delayed_work(), preventing the timer from being ignored if
>    already queued.
> 2. Apply the link policy to incoming ACL connections (previously only
>    applied to outgoing), ensuring incoming connections can also enter
>    idle modes.
> 3. Add idle_timeout to the configurable system parameters in the
>    Management interface. This allows userspace to control when the
>    Sniff mode is triggered, complementing the existing ability to
>    control the Sniff parameters themselves.
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
    (no matching commit)
  - [2/3] Bluetooth: hci_conn: Set link_policy on incoming ACL connections
    https://git.kernel.org/bluetooth/bluetooth-next/c/f7f2402b7807
  - [3/3] Bluetooth: mgmt: Add idle_timeout to configurable system parameters
    https://git.kernel.org/bluetooth/bluetooth-next/c/afa20d8099dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


