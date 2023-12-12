Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42B78E60
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy3gH3l+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7514CC433C8;
	Tue, 12 Dec 2023 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702398623;
	bh=lpmDF6zAIM5bqqgCYV8D+XdmoofBH2Wltv752FmDLoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sy3gH3l+8DjXccvUxS4znhpBWQ94TTMKOFifBdZgVso4EFwRWuf2bcJT3cDj82gk0
	 2ZCO2oPyoRWc1CLrCTQ+NsNxjeecNfylw5zoudcXvy5GkUUdQ/qLVBUqm9p/BpaF8v
	 oPOO+AuZXVFtmefNzqNWN0POiDSVDq3ve/bUSrpI3n28uVgAMxOFpnd5s+HcL5ICJX
	 Z5tio4/Ude3gVSe6inK0QrFzpfQ6/pPO4UcS+whRvo3+bolIxC8MkFM1ZWaxJs42vE
	 X6Uwaq78feQNu7FVe5UM+VZnRY5SpKZC/0lItngFwZkbHBv2SUmzcSf16e6NefRCgD
	 +MTFlx2a6u0qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B431C4314C;
	Tue, 12 Dec 2023 16:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Add more enc key size check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170239862337.27856.15531627573114071096.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 16:30:23 +0000
References: <ZXfFyoEhCj_S70qp@alexlu>
In-Reply-To: <ZXfFyoEhCj_S70qp@alexlu>
To: Alex Lu <alex_lu@realsil.com.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 max.chou@realtek.com, karenhsu@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Dec 2023 10:30:34 +0800 you wrote:
> From: Alex Lu <alex_lu@realsil.com.cn>
> 
> When we are slave role and receives l2cap conn req when encryption has
> started, we should check the enc key size to avoid KNOB attack or BLUFFS
> attack.
> From SIG recommendation, implementations are advised to reject
> service-level connections on an encrypted baseband link with key
> strengths below 7 octets.
> A simple and clear way to achieve this is to place the enc key size
> check in hci_cc_read_enc_key_size()
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Add more enc key size check
    https://git.kernel.org/bluetooth/bluetooth-next/c/19921189d442

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


