Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074EB3064B2
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547013; cv=none; b=aMppKN274cWETDH2pHIvzjW4+lLL0hDiPArPLeMtGuEebHBLnFaw2ND/un+BNIPrhvSoj5jJ5jqHZmcYUNfpoxOFAWX4GuWJevneMPzSIyQA/5vm5ajpp0LKVuqt5FTOXcmQwPCntvbFdC88tHz3WDi/YC1CaG4jtRWxj8OHzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547013; c=relaxed/simple;
	bh=SyBzDH2Pe0HsgTjYwWD2W+NC7uB+DonM8p25C1jaS1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nSI+TyUbvXhP8gPGKTg8kBv8gta93Pgfh0tHrERu4ma1Zvk02z9+hMvzT6E/BBWPlIM1OnEXuEjni17Shsf3OK/WYTcKy52bFWdTdx/Xfa6HdwZAE/04aKTfyVOFCYlS0Za0ADjhf//rFcTAswswqDr4pfQERn9YXuyrAwdlGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBug0rsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBug0rsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D221F000E9;
	Mon, 15 Jun 2026 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547011;
	bh=vHFBupYw9MSOmbiWNWLr3UIfqnNc0hADHqZxevGE38s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iBug0rsuvM0DiIQYdjY6bkNmLE0tabqG22Lqv7zbk7nIRxiAqHisYslSP+SgBPCbn
	 3Y2cBPPJBKGjIkVs60lP89ams2f2UNwAYGrhXPl7kXI9Bpjt50+BVmpBZCZPL21rVy
	 WAIgs/3CReBXsQOd5sS3jqmsN2+hfFd7lSbas/MtpUx6lj4xNUqaAUbXscYKdFA+qn
	 OCZH80kJVzNvLpo7yD8CMMnDoJMNQgPSLL/VzwQW14mtn0NpiSh3+eFaEvnfA4jTjv
	 jx/NDLqNybJCwasuoXyxInwe97earXxvJb/a/TnYjYrV7+xrD5xDWogQ81fdxeu4cG
	 A4Wv4plMm2iwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198543839A06;
	Mon, 15 Jun 2026 18:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] Bluetooth: btusb: Add new VID/PID 0x0489/0xe156
 for
 MT7902
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178154700663.231677.10761395159710291118.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 18:10:06 +0000
References: <20260614141258.1011-1-kirill.kz.902@gmail.com>
In-Reply-To: <20260614141258.1011-1-kirill.kz.902@gmail.com>
To: Kirill Shubin <kirill.kz.902@gmail.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 sean.wang@mediatek.com, sean.wang@kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 14 Jun 2026 17:12:58 +0300 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add VID 0489 & PID e156 for MediaTek MT7902 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: btusb: Add new VID/PID 0x0489/0xe156 for MT7902
    https://git.kernel.org/bluetooth/bluetooth-next/c/5d31430fc208

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


