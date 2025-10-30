Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B933BBA1
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863432; cv=none; b=nssJ5dno5XBulN3V21m6dNO+pdoYcQm9DucCqkyQq3FE1eRodnKZZ1g0BrvQmntCpFAhRA/i2+WABfNhozSWYhcZUBPgMPm+OHoBxL+EiLPt62aV5oOrTi6OWeX2KBqeCbZot6RlTqgaSmCzFod+Cl5steMj8/KC7GtPPeA9mkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863432; c=relaxed/simple;
	bh=GqxWEyGMLfFJEWz//ZTdzklGgEnVgbHREuFAglOEN/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxJu6ZDuurTVGtjYmPFzOYr7k8z/MEHDIWxfh/8cuy4cB9eaIsfFNQ3i3ecrRQc2pNm5zNO0k3aPGMSNLc9GCzPltg9dFRzU7g/qspskEq2WbRCKFynklzuniapLFW8qfCn4vqXP31YcQakVz3chQzdqugu9zTt3EyOy82seUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/qLLD6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/qLLD6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B047C4CEF1;
	Thu, 30 Oct 2025 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761863431;
	bh=GqxWEyGMLfFJEWz//ZTdzklGgEnVgbHREuFAglOEN/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M/qLLD6aHnjp1psUNbD22qZ5mMkAWP501C9pfPuIgw/TVI9so33ZoEIOPcBoyXnw5
	 9zXMGEDuy/GKh4QHiJJlqilYoEeWg+cWJrrlHRl47tJTvid+/mZmH8SznybxSc/i/s
	 N2OdEg1g9cOj13zJ7MY9Iv87zL0uO3QWHG3JFK8hi0/1RQlKEB0eYQ0AzSHgaYMRx/
	 ftoPOUe6TSYWKdn85CLJpeTw2OvXWDv7esikkiFKaDK6QEzelM1HpbPF86Wb+6O8R7
	 UM1MSkMZp6OxbmsoYlpHgrWkdnDEE3hoJfUFo5gGRvZ1BRnoTnLRfiSfG61UjGPGe2
	 fx2tli7D/wWzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340703A78A6E;
	Thu, 30 Oct 2025 22:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] bthost: Fix crash on bthost_past_set_info
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176186340774.4061108.6067209446487123402.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 22:30:07 +0000
References: <20251030170126.251566-1-luiz.dentz@gmail.com>
In-Reply-To: <20251030170126.251566-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Oct 2025 13:01:25 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following crash:
> 
> Invalid read of size 1
>    at 0x401DEFE: send_command (bthost.c:1101)
>    by 0x4021F01: bthost_past_set_info (bthost.c:3758)
>    by 0x4006038: test_listen_past (iso-tester.c:3246)
>    by 0x494984A: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
>    by 0x4943862: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
>    by 0x494C7A7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
>    by 0x494CA4E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.4)
>    by 0x402CC4D: mainloop_run (mainloop-glib.c:65)
>    by 0x402D224: mainloop_run_with_signal (mainloop-notify.c:196)
>    by 0x402C445: tester_run (tester.c:1084)
>    by 0x4005609: main (iso-tester.c:4335)
>  Address 0x40 is not stack'd, malloc'd or (recently) free'd
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] bthost: Fix crash on bthost_past_set_info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=229d411e5a71
  - [BlueZ,v1,2/2] btdev: Fix crash on BIG cleanup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bb82243a6c27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


