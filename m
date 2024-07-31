Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249E1A76A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445832; cv=none; b=PPA0FpxqyruTts73Zry5E59Gzy+X+1lSzgcgnoxhJspkPbx7NCMIhZYVgi2gXJebD4Jjfh8U+WqvGj7blrfKxKch/fVSaJzGSIr3w+q9NTiEF3xAHP/RCcddj/scEnR/yuzcp5d3BUtc2seqDte2BaxK0yqRH21ICW2fa9ZKW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445832; c=relaxed/simple;
	bh=Rq0nDCPisD1hbnQOJQgp2jXZJJLCcCzf0R0KlfSOnBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t24WAJBoREwt8VEpR9Kt0jFPpK31/hZ+u/lKWC8Or/8UQFMhpbKjmrbp4FzW4zu2ACFoeoqEgE5hhxvQn3+Cxw0pCHv7moDHjlaNMFnPKfZ/cqYWj59jo6D569RE1JL9Jl2l0KUvOZtSPf3pXblNKxVIu8iEc7epLDZW9+Tux+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2XoHh7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2XoHh7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05319C4AF0C;
	Wed, 31 Jul 2024 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722445832;
	bh=Rq0nDCPisD1hbnQOJQgp2jXZJJLCcCzf0R0KlfSOnBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I2XoHh7ZTJKBUHd8gv2Q5NRkiJjB704rHAcid7e5a30HZWRSSmF9i1OY+Y1Xlm3MM
	 8wp/OyvSr6gBjM+maGKG0/+OG0dp6ZZwCI38eWkABsJf6u5vZMKjdW6rvg74mcwFrV
	 P1y3CcmupBdznG5Zmt4/520uQZ8VIfIBLJKKs+dbMtT4nC2xZca85+1YaCRY+WkfJz
	 1X+BZ2f5lidUrjZZHK5YM8A3X7LzQol3kebf0mHsypmDAPVO3BUP3cWCGfwL5Q7kYp
	 92RNO8t/D4k821ERzc7B+AoYEvkoPh6pRbJY/nkl2Wme+8LixJeNgz3QRM3fZ1EIgt
	 OxMq2JVgYuxtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3005C6E396;
	Wed, 31 Jul 2024 17:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/4] client/player: Fix not setting config
 target_latency with edpoint.config
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172244583192.3222.10554985461302298758.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 17:10:31 +0000
References: <20240731135718.429604-1-luiz.dentz@gmail.com>
In-Reply-To: <20240731135718.429604-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 31 Jul 2024 14:57:15 +0100 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes not setting target_latency with endpoint.config command.
> ---
>  client/player.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/4] client/player: Fix not setting config target_latency with edpoint.config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=549d38852f66
  - [BlueZ,v1,2/4] monitor: Fix crash parsing notification
    (no matching commit)
  - [BlueZ,v1,3/4] shared/bap: Fix not setting metadata
    (no matching commit)
  - [BlueZ,v1,4/4] bap: Fix not setting metatada
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


