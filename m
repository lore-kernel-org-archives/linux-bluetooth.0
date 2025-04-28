Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38696152E02
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852393; cv=none; b=H8y4hEOZcrntim43iVwZa11FIJxxTNkCnOX2zJa3xriUOiXBY1kKXMQzcj6jfMYVtgY13MwFa8NWobfI3giXkoboPYiRcGr1u+k6afeiFO9IiqgxJYDVb4RjQ17iI60UUlfs9C3i+/c8t2nu2dwN17UtrMtZhWGsh3jIvq1VXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852393; c=relaxed/simple;
	bh=DiV8ECLnEYfV4h7YUkmpbmyJOYIjbVAp8/3DbB9ZK0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BUEa5j8VRfTmocAbn1lPM/ePE6bmRwrDpBonzd1UcP+Mx7VzWQP/yxJljtIw0kyYYaUxNrtwTtID1T4vx8ueX4jqwB2yyUWyIVOlmSChBMAlIWlyFXMDs0+Hts1xZOSQN+9kXFgYawcENPl/uut4L9Vk37qrf2XsfTAqpn/hOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUf53qCB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUf53qCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F691C4CEE4;
	Mon, 28 Apr 2025 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745852392;
	bh=DiV8ECLnEYfV4h7YUkmpbmyJOYIjbVAp8/3DbB9ZK0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AUf53qCB+qQS+/CggKbYXn+pMeZvOcli6ZIxyxyPwTqRpA3pQrIwMdDaH0aLWMCWc
	 wKKQtG0Cx48QZwGVRpu216T4TTwFZSvCbOTqvL0L3pKqJtu7cMNHR2aXTD3CYpzesP
	 19zs0o2C+WDqqB9R+RouDcE29f+IfWbukMZB72vn+j+iz4F6Llxdx23V/EvdPQOXWb
	 TtV3EgWJIv4m5DlpkAj3aQR06qQPGdHIz6KcFEbBvuaEvI6MXTesgUEbnskEWopM36
	 xC45sHL5cdmsWMwSA+NLgC3cPPQ8h3wS6s2w/1N94YqSDxnK4J2tLCSlqGCxFT7c0w
	 +so6flO8tcKMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF083822D43;
	Mon, 28 Apr 2025 15:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/ad: Fix crash on match_manufacturer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174585243148.938927.16270010903262705990.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 15:00:31 +0000
References: <20250425194531.1582203-1-luiz.dentz@gmail.com>
In-Reply-To: <20250425194531.1582203-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Apr 2025 15:45:31 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When matching manufacturer BT_EA_MAX_DATA_LEN in case of EA since that
> can be bigger than regular advertisements otherwise it can cause the
> following crash:
> 
> data #0 __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:47
> 1 0xb6e05c58 in __pthread_kill_implementation (threadid=, signo=signo@entry=6,
> no_tid=no_tid@entry=0) at pthread_kill.c:43
> 2 0xb6e05c8c in __pthread_kill_internal (signo=6, threadid=) at pthread_kill.c:78
> 3 0xb6dd63ce in __GI_raise (sig=sig@entry=6)
> at /usr/src/debug/glibc/2.39+git/sysdeps/posix/raise.c:26
> 4 0xb6dc7f5c in __GI_abort () at abort.c:79
> 5 0xb6dfd608 in __libc_message_impl (fmt=0xb6ea1a50 "*** %s **: terminated\n")
> at /usr/src/debug/glibc/2.39+git/sysdeps/posix/libc_fatal.c:134
> 6 0xb6e5a430 in __GI___fortify_fail (msg=) at fortify_fail.c:24
> 7 0xb6e59ffe in __GI___chk_fail () at chk_fail.c:28
> 8 0xb6e5a8a2 in __GI___memcpy_chk (dstpp=dstpp@entry=0xbefff7e6, srcpp=,
> len=, dstlen=dstlen@entry=29) at memcpy_chk.c:27
> 9 0x004944f4 in memcpy (__len=, __src=, __dest=0xbefff7e6)
> at /usr/include/bits/string_fortified.h:29
> 10 match_manufacturer (data=, user_data=)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/ad: Fix crash on match_manufacturer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1be17107d22b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


