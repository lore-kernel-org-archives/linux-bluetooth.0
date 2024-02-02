Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4219210E4
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887231; cv=none; b=kxrqfpywuHNXWEX9vCgPtNTPKbKedv7OgreSkXqDgQs8+/soOc4XoL3F4RBBPlLeszYsFkvDSaHXcZ39PQioy6br6tk13RbclNzCeLf+EWQP8AFLxLpqK2FRg72W9lU8YHbXuRmHcGMyvdO2I58jxcetsAM13rKk3rEm+AR7SLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887231; c=relaxed/simple;
	bh=2L8WN1I6K4OY0yWZSNR/Jmd4V5HiiNVaxFXYLZBdtTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jkWTg/VHaprgPHHrj/zPt199r+i2FJ4uGANSblsfB+Ypj+XOdFAU9xa2WZnbyJ8rqqqIi5CfjGJpabOnZ9eyKAXakMHSHWPtEd9PtPVVSZwAKLKV0xv20IC/lOgSSXXTK3wK0pc07ig4XCjUQlI+Z0jP2C3tM94nlwrLE98+XNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBONnSHp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBONnSHp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36D35C43394;
	Fri,  2 Feb 2024 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706887229;
	bh=2L8WN1I6K4OY0yWZSNR/Jmd4V5HiiNVaxFXYLZBdtTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gBONnSHp2tXcIgGjT7fN7JPUaZSnq5ipiWlTvp8CDMJIYRL8sg2H+0tlWTbPNjk4s
	 l+vnd8OmC8oiQEqi8OkBtvksvMb+dCl729IMSpNtkCfaULaVMgzybDT0A0C1o+E+3z
	 lJPz9cOfJurKxyj7gGVyTswi9bNBe8nBABM4/0MoR3xeKXmW2IxsyMKNoQ2arX9Rjb
	 rmZvBsVjRRAglZG2/ZOU16CXUJ+AUoSTMfgjcLIdlKZ6IXGUhY6kDO0g3dGDzO1so5
	 g3/7k0oFBxb7WWV8qFm40GECR9Rj7PzgflUiH0Gq4HvA/qZyXwCB0WYzAAF8UGSN3b
	 kaAmbQENvElqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2132CC04E32;
	Fri,  2 Feb 2024 15:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] BAP fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170688722913.29555.3991548366771367647.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 15:20:29 +0000
References: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  2 Feb 2024 16:10:33 +0200 you wrote:
> This patch fixes crashes at Broadcast Sink cleanup.
> 
> I reproduced the crashes with the following setup:
> 
> [bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
> 
> [bluetooth]# scan on
> [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/ pac_bcast0
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] shared/bap: Properly cleanup bap remote endpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=29dee7b54303
  - [BlueZ,2/3] bap: Fix incorrect parsing of caps and meta in parse_base
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=35032a6075c5
  - [BlueZ,3/3] bap: Remove incorrect assignment of listen io
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=05efcccdcc5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


