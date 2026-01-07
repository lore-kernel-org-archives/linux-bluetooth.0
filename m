Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE162D7DC1
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819810; cv=none; b=NSA0e3EPfKPJ9FM9SXj4eDkscwW0ZJLIFSqAAfNRf8arIV7x5aqvbdHo3v6lyg58kc59dinTqw3mSKZFWIAdAxroSy2LpZ1zwknvQCMebddHSMI2+ozpgdvaHdXrGPmHrwliJt5tTrq+y7g101faPVL4//W8Ac9Q9gWlPp9U2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819810; c=relaxed/simple;
	bh=BnEoEdbIdwkfpHvJfeT6uK/O0uUwE2+rqXiOmVLF+fs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bxQwrm4JwiGPtEo8fN4j0AN4UTjyLpRSNXpAzaMMtQ7tbrdCYtBduXUpBMipGrgPfGdUObYHnG6tphfBlppB5YBZn53Q0tUm7+6bCslOQQnBpevOXXtttNKSdLTjOgwENbJZAE0V6GHaoWgSFwElEigXm5sxFPIbZ65F2phcwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYAnFt4D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYAnFt4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A47C4CEF1;
	Wed,  7 Jan 2026 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767819809;
	bh=BnEoEdbIdwkfpHvJfeT6uK/O0uUwE2+rqXiOmVLF+fs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YYAnFt4DyLWkhaD7RbhwD/qUAmkqNbSEWV7W/sqdIaPIVjlf30bIh/G1ygwBpWyzv
	 y0BG3scpv5W9WQWn85LCrWzx3+d/7+9Z0ux0bC+qj5p8AFCu+AneF3M7O72k/uTL+4
	 0xx2xuy37wwf0sjm8l/pqOwqrsxWS3/Ivvs3x7iPjO9rvPFHXJPCiqW2Cwj1DW+oW7
	 ja64cvvEeKSXfxLNeq+scunT06yAbFeZd36iQoLlh2aqi0b5Iz60/djZX6Wkr4bdyJ
	 NKqw4r3g85khSHKzXu9PJJKft9C9tL07uRI9p6+L7rK6Rb32Kv0f/nmoC3VmSSVktL
	 dfIVHGRTRAwJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5DD63A40FDD;
	Wed,  7 Jan 2026 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Fix using PHYs bitfields as PHY value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176781960657.2979474.7674700985271504911.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 21:00:06 +0000
References: <20260105211019.3098952-1-luiz.dentz@gmail.com>
In-Reply-To: <20260105211019.3098952-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Jan 2026 16:10:19 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This renames the PHY fields in bt_iso_io_qos to PHYs (plural) since it
> represents a bitfield where multiple PHYs can be set and make the same
> change also to HCI_OP_LE_SET_CIG_PARAMS since both c_phy and p_phy
> fields are bitfields.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Fix using PHYs bitfields as PHY value
    https://git.kernel.org/bluetooth/bluetooth-next/c/bdb9aba465a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


