Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F01A23BB
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508591; cv=none; b=oWQJco3xZbB8zpgGh6N1TyHgSZVFFPfUglU0SUp7G6W83rXRJ4x+mUQkKU2ESeQ4115jtZ5hkO0qWuwiHfKPUin5xN3bmDybuAPoswq+I33CQ7e0pSWFaN54TOLx7WPcSHZnygBif/VEzs5SldQ9d2Vw+OczHFTJw5nizgYIxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508591; c=relaxed/simple;
	bh=U5rRe61aN8p1szefWXZcCBtEcKEPJYextnYpvANo7S8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MZBieGrQioTi/E3pDJrZzMRUxaQFB80mSqHwGpf4QSU8eo1EOLmeAynqwOhA9yIgnnDp3One133C9uG+KZkB78ysjLM6BNk6/lYPUdA064OvgUzAjcZ3OM6CtSwkV2Ubs+PiDReVQfS6bW4EG7O5XgL56z5WG9f9yAZtNiSPtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDxdVnWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDxdVnWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571BEC4CEE8;
	Thu, 24 Apr 2025 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745508590;
	bh=U5rRe61aN8p1szefWXZcCBtEcKEPJYextnYpvANo7S8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DDxdVnWh1bxLJ5Pdit1ytdMfw3muXS1pV7Vr4QDn/Nm+6h1ZjEI2gs3yxKDUmD933
	 o9yW5zv296XDaBV+AufzCKSnQUymFlT4yPOx1xcUHv7PS48sPom5svRJYmI9AXCDoI
	 PEE3d0PsEqYihRH/CPqywe8Lsezf5R927oRMNYoWBq32X01b+zPJc/YL7Ner39MJcl
	 yy/yXlfSqQoaO4a+sSxGF027Z40dTc/jmuFVqk/kJhfYHF8ITPOW5QwFb2DfD6MQ2D
	 Yk2khIhX2t6iZUWU87m4/cqyRiZfMNH4nnoVIs/IpZqr4Ns3HItZg2ZgaJZXG9DxL4
	 Gi91yclkvJZPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CAC380CFD9;
	Thu, 24 Apr 2025 15:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] workflows: Make use bluez/action-ci action
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174550862900.3390364.2822093238181450112.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 15:30:29 +0000
References: <20250424151540.1322778-1-luiz.dentz@gmail.com>
In-Reply-To: <20250424151540.1322778-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Apr 2025 11:15:39 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This replaces the bzcafe action with bluez/action-ci so we can maintain
> everything in the github bluez organization.
> ---
>  .github/workflows/ci.yml   | 2 +-
>  .github/workflows/sync.yml | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] workflows: Make use bluez/action-ci action
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a769a3af138
  - [BlueZ,v1,2/2] workflows/sync: Remove workflow job
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8bce6574327

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


