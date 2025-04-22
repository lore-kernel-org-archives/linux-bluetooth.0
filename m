Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B97DA6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313037; cv=none; b=SoFBXlN9CD/lWAQNXu45Eh1JUl2CrgFL43OVXCvnAbKG9qHWm3vpMctTrh5JTkCHXAR78oiXcT+RChogK0bwvDuP6+8zzK8htzCiiaQlEs20M4YtY55gKw6i4JkpdNOI0ae89arL8DR04YZMgv5Zf5Zt/ZLd4vSgvsTDZ61y85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313037; c=relaxed/simple;
	bh=bC7Swj6eQlLiBWMK0IyGjX5XcY15mbmmxyqRJWNj3Hs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QgOoXxmyj72vaNTWOPYSTmKTSbxWA7/3Q4XF1gTA45em1q7kn1W1XBJ6uAzW8CbOeQOMZI0p/W9I03usyBHp0sb7FeUK0rR8IfWJG+NDCfZR3DcnJ1FsW823o/6gXqXWqUAtywQ0oiFIaOAMkpFbiW9MJh9jxmouQaBygQepIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6jXfQlx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6jXfQlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC6C4CEE9;
	Tue, 22 Apr 2025 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313037;
	bh=bC7Swj6eQlLiBWMK0IyGjX5XcY15mbmmxyqRJWNj3Hs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H6jXfQlxLiRqJKiGRSUWahDDCn17e0LZ5KyNimP6HeVlWq9D+06bFIEXC0jHpRleG
	 GIJNcdQKpe4R4Bf9V3SHwVQG1dM7Ih+Lqz75dsaedQvJsu4hyJwwWFiZqCgvKPKfjs
	 9YXlrcf3NdEuTglt49dyBzRTIAF6oR5LXJJVskbTU24D8ucHnjirxqo8KNHMKKRGWz
	 twDQ1rcRs+aWz/3OrEGH8eW4665vAClhnL/sZyjeI671kIl4f40KOZTjCWrF0LLxuJ
	 BPCAgbP6gLK4WW+gvmm/cyKr4bYBlcsthpwr4Kyf+NYLJp4Ihoy+WAioE6ah2t3CVD
	 CZwd0tdEOIwJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06839D6546;
	Tue, 22 Apr 2025 09:11:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: fix crash when removing PAC
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174531307548.1477965.13329027277685740052.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:11:15 +0000
References: <86080a21f6604cb916b89aba57a43afe57475a59.1745252940.git.pav@iki.fi>
In-Reply-To: <86080a21f6604cb916b89aba57a43afe57475a59.1745252940.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Apr 2025 19:30:54 +0300 you wrote:
> When PAC is removed, streams need to go through RELEASING flow, which in
> some cases is not immediate. Access to stream->lpac is UAF during this
> time, e.g. in profiles/audio/bap.c:bap_find_setup_by_stream
> 
> Allow stream->lpac == NULL. This should occur only if stream is
> RELEASING.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: fix crash when removing PAC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=578a6fd688b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


