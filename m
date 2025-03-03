Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088978F40
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024206; cv=none; b=uKK0qFyhMRoVOQXM1JX4o4fPZQ6Mf7dzRLzHCX7Z8hKFiT/eN3E1KqCBghWuoUGAivCLQ8byohMjIxERs4CqAP6s9+49EbzDn/295zyRM9w5bRXlts2e0HLZKHZUgHAuy468DVi0eMVnaO31nOs2pbpWay0KBnAROFmE33ghF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024206; c=relaxed/simple;
	bh=LYevBhYVcFLGOIag2tOR6hA2a3EzQbY3ZgBVveuPJns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DIZZBhvn47bkd6P5LsCsOlaKyvWtulq3hShz7oE+9uW9lgrUZ7eeXGyfPrtHkznnGzX8gRpjqd/d+7Ez9i35uqINg3rz8yJg6DCLK04wPx3THEpVAB6lydvm3k2HC5QmUq3r0Vi7FcePKDyId0f4XK07/dLaUa18MTeB2pF30cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDAKBb+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDAKBb+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7983C4CED6;
	Mon,  3 Mar 2025 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741024205;
	bh=LYevBhYVcFLGOIag2tOR6hA2a3EzQbY3ZgBVveuPJns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aDAKBb+s7twHKGW4Xpa8JxgcsunfP9OnNkBpch5WOwlrASYWYbRiEnT2R1VriiPul
	 Dgtr3B9Z9mO5x2SfZn/UXxXYAZSFhxcV5I48l6XXQkcS7RZMdKGq5ao5k8c7FUElKb
	 c4XwmbLgKB3m6xpvXB7b3J9vHunGhQ5+losnrVoBk6at7kz2ng3H4ejh/9Ke+HsGA6
	 hpas/LNWM/pOrICS9qflk6rJdl7xkWGGimsqhu1T5yKAHfuKtSBrnlYucoNFnohlzB
	 hYBtTLrJVDVatOwmbzojJfevrWobNA5hjzkAQLgNu/C635t0aL/UZkEZIOwV+byPnl
	 NqgihMPOljZZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3353809A8F;
	Mon,  3 Mar 2025 17:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] uuid-helper: Accept any 16-bit HEX value as a valid
 UUID
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174102423824.3666733.13768128595760430757.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 17:50:38 +0000
References: <20250302090331.17756-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250302090331.17756-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  2 Mar 2025 10:03:30 +0100 you wrote:
> The bt_name2string() function restricts HEX values to the list of
> predefined service names. This list is very limited, so loosing that
> restriction will allow to pass any 16-bit HEX value as a profile to
> D-Bus API calls like ConnectProfile or RegisterProfile.
> ---
>  src/uuid-helper.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] uuid-helper: Accept any 16-bit HEX value as a valid UUID
    (no matching commit)
  - [BlueZ,2/2] core: Report error in case of bt_name2string failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32e2e5a42b2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


