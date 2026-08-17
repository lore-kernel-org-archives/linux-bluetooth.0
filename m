Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22446AF2C;
	Mon, 17 Aug 2026 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996009; cv=none; b=ghcKMqPttgUh5nmKvPee1WPb0ed9+TWBZVeaIIThbTqEZc0cZ+vA5VfMtxb34aeKDBQLK5nhtn89i2aTRLHAnZn1v2a6uHbVUZvOp4nj81lsr/7rtskRWiDZ+XCqqb00+NPC+HK2jBhzH6IZyOVWcwET2cQUzM3yaHiPJccEtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996009; c=relaxed/simple;
	bh=tOhSkgxsAmFevlLXNsYmbICbmIh/Tj7YFbyDczOeJOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nB3mSuN+v2feF05I7SkSCr+RoIll0loVWWUWUtIJmNDI1VzhFEux/1mnGyZTmQ0LUWJKrpGyuUWFsQ1K1MCVyA3+wiZCkVRl/IO7HyJ2uiY7wWaHZ/O4mWUvgAAMbMcqFQz6vBeqS4/SyimO1KSS20iIFKSoP+56c32SkTjr4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqDReBdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqDReBdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721BB1F000E9;
	Mon, 17 Aug 2026 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996008;
	bh=CKjj70wy++8B4OuPl3qmHY5wJCNNCbgrj5oNpTSYmOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eqDReBdm5AiwgrZIhHP/3S9LFHYP5yyJwIbUnaJmxOnHGF4Vxw16jJ0Uv/IITYH8H
	 /u3ns8Rzmvgn6S7s4A5I0bFMIoih7T/bwiR5tBP3cY413+lPFnq20c9ptfdxx4z+hy
	 e5MxASAokV+sO9SJ8MCocHIIZR6osP4P6Q1y3c1ZVKZAHh8Ila9z4K77neuNeir9Sc
	 z0RA0XlZEo7g3yXifH0YC4cjUnXyWkHIXRg30/PbGz6XiACKK9y/WeMWIm/jh+ZEOZ
	 p5ytKTtolJxFQAv9F6jWzE2AZGOlMSzZ5RK8U8rKr6ZisE8mzoloD3XiJLbE/SZAA5
	 kQLuohZ73qPfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D13926262;
	Mon, 17 Aug 2026 19:46:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: btmtk: fix subsystem reset error
 reporting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178699596038.1691257.10089072145797162594.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:46:00 +0000
References: <20260815115624.8309-1-ismailtarim7@gmail.com>
In-Reply-To: <20260815115624.8309-1-ismailtarim7@gmail.com>
To: Ismail Tarim <ismailtarim7@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, jing.cai@mediatek.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 15 Aug 2026 14:56:22 +0300 you wrote:
> Two bugs in btmtk_usb_subsys_reset() that make it report success to its
> caller when the subsystem reset has actually failed.
> 
> Patch 1 covers the case where the post-reset chip id reads back as zero:
> the function logs "subsys reset fail." and then returns 0.
> 
> Patch 2 restores propagation of the MTK_BT_RST_DONE poll timeout, which
> has been silently overwritten since commit 3dcb122b3064 ("Bluetooth:
> btusb: mediatek: return error for failed reg access") started assigning
> err at the chip id read.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btmtk: Do not report success when subsys reset fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/771e812f94b3
  - [v2,2/2] Bluetooth: btmtk: Do not discard the subsystem reset timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/54c03e6bc718

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


