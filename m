Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383E47A0A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576441; cv=none; b=iaRK/LNISsoCyXbIwoG0Ybd+LkeZs9gKpyA6SXzfhU4JZhia0Fyf7sROAIuzRNo4xSvnvvr4Wekh6h41bTj2RtiYxkwIcOAG/5hp9ZyuHOUgj0nvCFWOUAEQ5JaF8qsk3NW9EC/cauhoE6awNQF4UT1nvUdEiPHHNHtiuazR08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576441; c=relaxed/simple;
	bh=EgUpWlKh3tHa1bD6thShWCD+RW6VmsFZb0TxOimcECs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HXvOhcIeBqcEa+ZEGyGDUkorfRGRu/3mZXlrqmXbAtGlJnbZ1fqBnb8hvLqVE147/5uYttiaNnA5kj/ptKcKTlVRXjPiF+L/UThfaPJhak+9OVjAa9VSqVz+lPgXOP7pkG/XCjhxg99g48rsWbojUoNRxaO4MpnqZaHFx/+wNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj7Y99Kl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj7Y99Kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71531F000E9;
	Mon, 20 Jul 2026 19:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784576439;
	bh=09Wh+rugfYdG5lXi03ppByzFzGZY8dGNM1nMfJCD7iA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mj7Y99KlVtCFYB+/z8ic173HcQQuu0fmjmcPKI1VGAvAACcJvG7812EaX65qcCshH
	 HCt/tgsTEVMAXLbQNuKRPgif0EuP3/pm2RRciPqGrQGWdft+OGmcAhAGy7zzIHMV+L
	 Qf+5KHWCiJ4a3dFeReIo/EQEslWo+PuBrB5cZWCrdVDJsaPqow1I48uWq+dl5SYNk5
	 q1lgGS5CBQ3JJJVSQfFVysV9n4Iu26uDR81RfD7Ikvu97jPDzQJLMffwCjENlPyGCL
	 +lOrAgUjExK7M6p2SGyeKxO9lBciUfiOuM5ztomg9W3bMVMsujAr8gM2HWAAFWu85r
	 jSAdL60lDGJ/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5682B39244CA;
	Mon, 20 Jul 2026 19:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] test-runner: use virtio for the default kernel
 console
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178457640988.4136385.10063865970416660513.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 19:40:09 +0000
References: 
 <e71384747c71a2fa0db585acdb727f324161d1b8.1784554811.git.pav@iki.fi>
In-Reply-To: 
 <e71384747c71a2fa0db585acdb727f324161d1b8.1784554811.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Jul 2026 17:09:01 +0300 you wrote:
> Serial as console is slow when commands produce large amounts of output,
> e.g. for the -d debug option of the testers.
> 
> Use virtio console=hvc0 as the console, requiring
> CONFIG_VIRTIO_CONSOLE=y which is already in tester config.
> 
> For capturing the early boot messages, retain the qemu serial, kernel
> will switch to hvc0 during boot when the HVC driver initializes.
> 
> [...]

Here is the summary with links:
  - [BlueZ] test-runner: use virtio for the default kernel console
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=004e1b5d245e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


