Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70140DFC4;
	Fri, 20 Mar 2026 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964821; cv=none; b=BjVeS4xOfZpIbjvue7sa/ytrh2w4zcwkDHqDge0X1hfSI3JqR5fLcXM6hx8xaPfyT2sbRQ0pZ0we9MSnQTw9ja+0D520cmn7zmgSsHJ+XoVxB3HsR//4EY5sapSCVBOw9mSMpZiX1dD8+viAQMRpgOAHLJ2K05Q1O+6VyRRc3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964821; c=relaxed/simple;
	bh=y43+89dhojU8Z4rZW53PdmFFps6rbE9l/UibMCSgQe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lYF8bLXSiA8yX2rhqfxNCuTuXzUWzIs+kd5tbDz7vF326kQ9oFXruzRnKFnCWb5sfasF8W6O/Y0U3c6YkMZsG8Yf+dx3nBdUbXPjS69/jxvvTOsRWV1OjCVa0SVD9qNfQOTeDlYmyyloiOlm2csCWhQMzW19JtKhkfsvA1y3JJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGrDS8to; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGrDS8to"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA69C2BCB0;
	Fri, 20 Mar 2026 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773964820;
	bh=y43+89dhojU8Z4rZW53PdmFFps6rbE9l/UibMCSgQe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GGrDS8to/20fA5PRQKsyjB9/9GGxCyqEVp4PmX0pn1j/4pWzURjnYYjdULACjHyEn
	 CSyn3nSEsXfKNFzpYLVCHLF9NA135EOJG9tzvW1zCyGvcFo+KUJ38GG8mW34lXh10z
	 mhvD5o7YTWOWrD98BypagjRrGQLGOT2Cf7GNlwKYUjyiVItXkzkYgC3iL/btL+v9ew
	 ABo3WYo5hykumwUTj81F5LuXZ3y0cSCWqwWUAYZG6/bmJMDVrZMhwTnN6ejMsHUPbT
	 8rC5/u+tKBHom3bbbbW107Q2Cje0sjAvgW6KzIq8TyjK9aNMNeCRCCsWE+Bnx3g6Ff
	 /NDd3eH/U/0pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA23739302FD;
	Fri, 20 Mar 2026 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-03-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:00:11 +0000
References: <20260319190455.135302-1-luiz.dentz@gmail.com>
In-Reply-To: <20260319190455.135302-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 15:04:55 -0400 you wrote:
> The following changes since commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229:
> 
>   MPTCP: fix lock class name family in pm_nl_create_listen_socket (2026-03-19 09:37:48 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-19
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-03-19
    https://git.kernel.org/netdev/net/c/57ce3b2e9cda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


