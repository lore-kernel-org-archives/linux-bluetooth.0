Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39595275B11
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727991; cv=none; b=F3iCRXVD7l2Rv6Frndc53/qJCk1vElRericnNTq50fPx5p1+jrsNNgCk3BZ7V5GRb7B6oN/DBDhuTNCvOcth5AH9p7H+A1XVMKqPrmrtZTqV2R9bTK6L7QlH6QwC5uobXA/mLXLqWzX2MyNYejIJ0tljrl3Aa/duJbdFQKNwqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727991; c=relaxed/simple;
	bh=zUuyGga3XEloByDwyPNLsozApKTznOZ8W6Q2CrSY2Y4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BUBrMFXZMHI1J9j0A3MzaiU/mZ4f0G1wrRTv4EbGoQuarxUKpmKsHp5r3BIPiDbfCQYmXbc7UST7KFykZTemZPKCnSYQpU7Ue6WJAxozHWev7xFII4RbzNewOf1Pf7u5Uq0hon4Zn/ur9pftK6iWmSwhR7UlmWN6xgyc/fToRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtKMMtLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtKMMtLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE8DC4CEF4;
	Mon, 28 Jul 2025 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753727990;
	bh=zUuyGga3XEloByDwyPNLsozApKTznOZ8W6Q2CrSY2Y4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PtKMMtLmVruWCwis3E6NlFbWSDWmYVe6wGOkXqXxrQGxzXvn6Crm6UFAw0egtxRPZ
	 sDQhiSfiZ2aU6O6TW7sOsiZ6Tj5aI+LlVWAERubeYnKz3gcL3YB0Qau/NbeKRdLkAR
	 PRjOb2l+DPRl95V2N796PtBuuI9AeLG9BelIV972frJrwQZfgMASRu+LBN2M5CFmek
	 oXPmSJZCDEZfidMj/PSaTuTTXV+quhhVkbyv2kDvyqfN7xfW8TuN3hg1dWssH2kDjZ
	 qaCSmYlekbB6QwsOhykLMg2JnPSZZX97ndQt6esoB6Qjf2CVbnlTihAxy6d1aICldO
	 8SsqyCoNfD+NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E87383BF5F;
	Mon, 28 Jul 2025 18:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel_pcie: Add Bluetooth
 core/platform
 as comments
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175372800699.807848.11069796095738081245.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 18:40:06 +0000
References: <20250728154910.1428086-1-kiran.k@intel.com>
In-Reply-To: <20250728154910.1428086-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com, pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Jul 2025 21:19:08 +0530 you wrote:
> Add Bluetooth CNVi core and platform names to the PCI device table for
> each device ID as a comment.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v3:
>     - Include product and platform name in commit message
>     - s/commnents/comments/g
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: btintel_pcie: Add Bluetooth core/platform as comments
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca4d74a68c46
  - [v3,2/2] Bluetooth: btintel_pcie: Add id of Scorpious, Panther Lake-H484
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


