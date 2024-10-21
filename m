Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24B1991AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542026; cv=none; b=A9HNnOHl1ZfnbV98VSuq92MGHsyLmKD5MiLBPlvUia++Hp4cqfEWIld12W3h9T1ouRIUWD9klhss95lq/70m4t3c29y6ULpHklplxKPNPCNlIe75hOdDdZrT9Ny+R5/V06XWke1t/jXF+2qnzN8ASzMRztlSY+SSeHVmEEyc9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542026; c=relaxed/simple;
	bh=FV3pzgVPjUBA88YeNriMCkdKhZbX6IerXuZJX+3vEaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=slV/uVW0s73aHcc/d+22Q8QzYeih9w9x6sk/3vPzD8r+t7yFwQJoyQcSUWdfNiFOyMH2LUX3mnOtNs6mpxS8eVKNN0NPLDQe+l0n93j/MpPkmF1Xn4m3CLbaEqJG+lrPYGt4YnR95CHPtyioGr0UMt3GVJuZs4RbQ3rKxFxj8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd3aesNn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd3aesNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E29C4CEC3;
	Mon, 21 Oct 2024 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729542025;
	bh=FV3pzgVPjUBA88YeNriMCkdKhZbX6IerXuZJX+3vEaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fd3aesNntohT0jMEJh45oyEqShmfRAD4BH+dgl+rCQ1U+/4NDqp6DSmroIFa1PprO
	 T/3HUz6046afa96d3bVqpOK18g8b9ZBeuDI/77OBr1/wUYUYdPp+AQEEvxoDjF/g9Q
	 HHySnnXc75NA7p89LBBLbiVkT4wVvFCo0UT9ztTmNOz2b07KJzztS5jYyldf/c6+LY
	 tzEqG4TyVCTJbCMiX3FGSX6a/CWzW4nHGsgoDzo6mMpxyCO5fmHaOmx00s40EoWyqv
	 RgBvWcG/VjOWYtng5ve4T0FbZ08xz2xmplQ4T2mXt2NtKF1D1ZbBioTDquHR1VHMb4
	 0eCpVWBLCtdKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7213809A8A;
	Mon, 21 Oct 2024 20:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc: Add initial HCI(7) documentation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172954203151.432446.2784178945796563209.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 20:20:31 +0000
References: <20241018193730.1177359-1-luiz.dentz@gmail.com>
In-Reply-To: <20241018193730.1177359-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 18 Oct 2024 15:37:30 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds initial documentation for HCI sockets.
> ---
>  Makefile.am |   6 +--
>  doc/hci.rst | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 155 insertions(+), 3 deletions(-)
>  create mode 100644 doc/hci.rst

Here is the summary with links:
  - [BlueZ,v1] doc: Add initial HCI(7) documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8572f2430980

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


