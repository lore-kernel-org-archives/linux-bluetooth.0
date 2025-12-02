Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE359221F0C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685994; cv=none; b=dFvPxYD4Gv6ZOx2qwVEICdyWA4p3/oSd1gMGY5H9MceE97nguGQr3rru9LGwLqWO6xj9yoag2i+Qs1/DMRtBP32T9gEzZae9k9RAS8Se38wo8jIAmlayGiwi07RoMnqOQj0WwAepMotOgio7DVhHNd5z2ETCpwRawayeSxJi25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685994; c=relaxed/simple;
	bh=e2ksrugwqxUnU3IqHX/xROvUbi1OzYABP1u1UR/vl7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gQ3U2XR3KBRu/2GDuaF+yhZJxvQN0Tx13ZPoOZQ3lItRXrpCipnJc/VkdYFDjCeOrlAAHWY7J5UFcZrOBf5kadSUeKRWZrI8ihz7uAWhhucuht8rbwKmPOOueAAsLKJCVceF3x5Hk0gQujT+EG2wj20GZZ5MmLjZL3NIeQr79cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjjliueU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjjliueU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A420C4CEF1;
	Tue,  2 Dec 2025 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764685994;
	bh=e2ksrugwqxUnU3IqHX/xROvUbi1OzYABP1u1UR/vl7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gjjliueUycAZDgM1hC2/YKaTssYv5faNPv4t9PagA/mrFWe2JD/QufQmb+2EuAYz3
	 wLWT96Gi3+VrT50Ffo+nJ8lSv01iwhUJgOeMdUMSWyoALgc7ClwMAjyem3uY3mM/yt
	 FaOEdcjl0zUTqUbFua80yP9YAzyDK0Lg2or+GSi94T3dVCqW/jlWKKcRkKTmJKXZjS
	 X6otAAVFsh+WGwP26+EM/jd4DMaZ3mUhyLU6fcMd3U9YW4FoAzr93ItPQYJ9pHq76q
	 VMT+xT28HiCUtc8tV3lshl1AUT1DxAOpu3yTJbYEXdejg/CJHpk/mKbvFy8NhVNIsK
	 ga4yrLjsLpwZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA0E3A54A16;
	Tue,  2 Dec 2025 14:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] sco-tester: add timeout / close during
 connection
 tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176468581377.3250289.14912307641314192393.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 14:30:13 +0000
References: 
 <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
In-Reply-To: 
 <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 29 Nov 2025 18:40:59 +0200 you wrote:
> Add tests for connect timeout behavior and kernel corner cases:
> 
> eSCO CVSD - Timeout
> eSCO CVSD - Close
> ---
> 
> Notes:
>     Resend.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] sco-tester: add timeout / close during connection tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1d0655882d26
  - [BlueZ,2/4] btdev: implement Sync Conn Accept/Reject flow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2769a919ebd4
  - [BlueZ,3/4] bthost: add bthost_setup_sco() and accept incoming eSCO
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=85888a8357ea
  - [BlueZ,4/4] sco-tester: add socket listen tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a97ad574642

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


