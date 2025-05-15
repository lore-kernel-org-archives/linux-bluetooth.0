Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B4253F17;
	Thu, 15 May 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328994; cv=none; b=Z2ejEP4FVYWg38+rg679CsD6stpJwCS6f1sJ1IBLrSY2arox2X7JOggB+Rjj4otAN15NfvKyrQ47WnNBXpXwePfXROWqgEXDxsBb04ZWu6a2VIVjvnqPGi+xdhe/+Bf18WsUuCAzEHUvV4EI5mGaqu1NWCcQG2SqC154Pu6gPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328994; c=relaxed/simple;
	bh=vigcnckwJAxU7xBLD9wpWuNrdCa6qlHweBDjwqaDrGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LdFHQMOZVA4QmoUJ7gKr3/x2wBsIH4rF1w4UJV3nXM5NfgCAhnDBCHDSA+LdpXJEjzRBQyWnE+WKHO8gdgyZDeFmRxtJch8JHBh2aijPeWM/xYLw/JS40E/u3ODWusPhgZNHb00CIAjUOcmhoVB21zenjdk/KDuMaegVJg0sGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj7snRIl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj7snRIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65350C4CEE7;
	Thu, 15 May 2025 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747328993;
	bh=vigcnckwJAxU7xBLD9wpWuNrdCa6qlHweBDjwqaDrGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tj7snRIlyhVCMcAGIKYQ7aqTRqTDmICMm9sGE9FuaJILy9n2qJsp1yGyQFmu5qGb/
	 xXYeajq/Oned+JZEKb3sgnmWn1aXxNJF6f8oZ86ki9URAIrToswiD8/xfh4iVhAcV6
	 rMbap9zOVdLY9FMsKmPhMVPYhVj9uPURBvXdgCFQISNaHltyeTcD7nkmL2uOsNSykl
	 sRWWTugLUuUEg5LniZdazq6C42KwxXCPjukWxnJvBCNoOJPKF9XFyNO2QVxTg/N1CL
	 f+DzONjGHv6eaRUBmeXjV2dkK868Kz1U4216abFCrhHUhM25Su3SJ6YHlcCAaEXnyS
	 tOrwyGcMoxUIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC13806659;
	Thu, 15 May 2025 17:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174732903051.3181810.414853071879946435.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 17:10:30 +0000
References: <SY7P300MB0829AE8C53A9A35F9038F97ABF832@SY7P300MB0829.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY7P300MB0829AE8C53A9A35F9038F97ABF832@SY7P300MB0829.AUSP300.PROD.OUTLOOK.COM>
To: =?utf-8?b?6Z2S5Y+2IOilv+WfjiA8c3VubGl3ZWkyMDE1c0BvdXRsb29rLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Apr 2025 23:50:50 +0000 you wrote:
> From dcb763edda3fd9f3fdb6525b07072fdd136d713a Mon Sep 17 00:00:00 2001
> From: Liwei Sun <sunliwei2015s@outlook.com>
> Date: Thu, 1 May 2025 06:18:50 +0800
> Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
> 
> A new variant of MT7922 wireless device has been identified.
> The device introduces itself as MEDIATEK MT7922,
> so treat it as MediaTek device.
> With this patch, btusb driver works as expected:
> [    3.151162] Bluetooth: Core ver 2.22
> [    3.151185] Bluetooth: HCI device and connection manager initialized
> [    3.151189] Bluetooth: HCI socket layer initialized
> [    3.151191] Bluetooth: L2CAP socket layer initialized
> [    3.151194] Bluetooth: SCO socket layer initialized
> [    3.295718] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
> [    4.676634] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    4.676637] Bluetooth: BNEP filters: protocol multicast
> [    4.676640] Bluetooth: BNEP socket layer initialized
> [    5.560453] Bluetooth: hci0: Device setup in 2320660 usecs
> [    5.560457] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [    5.619197] Bluetooth: hci0: AOSP extensions version v1.00
> [    5.619204] Bluetooth: hci0: AOSP quality report is supported
> [    5.619301] Bluetooth: MGMT ver 1.23
> [    6.741247] Bluetooth: RFCOMM TTY layer initialized
> [    6.741258] Bluetooth: RFCOMM socket layer initialized
> [    6.741261] Bluetooth: RFCOMM ver 1.11
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/72d82f47a019

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


