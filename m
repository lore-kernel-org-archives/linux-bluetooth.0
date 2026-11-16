Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851417;
	b=EBHxoedyX3+6tfOIDOyxPntwF0jCsGsg9EfCQGDWYVmhgYfeprGihh2HH2ohzdyg5eAO
	 WPlVUkR7fKhnlWfb/AHfKuAzwK6Oo0RbDFzbHtNRYOgY3L7g5bgX1mlbPeUMBHRX5NWsu
	 KfcuO0NDxV6UerJzZaq+ggFiL7EaJkXToElvuYnj7ufTVelV3+Kxid/rSLAUDwN3R7AYy
	 5griRDaxAazD8ukACW51HYx9hHfAUSSuiu+Za9Nax0EudjExgF5imsTm03Am9UOYWv8jN
	 kJroZtieUKtpl116/jfTTZ7Im/+TyGvJnNIrMLefI5ViDWfkaausicnQeTsfucE8qxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851417;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ocJwFypq88M9NEt8ZfGNINW6kVfW2dwx0pSW+PttqMM=;
	b=ALkWNItH+9Ox+SzNpLwlm03nTF8cqNKKdkj0Jh7DhR81tjTP29P0b5glcnsLktks3Lu+
	 VUiS/yUme4+cm8HxWjmR+id1XY65cX1OH1lWNuEsgPIM9E2nqFcDSEiovh89dKM9FI+d8
	 dHuxtmA1Ykc4Nx1xGSAJhJ4Ov1YLo+LVmuiY7SPrRII91qMtT81Fla0Dk2pXQpDPmrAvV
	 GS6zlWeNMnkEpYA60x2aOT1SrnOhunFpShTv3y1+6lbo90nnVrsZxV1SKa/lRG1Weta99
	 qoMBwgzViJQ/Zdw2N4yMkKK0YrO4r2zZzH/Z9bIqANNb1/WgdGp9VPBflAR7uAeuxVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gjoz2K6/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D3606A33B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjoz2K6/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442F31F000C4;
	Mon, 16 Nov 2026 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851417;
	bh=ocJwFypq88M9NEt8ZfGNINW6kVfW2dwx0pSW+PttqMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gjoz2K6/SqPgKxumvQEBYQAQidgOzmIfnCrokUbAFqbcPJuPbYt4YSkJTEaUbXV0m
	 WweRi75gWr2ToLuNx8lZWOPsJnkwQJ3DoklJljiGh6GMyYzz+wWBYtSUIGHlcDdCjd
	 f0mlleZ8AViocGZCVVkEPqmWcXqSmu5oa9wZ4ep12+zLhq/QD6dYTYiKYe89/nyHZS
	 GtcMKSMS7L8/aGNu66gP7bgsRFGWF91Dg1qCtDK4FCX7pgIdfq7zzv0Hykd3Y8Lk0n
	 Juno9KJXPuH5skM9uYLpKXVMfhrEaUlZJbd0CW/ETGwxCjSweFtdCUMXDI6gJZpmJe
	 kG2VzBv5g5iQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A312391AFAF;
	Mon, 16 Nov 2026 17:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 2/8] unit/test-bap: Add test for disabling one
 ASE of
 a shared CIS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485141577.3796096.17049645777095759788.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:15 +0000
References: 
 <2b39b535cdf993b8e363d96ed66e58f07d7a42ed.1794349049.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <2b39b535cdf993b8e363d96ed66e58f07d7a42ed.1794349049.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Nov 2026 17:19:11 -0500 you wrote:
> From: Kannan J <kannan.j@intel.com>
> 
> Configure a Sink and a Source ASE for the same CIS and have both
> streaming over it, then disable and stop only the Source ASE, as when
> a call ends while media keeps playing. Once the Source ASE is back to
> QoS Configured, the Sink ASE has to still be linked to it and streaming
> over the same CIS, which has to stay connected.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e38984593c78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


