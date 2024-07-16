Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76519DF60;
	Tue, 16 Jul 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158232; cv=none; b=XGonIonKrA/fbr5k1G02q9rgGSXmMBoM/JFOJab+4iZnl8ghcLYiukhFVGjct1rA5YV3ilpFZLPd7nEg+KQpWl3i2MxQyk34Q0DxzeZlgLAOV5/qFgeiaKiD59gvNu05omFIUxOTOk0uArzQjjBrCIp6DF3D4ear/1x3NxkmKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158232; c=relaxed/simple;
	bh=0mb2nKjeB/LgNGshNrVxcD0GwoYd5a7HHsVx7CM727g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PSYCrHyl+cz4XtouGSXEYXlCj6Xx3zAyBRXrQ4+3W5eBTDmLD1/7LQFFUD5cL1SDZYUNUHuA1tjzxl8XW6GdA9Ex0g7b4zG9PUiaTwY29YV1m7xfJ1voAX5FD4V6kRiulIiL7UHIgvrzlqSq2OBZIZaKy5VZYRhv2AR+rrzNKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5DzsGMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5DzsGMH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57AFCC4AF0E;
	Tue, 16 Jul 2024 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721158232;
	bh=0mb2nKjeB/LgNGshNrVxcD0GwoYd5a7HHsVx7CM727g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C5DzsGMHSVpOz++wsg1gKQdtOFMsbvdQBoIo8u0JIyRzuvqbxVJmxsZT/33W7KE6g
	 35Q7asxyM/1eyOKlEZelNNRfZxXk0IZI+a2Rt57rntNHMuCRbQEWWn21Gb2K3r+yd8
	 WHX9WXHe2IF9AYgBOh+8x8brWQ+NyIXcf5nlMC+sNCf33Ms1xl0AUDB9ufCdYx2kGK
	 vgyQG/QCCbZJBWTi6gwLGFxk60CnweRyO3erjAUrV0ySZkzO2dUf2xxW11r4kg9s++
	 4LbPJuv77xKLdl4M1cWfI76/uDg9qOqEH/b9yQpWb5S/WU6tkCDsXDp+2Wut5q05+s
	 pHSY2x1Awv45Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 426FDC43336;
	Tue, 16 Jul 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btmtk: Fix kernel crash when entering
 btmtk_usb_suspend
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172115823226.13786.2850053898867663349.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jul 2024 19:30:32 +0000
References: <20240716074947.23073-1-chris.lu@mediatek.com>
In-Reply-To: <20240716074947.23073-1-chris.lu@mediatek.com>
To: =?utf-8?b?Q2hyaXMgTHUgKOmZuOeomuazkykgPGNocmlzLmx1QG1lZGlhdGVrLmNvbT4=?=@ci.codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Jul 2024 15:49:47 +0800 you wrote:
> If MediaTek's Bluetooth setup is unsuccessful, a NULL pointer issue
> occur when the system is suspended and the anchored kill function
> is called. To avoid this, add protection to prevent executing the
> anchored kill function if the setup is unsuccessful.
> 
> [    6.922106] Hardware name: Acer Tomato (rev2) board (DT)
> [    6.922114] Workqueue: pm pm_runtime_work
> [    6.922132] pstate: 804000c9
> (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    6.922147] pc : usb_kill_anchored_urbs+0x6c/0x1e0
> [    6.922164] lr : usb_kill_anchored_urbs+0x48/0x1e0
> [    6.922181] sp : ffff800080903b60
> [    6.922187] x29: ffff800080903b60
> x28: ffff2c7b85c32b80 x27: ffff2c7bbb370930
> [    6.922211] x26: 00000000000f4240
> x25: 00000000ffffffff x24: ffffd49ece2dcb48
> [    6.922255] x20: ffffffffffffffd8
> x19: 0000000000000000 x18: 0000000000000006
> [    6.922276] x17: 6531656337386238
> x16: 3632373862333863 x15: ffff800080903480
> [    6.922297] x14: 0000000000000000
> x13: 303278302f303178 x12: ffffd49ecf090e30
> [    6.922318] x11: 0000000000000001
> x10: 0000000000000001 x9 : ffffd49ecd2c5bb4
> [    6.922339] x8 : c0000000ffffdfff
> x7 : ffffd49ecefe0db8 x6 : 00000000000affa8
> [    6.922360] x5 : ffff2c7bbb35dd48
> x4 : 0000000000000000 x3 : 0000000000000000
> [    6.922379] x2 : 0000000000000000
> x1 : 0000000000000003 x0 : ffffffffffffffd8
> [    6.922400] Call trace:
> [    6.922405]  usb_kill_anchored_urbs+0x6c/0x1e0
> [    6.922422]  btmtk_usb_suspend+0x20/0x38
> [btmtk 5f200a97badbdfda4266773fee49acfc8e0224d5]
> [    6.922444]  btusb_suspend+0xd0/0x210
> [btusb 0bfbf19a87ff406c83b87268b87ce1e80e9a829b]
> [    6.922469]  usb_suspend_both+0x90/0x288
> [    6.922487]  usb_runtime_suspend+0x3c/0xa8
> [    6.922507]  __rpm_callback+0x50/0x1f0
> [    6.922523]  rpm_callback+0x70/0x88
> [    6.922538]  rpm_suspend+0xe4/0x5a0
> [    6.922553]  pm_runtime_work+0xd4/0xe0
> [    6.922569]  process_one_work+0x18c/0x440
> [    6.922588]  worker_thread+0x314/0x428
> [    6.922606]  kthread+0x128/0x138
> [    6.922621]  ret_from_fork+0x10/0x20
> [    6.922644] Code: f100a274 54000520 d503201f d100a260 (b8370000)
> [    6.922654] ---[ end trace 0000000000000000 ]---
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btmtk: Fix kernel crash when entering btmtk_usb_suspend
    https://git.kernel.org/bluetooth/bluetooth-next/c/0c9b6e2f7742

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


