Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD81591E8
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799633; cv=none; b=ITVmXwCdoo9OvaqYfupjpkbD8SEMMUJYJLrNwDEh+/hl+Yf1tMrquod/WoI2z69dLnk65lsft2V/RjmrJ/1SQAOWMgWY59inSESmPhqZQbkmt7eOsVm40OUToaiDao2Vuujs6bau5iapJSLkFWA2WEiXg3RfMmwtQ4k2FJfACyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799633; c=relaxed/simple;
	bh=XUdKUWCwJ0k9B8p0ijG08AaS9PLFeZOvaM5PBopl2jQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KC7bVYwNA7K/4BmooVoWPOSKJNGVquVVm0So3/FMFygmpZW6kGVAEXk5CFtuzn9C3pY4dLioAW5kw2tGH7TRajy9VHoaorvDHwUId0F1FT9vm0N8hyYHdPGeMEOXhaXxag0CIHZNqWkA1PpdlPkQ/ewIlT7y5E0SCXMwH319nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y56bwXzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y56bwXzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 061FFC4AF0D;
	Wed, 15 May 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715799633;
	bh=XUdKUWCwJ0k9B8p0ijG08AaS9PLFeZOvaM5PBopl2jQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y56bwXzJtWGonLpxQN4txAqI0y9q/vY32tWaQnwt9XXPOvAa1qSQ/tdFuZn5uQQrY
	 e18782NlMuT3Jqglt2C0SNNRJdThYqEa+OM1HUYHO1jPqhT4Sv9JJYyLZ5tHU00ygC
	 mlM6JFy85sD8ySgcR3wpULkS55fwwpjtD1HAMozAUHkriWojAqdiaEFcoxmxk1D14X
	 G7SaTBtRIQ5pVbLECgC9QfTZAuA0kck6sEyuOTvEcufZH8K6KF2DphddIkwOO2WFSZ
	 gTN+gIxK5UVZuBzx48cFetbRt2HeDEVliaadf7i4OMYgTgoQDdNPZkOkUh/HT2HG4d
	 5yhEMzX9xyI/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF5FFC43332;
	Wed, 15 May 2024 19:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not using correct handle
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171579963291.26824.9952078667050406137.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 19:00:32 +0000
References: <20240515143447.1371779-1-luiz.dentz@gmail.com>
In-Reply-To: <20240515143447.1371779-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 May 2024 10:34:47 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When setting up an advertisement the code shall always attempt to use
> the handle set by the instance since it may not be equal to the instance
> ID.
> 
> Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix not using correct handle
    https://git.kernel.org/bluetooth/bluetooth-next/c/1a556e63116d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


