Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839A345CCD;
	Fri, 29 May 2026 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069805; cv=none; b=fH+UOEUQA51+SiNY5C6ob7RLEydTPeQdlibNWnFQP6gN5YO/O2ypiW0YW20W+bO6gPB0PqpT3cS6tqAQZvJKKMzjxU5kHy7fqJf3tX+P7SNALnJaOQGBx1Sm7VL8Fc+a7L96p3ZwcM4rozwPys8ifbVZ1wSxqxNoKV67vaPjNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069805; c=relaxed/simple;
	bh=XVkXAHuyk7K7Zqipg/0yHAOIuFF/5UpiDF62s9C26Mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V5TdBlF/i4xtuOnqWPlHKilPR+59Ph71Ox6+fP0y/l1JL9XwWbdAkwEg3YeL3VltJqwtPahz91NZIJ0BEQ5csJeSNibR8C4n3qThPpV9cscOoFp6ghVM8JEb4yH8cqPDlXd9m2741+XDCpF0/YKE/sV6QBAOnapqM3YMBS1bMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHa+O/L+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHa+O/L+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522A51F00893;
	Fri, 29 May 2026 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069804;
	bh=OxE06Wbwn3iId26PCT43iLsv8npFzm6xigKipx4rF90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WHa+O/L+2PAw8VFGuzEa6ckVo4p8PhJ+rXXd+izuKMd8ObQpE591VH0ikb8JT7fnr
	 RSH+rLfARQvuGFgJTJ+6WIDb0v2MfKnnLfQivI37QtTxZXsRLWADQquySh/X9kUNhW
	 hT23rC+GPO5EuW/S3UiDZAxRvvIYz0fek0sBLpCuBcOCUR7Vcej14IUDCtfbLzl839
	 bDhSTYbtsHgIQyV0ddF/MPNRruLzOfQgbfu+ENL2PlqOSJEE5u7gElBd6SCtxEenY5
	 6GXgraWJeviliqQY5DCea9bheU35Sc0YRCtWhWOagGLAimhP/WvN9kQuGrWjTx99UH
	 ucY+xk4uHXVkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E83930193;
	Fri, 29 May 2026 15:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: bnep: reject short frames before parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178006980789.1863338.2427454275156665623.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 15:50:07 +0000
References: <20260529032209.2269753-1-rollkingzzc@gmail.com>
In-Reply-To: <20260529032209.2269753-1-rollkingzzc@gmail.com>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zerocling0077@gmail.com, 2045gemini@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 29 May 2026 11:22:09 +0800 you wrote:
> A BNEP peer can send a short BNEP SDU. bnep_rx_frame() reads the
> packet type byte immediately and, for control packets, reads the control
> opcode and setup UUID-size byte before proving that those bytes are
> present. bnep_rx_control() also dereferences the control opcode without
> rejecting an empty control payload.
> 
> Use skb_pull_data() for the fixed fields in bnep_rx_frame() so a NULL
> return gates each dereference. Split the control handler so the frame
> path can pass an opcode that has already been pulled, and keep the
> byte-buffer wrapper for extension control payloads.
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: bnep: reject short frames before parsing
    https://git.kernel.org/bluetooth/bluetooth-next/c/379b101059b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


