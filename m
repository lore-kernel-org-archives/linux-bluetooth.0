Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19D215F42
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187607; cv=none; b=WQppZrvOTEmVZriH84hRtRIYS/txtW/Ek7SSXmybV7ywLT8uPlQDebWmjqAfl4ieurNdapB8+57kvKAwGmloR1YMS6ALKijV3Pv6KCjyG9t1x5P2DizWywMvSJT01tR+sy3VMwnHTrTIBat5ZH8wDhtgRFtd0djE+YTMbgJy+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187607; c=relaxed/simple;
	bh=6QPoJZpok8FptwIgevojBKpQn0Mrw4waM4t+2pPqv88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QmSaaVUJ/dfOETtBt/RLbsG+nOr5MwRnMLe+ZQA96KSKlyITgTkar62RX7NhyFa1fjy0bwLsVGIcwXxJnzNeIdGhB5S2iFUxu5CjOgwkCa7pkN8Rd3DbNG4nDsWgkGprJDOUHCkbXVi4MJJJ//mhZX9ptW+4yFIqsM6KG0V+j/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/Up5ej4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/Up5ej4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC700C4CEE3;
	Tue, 17 Jun 2025 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750187606;
	bh=6QPoJZpok8FptwIgevojBKpQn0Mrw4waM4t+2pPqv88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/Up5ej4B1LRdD2j5lxE/wHiJnomJmfPmj2blGssMh9nY/G0fGzkuMrH5VZ5f90ar
	 WsZMfh2UD2c5fqNQcWhm0G9cnP1hCmOcF514OdHJmWiHaDKekQGXn66kCWNEWdnif7
	 nhW0xLHxG1lX8X7i3LqhYtJDBNW2Nvjk4z9nSOPCVUqDus9p9GjOC0QeJtc1XuhLI7
	 Qs0YYXJK7qhZ93DbCwoZzAiU/s9HC1xHzi3kQo4W2t1ThJ85nHRLn0Q6lvyNN6J9CE
	 Khlk+nmGJG8DTY8UStTKrt0oMJiEE48f6EL1zKTJbfZtd2rkijan+bsabSYPIGwEkB
	 0OY4nPQyMmVlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1A39EFFE0;
	Tue, 17 Jun 2025 19:13:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci_core: Fix use-after-free in
 vhci_flush()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175018763550.3264326.12579880624167447930.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 19:13:55 +0000
References: <20250617165819.1755687-1-kuni1840@gmail.com>
In-Reply-To: <20250617165819.1755687-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 david@readahead.eu, pmenzel@molgen.mpg.de, pav@iki.fi, kuniyu@google.com,
 linux-bluetooth@vger.kernel.org,
 syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Jun 2025 09:58:13 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> syzbot reported use-after-free in vhci_flush() without repro. [0]
> 
> From the splat, a thread close()d a vhci file descriptor while
> its device was being used by iotcl() on another thread.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
    https://git.kernel.org/bluetooth/bluetooth-next/c/dc3f099e8d70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


