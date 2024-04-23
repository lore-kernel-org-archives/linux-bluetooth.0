Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BEB13E03B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894029; cv=none; b=ZsMxGXrmqfo0ZBT1SoQxZwJB7bMlnR38PBBVnq5eeRsvxhZeYM5E/JmU5nwfZTwBoXkbBudcP6WlAceWr1k1Lq13qmKULxhTxKU1DxnscfapT9Eq22ajFxYB5tnJbcBeBWTB5uWh1iTWd3X1DBeMUtzcX0uq674QJvfz3pia52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894029; c=relaxed/simple;
	bh=7j98WgeSGdUcXHDOjxlbXy+ZezAB8oorW0YBvigUl6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=idjwxAS0mrn1J3N+SY4nN1GWyEiIzd+Nfw/5V6cSAfTkyPaVC4W2YNZaRaSuR9Y7e9O8tCL+mp+Avr7e1xmuJwm+4K5/XXdJa282WU5TMgxcshCHa8Kur64/JTgqNPL2+UVNMz2+VA0ljov3PPl/90oUWsw8YNFBS4G6Q8JoCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB41ypc7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB41ypc7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35E72C4AF09;
	Tue, 23 Apr 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713894029;
	bh=7j98WgeSGdUcXHDOjxlbXy+ZezAB8oorW0YBvigUl6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QB41ypc7xPUBe9xDwJmKakBd9J4g8njHwHee34hGZv04WVUM/Pzzs/w2X1ZVzJQTX
	 VC6jV9bs+Wuw4hkFaaRFHckzTvnkOZlzmfiEEkI51qW4HrmTwA7PjDJQfa5QEhUG5v
	 WdjagTYzQLgqFp2gDP9PfpCcbph89p3uDrcVobfDqhw9tC1i52tc1PT1iYvQUuKs3f
	 8g6ltw0JsKTynoB+XSYRZp9ZCEIBLtCySjdXfqUDDGqsRqzrm8ggduk2FNiPXvCR42
	 TAnVGMVrR0hO1ZxpFu+AZFUnozIsbfwHnRl4EjoiatHcmSWpJ5sOogoB3jcyMqk+nv
	 5lVduG1qYKpDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B35DC433E9;
	Tue, 23 Apr 2024 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/5] Create transports for matching BISes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171389402917.11756.8651224718514990654.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 17:40:29 +0000
References: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
In-Reply-To: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Apr 2024 21:07:47 +0300 you wrote:
> This patch refactors the flow for the BAP Broadcast Sink.
> After observing the BASE information, streams and transports will be
> generated for each BIS that matches local PAC capabilities.
> Because endpoints are not available any more, local PAC (which contain
> local registered capabilities) has a new list of setups. Each setup is
> generated based on the matching BIS observed.
> Then, the setup is used to configure a stream which then generates a
> MediaTransport.
> The transport is in the TRANSPORT_STATE_IDLE state until someone
> acquires it. The "Acquire" procedure results in creating the IO using
> BIG Create Sync. The successful reply of it causes the transport to be
> advanced in TRANSPORT_STATE_ACTIVE state.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] shared/bap: Allow NULL bap endpoint in streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5b4d9abfdeee
  - [BlueZ,2/5] shared/bap: Get broadcast channel location from stream capabilities
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=30b741baa569
  - [BlueZ,3/5] shared/bap: Update stream management to avoid PACs
    (no matching commit)
  - [BlueZ,4/5] shared/bap: In case of a BIS-PAC match return also the local pac
    (no matching commit)
  - [BlueZ,5/5] bap: Create streams and transports for each matching BIS
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


