Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3843845CD
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445433; cv=none; b=pusfKgb/ajqzVWIHGP5x7d3f9ykb+zaECEtjJJsqfXMmebPukOwsYdN/U391d1D2ZR9qXPSh5DlB+ot6EWQjPFUh0JuBIs0vccnyOxFYG3L1ErUn37QomntiX7N5xR9NhdgdJE+GYU4enKLaieoo+Df3SZuyMTQ97Le6JgxtK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445433; c=relaxed/simple;
	bh=uwdwJznzAlCoN9uj53gbdo7udarndAxAl0cmrSQlEc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H9fR0HI48aH0tcBaMVF0+rxEMccmboD75qdLrszw77a9eq52xVCI3VFRuq767OlOk3jFU2ZWSYDk9nmSba9KaL2kB1nGpq/T2fwRadKD2+js7kkI7ereWLh5gWrhlLuO84P/5PCxPMCK/Quf5Hf/nC3gtTKRnwsuj+WZzfENur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJoqB2wG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJoqB2wG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2CB1F000E9;
	Tue,  7 Jul 2026 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783445432;
	bh=uSxpKyB5uj4y8SIrclCFWILc70c+1WroHN+/WMxQank=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fJoqB2wGeOxSW0gX8NjgRNfqGgS57ut/qGNIVIRT9LJTfg1wKOQ8CpDfplBv87tX/
	 lEfaUTTu5hqBXEoP0zE/wNFCmr99AFqsrGCbbSvdvVypoUeCCWwrWAEOThWEbr28Qj
	 p2YEBkv31+GOKD+3fdFUrEvl4KzKhXLgA0Kx6oSzRvTIP5BaaOBOjnUq1nMqW4fGb5
	 A0Dg/0707QIRT1TgUbnmtuJw4QqtBw0PUVTfBie9zB2YwiK9Hypc3ZsxckITWulNuA
	 Wam+ncjGGgnktNV1FPtjRMUmYIRySc3sJybtcMYCPcX6CySLBN3BKyg623TcVBSLbT
	 AIf7iMeVBVPvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569D839253FD;
	Tue,  7 Jul 2026 17:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued
 update
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178344541188.2101608.13776117493322216001.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 17:30:11 +0000
References: <20260707041518.2799385-1-zzzccc427@gmail.com>
In-Reply-To: <20260707041518.2799385-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Jul 2026 12:15:18 +0800 you wrote:
> MGMT_OP_LOAD_CONN_PARAM queues conn_update_sync() when a single parameter
> update changes an existing LE central connection. The queued work currently
> stores a borrowed hci_conn_params entry from hdev->le_conn_params. A later
> LOAD_CONN_PARAM request can clear disabled parameters and free that entry
> before hci_cmd_sync_work() runs the queued callback.
> 
> Do not keep the borrowed hci_conn_params pointer in queued work. Queue the
> hci_conn instead and hold a reference until the queued callback completes.
> When the work runs, revalidate that the connection is still present, look
> up the current hci_conn_params entry, and cancel the update if userspace
> removed that entry while the work was pending.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued update
    https://git.kernel.org/bluetooth/bluetooth-next/c/3fbd73d24dcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


