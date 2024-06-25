Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DB1684AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324631; cv=none; b=CpK7jHJj/v7szn8XHYVVqAOmZx/dwwNy293eUWlcYUF1XFmM9Mfu0ayZenvEcme04tCpoPKsajDWK/TLVKSPMfiIhWXSzzECRxnFgwmo4HXRIcG0FhNcVPsiS6RVZmZVBbpavmw5DLtlet+HdHCCMSlBGfzrtq30L9YrLPGrR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324631; c=relaxed/simple;
	bh=CvRKjdk7I5S2zueOg/GFhzLJp6ABbrB8PkfGPPVhZFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pdmbMrnTfetRuo3B0aD+EzBbbDdSWmyzBFElz0FLX+s19IzhfxKWCjg9c2Od+IWmgmwL4OX71yxxMMiiZcG407vhAtBALpcijC9xhFdQNiC/QvAbFKPzIfDWtvDRIG7ibfokjjaeLMInStU7tlsZn2eQd88IHgrnLGFFquq/MJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Neu9FBza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Neu9FBza"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5F86C4AF09;
	Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324630;
	bh=CvRKjdk7I5S2zueOg/GFhzLJp6ABbrB8PkfGPPVhZFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Neu9FBzauezs04/11vPlHSnD/yWnZ/aOEpWk1K16dPvF4+A66APb5bb8einXKsqZT
	 77Ch25YRqLM3aVwAH+pC641D9YYV+vWpu3T7X2IL6VVciZOisLRXRiGdFu21QGV42W
	 Zoe64oQykYPK4OeZRtcttmYHm7oJIXJ90s/BFRBx17t/aDPFHrjtFZvTNOYA0/sWUd
	 YH1V23b9mT3GZ9EDnDXU26JnjOyNyMHyu0C82s2hS+hNkhG4fAic97x5JqAsV6WBwD
	 AMso+jv/syDVHgtQSHDe/XKdPRdFuT7JBu5Fp7Mqx3mbzBwILK3aoYRGgjIwQ3mNr1
	 nwiuMrHXQLwOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5E3FC54BD4;
	Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/5] test-bap: Add Broadcast Source STR MBIS tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171932463074.10330.6321243292711464221.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 14:10:30 +0000
References: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Jun 2024 10:27:06 +0300 you wrote:
> This patch adds BAP unit tests for Broadcast Source streaming with
> multiple BISes (4.14.3 Broadcast Audio Stream with Multiple BISes -
> Source - page 184).
> 
> This also moves the BASE defines from test-bap to lc3.h.
> 
> Iulia Tanasescu (5):
>   shared/lc3: Rename LC3_BASE
>   test-bap: Move BASE defines to lc3.h
>   test-bap: Add support to config multiple bsrc streams
>   shared/lc3: Add defines for BASE with multiple BISes
>   test-bap: Add Broadcast Source STR MBIS tests
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/5] shared/lc3: Rename LC3_BASE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=13da92529954
  - [BlueZ,v2,2/5] test-bap: Move BASE defines to lc3.h
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98013b74e5b1
  - [BlueZ,v2,3/5] test-bap: Add support to config multiple bsrc streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=409251a95b6f
  - [BlueZ,v2,4/5] shared/lc3: Add defines for BASE with multiple BISes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4571cdba13a3
  - [BlueZ,v2,5/5] test-bap: Add Broadcast Source STR MBIS tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=944909f2b2c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


