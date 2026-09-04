Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765B50EBE9
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541033; cv=none; b=R8nQupnA5AVZSw+zEpE1UqcHi0FST/KbzIlrIQlFzfMtyCb50NCynUsWRwTogCMJyY1Hpz/W/b2JCQfR8svVNHH/96ZT1dMVliC0rgr5eGkRzIy6deHJYXD1HCK+S2RgjkAhPZI9DuH02+NjvXa6GtSwWAIWFlXixa3wlIzHJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541033; c=relaxed/simple;
	bh=sNBeICmTLC/x9ThFn2VvSUk1E/UgS4/rHAyRF1HLcVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ah61j9eGzQkJEEb1Eve+wNYsijQ8O9PreVaq+XY4OuiKOSJR3Iwl3gY4ha0X1Y1LQ4YDMKUCxbXLzNOzobMT0iunDLB4gFcY+fRb5u8jSBv92YVAoBXE/ThERdZEr6urC/F49YktIp2RLr1auYEoNL2145Nh1TjTi/lspvYPT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtzDS+kL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtzDS+kL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB621F00A3D;
	Fri,  4 Sep 2026 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541031;
	bh=F7LPQX+hNmO6RlQ8aMzfBdC3HqlEvZS5aVWWLah8J48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BtzDS+kLOwGI9v5CchgxM5R+hJXUN6FYBNEZlG0U2kfC0Rq4JJFdeN0ReuTTgUMh5
	 8dwyhj4s0FD51hhxuEIkgTV8OYHsskHVQsxDH5no3/usQZWL43wEw3vbtErjMFIbj4
	 MgrU0PmmMcpEIaY8XJoh7LwNwTaQUBeJ0MF1rYptD8zAZhUa1dojnHxFYsuu86SULu
	 Qz9ryfzmaIIm70FJdPzq1op+XAbu8BE22NwY/WkGn3XaS4BnUWJBWhzxKypathb/7i
	 eQgsnYwXkrsbTLQYStoQmr5NqwV/pFUlri5xIml0hUgMbjboYVXArDb43JQ50DjVg3
	 5lH/ZRZxSNsog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199F03924A50;
	Fri,  4 Sep 2026 16:56:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel_pcie: remove duplicate
 BTINTEL_PCIE_MAGIC_NUM definition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854097164.344939.14595249328232664225.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:11 +0000
References: <20260904002939.622659-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260904002939.622659-1-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 05:59:36 +0530 you wrote:
> Two identical definitions of BTINTEL_PCIE_MAGIC_NUM were present in
> btintel_pcie.c, one indented with spaces and one with a tab. Remove the
> space-indented duplicate and the surrounding blank lines. Kernel coding
> style requires tabs for indentation, so keep the tab-indented copy.
> 
> No functional change.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
    https://git.kernel.org/bluetooth/bluetooth-next/c/1cdf710cc2a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


