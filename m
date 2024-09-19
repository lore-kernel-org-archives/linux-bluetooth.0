Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613119D083
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765838; cv=none; b=Rk8Ma9B59foWWPCTgw2YtKfjuSW/xdsQSM4sJFYMOhAq/pvR2PjQUl1QpUI3R67gsNfFloddoHW5QYKAvzkjahbk0DvRqg7XIeP4X6BB5al8JsAabQJKcRsMIj3wYWCJZBafc7J4uIecQpux7Cg/20BxIV5hSp53WJoDVQf2dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765838; c=relaxed/simple;
	bh=LItG8bx/F5/6V36RAVA8fL4JBlYxcBKEH3UWStlXdng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZ20VGtwNaXTfisbif5hzB9rcbAVYGeyFR0oZMukxk0AdubfgPTWYJwTQI9TyAL/nsET5CAQt285bk17CfDHmQtvVTTTV1tk/5kBPrA3zU3E2MZ9MvE+CnG7Bln1MV8xjOrf6V1pdrw5cxBRsppWGCQ76akqaLBPytnu0BztDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZUIId7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZUIId7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20071C4CEC4;
	Thu, 19 Sep 2024 17:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765838;
	bh=LItG8bx/F5/6V36RAVA8fL4JBlYxcBKEH3UWStlXdng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rZUIId7HR7NLDVPozaJrY6lh3JNWi6OYMYLHtkjC9UFzqgH4XYfd3shlBmqU/SfrJ
	 /hUMECZPSTHw6RNtdcl4TzGEX3Y1cRW09LjdOyHfgsOKe6DpS4qeW6hEnSousqMUWh
	 nMMaqk8gOyFOaSCChd96cSCYtEMuVctCjmXEuxkoLtiN6/bNxKvikjXAwOMR3J8D3c
	 xTFa8jejruaczLW69fNLPH4m1pvAeem75P0uyeBv44Yz25/Jxq3uk3rxhqZsZQJIjG
	 jSb4/HuaV2IE/NUH2zK3PVi3D4nbH8x0FcQcJqyFlB7Ks0w+x1JGXuWhFN6jLH8JqW
	 flrcn+07+FBuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F5A3809A80;
	Thu, 19 Sep 2024 17:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] bap: Set bap debug func at broadcast probe
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172676583975.1626973.8860109382842597030.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 17:10:39 +0000
References: <20240919082046.7208-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240919082046.7208-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Sep 2024 11:20:45 +0300 you wrote:
> When a Broadcast Sink acting as a Scan Delegator probes a Broadcaster with
> the help of a Broadcast Assistant, a new BAP session is added for the
> Broadcaster device before additional session information is initialized
> (like the bt_bap session). This causes the bap debug func to not be set
> in bap_data_add.
> 
> This patch adds an explicit call to set the function after the bt_bap
> session is created.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bap: Set bap debug func at broadcast probe
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ce6462eba2db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


