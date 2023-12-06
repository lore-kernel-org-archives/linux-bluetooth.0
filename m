Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69E883D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Dec 2023 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsDITDgd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7A95C433CB;
	Wed,  6 Dec 2023 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701874223;
	bh=3iRnXnNQEgmmSIDtgGHOHyDTHcULYDpB/dihJFvCB8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TsDITDgdg/yMyH+zBWONeMS2+OTibVJbkpGCugJlHA5UQrGD/2Kpftgrsy8EYRI3r
	 72rlMtPUYt6i2oSMArBabB3POVvTqW0Wa5/QMOjORpIcZ2UOrcVRFINEch2si3FHTy
	 jTGHUYkyubTlcexx2tq3ageznMgoGu08R026gIGhOxByLDRxLDYWoxzdVI9GzM5eM/
	 NKamfFHSbCB/lwWtmemyds/cUr/F6NRnjjNgMpvdFe2SH9K3qMqxTa/qJDIqvOBUzB
	 mjeUA2qViBrQG35mT3iTblZDwInJIFemB2I4i9VXLuUlXZL3c7cp7Bg61VnbJ1SQ/c
	 e/0oc2og5Qw+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4737C395DC;
	Wed,  6 Dec 2023 14:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2] Bluetooth: Fix bogus check for re-auth no supported
 with non-ssp
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170187422366.25010.16029122912094833108.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 14:50:23 +0000
References: <20231130135808.286908-1-hadess@hadess.net>
In-Reply-To: <20231130135808.286908-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Nov 2023 14:58:03 +0100 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This reverts 19f8def031bfa50c579149b200bfeeb919727b27
> "Bluetooth: Fix auth_complete_evt for legacy units" which seems to be
> working around a bug on a broken controller rather then any limitation
> imposed by the Bluetooth spec, in fact if there ws not possible to
> re-auth the command shall fail not succeed.
> 
> [...]

Here is the summary with links:
  - [RESEND,v2] Bluetooth: Fix bogus check for re-auth no supported with non-ssp
    https://git.kernel.org/bluetooth/bluetooth-next/c/b640347284c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


