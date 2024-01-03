Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF861D558
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOCkMTQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79F85C433C8;
	Wed,  3 Jan 2024 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704316226;
	bh=8Y1JlWNGI2GzGJwDZLISiaiF6CtmTyYJbqtlVilEf/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hOCkMTQ/1l0dyVGNMh1uz/CKmg5pAexo4071x97cS1ZPumBZUxXs2UVKDtYed6iOj
	 POSEkXLBlIhg9SVER61COqyWZ4l40RqtyQtaVVTYkAtAozsXV+LMWR/fc/KAbyOpwO
	 KEniRbtAd6vgQA0hPV2dhPTi5yK8y8WsTSBaix3AKNpHACVDOXalqQWZ9PbEbi8ofW
	 kxVIitAwdDBsyhYpMNBtZXo1sM0Q7/gAwBmB3Az+F5U3RIiLC4PQOJ/0yMWYnkRFgi
	 GZv48FZOcEpWYLz+txrP6v/rxKQWTR2UqSMcW8ucmXPVXQ9EnElJfV/XpMsh2WfwoW
	 QFWljzQ7wAAkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56086C395C5;
	Wed,  3 Jan 2024 21:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH] monitor: add Qualcomm and Mediatek MSFT opcodes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170431622634.16433.5099486692041738668.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 21:10:26 +0000
References: <20231212190531.BlueZ.1.Ia938c97b56083995e9f6bbba445a01b4cb4de0c9@changeid>
In-Reply-To: <20231212190531.BlueZ.1.Ia938c97b56083995e9f6bbba445a01b4cb4de0c9@changeid>
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 johan.hedberg@gmail.com, marcel@holtmann.org,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org,
 chharry@google.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Dec 2023 19:05:31 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> Qualcomm and Mediatek has 0xfd70 and 0xfd30 for their MSFT opcodes,
> respectively.
> 
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Hsin-chen Chuang <chharry@google.com>
> 
> [...]

Here is the summary with links:
  - [BlueZ] monitor: add Qualcomm and Mediatek MSFT opcodes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d206ab94a79e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


