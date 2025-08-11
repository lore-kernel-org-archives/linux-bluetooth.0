Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678C296BD7;
	Mon, 11 Aug 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930395; cv=none; b=CvLS1d9YGqAYK4KAClfAC/IxguYKSwbd+jfBvtyWlZjjFW9EHm4GZmnr+oL1F+SkGR+CTrRznjk7fFsaYM+BEa6aFfgu8SKy27btOXkNzW27+fr+ZOLTo0bFBCQ6TiRVX8dKgwsSxL6MRoMRes+l0pjrq0m6lciV6G4ryiQp6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930395; c=relaxed/simple;
	bh=YsRPZUyMgNgjr5FjQ7aq+Jv/uWYtdtWjLlrgx+z4knY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a4ZHVnOPGBBIlgCWk6tcXuzTwcDEO3+TOX1AxR5Me0nVrrm6Su6ONmj4JlSkuh+P4oRZgsLLzFQG/G6oaM6QsZYLv4iKXkVJRI+pMU1fGTAKaKIhicfXdu/R9/uX0ualaCRgcx/rlq+uVwqaPcpP0gqPxuKYJiiRua1EcyVAh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYcF6bZ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYcF6bZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618A3C4CEED;
	Mon, 11 Aug 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930394;
	bh=YsRPZUyMgNgjr5FjQ7aq+Jv/uWYtdtWjLlrgx+z4knY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fYcF6bZ25DiOwtg92ZN0PwUw5OOYMP/Czx0hLYcsi8MtwIfIbTr1sqHz4FOM5pHxr
	 CymAwnHhhaNcZU6Lr60hrlh27Su9f/nYIUN7rHCUmzFnS4P6DsGG6RqV7mb4N+1DrU
	 W/pe5WtwtAENzrwDTmEYcez/9cZeNNxuHX+i0fWdDvsYkT2Xzd+X8KJjmXDmR5eUgj
	 s1KAU5Zsn3WeBp3cliye9YYRlLJ6fwRxzto3wxqkrKeQUEyQCZ9ZCPBylcRgkGPirw
	 Zn8EyMS9o5Pnu/hW672zkQdkiPf9NChnwzzVWx7Y3Tt+IrhCPyf0JoMhRTAbK+qqWS
	 zaRT1GLdL80og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE60383BF51;
	Mon, 11 Aug 2025 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Uses threaded IRQ for host
 wakeup
 handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175493040649.1801125.3657849160282054995.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 16:40:06 +0000
References: <20250804103015.1104289-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250804103015.1104289-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Aug 2025 16:00:15 +0530 you wrote:
> This replaces devm_request_irq() with devm_request_threaded_irq().
> 
> On iMX93 11x11 EVK platform, the BT chip's BT_WAKE_OUT pin is connected
> to an I2C GPIO expander instead of directly been connected to iMX GPIO.
> 
> When I2C GPIO expander's (PCAL6524) host driver receives an interrupt on
> it's INTR line, the driver's interrupt handler needs to query the
> interrupt source with PCAL6524 first, and then call the actual interrupt
> handler, in this case the IRQ handler in BTNXPUART.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btnxpuart: Uses threaded IRQ for host wakeup handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/3f9a516852b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


