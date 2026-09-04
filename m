Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DDC3A6B8F
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550286; cv=none; b=nnOZCdmApyGjTYP2jQslhRlEzh/iM9gA6fu20bD2gDY1aEt/d8Hp50+OlA8wgjxGug34QEuKwAwrNzeVXZk9jzJ0TemNAfB8kGyp2/WTxICN+bIDT74hHdmIsuWojiUUsLoR+QHl3uF3SI5bBuKadEiPHSy1wbN/TWp5JwzzSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550286; c=relaxed/simple;
	bh=3tsXJqspEGE1VLBSkx3YVognS2TTwmd+WByDS+eK9k8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=un9Vq2c4OxcErCsruq/x68gzDHEMk8JDl6Oib7Dt7XbiA7DwPnm/L82/4Abafz2ztrvJpdyeFzYqZuTrFVo5zznH4kphW8JefR9V9sIKrbIE1Ky5IvFGfJ8XQvpXetg/66X2eXmtllvb7AcyOUPatKxFRjkdIkXN43XNeYig7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX2VqWJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX2VqWJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10371F00A3D;
	Fri,  4 Sep 2026 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788550282;
	bh=EsiK1KpecVWEKrWhKdYl1gV8GvNZ5SG3AGmkGAKUu0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lX2VqWJa0Sw+fi4TBamZ/A2/EHHVaa9KlvYCStEhdYyIwjXM0QqokGqvusj4jzQj9
	 R2nE8pN7/Y9IGQXVw1yNqOfdfuaUeNueE65G5PIH2Ge4jxFM/G+3DMlNCsjHOrmo/t
	 761+pSZTOZmudFy4TRAqo2L3OyKOOZcLtauHXoNcagJ+NLASAA+4XVlC0p30gLlYal
	 3PgQ/ay0+dD77YF2RJy8dfR4a0TWZVLdPTbWYl2fSXoLZaHKKEORO6xkRNB7sz1EUi
	 uAhcAsn+22m16hVThF10i2a5OS39uNtRSYCKBgjkSSyysCIJPLj88bQ5fGoY3GxGx+
	 qIXIbHtQtXeXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BF33924A6A;
	Fri,  4 Sep 2026 19:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ vRFC 1/4] test-runner: Add support for PCIe
 passthrough
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178855022348.496513.12616689441813971481.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 19:30:23 +0000
References: <20260827165326.350079-1-luiz.dentz@gmail.com>
In-Reply-To: <20260827165326.350079-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Aug 2026 12:53:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add a -P/--pcie option which passes the given QEMU device arguments
> through to QEMU, in the same way -U/--usb does for USB devices, so a
> host controller can be handed to the guest:
> 
>   $ tools/test-runner -P "vfio-pci,host=0000:00:14.3" \
>         -d -k /pathto/bzImage -- /bin/bash
> 
> [...]

Here is the summary with links:
  - [BlueZ,vRFC,1/4] test-runner: Add support for PCIe passthrough
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ef24e77a642
  - [BlueZ,vRFC,2/4] monitor: Add latency standard deviation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24a46bbd3b78
  - [BlueZ,vRFC,3/4] monitor: Add ISO packet loss counters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7bcf6c42721e
  - [BlueZ,vRFC,4/4] doc/btmon: Document the deviation and loss counters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4b92dddc8e54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


