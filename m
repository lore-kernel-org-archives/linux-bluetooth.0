Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D24F96D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841816; cv=none; b=WBdks8rGlt87qPJsk2dGqIMVrdeQ4B/XMKX6bwMqSRiJp5xxR5rHMj2lZlZux/UQXyjYOD1+67o68t0FK+9hS0HmErlVeVMKeNe44wX6fw5t5dmHnZATdtkjgqooMdlj/V8PqPHvYwOBUcaFlXnhFq7rcBTg5mZQMkAwvVhDkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841816; c=relaxed/simple;
	bh=Z8W/5RhF11JpWgi8enPyzCdU+1814Xe1GxiQ/xXzEfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gCuxiEdpfkcvfXGX/pF4k2h8+f2X9Amv6l9pO3WP/TGXQ7WSmPiDIEoj0VB3xJN4/SxuKp2XnN/aRhsNBW8+xb3ZryqkARb4DPM5KeSrr9oWyEseV8DDodWl5yxtCWrmDbx7tHaA5nKJOzwYcPNUOz8bi+QAHOnT2ebNKC1EJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFXUOX/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFXUOX/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC15B1F008A4;
	Mon, 12 Oct 2026 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791841809;
	bh=O53hnfkcsnokcQT/r3p21A8yMaTxef/ttfz3QfmnkyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SFXUOX/t21iWlyGYpd0/IYRx/FUW3WcXPuawjDoCcCVnyGDa+8ovaiR7APdvUhTiX
	 vH6o2IEoXHeF3PkpmVSGeplgFm6iHD/xXKDx4QScUYhdIUByIixaavJPinKY8dj9B8
	 egeFR8CmNSnwmtPyWYbzNOFhzf/V6DfyNU2wrHnJW8VXLPtaoZE8O433S1qA7SaAcA
	 +N4JLM4eBjqXssJe72t+nhc6ft1rNet/hXVJvqTL17VlZ6J0eez1bBTetUEJBiNtSt
	 9bklIdD/+cS2cQbVoxOpVCvGmToHNQHWGZbSx7f2gopdcvhRD4Vwt5aq76TuFUlcei
	 R9dn+VR8LXSVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B434439253C8;
	Mon, 12 Oct 2026 21:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] mgmt-tester: Add simultaneous discovery stop
 tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179184180826.4115061.4265843541074534796.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 21:50:08 +0000
References: <20261010031852.2842893-1-yaroslav.voytovych@gmail.com>
In-Reply-To: <20261010031852.2842893-1-yaroslav.voytovych@gmail.com>
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 10 Oct 2026 05:18:48 +0200 you wrote:
> These tests cover the kernel bug fixed by 96d006ae6445 ("Bluetooth:
> hci_event: fix simultaneous discovery stuck in FINDING"): with
> HCI_QUIRK_SIMULTANEOUS_DISCOVERY, an Inquiry Complete that arrives
> between LE Set Scan Enable (disable) and its Command Complete leaves
> discovery stuck, and Start Discovery is answered Busy. The fix is in
> 7.2-rc1, 7.1.5 and 6.18.40, and backports for 6.12.y, 6.6.y and 6.1.y
> are on the stable list; on kernels without it the Late case fails.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] emulator: Add btdev_send_event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3344d20d904
  - [BlueZ,2/3] emulator/vhci: Add vhci_set_quirk_simultaneous_discovery
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2942883d2738
  - [BlueZ,3/3] mgmt-tester: Add simultaneous discovery stop tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=49a70562f0bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


