Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82541313281
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704214; cv=none; b=ix7tm/lEhFfmSLEGspdGCjJQAtBCmNfFMWw99msLOgoPWtFGJeLViADU/h0VCcUS9PHBYsyfQgOJh/dJb3WgcwIigHTTbMuIY17cE8JE0p3EcZUHn4yuxaooyu7/RTvUWi04si9CZnKSduoZTkTstq6dVS9suD5Ql4XQCr09AII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704214; c=relaxed/simple;
	bh=PyLoIzLW4Ad4anrybOSOMK5z7TxwHKuDudmOoCBc8s8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6ENOip3oZPhPKfBA4ooNIn0i2x4P7P07wbxsGmFpCLfogM9cKcCEY2ZIXqFhFdKkVAdG3FBO3ovqibAPpCUu4WVtkCgM9JdYfbaxPSQxlBmv4Zr7bqpbYm9cfzhnyU/EFbuwiEwDlIxzM7H/eJ0fxXHEnegf64HIs1yez8ZtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4DDKUTg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4DDKUTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B07C4CEF7;
	Thu, 29 Jan 2026 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704214;
	bh=PyLoIzLW4Ad4anrybOSOMK5z7TxwHKuDudmOoCBc8s8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e4DDKUTgLN3tNYViSXdv/vpVpFbxtGOgi1cMojRcauww9F6sTx1ENN7/EdDZeH2fg
	 igVODIl35PNch8/i1MuzaqV0EYq+CI5QkVtGpMcqPv1M0O4FtW//yvWL/iUTxsmpMx
	 De+lVZjPwZcrobHqEjF3tAVNi8jGD2Sw3kXU4mjRw1c9EymnR6dkNpYsleenlY00xy
	 Ns6i1jj9aODqYak1tsV1z4PJp1ERQ9vzgDmlVq8QLozlBhaDgbpf4lvmnf171it0sf
	 ha6NZb0XMV9O81a0SbzgDgnBJOMppXcZwtZE2cOMARnEK4WHs/bqofxFwjDUO6C4iT
	 BIXcrha/JUwYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BA57380CECB;
	Thu, 29 Jan 2026 16:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] build: Don't install btmgmt man page as tool
 isn't
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176970420714.2563498.9614714813428421557.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 16:30:07 +0000
References: <20260129125948.2724071-1-hadess@hadess.net>
In-Reply-To: <20260129125948.2724071-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Jan 2026 13:57:01 +0100 you wrote:
> As discussed in "[PATCH BlueZ v6 10/20] tools: Install btmgmt along with
> other tools".
> 
> I have a similar patch for meson, not sure whether you would prefer it
> integrated in the existing meson patchset (which would require more
> rebase work) or as a fix afterwards.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] build: Don't install btmgmt man page as tool isn't
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a2d140d70b1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


