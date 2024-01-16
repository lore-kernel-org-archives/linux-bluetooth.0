Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED721BF54
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRUjFL9n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 633FCC433F1;
	Tue, 16 Jan 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705420829;
	bh=knIYSYlZfUBi/NbYz94cKgmeb2O4qWk6aQCvDcBJoe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRUjFL9nmbMwEyXVmhTQ0oUKd6SZJTdB+54ef3nkeOAtwVExbUmV30xbLTa3u8+fM
	 ov6HfgT7fFgRLB/IaLVmjhzvayNtnnHOE2fdYO1GnOVW+OBgcJ+ToeA6Vm5X5SmAIV
	 SvmMMphuiNsNHgGVC+F+hi3ynhecvYj4hq1uPvNyf8qXoASJBSfB0yIC/Gh0zv/MEq
	 973LRdBOIUlvvnelFluaniVJfDZvnfmJ248iIkPykd/a+aIssrER6euzA+svjY9WfD
	 Y1r37bA+Y/rPHSCdrUOkE9OB/q9T72rvp8Dr9Q9Q92VOLbgOeBl/hg0bfE49yksz/m
	 1Vxj4L7TGJVYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AD0AD8C98B;
	Tue, 16 Jan 2024 16:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci_core: Cancel request on command timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170542082930.25552.11676569778160982942.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 16:00:29 +0000
References: <20240111200205.795964-1-luiz.dentz@gmail.com>
In-Reply-To: <20240111200205.795964-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Jan 2024 15:02:05 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If command has timed out call __hci_cmd_sync_cancel to notify the
> hci_req since it will inevitably cause a timeout.
> 
> This also rework the code around __hci_cmd_sync_cancel since it was
> wrongly assuming it needs to cancel timer as well, but sometimes the
> timers have not been started or in fact they already had timed out in
> which case they don't need to be cancel yet again.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_core: Cancel request on command timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/711c35949648

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


