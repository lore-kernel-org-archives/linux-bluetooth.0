Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092F353A81
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728055; cv=none; b=eeGMqWAZ6bruzf/fJDwlxcvwUOuQqQueN0gie/yo2rRKAT200887aRETjvQfwlbIm720kJtsXxojmgd+ix9p4EB+K4d5gErjK1W4ZdBzOp8r0eJBAJLipQtCCT3vFxZcUzNQfCUaeOGbwtqByHJQlYbStsZCeK7ciZ2aFG16I/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728055; c=relaxed/simple;
	bh=17RD7Z4B9HWD7cgtYBkIa01lXjSqFEjPeBaYUX56FIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Egb9nPMiAOT/8sXNjpTKuubicwwNGGsDIYAamuHcc+VRBi7CjVquqFeP7D4hYvNUoO1c7PhbGjWv+f3XkeYQrv7pVjhMQgJRiUjXpEOTUxECsH3bNgVYZoE/QA+E5V4Yf151VpMHtRgtaQDwR099TM55KasUZjO3JKTgZ0zMrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiZ3Me9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiZ3Me9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4DA1F000E9;
	Fri, 14 Aug 2026 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728054;
	bh=v3LmL4HsPuR7Kcql6fnotwUToVeQEGtF6p+wpRnmsOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kiZ3Me9a/l4z/u9XMYjlon5O9TS3Yq/tdnsuSwcX4M+gEOagSOAOjhFrYN/Q8AQwi
	 4Ife5+pq7YMObhhria95NP2vcQy6tiIJ9k6anFlLYAfx/NY6JSumc9T9VRV7DVfInY
	 D0pRU5Hetjhc6+rvhGR+wBuETizE2PBgKnkO8gMKS2ZLQmaRNRCNB4VcDTkFqYBt0p
	 Fbd3A22Vrlqqznxqc2xeXDEe9O0BgTD6rWSK4Is5ASIWCLvs8VeE1I7Xp5KJLbBaSW
	 OBsYlmUWCC2DsP3hDo1zrg2VH0JUVLmNNtpk1a0gStZ6F/ZsaN4thaWMcOz51/JdZX
	 jBUIlLg5yqqCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939183924457;
	Fri, 14 Aug 2026 17:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ, v4 0/9] 3 SDP XML security fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178672800814.3885098.3891730375352054107.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 17:20:08 +0000
References: <20260812080410.2116906-1-hadess@hadess.net>
In-Reply-To: <20260812080410.2116906-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Aug 2026 10:01:31 +0200 you wrote:
> Changes since v3:
> - Fixed some "line length exceeds 80 columns" warnings
> - Fixed "macros should not use a trailing semicolon" warnings
> - Fixed "Missing a blank line after declarations" warning
> - Fixed distcheck
> 
> Changes since v2:
> - Reorder commits so that unit tests are added after the fix, so as
>   not to break "git bisect"
> - Add "Fix stack overflow when converting large sequences to XML" patch
> - Fix crash in unit test when test files are missing
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/9] unit: Add test for sdp_xml_parse_record()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e55ff8818f72
  - [BlueZ,v4,2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=985e643d78b0
  - [BlueZ,v4,3/9] unit: Add test for sdp-xml type-confusion bug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a92683ce81ab
  - [BlueZ,v4,4/9] sdp-xml: Fix memory leak when adding duplicate attributes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae6c543e892f
  - [BlueZ,v4,5/9] unit: Add test for sdp-xml duplicate attribute bug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ab91b4528229
  - [BlueZ,v4,6/9] sdp-xml: Optimise parsing large sequences
    (no matching commit)
  - [BlueZ,v4,7/9] unit: Add test for slow element_end() append
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95fa5735562e
  - [BlueZ,v4,8/9] sdp-xml: Fix stack overflow when converting large sequences to XML
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9caa7d3e2bf
  - [BlueZ,v4,9/9] unit: Add convert_sdp_record_to_xml() to SDP XML testing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d01ba78b1d8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


