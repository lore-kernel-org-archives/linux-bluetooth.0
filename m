Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06826FA5C
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898602; cv=none; b=lC5myDAQSqbIZBmDXSMfW7KYBo96Tp2ellId3oe92HRotJi+9H/D7zv+GxB1WlSJp0jXyKfxQ+erZFjPeMYwNz4jAiYko4CO5UzYdithA9XMN8gA4jO7dxMgXzoE8uJFpkqgcvs0cMD6Eu4g842aweB4+OYVuHTKYB63wuqxNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898602; c=relaxed/simple;
	bh=5T5RIrLRaHGtbMu4ajmSz/iOahRkNfrCMS0CD7hGYDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fa2HZ/+9wAEXEL//VysnOSdp3tD8p91Hbaiyu+4wB/I7zr24e+ApOj6/Cy5XdypWIrquDTgcGrVYTERAFOWO6iYqcKUF2+r69sNmV32bRTz+qc+4ijrxB9ng/qJT0d+FTNGJ7KSThiyKhx16J6hkZH74fRt/eef0OllkgLzHies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/T8Of7a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/T8Of7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695A4C4CEE2;
	Tue, 18 Feb 2025 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898601;
	bh=5T5RIrLRaHGtbMu4ajmSz/iOahRkNfrCMS0CD7hGYDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m/T8Of7a8MGJwkYzg0Tf4AkF48RBJGtcX2QwC95ojpBV186KsMOyEstn/HV+ku9I6
	 KzD9pddTz9xcuNavc8RW68fyO1XLzDXLbRZo6CU8TstW9vIJZNchQHru6fapdJHspo
	 2O3oWgL1ZIbEga61GxvUgwz8YqvUE1cfjh+vh9XUrxqmlD/d8QBafo/TEzGLEwQTjQ
	 RLi05k15wmS1oCgBWxUFBPXBIrUX3mnvzGAAVrewGNBv3wOaBGmU6obBpJcpHFUy7x
	 74Eymp/HYbYpkyMv3pfjgJQW21dLcF2ZhFr2O2wiDjQnbF26agvxAjHajSkGK5d5eN
	 wrJFpN/MNbIuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC6CF380AAE9;
	Tue, 18 Feb 2025 17:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Fix crash due to negative max_len
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173989863178.4153921.4204641197219112373.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 17:10:31 +0000
References: <20250218164820.1458561-1-luiz.dentz@gmail.com>
In-Reply-To: <20250218164820.1458561-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Feb 2025 11:48:20 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> While calculating the max_len for printing the packet details that can
> come out negative, so this discards extra text if that happens otherwise
> it can cause the following error:
> 
>  Process terminating with default action of signal 6 (SIGABRT)
>     at 0x4A800F4: __pthread_kill_implementation (in /usr/lib64/libc.so.6)
>     by 0x4A26FDD: raise (in /usr/lib64/libc.so.6)
>     by 0x4A0E941: abort (in /usr/lib64/libc.so.6)
>     by 0x4A0F7A6: __libc_message_impl.cold (in /usr/lib64/libc.so.6)
>     by 0x4B0E3B8: __fortify_fail (in /usr/lib64/libc.so.6)
>     by 0x4B0DD53: __chk_fail (in /usr/lib64/libc.so.6)
>     by 0x4B0F544: __snprintf_chk (in /usr/lib64/libc.so.6)
>     by 0x11F3E6: snprintf (stdio2.h:68)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor: Fix crash due to negative max_len
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdbfe0018f6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


