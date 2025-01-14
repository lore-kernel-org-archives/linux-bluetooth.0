Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94F14A609;
	Tue, 14 Jan 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875215; cv=none; b=pLAd8imvhiPyMb/iAkr8Vq6Rl4QWZg2/NDHRuRGlkEew/RIIRR8PCVyQ2e8Ar7BTd+pTzkJjHKMNVnniJ7iXVml3ciLOAWmrdELI4ja/YeEynsWUOJ+hnNZ5adCnECOhM1O8BGxSUE4yOv0Fh8/C5GMFCq5+GEeLoAiViJxueQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875215; c=relaxed/simple;
	bh=TlWJifcB8hMioSGlbZjFtLR//EdJjl7Abeu7ykZiFxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DF42pkQeG1He1eYtqo6hnUDaiHiUSWi+GR0UH0S4MNNiDjOh7KOsfp+kuKOq8QhrbQPQSflX+L4YleXYFH3FJfvQxb1FWl1FP1Zy8+CztU2LMH7BI0UfERwYLvwx4Ev/hMthZoA+pNRriuxDD7DC5MWW3IvISYziZmdRaaaGqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDFDmz0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDFDmz0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFE1C4CEE0;
	Tue, 14 Jan 2025 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736875215;
	bh=TlWJifcB8hMioSGlbZjFtLR//EdJjl7Abeu7ykZiFxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tDFDmz0k+Gbux14Q2xL1JFf0LYcgsOwrgvny+nL9u8WjQ5HuiTPAdVzwhA1f7JVN0
	 pdlE/aFqv6RGmXvvfr9J077opqaAP4SMuQclDG144U0ap3mxPRbEz7fOkAEPf94kCF
	 wD1qmpX59eNBh0LsMROw61uidCV00/A/61IhVVO23dx6NfcDaztOXlNX/zqF1FO64R
	 GwCmgUIT1IB3i6W0bKOvxXNyftLMAAVYg1WEhpnLcJsv0s/U80K4EiRxIt2zJ7C2/H
	 mFKaBcPgJwtBW9YasQTXpJVxKTsYew04sxOfdZYrr+69P9f4sOxX3SKOB+qL3ZV3tC
	 AmSNowI0JpyQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD4380AA5F;
	Tue, 14 Jan 2025 17:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: Remove the cmd timeout count in btusb
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173687523775.62266.15896593510934869210.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 17:20:37 +0000
References: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
In-Reply-To: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org, chharry@chromium.org,
 marcel@holtmann.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 Jan 2025 20:24:42 +0800 you wrote:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> Remove the cmd timeout count in btusb since we only ever allow one
> command in flight at a time. We should always reset after a single
> command times out.
> 
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: Remove the cmd timeout count in btusb
    https://git.kernel.org/bluetooth/bluetooth-next/c/e52a5e074971
  - [v3,2/3] Bluetooth: Get rid of cmd_timeout and use the reset callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd224b09eedd
  - [v3,3/3] Bluetooth: Allow reset via sysfs
    https://git.kernel.org/bluetooth/bluetooth-next/c/c4e01540368c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


