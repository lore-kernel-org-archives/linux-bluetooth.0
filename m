Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6F2D4809
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928961; cv=none; b=hGUG51fJsk/KeOoRavOGvmTwitaEkv/5yxt6e8/P9T0sfI4XcsVOccs9t7kWT4mD7yo492kd4vlz92oPRQJcRxjuDV2JpCzS9QVp03SZr0TGEaK9RcgZhte2iGqAoobhQedp6GjwAN0RbRA1ZcPnvBTx2gc1u7ZY4+t5u1JJrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928961; c=relaxed/simple;
	bh=0+5XuOWhx0F77SVQRdND9GYYe2seMogQnCfhRb/Ylxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTH3ZdpRZX3eQNfNHHz5nGZEcHkQvYt/yOWBpuylkMyTeNRYn1GOiG7TGaxN1HKHzxIFWvdBkmiMBeYtyJiHRc6f5hJUQ1sjyJhXWHjZVsTsBcwqxFFgolyXJdnfYV+LHRkUKunN8Es/DWdL2/xr+k/d68PXh1GaUkeaTLhM4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojV873Lg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojV873Lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4106C4CEED;
	Mon, 11 Aug 2025 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754928960;
	bh=0+5XuOWhx0F77SVQRdND9GYYe2seMogQnCfhRb/Ylxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ojV873LgtD4bHKekm4BuRafTql7ONjofjj1q76FszpLRQUvfoXClQutEm4JJIrQtB
	 1CqRZyl3zGZzkcSMwTKXcC1dqdV1ih49/nvLmGlZVZuju4CZYandDMdp3hKsUaV6oW
	 /17eR6FqRhW2cuFW6Mj+QRkGf7H1DDDgrBQp89pSy6HiU+UZcfujIsHkm060dy0FE5
	 IpBGd24vpDT0Tj6nJxyy65wGsc7fr55otXL+d4yONGSALMD1hZbPhHpv1bUeLTVnNk
	 vmykzrlI3ibSYtHqRS0W/4tyLN4xSnPyvWSMRzj08csAwUm4ZocU+7ZYdjFuBJ8SZD
	 JwqvWETkhFQOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D09383BF51;
	Mon, 11 Aug 2025 16:16:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: fix MTU for BN == 0 in CIS
 Established
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175492897299.1716045.9865354103224492274.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 16:16:12 +0000
References: 
 <cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
In-Reply-To: 
 <cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  9 Aug 2025 11:36:20 +0300 you wrote:
> BN == 0x00 in CIS Established means no isochronous data for the
> corresponding direction (Core v6.1 pp. 2394). In this case SDU MTU
> should be 0.
> 
> However, the specification does not say the Max_PDU_C_To_P or P_To_C are
> then zero.  Intel AX210 in Framed CIS mode sets nonzero Max_PDU for
> direction with zero BN.  This causes failure later when we try to LE
> Setup ISO Data Path for disabled direction, which is disallowed (Core
> v6.1 pp. 2750).
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: fix MTU for BN == 0 in CIS Established
    https://git.kernel.org/bluetooth/bluetooth-next/c/ad2f0c8792ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


