Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6D1E891;
	Mon, 22 Jul 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663204; cv=none; b=FqR6dqxqQhME+36ziVHlX3Jba1SqCURW/xIOWjhkZlHq1hn5RRRJH3YvQVvclsO1NY6hx7+ssSZQPk0JWy5/p2sBQfNfT7HB7xPD3h0tLyb5ic8SpV3AQ2TqOCKxXRJNKXZHtfQn17Dw/jU6nsZGnL3MFvXNQb30I1cbxxvpZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663204; c=relaxed/simple;
	bh=iDcs41/CjcBH8d6NVmbZSwRvJqer6cBZo3rgOF22y3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eYmOQNc/wRsds8ztSB2pU+RvNAFDBPtNmNZjdqsfmyHjz3rRc//rsfFmG9xSRHxvmnQ7BLkpVUPYTTqwgSjQk9uQWrqBm8l6gnoI2wYtQFQwp7i62qpquzUalkg7dWfrDcbr0PaWt1ZzJ9GLDH/3Hm7by/y1PewTNKAStTjJJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzfM4VtT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzfM4VtT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82414C4AF0D;
	Mon, 22 Jul 2024 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721663204;
	bh=iDcs41/CjcBH8d6NVmbZSwRvJqer6cBZo3rgOF22y3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HzfM4VtTQP1KXaIAF5aCVM2q3NtBMR8ryGK3WZ084J7Y77dUtFfK9ZHFwlNtnexpz
	 EJ++0vN3Z1IB1szLOm4wBIj9/kL6YoxMzJzaszU+talm0nNXKElRPc6CIEaSgkrPDf
	 TWkUW1kRyM73AFl/XLzend7b8YOCiTKhystpzXfVed3edGWtYJGVjrwfmLXZMjvO16
	 vGN80TyKQWRvfD1SQKsKQo5NpCKZ08sb1drIexZjhqdwJWBSWzzrvlDaTBl8PuIUna
	 Y89rYEOaAx6sJLWxuAmWs7lFoQQT3N+57j9CDrmeLVNDewWxhajVHYYOoKempy9nOs
	 2vyZkKUMvbqvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71971C43445;
	Mon, 22 Jul 2024 15:46:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btmtk: Fix btmtk.c undefined reference build
 error harder
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172166320446.31131.10977067009294676600.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jul 2024 15:46:44 +0000
References: <20240722092735.1109925-1-arnd@kernel.org>
In-Reply-To: <20240722092735.1109925-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, chris.lu@mediatek.com,
 arnd@arndb.de, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Jul 2024 11:27:05 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The previous fix was incomplete as the link failure still persists
> with CONFIG_USB=m when the sdio or serial wrappers for btmtk.c
> are build-in:
> 
> btmtk.c:(.text+0x468): undefined reference to `usb_alloc_urb'
> btmtk.c:(.text+0x488): undefined reference to `usb_free_urb'
> btmtk.c:(.text+0x500): undefined reference to `usb_anchor_urb'
> btmtk.c:(.text+0x50a): undefined reference to `usb_submit_urb'
> btmtk.c:(.text+0x92c): undefined reference to `usb_control_msg'
> btmtk.c:(.text+0xa92): undefined reference to `usb_unanchor_urb'
> btmtk.c:(.text+0x11e4): undefined reference to `usb_set_interface'
> btmtk.c:(.text+0x120a): undefined reference to `usb_kill_anchored_urbs'
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btmtk: Fix btmtk.c undefined reference build error harder
    https://git.kernel.org/bluetooth/bluetooth-next/c/0f6bd069a04a
  - [2/2] Bluetooth: btmtk: remove #ifdef around declarations
    https://git.kernel.org/bluetooth/bluetooth-next/c/3a493d96e81c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


