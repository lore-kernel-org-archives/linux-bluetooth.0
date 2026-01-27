Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC71221540
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536820; cv=none; b=Svn3lXiuvqOBDDcdl4bC58DLKBmTT2sPJ4LdeTaIh6s69DidAFpUem0wyMRO18QbxWei8e/RPbrzG4GS9PVOigLOHcNdNnI6JI21WV2k1MkdkVzGxyO/+d/KZUEVMaSWloxI/gVdFhK5FU9uJmYxUrDS8KIrFG6kEbcSpkIADZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536820; c=relaxed/simple;
	bh=Y+viwQriiu7/jgfyiLFyX5UbL72v/zbO4O6I24b+P5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K+xq724SEY1U/Lra47YH25q6smdRbZbO1hOYBHjB0qUcY9Btm1q0yDUFrbH2I3cVF3T7p78eFFWeHTUwzg83D3Ckblu2NFLnApnQPDuX1G3KZetdZALE/RSCj9qh3ZOSx22svrCwe4mq6Rmy0EpNQvPCYo4ActGWt+AWWBV9NT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imEUHegz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imEUHegz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0C2C116C6;
	Tue, 27 Jan 2026 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536819;
	bh=Y+viwQriiu7/jgfyiLFyX5UbL72v/zbO4O6I24b+P5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=imEUHegz9SdbqrstBSNz5vQj1gXpi3CjVtOZnQcnttx6396MEkKpijG9wCPpO5yyq
	 dZ702beambvBi8ByVUXBQodJETTk2lWUBjWRb9gTNDDcvZl5hVlpopGrtgmWA/Xkm/
	 G26k+WUx0uzpmFkKqIPLUiy3kvjrlLDkqHUNs4SzFfl4Rskmo8UJ/OJokHjWP1l53f
	 VTm7v0DQZjkj2SAa/BPGhnW5DrhiTYFC/clmkhzHHLX4p32lcnGimegAegdBHzEhSV
	 oOI68zzAlaA05+vDQYo7YMme205RNfhNmSytX22POl2iGVIoBnCkfZ5oCEX3ATbuNq
	 iF2+DRkPI1O3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11BD9380AA58;
	Tue, 27 Jan 2026 18:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] lib/uuid: Add RAS service and characteristic UUIDs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953681359.1341664.5577270517791433879.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:00:13 +0000
References: <20260123104120.528321-1-prathibha.madugonde@oss.qualcomm.com>
In-Reply-To: <20260123104120.528321-1-prathibha.madugonde@oss.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Jan 2026 16:11:20 +0530 you wrote:
> ---
>  lib/bluetooth/uuid.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Here is the summary with links:
  - [BlueZ] lib/uuid: Add RAS service and characteristic UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92482d569345

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


