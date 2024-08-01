Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAB13D891
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500435; cv=none; b=g+ZCbSGBAQh0meZuPHZbMF+cTcki+HFJPTdXd7nQm9SdX62tZfF0du9Fbn/kY6AXn4A41gfVRQZLmhROVbC7QyVRWQMM2fHljEzYYbQZvpdOPSk9ch/Xkgb0lbvysUMsTJuzQVeKcDve4hO6gk9fmGzS56q2LnDXPGMY2KXhy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500435; c=relaxed/simple;
	bh=aQzM8uZsnmAgn0Qj8eHVPLFShCLwYdCAXCQCwpI6LXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ER1BJt3guqlmm6ynI2qs4EfX1oXWXr2F09+AgfYeZUnVmqm9QTIlF4JIDsr030H36vC5J0WRyG2zFjLVyHYTb5OZKrhw7/Fh5ASBO8jtvHXbLA/PN9Itg8eD4lpznk6NzuXxMcddSXz3YCOsSNYhTDFX/gFJUVAqL8IDFhAGRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFDW4trt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFDW4trt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC63C4AF0D;
	Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722500435;
	bh=aQzM8uZsnmAgn0Qj8eHVPLFShCLwYdCAXCQCwpI6LXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dFDW4trt4oHQFHzzFcuYfZA0cbhewD5TORSBTM3LVgDRV5B5TC+LTNawCVSK00DVj
	 iI0fN8iQiVvXpUweJK/Z2ED61132w+nYh5qWMhWfp+ZZjaQxWZ4zebub71wZS6EE1Y
	 r4oOTBxw47PY48tsCsYLW0u6HKXQG3nje3BF9TUUt8yRURCblzqOdaT58yzR5RPEtM
	 RhXXUw70bIfOL/sAOMXvgVNSlkdkGP4Ns3dwy/ykxnDpN38oeZSZNV2ZR9UXB4xQ83
	 SqYb/708mE/Abk3b3TXWJru+k9yxIUU8xXaaxr5r1UAuEdtU5aeVdd/yxdgqYaa427
	 XIgxr4GYN5Wcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31CCBC43443;
	Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix missing unlock in l2cap_conless_channel
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172250043520.11616.17755338420150049860.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 08:20:35 +0000
References: <7f815a56-34bd-4aea-9072-312cfdd0d80a@I-love.SAKURA.ne.jp>
In-Reply-To: <7f815a56-34bd-4aea-9072-312cfdd0d80a@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 27 Jul 2024 16:49:37 +0900 you wrote:
> syzbot is reporting that l2cap_chan_unlock(chan) is missing.
> 
> Reported-by: syzbot <syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=45ac74737e866894acb0
> Fixes: f1a8f402f13f ("Bluetooth: L2CAP: Fix deadlock")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix missing unlock in l2cap_conless_channel
    https://git.kernel.org/bluetooth/bluetooth-next/c/1e69bd3ba19c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


