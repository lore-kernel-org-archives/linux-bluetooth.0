Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD120E025
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998611; cv=none; b=VnUD+gLclMBNG5c3mP+l98l/0nKJOjz73/PVTaVtKEmG2RDWe0RfrSfrd9gjxSX7s80/Jsj9N9CaUYlVSQcpQAersTWcyTI7Afoe5kJNL08VoUGddWvAHEfuHX3QdHRDXfyw0mL2ZqLCeHBz/rOjlv+0JsPV51YcK1sNBmQB0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998611; c=relaxed/simple;
	bh=Y4fM+yACkyfhlcov00zxn46B+B56gpnvFaf5qBOnIrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PnQeVsYqv8S3NtQxcGGL/M8D9VGgKYMzMDUBoGJWenlFS6XKRtLmD17eNDh0WWXCW3VloNDJkRep0uTGt5aEAvrP9/T15F80KqVMeb/zjXJJ/pIGPrSSaGT7FRSk+bByTeuEkb66FMJgbn0HwxxkGfsAn5NqS6b5+ubJOqpOg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALrTOuHW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALrTOuHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17907C4CEF1;
	Fri,  9 Jan 2026 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767998611;
	bh=Y4fM+yACkyfhlcov00zxn46B+B56gpnvFaf5qBOnIrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ALrTOuHWd1pdPyikz7SoCtW76dfHzoLQ2CkK+m6mu6ThUu1kgSiUaOftXVp9fAiHy
	 kpKjfltKTVkWqbNdyoxnw6UFggSl/rPmFP1dinaa9bV3/amuShneiQBPlgbylDgHPI
	 ZCgH4yXEXfe9+FI5eRg6t9snmQd6p4RGD2wBvaW7QT4tNeYYkvHhBhnGKSwM1GGU3W
	 ZCTqRZbZgvvg2sgNEuuVcFo5mdJEwxXpKv+KIRhMCdcMq3vT9cr5Dx44pciKD62duV
	 HOVyKNaxI8kzpUfqC2AoM1SULQVWC5VfXQ0YMil1QiJ1G+f05lijmP/1pEU1+ywT1b
	 X2B3dLYqeG9gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29D43AA9A96;
	Fri,  9 Jan 2026 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v1 0/3] Unit tests speed-up
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176799840679.418288.11899668269970851996.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 22:40:06 +0000
References: <20260109093602.1224918-1-hadess@hadess.net>
In-Reply-To: <20260109093602.1224918-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Jan 2026 10:28:59 +0100 you wrote:
> With those small changes, as well as running tests concurrently using
> meson, I was able to make the whole test suite run in less than 4
> seconds on my desktop system, with a baseline of 50 seconds for "make
> -j8 check" under the autotools.
> 
> make -j8 check: 50 seconds
> meson before changes: 13 seconds
> meson after changes: 3.6 seconds
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] unit: Speed up unit-avdtp test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=51d93aca7afa
  - [BlueZ,v1,2/3] unit: Speed up unit-gobex-transfer test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=027e29c34225
  - [BlueZ,v1,3/3] unit: Speed up unit-ringbuf test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=00e5c016145a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


