Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A52C80
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177231; cv=none; b=VwwUDfJHMt2Zhehwl3uiNZHprYRQfwi1LMLRnm4JqFqRy0TTrdQZpXRfo8zJ7oJ17b3w2P9qwTnu5K2gUP4mRTiO1azDnT6zMWDtHJ6a4BkcjsDNDUZ7hgiMz365LMS9IFj+C6N7OlnbUSNFE8qQolcFcpFwTxxgRIhf4bsFJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177231; c=relaxed/simple;
	bh=NwxQJnuM9yESs+fNLACNUgY7BpAZf79ErmRpa7yKv+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MPtwiZPDSEOFANr39cC+xfsKRseUf774+wz65oyXc9yF3cL5/GqZX9IkKtKeuqE+yh0prW8aHUOf3Lp3uLlF1lPTrrIcwFJAhPgGAovvGTLD1qz46d0fn2cTrxcelogtaODSUImE/rmj9zd9rHuBC/FHHWbpVsDqBV+47/cBgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQzkuC23; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQzkuC23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10340C4CEC3;
	Thu, 12 Sep 2024 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726177231;
	bh=NwxQJnuM9yESs+fNLACNUgY7BpAZf79ErmRpa7yKv+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cQzkuC23bFRBVCfMsExWjYuHKhxPkrN87sn3bFHNOoLagx25xJK3C6XS2nvVbx94K
	 w1N2NiGEFmkH2Y/y0BD5Phri3tub+uziJCVSxYyHc/STa7SJ3L2lFD/9dktCxrn+I4
	 Z56rrmaZ4va7NK6tI70GqnFqt8MVXnCGy5MrqWFkZl2VbrLG7bdZPVAyz2ebrQInWg
	 lnuNeGvMh7/xBkqyIQ/zh3H/qIyoMk51ztUuLzqeSOc6L+OmgCeMCeFa+CknwwvtSa
	 97N8nsAed3F6r9cTH5lKHSRYGv2Q1zx1OHdy6xR/pmvH+xW9HRz1KJLnnUiYB/oSAt
	 Wwb1Q87zxG8Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717F33806654;
	Thu, 12 Sep 2024 21:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Allocate memory for driver
 private data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172617723230.1728851.11282095374692848559.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 21:40:32 +0000
References: <20240912105100.46534-1-kiran.k@intel.com>
In-Reply-To: <20240912105100.46534-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Sep 2024 16:21:00 +0530 you wrote:
> Fix driver not allocating memory for struct btintel_data which is used
> to store internal data.
> 
> Fixes: 6e65a09f9275 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Allocate memory for driver private data
    https://git.kernel.org/bluetooth/bluetooth-next/c/7ffaa2002518

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


