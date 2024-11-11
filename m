Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466B1A254F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341425; cv=none; b=TFlGXrhUG5GShbDBBeaybu5y4QeREA/u4Yez+43K4aOUraMrIfjYIG8WhWk8oaVOynZRAEKszKGmIiv8+3C7v9QQo0IYHCgd3hgGoVsAWSlL5SF1TH1R65dSj1IlAMhYp6Z6r55PGPqgN3ejjUc1AGXMJQsMZFYojWpO0g89MVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341425; c=relaxed/simple;
	bh=qpBRynZUz3qbREk3DVYGI7aoYXWk2WwJl9AJWGObZwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ADsevkS1rOnDwjA2nyJQeTjp40zuPnxk+0fugF1Jw6F3qQeAeahOzKXyWh9Uy61JKxdJigNMl4AkN4Boq49tTfjROLizwILoh9BO3UPnnWqu/8WzXTxBf6VB+Kne2z5Xj45X/b5zR42y2s+/A3YWLv6sF8sPwx8Xerboh6hpCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVp0YTEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVp0YTEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C722C4CED6;
	Mon, 11 Nov 2024 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731341425;
	bh=qpBRynZUz3qbREk3DVYGI7aoYXWk2WwJl9AJWGObZwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VVp0YTEFSfI97p6+DxtMhprt575SrUWAmWhXh54malAp6y8LpLaQnkCW9JLTokr26
	 GCWK7yhj5gTHC8Ng5Oh6bJdQwemrHNQUikI08xbPHpZiTCuz8dZAII9P14vNBxEA51
	 j0bIjPLztoYWS4Y95ELffYmUnVzLdIFwYHM4zCIfkOm6YSAClh1rcoDVstu/AlPfQa
	 URdeFrQtIunxTSArD6Mmc9WFQvzpPIHBWNF+f7RIICJ+7xAfVnS0yZPGkloSwqL+FK
	 IBnQ9k8TE11MudLBzZ3gevoNCNKQwiG1yV0DvbHH2hmexHs5qBM/xsNAx0DopDQm7A
	 EYbyXGFKys2/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716D83809A80;
	Mon, 11 Nov 2024 16:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: ISO: PA/BIG sync fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173134143512.4081786.7823892458368075561.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 16:10:35 +0000
References: <20241111114708.10722-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241111114708.10722-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Nov 2024 13:47:06 +0200 you wrote:
> This adds a fix for the following BUG message, caused by alloc
> inside critical section in create_pa_sync:
> 
> BUG: sleeping function called from invalid context at
> include/linux/sched/mm.h:321
> 
> This also adds a fix for the LE BIG create sync command, which
> is sent dirrectly via hci_send_cmd, instead of being submitted
> to the cmd_sync_work, causing ordering issues with other
> commands.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_conn: Remove alloc from critical section
    https://git.kernel.org/bluetooth/bluetooth-next/c/4b704b1b0afd
  - [v2,2/2] Bluetooth: ISO: Send BIG Create Sync via hci_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/f2da2b5cf76d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


