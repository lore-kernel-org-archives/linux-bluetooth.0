Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B839446B
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472618; cv=none; b=WoxHMSk/JANwOfXmkTLfvMjgkiPonRi26G4Gd6wxwXRB9uepG4s+fEo3VIHJVdbM/Vh9OMn8b+ISwZobb9mjqJMG2Pnel1ji7s43p6BXNyCA1ZyymITmDgx10R0AgfHXRtrpJ9BzTgF/UoLyPwqmFUN0rd1eKeGVQZ3OWKs6Enw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472618; c=relaxed/simple;
	bh=hV6oFcQaW7Pf+a+VSKTd2EZmaA8bB5Bp2nymQpZgajU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mz8N0FrE4DHW0z4tT9wxOlpxKzdFFVOukgHPg3jU5jLEEcFS7zbivYly8deUXsDtVKA6Y7L6Qi3kVLF8/ai7SlngiyNFZh+8IccZQ4DMT6U9NufLOnXwBltNK7J+ZzvuzqfmBuFwAgqkqd8A8WprWd6kdMmWniDFRRWc8yaARbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJN6MFvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJN6MFvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA621F00A3A;
	Fri, 26 Jun 2026 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472617;
	bh=88qClw6aQ/aNjsDUNeEGDPNVeu/M0PmE3NalLEiCzLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PJN6MFvscDpD40hfJwacAhEmk0PPT6gE/CXdCTr6R3XhEDlf7MzeDhvTP1s2x8O7B
	 Ifx5sezBvGW1MSdbjgdbfC/+6KuEVflzxOVwoBz07u43U4ChAFOYQWASeR4+Xb7hi9
	 4bPiATTs7AA5ANf3G+apV+fllvaAHHSPWXoxNbl7gOK5Beqn8+2w6E2pvvTpnpBGGp
	 koO0TGxJvub9TAclEcFRYSKGz0hCYxryO8XUrJZIby7kf4AcyJnoH/gYBh2MuN9w6B
	 9v+AoQlosT6qfvswYf9sRz8iTw8Lx5qjcyLEmYiAPYrZbpvqFiP2z22H2vGyh7xIja
	 tUWRX52sj4pYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699B39389EE;
	Fri, 26 Jun 2026 11:16:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: 6lowpan: avoid untracked enable work
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178247260405.3816447.9539369733535711581.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 11:16:44 +0000
References: <20260623161229.2174546-1-zzzccc427@gmail.com>
In-Reply-To: <20260623161229.2174546-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Jun 2026 00:12:29 +0800 you wrote:
> lowpan_enable_set() allocates a temporary work item and schedules
> do_enable_set() on system_wq, then returns to debugfs. The debugfs active
> operation has ended at that point, but the worker still executes module
> text and manipulates enable_6lowpan and listen_chan.
> 
> bt_6lowpan_exit() removes the debugfs files and immediately closes and
> puts listen_chan. It has no pointer to the queued work item, so it cannot
> cancel or flush it before tearing down the state that the worker uses.
> 
> [...]

Here is the summary with links:
  - Bluetooth: 6lowpan: avoid untracked enable work
    https://git.kernel.org/bluetooth/bluetooth-next/c/a8fb0c8ec7d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


