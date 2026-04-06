Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986919C553
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494827; cv=none; b=g8+jC81mQWQ8rG224RlS1hFRAeVXLKmS32StP/uxTiQDvAy753h5QlTLtYz5GvY910BKzs4oomIS3brlgTCEg+FklXK8Tt0E051WOjoCYhR0AQTCxiRREQX3x2SIRu13oPZ/tvWKV/803PGIoFyz3lyjARiKyLbYE+iztSx42Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494827; c=relaxed/simple;
	bh=lb50eY9JjDD7MESoh9Jt82858hbpgJBKRtaTLcessbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jJBi833qg8LehIJGWko9L80vSyfre9FktsHCJn8YoNG99KtDkMUm0GoRR2Pwf0ubBDDCYMBz2QsBOVDuY5MSwx+d77WSAuofKmQK0vIQhTXcFcbIiEqn0c7Wy8dsEfU9ihPm07DaDM/JzhiX1wlyMuczw4rmYGhwtlrXG9lZmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsE6/c+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsE6/c+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7CCC4CEF7;
	Mon,  6 Apr 2026 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775494827;
	bh=lb50eY9JjDD7MESoh9Jt82858hbpgJBKRtaTLcessbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hsE6/c+ZeiwWmyqZ3CzfKp0+lGXAVINSN0cw/WNufBd/5ilosIXapeadbtqQp2s5V
	 z9QSs0GwC7Buw/doChdZVbHXQhQIESAvXPGCpGxxF80myv0uSKlqNkeyb+ZXYhzSdi
	 VBEsHEfh6HLk9DrjJbSumKk5izVbNKyLViE1TLVJMm8POIQJgxWFiQm10tBnJbLU2A
	 KoOmN/CLjkt02wZQKaRnd20lykMdzVRhGU02dM7oal9dEVn9ruVJDFN5N26276rA4t
	 GiyjJvLCqXrPCj4mxbN9oXxSIwtmpaMxDyFACREP6vecnfJ2tntV84AiAvVFZr6h9r
	 jYhj5V/n/zMQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1163809A35;
	Mon,  6 Apr 2026 17:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] monitor: check data size properly in
 evt_num_completed_packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177549480629.3188653.3372868880702040537.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 17:00:06 +0000
References: 
 <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
In-Reply-To: 
 <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Apr 2026 14:23:50 +0300 you wrote:
> Use util_iov_pull to check data size before dereferencing.
> ---
>  monitor/analyze.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,1/5] monitor: check data size properly in evt_num_completed_packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0e37aab12463
  - [BlueZ,2/5] emulator: Remove assigned but unused variables
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=81111489faf4
  - [BlueZ,3/5] monitor: Remove assigned but unused variables
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dfc5e135737b
  - [BlueZ,4/5] src: Remove assigned but unused variables
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5a0932cc8e05
  - [BlueZ,5/5] tools: Remove assigned but unused variables
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=474f2ee8597b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


