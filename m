Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06E3B8D4D
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965590; cv=none; b=T+iDzm2/FJIb847+DhirGt79W4/sL+LTrKWNz+pjnjFuFteWTkXUKpGmVsyXERAFIOvBdZgzBpkW+yKiqbyUORqnaqZ+6+0Slqo7Gkoh68UNYpGf8Lyb3kR/mDKbRGUxWbPHilAxKcAX4KKVHHTZ78qj4z9zhb2KhFqu10cwvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965590; c=relaxed/simple;
	bh=spj9cYnuzzviG9jdhPUdhswbaZxzK3BpLPRsQ/xv8qk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WL409AiyNj1F5HKBODVO/MXGpd+uLFQt4nQgFGVfaEFJODUoIgdm4pq1vHmE1M6aAXLkDoI0udhqZDz0axr7zhRl7jmgK4KYe91dSi4F4UU/e8SqlVIAXYm+/pXVzF+fATMigJX1iIf5SI+QTPBRlKKuUYwErHJ+/kQIO5FC5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5r85bEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5r85bEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76795C4CEF1;
	Fri,  5 Dec 2025 20:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764965588;
	bh=spj9cYnuzzviG9jdhPUdhswbaZxzK3BpLPRsQ/xv8qk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N5r85bEfLRQsq3JUNv3l87a5g6dxM9XruML8NUNaHmC0/XKssgD4GLcsk+qQMZuwx
	 2mxL7T1XN1HOyUlzcCAecCpuXzaUbcz4987Gv8IqVGfgH+oj8UiGuFX1LFVa/Yo1mj
	 YrgWFabi1YQK2sUlXes3QL6fjYCn4aanQ1KcoPEz2tAsHZY36BG6VhWFNiO08VSi6C
	 AcSt5MqZyjCoPfP68JxdWEfkHocdnX5YVit5ZEv/2SOGDjDed34bzEjEGLsTzYnlXN
	 gyah7wiObbGNmU8+Schs9sJwHdebTupu9JHVCOO/xdySMYI5T9hhxKayjMtStiZkmj
	 nvGXSLGRXYqZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8893AAA0D7;
	Fri,  5 Dec 2025 20:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] bass: Fix attaching to unicast session
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176496540604.1804616.14898835056527491340.git-patchwork-notify@kernel.org>
Date: Fri, 05 Dec 2025 20:10:06 +0000
References: <20251204183115.2533504-1-luiz.dentz@gmail.com>
In-Reply-To: <20251204183115.2533504-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Dec 2025 13:31:14 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempst to check if bt_bap session is attached to an ATT channel
> then it shall be considered an unicast session not a broadcast session.
> ---
>  profiles/audio/bass.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/2] bass: Fix attaching to unicast session
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=90a2447a39fc
  - [BlueZ,v1,2/2] shared/bap: Fix parsing of BT_ASCS_METADATA for multiple ASE IDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=753262031701

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


