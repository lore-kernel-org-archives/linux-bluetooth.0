Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D67223DCE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329529; cv=none; b=FwPG2qg6EZmBASJM1tOzkDh0iqNGuCkkyeaZ84u+oGAxW0oHOGEb8vZuqJPhfoNTTmG+fj/thJMV80ToKhNtSe/aRJkFlshoWwM2D8XiJDkopOVAYN19u9/7ODYjr3qo01mMno3rqkuMaSn1vVyBOGKgaPeWHAl6BBhbl2z5DCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329529; c=relaxed/simple;
	bh=/mRDXVt0hDublYq4pF4L/EdEPrOql7uOVnOlaYy9N8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FzXHOTJd0HGSHn4kECx0SmRQF5AZH7QXYDJAOJpK6xG62hrPUiPS3+HGIPR0IdJx3LSPBWFYJWQA8OwLTpai6zN68U4fQckNJcdzEtcqoHeZ+k2jM9RkU8zBSsay7mH3jxJU1+bObICwPLHW4Lb9epoO/hZdb1YiK/Sh1ngFB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyexdCkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyexdCkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2A41F000E9;
	Wed, 24 Jun 2026 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782329528;
	bh=/iNLCLqs/mxbn7/U9SjG7v1epXf7H4jqX86GlepQ0s8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RyexdCkStkowspQjwbzIIRpvDBl2FIuyBExcff+OQPNJMa334UYDPFBxN5EwoP6S3
	 7ECsrxX3lvIRTxqYbHaUrOdf+XWF6MaeGUYeJjtkwrv9vl0w9a7TL4gHRBZbYKf7M6
	 nJiheqeZO6heNgMrJxhGoo045WWqi72RTFxW1mKfvIKJxVWD4wfwkaXpd+LB8vzNSW
	 QSXVdfCsrBtAqFeXFAcexoTkCodj4oxPaAsVbIyIg6YjTKZ0cUbtf7hrWX4WJP1P0H
	 /Sk1LxabqUADHY7ArmDKZG3TDprZbMJSYK4IWHH/nTrHxrkqgJAQ/6zO8ncWfmwB7R
	 9WZ5wxzNZT++g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569133AA6A68;
	Wed, 24 Jun 2026 19:31:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] unit: test-bap: disable optimization to speed up
 compilation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178232951697.2888927.106360092002367263.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 19:31:56 +0000
References: 
 <e0650488e684f464f69cf013d1654f46bb862d46.1782046466.git.pav@iki.fi>
In-Reply-To: 
 <e0650488e684f464f69cf013d1654f46bb862d46.1782046466.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 21 Jun 2026 15:54:34 +0300 you wrote:
> Compilation of this file with optimization takes 12 min with ASAN, 1 min
> without.  This is too long, and the -O2 doesn't serve purpose for unit
> tests.
> 
> Disable optimization to reduce to 30 sec with ASAN (5 sec without).
> 
> autoconf puts global -O2 in CFLAGS that cannot be overridden eg. with
> unit_test_bap_CFLAGS. Use pragma instead.
> 
> [...]

Here is the summary with links:
  - [BlueZ] unit: test-bap: disable optimization to speed up compilation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb9b35c8d13d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


