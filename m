Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14861EF0B7
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258208; cv=none; b=HyD7IhqI3X/SbwIaRibIzcMDfa5CY3NUWHEd2TqoONSLFxwC0Qb83bDiNP8eIxIPfAUX5OYYVf91q4zL+AnTimtH0uu3I9fXYq+Z8haU7lb11urpnDMa9mWoyWeSwOUOGrkvlBb8WHXQlfseSu6mSC+eIpeyR/N6dAKV8ztH2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258208; c=relaxed/simple;
	bh=9N14ICPN+RQIei3ZAkvEhYFjWwzsDgc1nabpFJuMswg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VqrH+XVaskBdQex6qadKvHUV3Ny1IAObu+CVZtBIZafUzxx4AuAfObAc5shjZe3c2XAiT6XOnct1n25xqIwO2EJruO9X69S69eJP419sqy3lSyQraCGnEgj7JzTmyBOcF58XqcipzVeTc6mLlIXZjABxvNBJJNr28Ij14RmXJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2Fp4Oab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2Fp4Oab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381A6C4CED2;
	Thu, 30 Jan 2025 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738258208;
	bh=9N14ICPN+RQIei3ZAkvEhYFjWwzsDgc1nabpFJuMswg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P2Fp4Oabwi+KtBHHNb+z1DJcvKsJQIUV1BtYu6X5Y8tKAc+rY8WTCrI+hFgkPzNLW
	 uKK7fFIkOOswtK+XCfAgYDUkl/aWWzy7LAwIgwAH0ra1jL3ensJ2PI7sEOR+V2EB6/
	 lmaNn6XI3cQK/zo9gT/UkNbp05fRlQQBMP0tF/VImYrZz6g6mxHP8KGvpsGYJCGAHo
	 IZ6zWLuq3OMptzkkdKg1pzsPf341OJZ79r9ePY6WGoD1IS6e1KVJ0Y2/Li9FWFJhVb
	 9D/y9RPzr1uXuNwYxuREgjhQbhiYKWsUdPkFwdRam44xDw1UgcKlvj3AyluIMtWVuw
	 tNNKuvzWFRoEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE448380AA66;
	Thu, 30 Jan 2025 17:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] audio: actually try to enable MTU auto-tuning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173825823449.1027237.5797702882442522177.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 17:30:34 +0000
References: <20250129084950.41987-1-pchelkin@ispras.ru>
In-Reply-To: <20250129084950.41987-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jan 2025 11:49:49 +0300 you wrote:
> A "0" for the input MTU passed to the underlying socket is supposed to
> indicate that its value should be determined by the L2CAP layer.
> However, the current code treats a zero imtu just as if there is
> nothing to change.
> 
> Introduce an additional flag to indicate that the zero imtu is
> explicitly requested by the caller for the purpose of auto-tuning.
> Otherwise, the similar behavior remains.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] audio: actually try to enable MTU auto-tuning
    (no matching commit)
  - [BlueZ,v2,2/2] a2dp: enable input MTU auto-tuning for the server
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=252a32ac0b3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


