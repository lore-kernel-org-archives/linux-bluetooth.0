Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76B223DCE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329525; cv=none; b=pIM5AGVihs3D7aI2fKWOiDi6YS9tBvm1i/Y5YBLai/fd7c6pfEzY+LB4d7SLpzyc1Knjf0uKw2J9IDc/Xpy8RA4lAR/twX700Pkv5v2Bg7meLGRcNwkesdzUe7zrQ8R8amwaZQF6uRx1Oy5MxgPknlELVhtH/Qv0K8X09TouLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329525; c=relaxed/simple;
	bh=qAus9ROvkjHl9J0rz6FB4cCstwOw+hhCimqFlii1n1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EtH4jKViFM5xvkP5YyTx0TyCHEiLqxE2mmiKThzGBPbBpzmiz1kxGBQLNPCzqRKjyEdmBzIzwMUfOSP1aSmtiqqVCbbrkbe6m9ceWvfXzgQJsLmOI4E2UHtAFfjOZ1PASamBTgFRxX5LZZDIBSiZVeOGvSOW5QlmVyMYLVSrQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE07Aiqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE07Aiqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907031F000E9;
	Wed, 24 Jun 2026 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782329524;
	bh=kU4KPhnY5OCTuRN4wTHL8aY0xZvIIq2+D0KPyWhWsQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QE07AiqcNIvzS2DbkiR7qiHVPYBJG3aSYx+6fe5vrKG+yVEGGg34xMw+qInAgZkvL
	 ZxNblh+p5c3bHJ31wuOK/b8Lt5A2+sGR1k9sjX/rsojN7XeVdbhfFkTO/9G1iBsvub
	 bqt6B9QqhjAchBoSbUKT2XmSSA0EWFDgs6py27D8U+R+/nw3rbltrEPE9AWU5iy9KA
	 1G6pKyL2q7QA08/Ohg7wP4qZICrfvD5ozBVWIzIBzx72w1CaMxjFFG8FyUPWXbkNA5
	 FbcwlsNQJCkm3SGq3Jz5/aaUN9Ao8riadwRCVyGm+7iZbAf4UrRLoBSAL1fYIfXgu6
	 LO5C9oPy7/6Dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569083AA6A68;
	Wed, 24 Jun 2026 19:31:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared: rap: Defer CS Event registration until
  connection setup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178232951284.2888927.12635405443082868428.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 19:31:52 +0000
References: <20260622062905.3525480-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260622062905.3525480-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Jun 2026 11:59:05 +0530 you wrote:
> Move LE CS event registration from rap_probe()
> to rap_accept(). rap_probe() runs during service discovery
> while no ACL connection or connection handle exists,
> so connection-scoped CS events cannot be delivered or
> associated with a device. rap_accept() is called
> after the ACL link is established, when a valid
> connection handle is available and the HCI layer
> can route events correctly.
> Registering events at this point ensures
> proper handling of CS events.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared: rap: Defer CS Event registration until connection setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7efd9383f0a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


