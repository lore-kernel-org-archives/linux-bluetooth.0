Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B147B42F
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851583; cv=none; b=sq1i0P7+cNsT3dTNYIpZJYBogNPTr636zXPT7KvtbVLz2Z1OzNJM4OurfVABLf2VZef+JGP/EIK3aafB4haaIjCn6PVq8Mo4yjSIiC8LLn59+0/HyRHJIc9KIf37eEl26EjlUzIkMqPMcrSpp7WK6bvK22HVRt8hcwqd1GoTzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851583; c=relaxed/simple;
	bh=Y1TFzFeacYgo7rPtmQwMKfSGp4m81LShVm9HMBJR+Zo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sta9D7jRtnwmZGY+RCjz2jcqfNtC7o0rNT6K8CwZsbE/jMO7Em9nThOsYELVS19j/V6zOwFvi6D2n28zBqLG3efpdLoypsGga8Ni7KneSdiY0aSt9xRlRjI0xyAG1DSNlqo8uxZ3jz7bM64hQrQZpqGJprHtwipTa6/6hQ6KJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM3sB9GU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM3sB9GU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0431F000E9;
	Tue, 30 Jun 2026 20:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851581;
	bh=elGdH174mfH4CXtVTpaceAytMNNJ9kRBAFDUGWemeGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mM3sB9GUrf0XT38/xRR18UO6TrUH2OF3PHxO6Nh1nDjm6/pKFACJuKF+HW6AKiHXm
	 iFaK4WffeO327wWD714qLEW5nMqvJCie1sYUNGdLCOFBpctmiVKztTD2qQhwNERFEQ
	 /tmEbjSyRttOxxQRo6nuZ4JPcC8ybWghG/Y9c1aPYcVUusxmw7+PwsIZWdrLpwCNrj
	 ezoTrnWtKC1GZVSJ73dFs1FzBNanb4MrEbHwqfiksthv80kOvKMZ9laJVY09HT9Ii+
	 2PCNm8xv/V1Zyr7QWW6Yl2o2LsdLAugneIG1LGXAPUPJLUlW7Il9/Tkl57bb35cJzs
	 nc9kVN8Jl9/IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B4393A951;
	Tue, 30 Jun 2026 20:32:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/5] bass: Fix possible crash on
 bass_update_bis_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178285156563.267316.16319028944884888824.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:45 +0000
References: <20260629142649.966025-1-luiz.dentz@gmail.com>
In-Reply-To: <20260629142649.966025-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Jun 2026 10:26:45 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> bass_update_bis_sync does use bass_remove_bis which may end up
> removing the current entry causing a crash on entry->next, to avoid
> that prefetch the next entry.
> ---
>  profiles/audio/bass.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/5] bass: Fix possible crash on bass_update_bis_sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=27a4c48b0481
  - [BlueZ,v3,2/5] shared/bap: Check if stream is valid before attempting to release
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2262e3715649
  - [BlueZ,v3,3/5] shared/bap: Don't transition to IDLE inside bap_bcast_set_state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c0fec57e9fa2
  - [BlueZ,v3,4/5] shared/bap: Use queue_foreach to notify state changes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a9b6c8a2ea62
  - [BlueZ,v3,5/5] shared/bap: Protect bap_stream_notify_connecting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a2c7bc03b759

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


