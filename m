Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD103B27ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134837; cv=none; b=nMMFg7ptkqeyBr8zecN4HxgnlbCwCSw9yVUs9cVwGmYFC5HVu8OGsHGJGOPDFXCNtWdIP9KBwiWi95sew9A1I/JNqE+TUUnFbVVvTr4EJ13ISry9frruVnhqgD+zrAB8sTSHhtQUv9VchdnjZOYXDzrxSBLQO0GmcxPjQ/iVU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134837; c=relaxed/simple;
	bh=WK7YvFSNxkxS0BC93EEOid2yKWC1xSljXzFQ0gcmaCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iUxlIE0wuv8zqrZoUnC3Rvbb4xeC5O2tuhs575CunCyH8qRJDkTmcNulv6W0TZHs+agQ6r9EvLu9ZABroDeKeoOk7I+cgr2aTtIlceHFZQE12Aq9lFxldVultm3MUNovn3ryRM3dK3fi9NPfHwmMRIUNtCYBvbZDGFtC7iKtoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv+oghr9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv+oghr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C108D1F000E9;
	Wed, 15 Jul 2026 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784134835;
	bh=dShKuZbgm+XbBoU7PCPpse3QTDcWMf/8SivcI/R4nYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yv+oghr95Ds1yEhm4L8t8KAdUNOrwK4UwIJW2OUEgFtIS5CJnIUuvRD1Kb467Sxho
	 KuQZlo5i33BTarb9kuljK2or3mJgaPYlrRMtpYYagT4UtXKIAz+s5z06kkfwjan/BU
	 pv52ibeb+lWrGZ5oghPIdsYFdaeLEtNiFI/big2RRJ56P2P4StDIAHVKwQiZASQNHl
	 Rz/W6+cQOPgQn6ij744Ar3NeAZORbJcgpUdfpl1p6yZ/IQNDhaAT8y7X802rluBh9R
	 g6eTS6oK+HcGJMYPimiuXTu+IUbJ1FXAacBwO/pCNFmCozF4q1PSgHcNDM7PfSEq3b
	 amS4hI0Vy42lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B8B393AF94;
	Wed, 15 Jul 2026 17:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/7] plugins/admin: make AdminPolicy state
 per-adapter
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178413480939.415350.6266083914082860341.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 17:00:09 +0000
References: <20260702083641.378994-1-frederic.danis@collabora.com>
In-Reply-To: <20260702083641.378994-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Jul 2026 10:36:35 +0200 you wrote:
> Fix AdminPolicy D-Bus updates being emitted on the wrong adapter path
> by removing the single global policy context and moving to per-adapter
> policy objects.
> 
> Changes include:
> - track policy contexts in a policy queue keyed by adapter pointer
> - keep per-adapter device lists inside each policy context
> - emit ServiceAllowList changes using the callback's adapter context
> - scope device affected updates to the current adapter only
> - clean up probe/remove lifecycle so adapters are registered and torn
>   down independently
> - remove remaining global policy_data/devices coupling
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/7] plugins/admin: make AdminPolicy state per-adapter
    (no matching commit)
  - [BlueZ,2/7] client/bluetoothctl: make admin.allow controller-aware
    (no matching commit)
  - [BlueZ,3/7] doc: document admin.allow optional controller argument
    (no matching commit)
  - [BlueZ,4/7] src/adapter: enforce allowlist for local services
    (no matching commit)
  - [BlueZ,5/7] plugins/admin: reapply allowlist on policy updates
    (no matching commit)
  - [BlueZ,6/7] doc: describe admin allowlist runtime enforcement
    (no matching commit)
  - [BlueZ,7/7] profiles/audio: fix UAF on external media service teardown
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7482aceece70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


