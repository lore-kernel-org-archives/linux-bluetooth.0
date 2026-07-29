Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7A3C1D57
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340243; cv=none; b=KoPW1TPPlvXvhPZ1ZaA/mUHuYNRr4g/SxIPoSjQL1jA9Q7tCCijMXfGYKderddhq/iiRntUpIOnxI/+wygrV9eKOyBI6JbZAsI1aP1vPDBe+S4DS9jjgoq/kBwfnK2Zeph6SHem9ZFIRV91IsXWIl661gFnagm5VCXRXZcK50Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340243; c=relaxed/simple;
	bh=BpiVMKr7JneSl5oK93DDF+X6Ar6Y5HLyu/At4+nbfos=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Iihw3TJYpv+yCVN4gMLimdL0adG/ikvdNY2aRu/rO5BGFyrnSAn24cUN/lGzmjPacrTw0XIN+lTFEUIZxEI75woCnVYFbV6aZ4SUy+0bdqGz3XnJfXEGpnlIHJjtBTf/dan8Wy9qKqymDJ0rCxoqivcAHP+ndWyuZkP+hIK02lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcCvIYnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcCvIYnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7F81F000E9;
	Wed, 29 Jul 2026 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340242;
	bh=kYwH4RpFMMENV25Xv5nqtHFq8SxI+Fqvw53knYt6NGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fcCvIYnILlY8KcKQJpM4mb8lDIKb2rw57PgHs38263XTrOufNVGCf61/mynUW6U8P
	 fKFWMvvOczbtu4d41E6FWtl4hBloQQ4f2hVtuu2Is/OJw39XcmD2JW1QKpqr/qfgXM
	 wNRleJclF7mFG/tSBqutSe51oASpiNyUsrUmci8K2dJxv4JBF5CSPHn1CN/X5vrk3o
	 XjIs98KhnXw2yiFlERtuWkTABoiauzIgObstAmBqJpzIfJse2Q/Bw0A0qlm7X2A4TJ
	 3TnckBriduOzk8SGpIZsko5EpATaXmNeo1fnKp07bmkiD3AYeC8NscJ/Kd+MeMpicn
	 2WmbVvVfpIguA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85ABE39253CF;
	Wed, 29 Jul 2026 15:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ bluez v2] bap: fixed the return value of GIOFunc
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178534020629.3138935.4210335244392986040.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jul 2026 15:50:06 +0000
References: <20260729-fix_iofunc-v2-1-f4043eff6664@amlogic.com>
In-Reply-To: <20260729-fix_iofunc-v2-1-f4043eff6664@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jul 2026 14:51:43 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> The GIOFunc should return FALSE if the event source should be removed.
> 
> Fixes: 322c39a64 ("bap: Start BIG sync after receiving BIGInfo")
> 
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> 
> [...]

Here is the summary with links:
  - [BlueZ,bluez,v2] bap: fixed the return value of GIOFunc
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=66d19bb2a027

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


