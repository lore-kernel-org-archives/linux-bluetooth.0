Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739013BC3E
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633431; cv=none; b=AI7HW7GMrG9VDD0CNz1hTSFEKMJgd5aYD1BXv3LWxQkCIA2aFaR7R1ssL667X8ltqvWZDqbZX/1mDMNyXwWWA4tP92CGMyjr8DKPPkxxivlRAfMAoLDkiDwqEz7xFe9e1k9FFG0LWrygahVdufdqVy8g56t8vnvt2sW82Aq2W2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633431; c=relaxed/simple;
	bh=PPAsVxORkt9FTyaL4Zut2v0LLbFfEFUkgMA3phJNQ1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=coOCZ5W641UtyU3Km4lZqvVmvRwirOWEilAKUj4THBKaPNnv64KkgJFTVQ0sAjkUk6jp171LgpdOGiH75NXtcNZCXs+vDXjMnNf/j75/zEbAFysB0O0MrwiiT3V07m/8t6Izbm7kBSS21Adp9YV5nTovpvf/j3/x7otcj/mEOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI7wei79; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI7wei79"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AEC3C4DE01;
	Mon, 17 Jun 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718633431;
	bh=PPAsVxORkt9FTyaL4Zut2v0LLbFfEFUkgMA3phJNQ1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OI7wei79YfX6XidMjHluOcsKPdwvIXEmIdQFiZu5b9BaAmeuqk0PB2EMXYnyVCoRD
	 I7NDWm9dJUvXtOHIDNVl/MLuwOuXZbDl0Jj1KAH2/R96Eu9jMgjJl7bpPzWTrshyI5
	 efa0uTyIcG9bytXdJlYW/UhKhF+x6aI3nNSBRz1bZQ7Rgcv4D2qKyHmQsU6AzePA7P
	 SADbSfSE9l59j5mBbC7xAKL/x+XaJvnthl+4Or/H4cL/lZK9fNV7mt+0LjvfxG+HPK
	 76/NrPrIMhsU50MBmBspM5gyMDZCotX0L+DxG+XSiXqm5AHTRwiSS1T4FTG4vJtJs+
	 Tazp2sfGoDT2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03E50C54BA0;
	Mon, 17 Jun 2024 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: hci_event: Set QoS encryption from BIGInfo
 report
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171863343101.8850.8894644155499539248.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 14:10:31 +0000
References: <20240617085206.5750-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240617085206.5750-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Jun 2024 11:52:05 +0300 you wrote:
> On a Broadcast Sink, after synchronizing to the PA transimitted by a
> Broadcast Source, the BIGInfo advertising reports emitted by the
> Controller hold the encryption field, which indicates whether the
> Broadcast Source is transmitting encrypted streams.
> 
> This updates the PA sync hcon QoS with the encryption value reported
> in the BIGInfo report, so that this information is accurate if the
> userspace tries to access the QoS struct via getsockopt.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: hci_event: Set QoS encryption from BIGInfo report
    https://git.kernel.org/bluetooth/bluetooth-next/c/bc73df197b70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


