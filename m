Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B93139566
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441990; cv=none; b=E7t03pcvBFoq270hCTRtx9B9+nymbyjKEY3CrMJWY3NFlTK0HRMSCMGI60ZR/GQq6Ot2Wa/dbHlPJJ05hzfbDY2JGuyoDrGqFDYjzu/q8OZ8WkEeRxNZUrHT1oXzy1vZAkce2E73A8USq0dC3SkIkIJL8Yj3bAleIGczqO92BXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441990; c=relaxed/simple;
	bh=SyOc863ktPKIpIgigRA8q/2oM9CB2Xn4jMVgFhFAnbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bw+wgnkQ6rQKd27z8Ja5ckIaIxim16dsqJ7zgjme2cC4oTlf4WVEQAwzCJmgXwhjX8/k6ozZ0L/SjMZOhqr1lCYvLJM0JmURv5132TJ/rdWmzMBAxxA/Usr/NQaC6SA2ZTU5UH16j3r6SqEvrwhuVWDfnVoZ1+JeoKaga0QTavA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAOZ4DiE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAOZ4DiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCB8C4CEE2;
	Wed, 23 Apr 2025 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745441989;
	bh=SyOc863ktPKIpIgigRA8q/2oM9CB2Xn4jMVgFhFAnbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YAOZ4DiE6Yi2V4hCCRNhZc894pQvNqsFb6QwpZHgylT8AFKQRQ98Aq6cbviKoRMuh
	 4LkABhOayw4VfTDvedoBUEBILvYgY8LPgwRNXadXuhHSGSYkfZsaqtaBNQ/H0BBg7x
	 IpCBuEGQxdpJPVVOkojxljDbac10vYyy3m0G7C6qWeah+N1GGSJwNUL+RSvC93N+Dm
	 5LnwAEsPhKe6Cdpv3P2PK46ZPwyQ5IDN0d2gCTUubGEbbl9+SXzVuYj42Z+hIsowhh
	 G8WEgkE7tSojTqqSdx+Op8Q7f5YYWV1gcFRSp9YeXKgB4twI0EhaV9/cz7kvzBxOvt
	 3KRc6tEkg+tnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C77380CED9;
	Wed, 23 Apr 2025 21:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] Fixes for re-connection issues with ASHA profile
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174544202825.2766467.9984202176484065289.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 21:00:28 +0000
References: <20250423150742.319463-1-arun@asymptotic.io>
In-Reply-To: <20250423150742.319463-1-arun@asymptotic.io>
To: Arun Raghavan <arun@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org, sanchayan@asymptotic.io

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Apr 2025 11:07:39 -0400 you wrote:
> This set of two patches fixes re-connection issues for the ASHA profile.
> 
> v2:
>   * Incorporate feedback from review -- reset state in
>     `bt_asha_reset()`, and use "attach" instead of "probe"
>   * Add a minor renaming patch for readability
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] profiles/audio: asha: Reset state on disconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=918432b2c68d
  - [BlueZ,v2,2/3] profiles/audio: asha: Only expose device after we have attributes
    (no matching commit)
  - [BlueZ,v2,3/3] shared: asha: Use a more descriptive name for the state callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=629672307f6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


