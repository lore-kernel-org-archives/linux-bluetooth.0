Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250C125DF
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107394; cv=none; b=OFb8QYRVQtiZegfb3mfsAqUhsg8spwFVLw6w7GC7iedBfrFI/Cg2Dkz7LW7LLhri6AOrYJlI5tnWejJveYgP5l0Gwq4zrqDxNu289ZYCqjenHPy9eKsTKcgLSa7Ca5XeysJLpZPjx5yFhk5DohHSL4c0LaIrpPBN45C4KtrRqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107394; c=relaxed/simple;
	bh=VuCxj/EXsIAwyf8b+9Z0XdXlK4eFiGUviWx/nRkSq/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvPz4NGPUqGY9cxw1zPMTP/io1YIw80FO1Rd6EvjSwJzcL5mST0ctf64HzLYMxsdOvr9lbf4P3/NWJJkdgRFy1OF2J4pSwWpkswdTauhESw5UdMMjYXxG3KnKrHJuN8+cweGzRjS08GIQ0wRRiw6RqYEtgDSeI1M7yCnxsFm+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGFmCVDm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGFmCVDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FD9C4CEF0;
	Thu,  1 May 2025 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746107394;
	bh=VuCxj/EXsIAwyf8b+9Z0XdXlK4eFiGUviWx/nRkSq/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fGFmCVDmi8F+qJxISDRtgyoTjlCDpUbPQ57ZhLBqxoUVfNd0cFTDd3GFUYv5odpfM
	 LXv/WctQZh3OOn5S3DpJOY/CkyzLSwWZT2JM4VsoUSYChrg8ZY5EqtYpoNF/Fb1yKB
	 Eng+sEZj104FGwUkZRJ9kmQb+q56aiOn0SAzclzN4b/AQZ+eMi6h3pEWMqAYP8PFQR
	 2NlCLwNiGiaOEcSRD7jqF2PmmYWrCFiw4roKDmpmKlr+yXZR8Rc9/8rQe8qWHEpOuv
	 rxUj5EEtQM5BDdmJQLjrUhXogA2j3Oq3RD8K0jGsc1+hQfbecK80HewvSLafq8lX7U
	 VpABUmcy8ly6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D233822D59;
	Thu,  1 May 2025 13:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6 0/3] obexd: unregister profiles when the user is
 inactive
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174610743298.2986402.2691498734604978766.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 13:50:32 +0000
References: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, pav@iki.fi

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Apr 2025 14:13:59 +0100 you wrote:
> This is a follow-up to "obexd: only run one instance at once".
> Instead of refusing to run parallel services, it unregisters
> profiles when the user is inactive.  This avoids the need
> for tmpfiles, and avoids issues where the user with the
> obex service logs out, leaving obex disabled altogether.
> 
> Luiz previously suggested moving this to systemd, but I haven't had much
> luck getting the systemd devs to accept changes, and Pauli's mention of
> elogind (i.e. logind without systemd) suggests it's probably better
> to avoid the dependency anyway.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v6,1/3] obexd: Unregister profiles when the user is inactive
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=765356e80262
  - [BlueZ,v6,2/3] obexd: Support sd_login_monitor_get_timeout()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8b29b5a46cdc
  - [BlueZ,v6,3/3] Revert "obexd: only run one instance at once"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8d0dc114036

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


