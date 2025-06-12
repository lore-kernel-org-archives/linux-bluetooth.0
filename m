Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E326FD91
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740398; cv=none; b=KxJY4kANI8xArr3NGygz/Jlz+V7DBxt3HV/TuuMZ8FdP0NhCr+kl6Ysg5XjIVrAJlmDqvwM/oEkOLr4Q3C62+TlBwQmT/oWri+0x0dCn/yUxdbK1gO8ooSvp5Wj2ZXMGkqJkRbUdeR6Law2q1MlzuYqX/zJixKqPPIebsGAYWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740398; c=relaxed/simple;
	bh=VjYT3viEaSuAhKXSQvULRyjUucvKUgMv+Bk7FHXhGk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UqSRbgg6tHei+xJojRidZs3xw+8PU8fJ0KhF8Ob1GBD8Nx4rib2w8P97sHJSODDC2wPOmIs7HB51Ka/HX+WMEMPSflbi7ogJ3dXQjRBvwBMKnRBd01VZkpYiRr31a1JazAmhuYsF1nGQv0Hi1P32akTRp/5CKY7sGQUCqiPh3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny3YtiA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny3YtiA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914AEC4CEEA;
	Thu, 12 Jun 2025 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749740398;
	bh=VjYT3viEaSuAhKXSQvULRyjUucvKUgMv+Bk7FHXhGk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ny3YtiA78Fh1aH92rWjDV7oDdJHy/4O1i3G3Ko30AnLTDXd4ACTYVUuaUBh6Sd3Hp
	 K5QpctjSel4RjF1Y1tCREa8fAw7bRLojYEgzebzwe6kuRxPL92kd+CGFg09e1Uk90S
	 ahEJ3DHs0MIkXt+FmsLWTpfrfnf1Il7iKugcUWQOoLSZDw9RoQ41PtPgAb7vofzjKX
	 hIs0d+PhBWGMAhAcXiXBaKiLwrz6GRK/V1Mdb6AZWBtG0m63rlkxFcdYogBRBiZLqN
	 2DWj0Ok9fUxmbI4/i7Ch8zpZCXgkEy4JFJJzXWtyqVQXtKUiD9NyM3il/74OnfiAKY
	 HJfF2PD4RBbUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC6539EFFCF;
	Thu, 12 Jun 2025 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ bluez v2 0/2] bass: Support for Encrypted Broadcast
 Source
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174974042850.4169125.7308697544310573706.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:00:28 +0000
References: 
 <20250612-bass_for_encrypted_broadcast_source-v2-0-9128a437b595@amlogic.com>
In-Reply-To: 
 <20250612-bass_for_encrypted_broadcast_source-v2-0-9128a437b595@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Jun 2025 13:31:00 +0800 you wrote:
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v2:
> - Submit shared/bass.c separately.
> - Add necessary comments.
> - Link to v1: https://patch.msgid.link/20250611-bass_for_encrypted_broadcast_source-v1-1-69b8b156488c@amlogic.com
> 
> [...]

Here is the summary with links:
  - [BlueZ,bluez,v2,1/2] bass: support for encrypted broadcast source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6bc584b11b8b
  - [BlueZ,bluez,v2,2/2] shared/bass: Move cb->handle earlier in the flow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=39d965185765

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


