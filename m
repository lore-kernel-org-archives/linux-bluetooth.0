Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE143B3FE
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701629; cv=none; b=U71pIdHhD2tb4awF2tNRYHdR7CVvYV9mZ6ukSsyOCl+wIZ+sAjjQfxyy2xcor4k8OAhp8JO16ogD5ne0PbkuC9V7SnkKsBwI7trPfcuDqQBdXElitv6s9EQDxOIe8kpfB0eL8tvKbIKeowlt6sYz+5Xt9rO9j5zLeGT4X8FBlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701629; c=relaxed/simple;
	bh=vShdWstB01GrJIa2e5SQHD/7iK9QEjsDzFMfaLfLy3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WF038PkJK2T4ZGROJJeisEOvthsA1AlHl38RkVulSVUEZbESamDZ3jVy2kJ14VbZuU4/4/59iyUNv+lZAvU2NPpKJIacIpsrLAehNm0vjIKG0JPSnU9UJ/FdATMSWMT8taOVdsgqHOvUXhO005pKoIiMsNqponQPmHiSjVyOUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVTsF+jd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVTsF+jd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216DE1F00A3E;
	Fri, 10 Jul 2026 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783701627;
	bh=17yvXn8vG4bDfBrcdTozVRUAg9kbviDgfM87nArRGmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FVTsF+jdc7NEgxabiegZvM47sXlgNknthvAZcZ4T1U983OaiBBgUbhsKL5enBg1On
	 FMOYOaXn5X7fuf3l98ua9XQw6tT/rS4u1bQZcZJB8TqAJHzQpXQqEpqsIxWDwF2uvQ
	 aJKCR1wT9Y3Td5vwlCuEayhZ0xr73Se1bpYGs1cnalZkVhanBYD8g9+ncY7iRVfGKa
	 RhyVNyeROOd84GWJPdBy1trNW5O5RRrJvGggGKLsfNLSa2zr/x+TSJopaUa9rQw3Cd
	 km5rbYD/2eo3g0ONAEQt/pYBhiNaOHWwGTohBofvp+WZ/yb/nnOnO/d91uRjaOIROk
	 R4bpbUhd3tnfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197803924FA5;
	Fri, 10 Jul 2026 16:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] a2dp: Fix loading of remote SEP from cache
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178370160465.762415.8304209421100482316.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 16:40:04 +0000
References: <20260710072817.270328-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260710072817.270328-1-mikhail.v.gavrilov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jul 2026 12:28:17 +0500 you wrote:
> Commit 912f5efb0dd9 ("a2dp: Fix handling of codec capability storage")
> added an 'i >= 2' condition to the loop that parses the stored codec
> capabilities. Since i starts at 0 the loop body never runs, i stays 0,
> and the subsequent 'if (i != size)' check discards every endpoint found
> in the cache:
> 
>   load_remote_sep() Unable to load LastUsed: rseid 6 not found
> 
> [...]

Here is the summary with links:
  - [BlueZ] a2dp: Fix loading of remote SEP from cache
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b7d71e506785

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


