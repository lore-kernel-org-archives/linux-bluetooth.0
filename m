Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815AF25C704;
	Mon,  1 Dec 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625094; cv=none; b=sH6v/mnximJFQe8rVgN15SN0QMAw68yhUTat67iRz/1ZQC7TmyYEo0QK4aIt6n9l4fagO9DDSQEtice3Ypw64EVdxKhnTA3J6U/E366hebp9MMBqi7zd1iQXeYhTyLbHiSPae9NX9qOUZtqa0L0QQCrXGo3FJpjx8ctmGDULPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625094; c=relaxed/simple;
	bh=VPn9USi2g/mwxAvho4yaUUyycfRJ5gCzbqEllDaKzQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qga26rb/jsaW80oKgeO2FfrU/p+EisNTxOnwCNa1+JJHnJoyltwADVePULUESdnoabT9cciJvMdvifOcJohXXLCT29dEh2+XBtF7lhltYTB5+87V9/JGmqnh6oWeEVN5uMt7I1yfvGlgYiN8mBL9R6FnTRt9CCAKfnEqJ2F+Na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZOxWvT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZOxWvT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF0CC4CEF1;
	Mon,  1 Dec 2025 21:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764625093;
	bh=VPn9USi2g/mwxAvho4yaUUyycfRJ5gCzbqEllDaKzQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GZOxWvT9JJ4L1GdvGaMo1zQKiux0hn0MrtmHpIRYyhGcCgypLh7wEF1eD2/oIYmdQ
	 YlvY4oqNWt9/l9ETNI1mCqHpBNpM0qRfxzb7FOWP+qtkZ7E6SOIhcxGVF9zcwkLrt3
	 WGLbAG40W8pBJ4nOsgi3NBNm2O972j2fpCwp2K8OMRAWydALOSdrMmY2GtV1ICdNgQ
	 GgFejEF1qVB8iBwtgTDBWJkR/FShq9J6UzIuFeakWBrx0vZCv3M0jBYP91lpJq6OHi
	 AYCCzNJLlD6L5fH60ZqF4LedRlNeqBPYsMUuoogUtveTkDTkIG9lhqA0t+lloxsZ4r
	 lhJKQln69l8/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6D0381196A;
	Mon,  1 Dec 2025 21:35:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ALSA: usb-audio: add min_mute quirk for SteelSeries
 Arctis
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176462491281.2545331.15406826506379278586.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:35:12 +0000
References: 
 <a83f2694b1f8c37e4667a3cf057ffdc408b0f70d.1762108507.git.pav@iki.fi>
In-Reply-To: 
 <a83f2694b1f8c37e4667a3cf057ffdc408b0f70d.1762108507.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Takashi Iwai <tiwai@suse.de>:

On Sun,  2 Nov 2025 21:10:15 +0200 you wrote:
> ID 1038:1294 SteelSeries ApS Arctis Pro Wireless
> is reported to have muted min playback volume. Apply quirk for that.
> 
> Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4229#note_3174448
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  sound/usb/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - ALSA: usb-audio: add min_mute quirk for SteelSeries Arctis
    https://git.kernel.org/bluetooth/bluetooth-next/c/b98b69c38512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


