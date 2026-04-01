Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C639FCC5
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070623; cv=none; b=WOsYDTmcQIbQzxJt4sCIb13OB8TqcXpf1D7nNrUcplmlmzrdKlvNX0hGtVj9/++wSJ7sirOwNPko8OMacACNrJsK/BLkPkaphLGY4TCGjw2uTztbtrB5wbq8KyaxNVTx363fK0ql3yEiD7x+UOFWz1Taf3NR2+58sBT4mqp5J18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070623; c=relaxed/simple;
	bh=mzcc4tBgI9WkgQ9DLSWmkHqTk28kCHMssstgxiooRic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pnWj06eq7XBdJNyGsLeqQFCV9eacwSs1fMiiIhXHxV26sWdEd1k6EGZ/d9SfCVOIPeNfMvROrgpuEPiLjMPkOcsUr5rmV9WDh+26s1I82lEjbIdaTkLzDElUzgDdkGpzZrg0rA5FtMrhdMqD9Zb+4p6Z7Gqxp3OElgCuM0YOlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKYuYiYA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKYuYiYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A3C19423;
	Wed,  1 Apr 2026 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775070623;
	bh=mzcc4tBgI9WkgQ9DLSWmkHqTk28kCHMssstgxiooRic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JKYuYiYAYA+R6q09/+ElWkiy91I9v1XtyOKRkIxvjKDUkKTAp6lB1ntKYBwfYrDmJ
	 cjFdNTChgsvaExpKUrINxC3BXJEOt8jQpWQF/m1t17MtjKImfPWhrv+/X4NCHQ35xR
	 EkpY5x/WQTQKpJHtsa+vt9zKN8Mnf8OFV0R30pkc8BBSW8ZCYluajk3a2NAKc9TVvh
	 1I30VLKyvHF0V4rFVHPKunGpb1BytzWPjoWS71gWvO5alRjTAhWom6HnUHd3gR9Bqv
	 MORiuPgHKY8jo4K2X0oH56J/y/aoYB3XSysOaXr+cEnXT9JjKfy5lxXCAdazIFi1up
	 gWtZqswJszk6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCDE3808203;
	Wed,  1 Apr 2026 19:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/3] Bluetooth: SMP: force responder MITM requirements
 before building the pairing response
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177507060603.3825986.17242762687014277878.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 19:10:06 +0000
References: <20260401160153.1980387-1-luiz.dentz@gmail.com>
In-Reply-To: <20260401160153.1980387-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Apr 2026 12:01:51 -0400 you wrote:
> From: Oleh Konko <security@1seal.org>
> 
> smp_cmd_pairing_req() currently builds the pairing response from the
> initiator auth_req before enforcing the local BT_SECURITY_HIGH
> requirement. If the initiator omits SMP_AUTH_MITM, the response can
> also omit it even though the local side still requires MITM.
> 
> [...]

Here is the summary with links:
  - [v5,1/3] Bluetooth: SMP: force responder MITM requirements before building the pairing response
    https://git.kernel.org/bluetooth/bluetooth-next/c/1bd2e4ce149f
  - [v5,2/3] Bluetooth: SMP: derive legacy responder STK authentication from MITM state
    https://git.kernel.org/bluetooth/bluetooth-next/c/3a0b100b337c
  - [v5,3/3] Bluetooth: L2CAP: Fix allowing to change security multiple times
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


