Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40AC21018A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945013; cv=none; b=TYg9SUda5Fwdz0cgV3X2Ykr+UgmOQYKfSWZek4B6/LkYtXcWf78Pq77Vl6hexDSGX7tBAbJtnbzAAFQXmRhnEldBjUx3/NtoaKHv70ZZlkdrDyc8NKdy48U23yaQrYeRwxqm0ffug+cLsqMzJMcCOMoqrwtzCzoo96emmerQng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945013; c=relaxed/simple;
	bh=NCpixay8qXKNz+v4kQFqms3p7svvMJgbpDPF3sKzUms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOZ2HCGf2oTrt4dE18h1j+crpAx7nQ3FSse0OdsMblVST06huX9wa/W+VHSHU9FwThAxbCkp6jr6CzcEWt5pki/zZIDJcP2SXZ+h28ZkpksWIGWBCggr0ixt1Z45SuoyqftAO+N6Yyyn/SArShk3SedL9gKIM4E8juDyLnhMiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9twMhdl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9twMhdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB47C19424;
	Thu, 19 Mar 2026 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773945013;
	bh=NCpixay8qXKNz+v4kQFqms3p7svvMJgbpDPF3sKzUms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b9twMhdlPHe1n8JJOPSYgpAmPbC6AJfHkaCMe5B4XyvXYui0T39KcnAlAcfTwbC19
	 db97kveZ7eM9W2uo2CXn5559NubHxp5ccJF3lzmUfKefJ8R40js3LOEGxwYCDafp6U
	 00mDnJYLdRFd/uWiaQJACSeWzHp0hvUkhXXutvNW2xEqObTgEiYmGHrtQ9tn5Q0GpN
	 1uC6xG+F7P0Tf75cWBAkMBdcA7ib4hT4pk44Q8Un+XAIQ4XD61E+RYGCVjLiui9mDN
	 OkKAVCD57IDDPjgt/4VG3zm4vaiUBM878tnLJc3Q/CiM6dAawIs38bEXXpa5uJywAq
	 oIke2qHAFFzOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0D239302EF;
	Thu, 19 Mar 2026 18:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: L2CAP: Fix regressions caused by reusing
 ident
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177394500454.1753486.12663891952482263879.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 18:30:04 +0000
References: <20260319152247.13225-1-luiz.dentz@gmail.com>
In-Reply-To: <20260319152247.13225-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Mar 2026 11:22:47 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempt to fix regressions caused by reusing ident which apparently
> is not handled well on certain stacks causing the stack to not respond to
> requests, so instead of simple returning the first unallocated id this
> stores the last used tx_ident and then attempt to use the next until all
> available ids are exausted and then cycle starting over to 1.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: L2CAP: Fix regressions caused by reusing ident
    https://git.kernel.org/bluetooth/bluetooth-next/c/eae2412ea6f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


