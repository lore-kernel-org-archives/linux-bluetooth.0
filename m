Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43A283684
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543590; cv=none; b=KsJYdiUS8DUb7s0EhaPx1T57ymmWrWMcGhyXLRuAQTx8Znm9Fpd2WI5Foe/ql15wykp1SrAwVgi9sbF+hVprgOcX7AI6boNByzBQGw4e3WIzvLVz8a/vlxx/d2XazpORilIpsZBPB4NH5iSYYNMSdNOnYs8aoD1v4SKyojjtj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543590; c=relaxed/simple;
	bh=Sg4x9JIu/ae96yILVbxbbKAlyR5eYIykiZDdt+BBBlU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V7pCwfuvgTYVecrrE0WXsw+/dNnN/McVKp4sXIxntczK2iWNlIyVZr14kKHkXiVrzfwmKMCbNPFA8JTd1dvgH0a3tluWRsyB9Rq6X28F0rLQBB8Qhp73lNQ7medPmw965BeXlyDsds5zE1V5gDbFMIxKlt0JCUzdq0Inag301mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT4cEgFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT4cEgFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD50C4CEEB;
	Tue,  6 May 2025 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746543589;
	bh=Sg4x9JIu/ae96yILVbxbbKAlyR5eYIykiZDdt+BBBlU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UT4cEgFGxsdopx06Zb9y1BHNGcSzzkFioL47WLOwpl03eQZRBgOCvUjSaQ3paqdE5
	 6idsdiWJpWT+a9P812lgzJbmcRzG1G43uuamXVlftWAca4J938JrZZ+3/gJcofkQQl
	 5uxpCl2lJ98/l6Ce2Z5DY9p1Yi2oivZR+J3gnGB7QBFhVFVCjHuuvaQvViMIm1R+Eu
	 4FcpZHqwF92MoOMO+kmrNdzZURkPag40UVxh1Qh1SxsKN8Mslh/k2GFwvkjpDFA1mP
	 bgad60U7bVQsj6DxmsZvGLQ8c5EHJ8fu3OljzxEioTRV8uqLzrv3sknfbmODPT093Y
	 vPZxgcps6G4iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D27380CFD7;
	Tue,  6 May 2025 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/2] org.bluez.Media: add SupportedFeatures
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174654362899.1554625.910351840236203317.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 15:00:28 +0000
References: <6df15922fc4f602c9b10baf640e07859c4d3e958.1746256909.git.pav@iki.fi>
In-Reply-To: <6df15922fc4f602c9b10baf640e07859c4d3e958.1746256909.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  3 May 2025 10:24:25 +0300 you wrote:
> Add SupportedFeatures property for feature information that applications
> cannot find otherwise.
> 
> Add feature tx-timestamping. Applications cannot enable it on old BlueZ
> versions without that feature, as it requires special handling on BlueZ
> side.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/2] org.bluez.Media: add SupportedFeatures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=30d2de12868d
  - [BlueZ,v4,2/2] media: implement SupportedFeatures property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9ea27141c71f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


