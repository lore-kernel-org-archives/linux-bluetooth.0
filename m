Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CB4C955F
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483408; cv=none; b=TMnXpYHpmvRBj1P4Lsg/NRCzURbGqUsBDu2RDexzDJXdUxpkXHE6u1fg/CHbJySBAdCUfieOccz7NUq4HtxCnzLAZT1At0KaVWi5hqT1ltu818k0H5d8G81wo8/I2Ss0JUlZiIbDM7v0OnNKYLrjSdfUdHiZIIeh92JCZgj8d4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483408; c=relaxed/simple;
	bh=zwHA39KnEXPlq9eBI+xPmG4F1z+gYy089YyZIPiiLBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQ+RNfxLUh1mAOc2cI0kmLIMyygTyVr5xeYKK0giv995rn+W6exgNIjU89Wk6nJTnUhcF/0vOdoxQ+cE+6Shj1K1bHHWyC25K9Cuz14fClV08UlDjtFInjKvw4B9n5HIplm8Hl3WLka1Ou/H6Cq7t44siW/6kqSnT00CPAeW5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUsWR3J3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUsWR3J3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AA6C19423;
	Mon,  2 Mar 2026 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483408;
	bh=zwHA39KnEXPlq9eBI+xPmG4F1z+gYy089YyZIPiiLBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NUsWR3J38OIO3Ec4zU/965Dk7kT9atMrlHJCP24xaRug592vpfV+CuoVwuaqLZJ1G
	 x46WNxCxDiYpgOCCJ3LErXHfc2bmRhM5b5SWsBKGI13X9atJkUiCeZPmdJ9FpxuQ5f
	 Lm3U22vvXpQGQSjB1Cad0vIg45Inxivc77Gq7eT/KpiRWWEqvs3oa+uuLkGT8ffCu4
	 hox7wvy/wi6MdUUhzqRWzTZHxeLAnZH4FcBzUA/v1qoCOKMti2w/AtiupaboIqmEOl
	 Er9xLgFKyI4Y1gpdVFbKJnArhwLMBaJSr2DPui3+yIRNFaezArxwHbaMCSy9a+JY1s
	 Lvbw4Vgd5Uc0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF1C3809A80;
	Mon,  2 Mar 2026 20:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: ISO: Fix defer tests being unstable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177248340979.476472.976077286433311083.git-patchwork-notify@kernel.org>
Date: Mon, 02 Mar 2026 20:30:09 +0000
References: <20260227203506.573494-1-luiz.dentz@gmail.com>
In-Reply-To: <20260227203506.573494-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Feb 2026 15:35:06 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> iso-tester defer tests seem to fail with hci_conn_hash_lookup_cig
> being unable to resolve a cig in set_cig_params_sync due a race
> where it is run immediatelly before hci_bind_cis is able to set
> the QoS settings into the hci_conn object.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: ISO: Fix defer tests being unstable
    https://git.kernel.org/bluetooth/bluetooth-next/c/094ef2d048f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


