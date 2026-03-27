Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560437D125
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639222; cv=none; b=YK+ZBFt2ksa6FR5IfxQfpckGpZ4LYFmJ9KS2h4/A9y+BxdGLiHLkrPWI4zbpIM3nmE0L//5Tul1aI1GKlNAcFiaMS/GHmfTujufKba3zp9l9PiP0Chofr17yipHaFtGARNJ03e5UsnLSWwoem1+F9jNu3nitqNAfP3wicmeuLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639222; c=relaxed/simple;
	bh=il5BZ8WvaHw9XzZzL67SikJ31wYhL+ticmpVNDLBznE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OgJDrqm08LJgVRESn33LB369jMjTtLEGMnOBPBFoleX0nXY8kx2PEtRbsAm6045mzAXc+HqQS7drPKvEc4Fxn5kii9SU8wjvovQHTusEM1KXrRwkXUUkPvU/2n+fQdvS1z9J+1ctSXooGvZxZc6JOP8+0WOSSg8SYeEFgx2iBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URxQoHTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URxQoHTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E2FC2BC9E;
	Fri, 27 Mar 2026 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774639221;
	bh=il5BZ8WvaHw9XzZzL67SikJ31wYhL+ticmpVNDLBznE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=URxQoHTImFVrfZyNM+EbDe/iEUVn5MxF3EZowVrpbeLaQB9Xf0aW5QXEO5SXaSOQj
	 5zfkwHnuJ0IBMlrR/wQiAbOdq+csxwbHzNtIKVJqHBVWBga9Hcmcr1WEZoOKXK8Sk9
	 gTDaJ4A60XAzUxV/MFkH6LlhCiXnSL6xl7dVYspRBjG3P6qKr4kRTL9lOjPzU1N3R6
	 Mw6/RQxKecI0+dyDu+KCYpdGeiwI1RIcLQRQ/fJ88wRb3SQv1C55qGrpDnh5cKSN7X
	 hVna7Wj7CIZmBaE/+/ibEjL3+n/rffb1xD0kDuppC6iDC/ZaKY1UpKV+bUsVfi0eE5
	 7taIBJZLzub1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BD83806922;
	Fri, 27 Mar 2026 19:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix UAF in
 le_read_features_complete
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177463920753.3624781.17925792380339399238.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 19:20:07 +0000
References: <20260326205046.890020-1-luiz.dentz@gmail.com>
In-Reply-To: <20260326205046.890020-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Mar 2026 16:50:46 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following backtrace caused by hci_conn being freed
> before le_read_features_complete but after
> hci_le_read_remote_features_sync so hci_conn_del -> hci_cmd_sync_dequeue
> is not able to prevent it:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: Fix UAF in le_read_features_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/60562bebb651

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


