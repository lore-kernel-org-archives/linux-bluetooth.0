Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644D3019A6
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465412; cv=none; b=MDTcCtrKEd2etyGdgAKuWFJKITzXFW8jU+jrSGIDJiOFyI3weyh47YMMssDwndOxhG5oJ1xXsjeBOOs440ySJIHFMtarLYKS3l4QQmmhiwvlXxDzGp5XDToajdxhHlVNM6zNxG7qq5ihT1pUMFYL10gUha3SZXn6mPVlbxgBIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465412; c=relaxed/simple;
	bh=v/6ct36cr3Hi2NhI4ZEx86TRqMr2yEMbJzn19JtRtBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MH+y5Xb9K1pv3ysxwjkunl4jtI3nlG1+vfxcNc01bqG061ZAAQ2jVHRylg9O7enKTrrrfI7xz9UAFaVjzhsjW69am6IibfgIdlEEaGo8FRxJ6AuysrPdxO69x934UU4CIuDf476OKlcqUIVCjbrdPz7C8JN2B1/ibSE03rIVYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7s9119L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7s9119L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEC0C116C6;
	Mon, 26 Jan 2026 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769465411;
	bh=v/6ct36cr3Hi2NhI4ZEx86TRqMr2yEMbJzn19JtRtBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f7s9119L0CM1ltyea5k2xdf7yEbKjV0HI82zwuZY0YakVMSO3tnAYOnSDeJgoe0r9
	 CkihIkHbCQg0GUQTNSA0cN4KTm9RrAkLwz6Wsx2kCNCyKru4aJ0h6BKXv4N6gXK0B7
	 QA7NzMEMsaewth7u3QiLKQuerHwX58ly2ZweHUufm4iFix6+hKraYvs9IWs0sFmvdN
	 wZfyxG4rQN3kEwoFTuROi9jI1AlOA78rDPrf1JTXzrlQAD7lDRi01BoZZonHYAbVmQ
	 HuJPjTpSWWOrLtIJL5F8GxQpsaerLGH8w2o4eau1qZfukOD/uGXYOBZKPNx2ri1vX4
	 ki7VSBEqnsXLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11CC9380A958;
	Mon, 26 Jan 2026 22:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 0/2] Documentation fixups
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176946540585.196436.4757082840100826538.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 22:10:05 +0000
References: <20260122170001.122052-1-hadess@hadess.net>
In-Reply-To: <20260122170001.122052-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Jan 2026 17:58:56 +0100 you wrote:
> Some documentation fixups after "Port text docs to RST and move man
> pages" got merged.
> 
> Bastien Nocera (2):
>   doc: Add "C" code-block markers for coding-style doc
>   doc: Update .gitignore for new daemon man page locations
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] doc: Add "C" code-block markers for coding-style doc
    (no matching commit)
  - [BlueZ,2/2] doc: Update .gitignore for new daemon man page locations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f21f7817a40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


