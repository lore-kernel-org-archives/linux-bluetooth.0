Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D296330D24
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140356; cv=none; b=kiuwR0KW6l5PJXuW5kPDl/FiAZ3YUvlCF0aMR738edBfq+tQSw9564a3All5Rheh5wVGjbo/tGqmaFKD/DQKQ1aaG4wN8VprJRsyB7mVDFSSzq/3g0wzOJBSXE5iITuAWmN9WsWLX7IEW0G7yClE9UU5Vc5VZAn/EBdf4+qZSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140356; c=relaxed/simple;
	bh=DFjdthS1WfCd8tQe3dOi06QV7VlZIU330MRYRHHgCnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQwgBij7r9MKH+V+Ijkg9hGbekexyhQ5rtkeudSu3fSfbUPs8fCqvTkwdMRVt9zh9hJJXa4FxlLBnS4nU10SuqPPz1O6L1OGvAW4NA3Dl6CHPT5GkqZuqQn4oByJNLT2wr+51MdzhFf2iy33qFq05kz/f8+iVlb6LAbIUlbGxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6QfkSoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6QfkSoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A30C4CEF1;
	Fri, 14 Nov 2025 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140355;
	bh=DFjdthS1WfCd8tQe3dOi06QV7VlZIU330MRYRHHgCnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p6QfkSoqJ4WTABV+xhp64n26urx0YO5NGssu/7wpGlleGN5giFfbWBcaPmYaZkVeF
	 os+e8QIsLwAypbMo5iCGa9+FnqHPvmpPgbJaDKJIwgXDdf2lTqG7ZbxevVMUWTCk8R
	 3+CX1SzCHNUH0jNnOArX3WRRSL2RQXG7epe40j2dG3Y6aTootVCUVo0RQotCu7o+e8
	 epyfTev98tGjNLjOBiaIEUtSaKPnwlp0qt5qVWBgh+maNSWNeJ4CU7Rg1okEv5fgNa
	 efawB8niuqQwZb2TkpGQCn+VtdQdxGDsO2ExRhKwggMZ/MmD89F4T23RUSUdimzNED
	 x5glT+u6SzQpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710063A7859C;
	Fri, 14 Nov 2025 17:12:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 BlueZ 0/3] build: Fix distcheck while installing
 org.bluez.obex.service with --disable-system
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176314032400.1740925.4460596458732332307.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 17:12:04 +0000
References: <20251111155644.11675-1-parona@protonmail.com>
In-Reply-To: <20251111155644.11675-1-parona@protonmail.com>
To: Alfred Wingate <parona@protonmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Nov 2025 15:57:32 +0000 you wrote:
> From: Alfred Wingate <parona@protonmail.com>
> 
> Pkg-config variables give absolute paths with system prefixes, causing problems
> for distcheck which wants to install everything in its own prefix. To cope with
> this lets give distcheck its own configure arguments with its own prefix variable
> already included.
> 
> [...]

Here is the summary with links:
  - [v2,BlueZ,1/3] build: use AM_DISTCHECK_CONFIGURE_FLAGS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=708bf7d11056
  - [v2,BlueZ,2/3] build: Fix distcheck by hardcoding non absolute paths
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=057da54566f6
  - [v2,BlueZ,3/3] build: obexd: Revert "Fix make distcheck"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebd6f9fefa26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


