Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2F2066F7
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008384; cv=none; b=CEsT+zI9VjS0k39i670V6f4uPlV781gjXFcBOHRM/714f8pWPolISCbubRgr/Opd23NuzbPB85mVbGv6llD9BjMU1ABz981uq7fUuM1U0vY/7erx0F+EJiCa0nL9Xh/H2XH9jgJaHcZSf0flOLodcJh0AgnG3M+cpXb5JvCXO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008384; c=relaxed/simple;
	bh=KWBOilop9VI+sTAxI+5MUyqByod0vrerkMZS1SI31IE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VwnSnH2AMD3NgCE+Pofh8b2kE2WpTvCgZRTeSDZj1IS+KFAxtIamGeIzuLmV3eVWgTRRMgmowYmBbkED59BCeL2UJXUFVF3aa+hzpc9Y4/vWWX7NuS7TM/DfILaUUlmzDMevq/bV+zuByH19lYOC5LJltU59a4rlR6ZFnAcsJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXgD6dvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXgD6dvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A86C4CEED;
	Tue,  8 Jul 2025 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752008383;
	bh=KWBOilop9VI+sTAxI+5MUyqByod0vrerkMZS1SI31IE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AXgD6dvlCG1jwFfKea3lUsORa9EjeGI8JZu60CqmfWYl8SO3KMX69xQmkt5GsHHk3
	 PZmy3Q5/Hat2ckXLRqExu5U03fxWGimcA/eWgC+SbImPWPKdbB0yGqtbc5TNo+mPF5
	 8ngTH9a5CHvtzQVYY5lto3dGu95nS6ApOTr4prxl/1oVdosuMUqIhoDo5lMZFAv69s
	 b1+atJEdC+qYhcXQzX4Y0uTlmQ3wSULjbErHPFHuwclxnghLEYYH5p0YVqIJOUUHjv
	 PAt+jvXfkZNr/6wHOt9hGn9uTxZxkPvDYAHZOManrbLKsFM8FeZHRBAb9KAbKMXv3q
	 p09SxULn/buIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8250D380DBEE;
	Tue,  8 Jul 2025 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175200840627.14772.9685536220181964734.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 21:00:06 +0000
References: <20250707192832.3162227-1-kuniyu@google.com>
In-Reply-To: <20250707192832.3162227-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 kuni1840@gmail.com, linux-bluetooth@vger.kernel.org,
 syzbot+e4d73b165c3892852d22@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Jul 2025 19:28:29 +0000 you wrote:
> syzbot reported null-ptr-deref in l2cap_sock_resume_cb(). [0]
> 
> l2cap_sock_resume_cb() has a similar problem that was fixed by commit
> 1bff51ea59a9 ("Bluetooth: fix use-after-free error in lock_sock_nested()").
> 
> Since both l2cap_sock_kill() and l2cap_sock_resume_cb() are executed
> under l2cap_sock_resume_cb(), we can avoid the issue simply by checking
> if chan->data is NULL.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()
    https://git.kernel.org/bluetooth/bluetooth-next/c/3092dfdfc57c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


