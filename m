Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60E30E820
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356582; cv=none; b=V2Hp1EPgWkEkochi9XnqH0HQSw+q1Mi4rwjwEZeKJvGOpIK1ZJhyd8sof1M1Hul/WA+dmTJ3XuMgbRtB8MM5tB9m2LW4ldRz3kxos0gj6Ezikwlrv7eEO+52abRc94l4rdz142Fkng//gjeYKNdm57aM79UBmxBkdHckwTkrLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356582; c=relaxed/simple;
	bh=N56ILKpLWWs86v7Bs1kbbj7q0nEt9TfhoSbVwuivi7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kNpErpJ5Wz1UlszuQ+FXTyNePEK+siRo/+V3tYnN3yp79tQ3Rl2vnnpuXX/AODlmbbZMU3bbwMQ35m5V5N4lWNwv8H/lp+xLwMxNj2gR+nbqHRUOe0IsddxQ21qeg0Eo29ec9rRxPQVcTJucl9hFxeU1AynoblN2TQJSxPKuWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQs1BMFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQs1BMFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1914C4CEEA;
	Thu, 19 Jun 2025 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750356581;
	bh=N56ILKpLWWs86v7Bs1kbbj7q0nEt9TfhoSbVwuivi7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KQs1BMFGp/RiWqxeFtLGJmyPaeZnpGE2aLzbevP/7TUGNkWP+hdrOC409/5czCvTH
	 Sp90ZqY3UPLFYTiSWP6dKh8CLZ/2ru3+0zWBZR2CrTYuGMIqTTIMTTePrbduxJaN6u
	 dDJchrG/n6GuxtAarEH6NQ6Vr6ohHBx1S24YQyukyLpfwd0nkriIB+GmH7aFNgeDZM
	 BfL1NHMkljwXWKNae3bB7+eNqsJQ4y/PWL7NMRZ/QAsNTO8kYLJuBLtXvNZ0TLJZuS
	 6xP+KZ3VNeHvuecGQWfibZiHlM8lVWOCrxgAlZGgz8m/JHLX7b7awQcj9JuszEmmm4
	 GdKjcmLHPoA7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC4538111DD;
	Thu, 19 Jun 2025 18:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] test-runner: Add -U/--usb option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175035660988.946806.1144010891149214177.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 18:10:09 +0000
References: <20250618191125.3123951-1-luiz.dentz@gmail.com>
In-Reply-To: <20250618191125.3123951-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Jun 2025 15:11:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds option to use a host controller plugged over USB:
> 
> > tools/test-runner -U "usb-host,vendorid=0x8087,productid=0x0036"... -- /bin/bash
> > dmesg
> [    1.046214] usb 1-1: new full-speed USB device number 2 using xhci_hcd
> [    1.192623] Bluetooth: hci0: Firmware timestamp 2025.18 buildtype 2 build 82364
> [    1.192638] Bluetooth: hci0: Firmware SHA1: 0xa66e016b
> [    1.197362] Bluetooth: hci0: Fseq status: Success (0x00)
> [    1.197368] Bluetooth: hci0: Fseq executed: 00.00.04.196
> [    1.197371] Bluetooth: hci0: Fseq BT Top: 00.00.04.197
> > lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 002: ID 8087:0036 Intel Corp. BE200 Bluetooth
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] test-runner: Add -U/--usb option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b8bbd5236ee0
  - [BlueZ,v1,2/3] test-runner.rst: Add documentation for USB-passthrough
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f67234aa71b
  - [BlueZ,v1,3/3] tester.config: Add config options for USB-passthrough and drivers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ab13c24eab87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


