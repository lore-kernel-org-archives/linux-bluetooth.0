Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCC2D8773
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573038; cv=none; b=UqbJXlWVhhAlMXCHQEiCoIbqz3SG6rVQW2ErF+5fIYLSbr0xxXdM/0zf5k3QYABkaxVuhx9UpxJL7PLDqgkoclFm/UFq+nAVxkDI0hJMpZSx75S7MK2iEQCtZ2emkg/cTAtpmWmNoUcNZSWtxSsywcITrhuC6Yc79vIsimqanf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573038; c=relaxed/simple;
	bh=+2Eko4rLo7qud3D5TFsQcSiC3MBPWdyXAm1W0Rr2dko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZEEcHbZJC0xbd59xy38stBagwdntt2cpqnS3hPJ8iADcEWR6RkhPPUCkdyj/s/Nh6iiHaF387y5bET9Q3ODb54XJ2UFdiY0/LPqV7gE/qNgl+HhHgGPuIbiGiuWC3e/GfT8tGWN/jzSnpOXGLaqo9oSitJP7Fb4Ff6AmSQBPmAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3n64OE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3n64OE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06C8C4CEF1;
	Mon, 27 Oct 2025 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573037;
	bh=+2Eko4rLo7qud3D5TFsQcSiC3MBPWdyXAm1W0Rr2dko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O3n64OE00OU276FMnvpq/bFGRZ+K/q7mYC0Qu9TINgbTH/8ZfsPr5TJnEHeBb/I0l
	 XzylOXqeNdV5a4jtIpNSP+xJA/utkqMcL5/e8wwTPwMwUAEBqrPTBM69yhakOcwc4h
	 QLwus9OEze9/f6ExlUrFWJt4O2jCYSPacE1PLlIQ+eb5leYDtkR+Jv7rJID24Aa2QV
	 govFb8PIJ3yyRFGpxz3dY7Rh6xK3d43z8Buc6Z8Nl/FU1GfepggkuJmt/52z417fhg
	 6JEJf0ifbeKXBsU4dFo18bzXh5fSvCs23OK+/WFwiCR64JZdL3zV+4SJ07uArxzvPg
	 5TesA9rOn29rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D79380CEF8;
	Mon, 27 Oct 2025 13:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] client/assistant: Detect if object already
 contains a valid BCode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176157301600.1378834.6088040453865017639.git-patchwork-notify@kernel.org>
Date: Mon, 27 Oct 2025 13:50:16 +0000
References: <20251002134043.196760-1-luiz.dentz@gmail.com>
In-Reply-To: <20251002134043.196760-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Oct 2025 09:40:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If assistant object already contains a valid (non-zero) BCode
> (e.g state=local) use it instead of always request the user to
> re-enter.
> ---
>  client/assistant.c | 55 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 14 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/3] client/assistant: Detect if object already contains a valid BCode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdf49338d97d
  - [BlueZ,v2,2/3] shared/bass: Fix permissions not requiring encryption
    (no matching commit)
  - [BlueZ,v2,3/3] client/player: Set QoS.Encryption if QoS.BCode is set
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


