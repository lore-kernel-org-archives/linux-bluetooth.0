Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8F238D52
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134835; cv=none; b=c/YYoA2JTPWsrBBGkP6/BFhLzBn3XYONXeYWu+of4mN3LLoviDITfRNBNlnBvJb+mNHa6gxZKF6ij6ulX3N/BdymG2odaarUUIM40JmkHRX9P3at14Z8z/d17fqruyZ8SY3UUVlacW7s07tkumrI/aALe+mnmxDLUXd1HGogl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134835; c=relaxed/simple;
	bh=OtD6ObpPP7ScT02GnqW6W+W6uo4DP1mC6t4FVqUkgec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kt+VAK752k+A3FrqLaJy6cjwDJd/HCRRlkLNKTdq+79mKST31GNbmw51xu/glixC92nBvlgNIzjIvHU6NulzNxPJK6yPeXDJ29GMRAFcJLGiLeWr3dk2h3oIzHwfDEEbcE3M359hqCGrskPIyuUpkiK07g4M3LlEDxaoqF4IgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWPHgtMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWPHgtMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8C71F000E9;
	Wed, 15 Jul 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784134834;
	bh=3mDVUdMGUmSUOFOQ7pliG83LN9FpaVkFEGp+uf403zo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GWPHgtMU2YTi3AI9md0PqncE6b7hxejiwj0yV/J+SP8undkbkbNLlAAuuoul5HW80
	 7JlQFXPDWCT1Yh+xifgla4L7VTdut2MNb14gw/9oC1dt/J9Shw23Xt1sz1qvxR3EsS
	 Jd9qlkuprcsFn+tScHb6o2NE6nhS7BRx0ceEkfK0izjcu6COCb1fbbIOjyjxmdOVdE
	 W9RG7MqwSJNJ0ICU2oD9sVkU12rcEGl+KQh5F50/l9x9KIZJI23E7Jmh6tWb86V5U5
	 d/kVRv4Or+457MmKdOZyjkSc+17Xg4L9vWJJuOGHqfmDtazAXLPUvXkS3RzfY9skYb
	 AvUmI3T7jGv7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56D59393AF94;
	Wed, 15 Jul 2026 17:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6 0/3] doc: Add Channel Sounding API
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178413480788.415350.8572342439923022256.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 17:00:07 +0000
References: <20260715083958.2723407-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260715083958.2723407-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Jul 2026 14:09:55 +0530 you wrote:
> Improve Channel Sounding documentation by adding cross-references
> between the D-Bus APIs and bluetoothctl commands, along with practical
> usage examples.
> 
> The D-Bus API documents gain :Used by: references to the bluetoothctl
> cs submenu and examples for methods and signals, while the
> bluetoothctl documentation is updated with :Uses: references,
> argument descriptions, and usage examples.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v6,1/3] doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0abe23f58f1
  - [BlueZ,v6,2/3] doc/bluetoothctl-cs: Add :Uses: fields and document arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=30db66dc971b
  - [BlueZ,v6,3/3] client: Add scripts to start cs Initiator/reflector
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


