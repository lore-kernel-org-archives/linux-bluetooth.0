Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F0218841
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413817; cv=none; b=TGVtWhEw+LpBdcfR1s1iSDHOCHJlqGbJbDvlzAyJQP3XhniH+1EYcG59Cq3/F1awGpC4HVgxg42AZMQSh2D0Qyu8ygengdpcnI+J9fDhUXad7AoFMn73z5wCpgFpc4XO1ZC8MXDTefh7EjhJ2WLBDNPJryJJ0TaFOsoVKKIQ5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413817; c=relaxed/simple;
	bh=IwFruwdrAAlHNy+ABYOQV590Q0yEULAR+KpY5ZAIa8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7ZqhJbgQ3mVbHztI3+z9SOgK6XlqObil7CiG1nn7V+7zIP0jjn6apCyegtsNzievBdQQP3m5WW0y874r73g9jmEcf1ZfIanSHN3IrXp+leH5k3mZ2SUdYPBvQs3w4lDUesAA2xAZcEpR/w/fpFA42ZWLxA3pPl87rRDo1hUdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/JWCjSq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/JWCjSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F87C4CED1;
	Thu,  5 Dec 2024 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733413817;
	bh=IwFruwdrAAlHNy+ABYOQV590Q0yEULAR+KpY5ZAIa8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/JWCjSqXt4Ble15PHSl5ByQDWIf1hYT5GRS7F9URHF4sgIJGu3fBdpuR7/p3VZFH
	 GCq7IH96JP6fBohK4GipJF6/uu3T2AsCjwJNdonbCGqGR+MQJY4ID44zGvGQhFkr60
	 QiRpoPO3kAJ+6ITXUM72nQMw2kfOAKznQxNYsJiWQfVBIzbgzFd/hjyYDj42nlvcOb
	 u3dlLI/B1UYyJs7utwc3r63jten1GKRXPnLWPFc1V1UJxqHKNzkugcALMVSJP1t/GK
	 yhHw/cBj0txT0rwjF9z3yxpdi2VO6oY3jJIb10EmJn0HIW3ejvBApVLjYjzVhfOW0D
	 q5MTQYcX7jMAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71177380A951;
	Thu,  5 Dec 2024 15:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix using rcu_read_(un)lock while
 iterating
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173341383226.1962790.6754291284055147773.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 15:50:32 +0000
References: <20241204165849.392564-1-luiz.dentz@gmail.com>
In-Reply-To: <20241204165849.392564-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Dec 2024 11:58:48 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The usage of rcu_read_(un)lock while inside list_for_each_entry_rcu is
> not safe since for the most part entries fetched this way shall be
> treated as rcu_dereference:
> 
> 	Note that the value returned by rcu_dereference() is valid
> 	only within the enclosing RCU read-side critical section [1]_.
> 	For example, the following is **not** legal::
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating
    https://git.kernel.org/bluetooth/bluetooth-next/c/042ca30229a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


