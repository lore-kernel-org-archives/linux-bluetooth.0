Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB91B424D
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678606; cv=none; b=YPLik6Ls9gINGz6UVhuPohsCKKjgm4fCOXvGWCDXQdlsONvT6or59WxFV4/pZxmTMeuPCftL/WZQ2DtTKADo1htpbxufEGV/nvMYTIfB8tZpsWkE1x8LRI/PZ9FZlqH7rAKE4wUKxcoIVNZFwxT7BNa38v7c70BeVS8bgi3oGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678606; c=relaxed/simple;
	bh=mIysDDmj6EtODiWNLlImbn8FkU/nm/tsejzFaZ0SMVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pODwIi0vXv9K+rsICUq6gE5ptr9ZVQURKm5K6SkVmI6qMQBP1clKY+zPV7VLVs7n6bwV7AveaLrqn02cMEy8oFDCW2vNkok6oqCmBDpiC8AZ+xxTSBrc/N+X+F2RJAMCDiukPL3HtLy598NlQLIqtJQMqAiuu4vLYyfKlRRgPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0RM3xuW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0RM3xuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60FCC4CEDD;
	Thu, 27 Feb 2025 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678605;
	bh=mIysDDmj6EtODiWNLlImbn8FkU/nm/tsejzFaZ0SMVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W0RM3xuWl3jPbSrD0BVAQe4wHx3xCKfzrUtiB34h7m8MkyP/LLS3ZpuKHhyoMz8pn
	 mVpwErUjgi6WHcYDTFO8u+3BDhNzZGYaSRD6cD9tjC3nUBconlnCK6ztP0tmY0CLB2
	 vTKy5jTr89nQ2UfefkqTEkkt15oO8XWJzNGpu7Qm0NGCsrT6EomVaeAtWhm5UbEotB
	 JziYHfFDitM406wwYJaQ7KntZHZNNprNIkMcAePlbZqhVjqdRR+SJ2BOep6PepqCjV
	 7SlYsFD5Wlf7uzhy4P7jenCg380mJngu3GTgCufG2U8PtKWJq0fUseW1SHTb0fZDUC
	 Jgq//dg0dukEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F51380AACB;
	Thu, 27 Feb 2025 17:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] bass: Register bis probe/remove callbacks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174067863798.1511239.12598881600496648368.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 17:50:37 +0000
References: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Feb 2025 17:17:53 +0200 you wrote:
> This removes the bass_add_stream and bass_remove_stream APIs and
> implements a method to register bis probe/remove callbacks with
> shared/bap, to avoid making direct plugin calls between BAP and
> BASS.
> 
> Iulia Tanasescu (3):
>   shared/bap: Add support to register bis callbacks
>   bass: Create BASS session with Broadcasters
>   bass: Register bis probe/remove callbacks
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] shared/bap: Add support to register bis callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4b4c9383d58a
  - [BlueZ,v2,2/3] bass: Create BASS session with Broadcasters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f49953d96fab
  - [BlueZ,v2,3/3] bass: Register bis probe/remove callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d68dc1fd03bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


