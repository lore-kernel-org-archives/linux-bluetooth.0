Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029616;
	b=snKJGjLLa9AJKdKkNVXb2+PedeUsyNTjVTf9R7JlIfCYhythBo0AY8JA8WJNW+Q3TqZd
	 +yAsb7+5qFk4HzVxBbFl0RImjAYTEtlGHgRMvL2/siGHAsCLJtxFJW93K24RhbWYEfF/M
	 8f/qyrSReIawuYdsCqUT2x2FRuVuhgR+UT68PYzEU2YsT01aGCHuvYuYSv+WvSEipq56d
	 UkI/mrxknJD8fNDS59NePLXqIxbs+RXIveZ0pWFFQNTT7GghDZRkwrX7uiUTPniizHgFu
	 QqhwNxqRfh8lMyYlfbVfheXNnP3QMsxNzIY5SZKfaDWH1/HSllCtSfmWkJI3lvimvqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029616;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=73JYqpFOxBaIBCUmJ1YRJ0++DC/KHE1z4vLlcpagrGU=;
	b=H4NeZchbvTFVM6wTUmrrk1qmq1rnhP445cRfpA5XCNbSgp0ctyAfaSp674pbdJXNxFAB
	 AC6304vHDJMh1ubSC+HHLDtCYkx6nSQXRWLVyyBuR3FNGxs1CxlfcSZEQz+qmp3MZX7IH
	 iFQ8DzBOxqxsQeusOrhXagHodZ1av72vmJJukEjFpaH075RdEyJmG4Zp7p8519k60wBT0
	 bpPgoDdtkC5u4G5EBNvvgB81yffE908kDaHADCkMXVbTcRSX/ntBG+YYDqeW71uRKKYhh
	 0Q9vBzBZGdXTnR8QuAiJ5tdVqVOHqcdiSHwhuED/xN+CgqjvzFwIWhfN9A/REyi/nJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kygeGSOk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33F606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kygeGSOk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2E41F000C4;
	Wed, 18 Nov 2026 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029615;
	bh=73JYqpFOxBaIBCUmJ1YRJ0++DC/KHE1z4vLlcpagrGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kygeGSOk5vtYr8+ezptx8lOKOCQ3aKpHMMLvA3iQMgYR5BOZ5rs6P/yPj6RMMjz1p
	 /L57H4abKDZb0fDdh0ZfsyCQ7ivAmE9o3grrcRFTQC/VFIIx7BTROzjaWiYsQTx3sF
	 yib5voUKBNoP24qKlGL4zkgaCQM2/OYqEmYfJoeIoK3nTAqCkL4+/GFy+xMj09Mpfu
	 +TAVa4NAOuILfVixO59vMn5kjop7RjVYO+QABoQwkxKievdvJh1YI0HPh30qf+RxO3
	 xEDdWlI2zxXeBnMTP9o06SK2WPNhCur40E3vUhbrvLL6SwSrgi7WtzGiRostT4SJTi
	 WvriX5/A1bs4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B428A3808210;
	Wed, 18 Nov 2026 19:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/1] emulator: Fix version of 6.2 and 7.0
 controllers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179502961427.2490531.4491420503994317307.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 19:20:14 +0000
References: <20261116212805.3083583-1-luiz.dentz@gmail.com>
In-Reply-To: <20261116212805.3083583-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Nov 2026 16:28:05 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BTDEV_TYPE_BREDRLE62 reported 0x0e (6.0) since it never set a version
> of its own and BTDEV_TYPE_BREDRLE70 reported 0x10, which is 6.2, so
> set them to 0x10 and 0x12 respectively as decoded by btmon.
> 
> The version set for BTDEV_TYPE_BREDRLE70 in btdev_create was always
> overwritten by set_bredrle_features, so fold it into the other
> BREDRLE types. Update the versions expected by mgmt-tester to match.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] emulator: Fix version of 6.2 and 7.0 controllers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=35a9286435f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


