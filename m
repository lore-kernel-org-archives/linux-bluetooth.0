Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428E2264C7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422616; cv=none; b=FvQi3vtbTCh5tDWzzQnepS5FbpQ64mJGKgKqPU1+oXdBQ/qofzg8oXvAB+wyCVwaqfiuyNNrP6gB3lr9Fi7Xaj4OWcd1dbe0SFB34uY+iXvEiwKzGOvnA0lPt0g2C6wzp1nZdv+RBxO+/3zXuvljDEbu7eassCGoHgxnLZhcRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422616; c=relaxed/simple;
	bh=dGmUpOt+vtv17fPhE7PuLJUvO47shyc91FyztSeVczQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=egepWdItAB7Xppuz1ntEow+5iz74mOUT8YDj3YMgif/2FUdd8UDcfWi7WPLFdi6Vr51q6la/5ZhQRme2rzUiAgAOHQbulB1fyBqOYY5pP1Z/P9t7sOpuLie/VLTWnnPAtnE4OJzzsdSv5byUH6yjS9JIzLLk6i5vnOwI5Vd9ULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1A8H3bX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1A8H3bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB1BC4CEF9;
	Thu,  2 Oct 2025 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759422616;
	bh=dGmUpOt+vtv17fPhE7PuLJUvO47shyc91FyztSeVczQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p1A8H3bX4t0Zir8GT+nK/dfyFgogrU5rd9RFEZ76AjqUDPD5dn0CpaJv0itIf5TxU
	 ncQjvFUCMZjL4S9+2mIT74WJnHOrr5WD7gSCMv9lnJrNdFztVMK40QYN/x7r5mn/lz
	 Oie9XRftUSZF5LVgDUSFmm+/2fvc0zcS9rZmiDbSPofFCuQYef9P9Ac4mYRWePK9Eq
	 LLO8tiXICg1NmWfiRBWRm60/dWbTiy4NaPV8HMSHpHSCAGCaDllmEIKvG6fP0bn5Ip
	 I0CgJkseTXApEkYmpDoNYticGIYKfaTo1/auiVGkb20H9hXPTfu3LNJR6MbaOZ95M+
	 4VWaCGRYlcBTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3445639D0C1A;
	Thu,  2 Oct 2025 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] client/assistant: Detect if object already
 contains a valid BCode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175942260810.2981110.4369454839068321150.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 16:30:08 +0000
References: <20251002134043.196760-1-luiz.dentz@gmail.com>
In-Reply-To: <20251002134043.196760-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Oct 2025 09:40:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If assistant object already contains a valid (non-zero) BCode
> (e.g state=local) use it instead of always request the user to
> re-enter.
> ---
>  client/assistant.c | 55 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 14 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/3] client/assistant: Detect if object already contains a valid BCode
    (no matching commit)
  - [BlueZ,v2,2/3] shared/bass: Fix permissions not requiring encryption
    (no matching commit)
  - [BlueZ,v2,3/3] client/player: Set QoS.Encryption if QoS.BCode is set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e55476bf6c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


