Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAF2192FA
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750453779; cv=none; b=EpruinHQkbKHG6TmIbE4Ub960c7eFIeSWox9zd+aeThS1dlAarNq5suvf22+F2TPeHyfrsOgqCF20PaqmHPNS95cAZ+P/wVFs/PemSjlhRRfPvMX58KfayB6mvWQNq51T9I2QwW3ZQrTlCJA6aoBAXGO7p1pWCLsKp9kMHKQxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750453779; c=relaxed/simple;
	bh=BH8zKLKWOpBAduY3gEZN7F7Ey00FtCRErgb0iqSg6LY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UUBnVk/3qJ4C+kg0Ygt9ve/q7X4gKgnS1W2Sobzs7z4DnKnKxSnroy+lV0QbLX/zrHBQYw2sLJr45TR0bZJ5LqJBVwoWxDDDN+sX+1P+RL/tXOUHEJOhh+xyp84O3fGhWpKbJP//A+JUASex7k3G7tb+42dYiV8y9HzC1mPXnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM0VPTlJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM0VPTlJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED121C4CEE3;
	Fri, 20 Jun 2025 21:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750453778;
	bh=BH8zKLKWOpBAduY3gEZN7F7Ey00FtCRErgb0iqSg6LY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QM0VPTlJuapoHJHPcFxukXhcU6cjWIn8wv+ts5aeEvzFeT8zsm7Y/qZyasKr6aaIP
	 zW2BywX0FU7tEp2ptu3hL6QwQ97yQoroy2FYVa/ZyZUx4gFfSHIjqMElEcyzLkgq2t
	 Xl5LXWRAexr/7DjjaUfHoF48Mq4wBSkQ/xpgq70lmqUC8QQGNRWoeu8DdmuK48FfQ8
	 tOjY07WmW98m4JCyw7tknPyVq211NRbAywbK52NfefSV1yev4svmFopO9JejMsDIrA
	 6Ek53+0zdSXKQPHC6//LohBTLiQ2Deh8yINMk05/QwL3bs5icngMNCu4qghHDQuYnb
	 XY3d1MuETj5qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD938111DD;
	Fri, 20 Jun 2025 21:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3] bap: don't pass in stream's own metadata to
 enable()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175045380575.1703596.6805423044283146658.git-patchwork-notify@kernel.org>
Date: Fri, 20 Jun 2025 21:10:05 +0000
References: 
 <bbaf5b867f3756fcf72b8e0cd9c2e984d2622eeb.1750451973.git.pav@iki.fi>
In-Reply-To: 
 <bbaf5b867f3756fcf72b8e0cd9c2e984d2622eeb.1750451973.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Jun 2025 23:42:48 +0300 you wrote:
> Stream owned metadata pointers may be invalidated in bt_bap_stream
> operations. Just pass in NULL to keep the current value.
> 
> Fixes:
> 
> ERROR: AddressSanitizer: heap-use-after-free
> READ of size 8 at 0x7b86a76f5d18 thread T0
>     #0 0x000000836745 in util_iov_dup src/shared/util.c:353
>     #1 0x0000008ea96b in bap_stream_metadata src/shared/bap.c:1991
>     #2 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
>     #3 0x0000009226e7 in bt_bap_stream_enable src/shared/bap.c:6392
>     #4 0x00000044037d in transport_bap_resume profiles/audio/transport.c:1981
> freed by thread T0 here:
>     #0 0x7f66a92e5bcb in free.part.0 (/lib64/libasan.so.8+0xe5bcb)
>     #1 0x000000837002 in util_iov_free src/shared/util.c:392
>     #2 0x0000008ea94e in bap_stream_metadata src/shared/bap.c:1990
>     #3 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3] bap: don't pass in stream's own metadata to enable()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=01f3ef3cd9d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


