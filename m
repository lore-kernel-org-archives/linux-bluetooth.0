Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9771B423B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038822; cv=none; b=lrjhNnXJQnxNUaGYkLgL8l3+fGuyNBs3XhECB0oKiasCGs4CIKjICyG5Mk/op1thtEPMXQgz/DAywsbNu22gmDTl+s6WsXVc7hXFDXo5RoykoTvJKo9RVmsiR6g3cBS27WwpcqUBkJ7H7cv95yf3EeFAH0bp8RDBBh6ykvnpwX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038822; c=relaxed/simple;
	bh=P6jKw1Yw3LvQjlnIBJLVm0Q3mGqcEL+tIR9AE0Khyuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=igSmgbhkFunvxBTk+2Heeyty6d2IY/NHf38bAtSGpKVvHU1o1FZ95tV/eVQhI6MuKXp1wee8FUsGA0xQGRd67e0+U88sNTJDy/ywg0FCupwN0KdGwiMcWB+BuKx3qxZoNMU2IYj8WE012d4opJ+V9Nig3Y0Iy/QNxW5mUSjtuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej7Gp9CA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej7Gp9CA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DEDC4CEE7;
	Thu,  9 Oct 2025 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038821;
	bh=P6jKw1Yw3LvQjlnIBJLVm0Q3mGqcEL+tIR9AE0Khyuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ej7Gp9CAmJMZmnwkgpFWoFZZbeShXC0yi6kK7Lj2WvkvvTfRtff+7ufIdIfn/Bt4r
	 sbZwF0v0LwVx8YA5350w/YV7ce3C/ftBDkMEyzIAfsrNqus8SE2tpeYFSssXss3ecj
	 8XcNqwtY9ocbs2qjDHoilNCrNgKsCEXCMRJQHMqwzM1DhCNASuaNTPrK6mTVLI2mG/
	 UsjAqVonSpOj7b5I7f/1HFxUSZHN4FLc325TrDuxozIWvxQV5oCK0VlN7T/Yq75Xxf
	 webWD3NydTfq/A2J4ZMMIL9dDBaUa/lF0pqak/QT9NKw0crc36aYWYzztuT4+iUYPE
	 XQttqR6KnVjnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD983A55FA1;
	Thu,  9 Oct 2025 19:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] gobex: Fix abort for SRM operation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176003880948.253496.12188013630292036172.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 19:40:09 +0000
References: <20251009071159.359476-1-frederic.danis@collabora.com>
In-Reply-To: <20251009071159.359476-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Oct 2025 09:11:59 +0200 you wrote:
> The OBEX Abort operation currently triggers an OBEX session
> which prevents further OBEX operations:
> 
> obexd[327475]: obexd/client/transfer.c:obc_transfer_register()
>                0x50e000001380 registered
>                /org/bluez/obex/client/session0/transfer0
> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>                ref=3
> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>                ref=4
> obexd[327475]: obexd/client/session.c:session_process_transfer()
>                Transfer(0x50e000001380) started
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=3
> obexd[327475]: Transfer(0x50e000001380) Error: Transfer cancelled by user
> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>                ref=4
> obexd[327475]: obexd/client/transfer.c:obc_transfer_unregister()
>                0x50e000001380 unregistered
>                /org/bluez/obex/client/session0/transfer0
> obexd[327475]: obexd/client/transfer.c:obc_transfer_free() 0x50e000001380
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=3
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=2
> obexd[327475]: Unknown header offset for opcode 0x10
> obexd[327475]: obexd/client/session.c:obc_session_shutdown()
>                0x50c0000010c0
> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>                ref=3
> obexd[327475]: obexd/client/pbap.c:pbap_remove()
>                /org/bluez/obex/client/session0
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=2
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=1
> obexd[327475]: obexd/client/session.c:session_unregistered()
>                Session(0x50c0000010c0) unregistered
>                /org/bluez/obex/client/session0
> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>                ref=0
> 
> [...]

Here is the summary with links:
  - [BlueZ] gobex: Fix abort for SRM operation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=273bf9cec70d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


