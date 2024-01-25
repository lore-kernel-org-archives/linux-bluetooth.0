Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCB135A5E
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215826; cv=none; b=Aon/z6tesydInpERsViuPVb75zjZF/XnUjPh7zXIMb8ux+YSDL6EReEXN16bdPTZauRIYPf4cgoYLX+31d//KcD1bUTtVdOOTNv26PhSc8dBdCiUrg3fJDONrt5PSicJcxevO+LUiUTsfIy8E6JALlThFrqttfv2KrLnnC8/T3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215826; c=relaxed/simple;
	bh=inRM3ksETguj58F4fI6R0tgJA1R8Q24ZVyDe5285uaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gskbvR3leB0M36d4xb6l8NGylOEValY4tVWn8ZbMEaUS4+aUtwt+CihMrtg2d+s525Xfp18zrFfyzgRgkcxYLhi+/navGW4Uou7s6yVZOxqeNBtHYY6LV5YZEbxj1g/iYr1Q3iCPoQvoyFX4kRqM0dK6yRia7R7SnspB9xipwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzBA8s2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzBA8s2k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D508FC433C7;
	Thu, 25 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706215825;
	bh=inRM3ksETguj58F4fI6R0tgJA1R8Q24ZVyDe5285uaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AzBA8s2kWCIxw5PaTGMmzFmELtLPJlWrij/TyWAzN7mxB4w4OoeEku9boYI0HgI8d
	 KgtJLvszSCvRwvFrQEiO7X0JRaqo3FiEUlgCHUEZi9+iFOXfG1hNWvBc//WQnpk7KT
	 NCouvPR9K3wVBv89hNhPwS+aYzzee3Dp+Te6+VlwaFhAGAkxcoSe/tAnq0k4vfvWhJ
	 Yhm+ntFDpXa45zV/n3SEE12fDGDV0Znw3f1APq0TC7Tu/nBPCRZv0R7K2gWoKEXu0G
	 CKvRgF+qXQ/UsjSMl5s2+na5mMdA45nocCS1QQBmdbxdzwFpsaydRa4iNHK/uMfzSJ
	 vCzE8imStpH6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B70BDDFF765;
	Thu, 25 Jan 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix handling of
 HCI_EV_IO_CAPA_REQUEST
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170621582574.16174.15450598739287006126.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 20:50:25 +0000
References: <20240122161521.2650805-1-luiz.dentz@gmail.com>
In-Reply-To: <20240122161521.2650805-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Jan 2024 11:15:21 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If we received HCI_EV_IO_CAPA_REQUEST while
> HCI_OP_READ_REMOTE_EXT_FEATURES is yet to be responded assume the remote
> does support SSP since otherwise this event shouldn't be generated.
> 
> Link: https://lore.kernel.org/linux-bluetooth/CABBYNZ+9UdG1cMZVmdtN3U2aS16AKMCyTARZZyFX7xTEDWcMOw@mail.gmail.com/T/#t
> Fixes: c7f59461f5a7 ("Bluetooth: Fix a refcnt underflow problem for hci_conn")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST
    https://git.kernel.org/bluetooth/bluetooth-next/c/c931eafc5a82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


