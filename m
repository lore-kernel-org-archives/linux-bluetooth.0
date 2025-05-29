Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52741233722
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547594; cv=none; b=qMBwZ14AkpKwaLIRWj8RLS7/qHBDpey6/OO0AjiJUayMb/DoUNKh4QU14spwBJcqN/5mNGXKnG948L5QJ920pWglzbYa+/lDPYrU74YQgN3MW++sNJiFnWN+Ywv3cN6IZG9V7TMXeXPJEX5gwTDcgEDTVRj+EUfpBKx/+dgAV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547594; c=relaxed/simple;
	bh=x9xklXhZcpxyNoiqBmm+k7DRkI3YHvikIBCw4ChcshY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ks2jkxzarjTIcUw6LxwcXxfFnAHomk5C/epzY495jkm21QE4nL67I0bkdw22yIZkpt3NQJ1NtXXEHHA35W2OlVDpRBjQHVsWbB0ndE8YUh8Qw7nmL0Rjq3Me7zqwSj4eceTh7tevuY7Ef3iirHgtvOV13VXJdrD9AYVS9wN5Akw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M11Ri6fF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M11Ri6fF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07B7C4CEE7;
	Thu, 29 May 2025 19:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748547593;
	bh=x9xklXhZcpxyNoiqBmm+k7DRkI3YHvikIBCw4ChcshY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M11Ri6fFUlzXdoSlL+ds2c6cz1SV9LTOY01jv2juNTHktiZTCaPDs9c4D3KYv9lyN
	 v9WRNYwXP5httvy6D7u10xuAVo0VwgQgyxYC/rOWivUZgdxneDU6AYdpVvXkddY79v
	 MG1m8MpSO9zaTgrVQEgE/1DKKnVrxSmMQh6hAS4b32w0Vp4yFrihZSuzOZ4MYg5Gdw
	 iJNA0En2XuYSBYzrUEAKh2eZMbFtcvSkMjdAvTLny8yH9Ta6/27YnbuXjBtG9Y+MKN
	 nkqV3B7WelLEFIGKzBnci80fK+v0+NYOB4d6B1rJhHPajZTyfwYU8/OOc6JHU4asJN
	 XHVdq8H/MshhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1BE380664F;
	Thu, 29 May 2025 19:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bass: Fix not using SID from BT_BASS_ADD_SRC
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174854762752.3369736.12643245179581825305.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 19:40:27 +0000
References: <20250529164256.188167-1-luiz.dentz@gmail.com>
In-Reply-To: <20250529164256.188167-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 May 2025 12:42:56 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BT_BASS_ADD_SRC command does actually have the SID of the broadcast
> source which must be set otherwise the kernel would assume it to be
> 0x00 which may not always be the case.
> 
> Fixes: https://github.com/bluez/bluez/issues/1282
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] bass: Fix not using SID from BT_BASS_ADD_SRC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ad6ec151c61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


