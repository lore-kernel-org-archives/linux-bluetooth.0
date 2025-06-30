Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEC18FDBE
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293783; cv=none; b=OjUiXkeRVxMl2FNPy2dUVwEypup8xxI8da9OYBbvCheqD/QTQOOvBluXI6Kcsnhr3jWrqw0eup6LxTLWQu+mSZnPe+q7+5qWW2JBHPh2+BMSO74cyA3oDmMGRO9/nWE4Uk06BWRdY4pGKRcKDDt5bv4iE0T6V4KYMZYh0aPjLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293783; c=relaxed/simple;
	bh=XIqb0d9u/bqeO/2Ei1RruBu9yC0tX6aA7CDkxUISyg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PpzqXM9PaCJOQaZMqTBjNw4zqMvT7goVmvxyTRiBAMbl0iVJk1lW4METoThMfytvUoPzbwdsjj1yUaPg5CbxD4lnruCRj9aSR1THSxa3z2TXhR59ThimbISmPjSjp705YFFvA0yzfNPGY88A/MQJwc+2r9eVoFYlQ7T/UgsQvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKTQw0rY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKTQw0rY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E15C4CEE3;
	Mon, 30 Jun 2025 14:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751293783;
	bh=XIqb0d9u/bqeO/2Ei1RruBu9yC0tX6aA7CDkxUISyg8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SKTQw0rYBI9gVKDzuUdxUK0E3Fq+tpk1tNkT31f4mbbsCoqsJQwb20i2oJTPrjxd9
	 EJM2IadchSiWawIUYTYuXCEgTGKUitrWci32ApiedE2zRTgg3TrZLIu5E7NY9N1+/J
	 ptyKMS7U9k0Mr4FjlgO9SiwMTLJiFJZS6wZUrCx5UdhxUTwotw3EBK3JwgIc2Geza9
	 MxSJpySVJNCvQLlk63u485gRiVqkaMm1kntSTJyxrYlH0KaLlwYXqyM9992aMoN1N7
	 esCb8Yk1PVWfCCcqJCjwjUUVrXO7/AjVIBcgMZD4PES7W3+Becr6jiVyISi19YJ63u
	 ZNWIP0k8WyquQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1D383BA00;
	Mon, 30 Jun 2025 14:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not disabling advertising
 instance
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175129380849.3403730.11788124472013852317.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jun 2025 14:30:08 +0000
References: <20250627163133.430614-1-luiz.dentz@gmail.com>
In-Reply-To: <20250627163133.430614-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Jun 2025 12:31:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> As the code comments on hci_setup_ext_adv_instance_sync suggests the
> advertising instance needs to be disabled in order to update its
> parameters, but it was wrongly checking that !adv->pending.
> 
> Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix not disabling advertising instance
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a0ae2f6cd36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


