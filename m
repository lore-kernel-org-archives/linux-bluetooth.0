Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66B2031A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpCJNmDv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61E90C433D9;
	Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702047630;
	bh=CuneD4C42Kb7Lq7eB1k6/vRQLJE57KCt6g1F2P7hZrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CpCJNmDvZNi1Vu16Cp0wQ2dbN1uGDw9UojVZMiW8wOgpHeMNOOe5K3/kFOEimX0AI
	 kXKTZm4rrlSMMqtx3gidEoGeY+BPDj7Kjd6OC81c7Zg/MOE7HZ7H7KfFs4emGrCANr
	 vW9lwzEYfscCemtq7mtR8TDZKuSr8GQl1616EnQbfLkSh0ICf6u5QeSNscIJXY+Biq
	 KA7606hpgC6YtRz+W95ib0fc1bm/5A0iXOnPlT2wC+KMfdAKg2OsqMCFU8UqtMPTqZ
	 M5U4RLhTrEAN4EtKfrPMn3ADdFq2wBDgVdSnpwS4eSFK/rOcgGEnzLXcKFaLmzrqA2
	 kQ9lcYolOoepA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46A08C04E32;
	Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] test-vcp: Fix CCC value endianness
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170204763028.28520.3588495372277409614.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 15:00:30 +0000
References: <20231206220430.3713081-1-luiz.dentz@gmail.com>
In-Reply-To: <20231206220430.3713081-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Dec 2023 17:04:30 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> CCC value is 2 octects long so it needs to be converted using
> cpu_to_le16 in order to not fail in Big Endian architectures.
> ---
>  unit/test-vcp.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] test-vcp: Fix CCC value endianness
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71188eb0e752

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


