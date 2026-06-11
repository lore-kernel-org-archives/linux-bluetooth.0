Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7248BD57;
	Thu, 11 Jun 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200694; cv=none; b=ZVzKThu6oSf630VTZvCHcPK1D8/Hfa9Ws3Za67pdNJSIZZX91LaXn1jg86jLJIEjSazIcx2jNWOH5FSKwxJl1g9F1XKr5LkfgTTqExePw5rQb13TK1J7cni7nxNPq1mKASfgKFgt/E/G8R4rXSSnbycpWt8zQ+sZnoiT/kBd16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200694; c=relaxed/simple;
	bh=O02mcBcBOjj6KGKql2GDOPMaM82nZWPNMghaDwSrs90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kqimw4AFZg3x3j+0KwoCTi3iH7aT+9AbkA/4BkA43kHHda1fUUkn+CiZswmGkRr62CHUgE00FHl9HlMJLdoa+DAVQdj78QN0bp/I3NPRSVxcme9fvoqrp3UFToNsKvZFJZmZ8IJoRKX0cvuWYGZBqNvxHiyV+uwq21TaS1yntxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCv4DoU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCv4DoU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134E51F00893;
	Thu, 11 Jun 2026 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200693;
	bh=ALz+9GrPdiEVtpRLkIHlem/iZAxX+7lBScDgDqNoHVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nCv4DoU8Di0XIquePQxAP2kdOsn154otuLP43X4N9vBGV8SpWG/CThJebZgmXAxDX
	 1lS/6WBqxttNtGmWR9vmXa4+4ePNSWAnbvLyQ7IoUynNOwoUWoVamu8NP+iGGVoGgc
	 yGq6xko07BW3EY+7nicaEw5Vhx3nxY/rps+su7PHe1NjzPulGRo/gneEUuLRNxRfE+
	 s+fGT/YlxnZXjRFtPrWHSWDuedRkTOGTw4mHlpmWqOAOyt/MzlRLdkuHcTVUCGglAM
	 As5LkYwYB162uj1GjZG7nkD+ZWKdrBTVPnjVjlwUIf34C+k8vtHcibRcx+wSvnUhPb
	 XSwCRTLV62XcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938D33930F87;
	Thu, 11 Jun 2026 17:58:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-20
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120069013.286318.14387798672720633781.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:10 +0000
References: <20260520204959.2902497-1-luiz.dentz@gmail.com>
In-Reply-To: <20260520204959.2902497-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 16:49:58 -0400 you wrote:
> The following changes since commit 375ba7484132662a4a8c7547d088fb6275c00282:
> 
>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-20
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-20
    https://git.kernel.org/bluetooth/bluetooth-next/c/5027c886e26c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


