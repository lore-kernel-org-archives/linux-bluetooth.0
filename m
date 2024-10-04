Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9122067
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073228; cv=none; b=GG7IMFamCxGPRWP3seioqRABPcPNh5sNuMaOucvewV3vIqP/9G6tk3w2pIl5K+6ITBHGvn2PhwWQw7jK+gaIeQMwjPZjj5mh7u70tRcyIJiRxPj7oIAUfmMhnuHb8p4nmRs2Y7q/rEQr/oZLh3h88J8Z7klWqu28qjbMq+45NGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073228; c=relaxed/simple;
	bh=xYGUt7vdw/gbMU14Cld2RqplFAjb3DVmLefdkje7bjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lmosogh/Qp6vS/PcqpsObgtS0Nu6Y3jbfm+zWyf27LoCkDN7lDFtp2T6ie4pewS66J46X5H7BFpJh/xd7SGncGVWF6TJYIZbWLMgXezbXQDw0mSrM1d/Xux+oxZXu5fORCnJ5MPHirgpqn9mmIhv5u9x1diGw/6RNETqAICoxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClpXrU0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClpXrU0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F22C4CEC6;
	Fri,  4 Oct 2024 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728073228;
	bh=xYGUt7vdw/gbMU14Cld2RqplFAjb3DVmLefdkje7bjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ClpXrU0Jn3xFDZoUGuME8G/352WZTH89rdGDdfLo/mkfu4MjPLdJi4SZxSPd7C9FC
	 JXeWJ7G+l1ejsn3pTdAD6nJ50u73PzgyYvYcHajLi2KjQFfLejIRvC/hUdpKyz/rAq
	 /vZDepGvDq6F+x09BbwY9wsqHKNEw/ZUtJcnFdzp87bRwoOzDGDC+6KoJPRRO30wGs
	 vKnM0tkMYYimNNYL6qZDjP7TrPgVD69ODv6sRTy+lI9WsJJcmN9BS2VHsehT0oEsSJ
	 cr3hDkALKu99WoRz56ZD3sL1NcA2xGIp8SmPM3WyeATStV4umhUp33RINs+FZjNJCG
	 meT88bqsqmfqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED139F76FF;
	Fri,  4 Oct 2024 20:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] Fix now playing list on playlist change
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172807323150.2729693.15214678031707792071.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 20:20:31 +0000
References: <20241004144043.419832-1-frederic.danis@collabora.com>
In-Reply-To: <20241004144043.419832-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Oct 2024 16:40:40 +0200 you wrote:
> Some devices reuse the item ids for the Now Playing list on playlist
> change, e.g. using the Samsung Music on Samsung S23. These changes
> allows to clear the list and prevent to keep the previous tracks
> information.
> This also extend the ListItems method to get the Artist, Album,
> Track number, Duration and Cover art handle.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] audio/player: Fix media_player_set_metadata item destination
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=098b94ed6262
  - [BlueZ,2/3] audio/player: Clear playlist on Now Playing Changed AVRCP event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=671f370a8e34
  - [BlueZ,3/3] audio/avrcp: Extend ListItems to get more metadata
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=31e5b8f20679

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


