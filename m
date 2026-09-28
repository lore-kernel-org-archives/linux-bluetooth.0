Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742D493621
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617889; cv=none; b=DniPuRoOZYBJ54RWaSolSnu3nLTsc15xrCb27FFbKXdugF0Yr+At91FKp/C8bFyjL6XraJgyimJgpMvDtt32I/AU+rv24KvWe3AjmqMqfz6QiP8RxQhu9y2RhF3UW3g66mOAr1l6ZmPQtWyuJraT/V4dJ4lR94ElMj2bdfaMRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617889; c=relaxed/simple;
	bh=2MagYxlJqRJYc2+6rCl/flfwBat5peLMtcMHiNRXFFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ye066c7pDb61mo/Yy4eafWb7ei/p9wmZhAfOM56EjMlfEPCO5ZyEbsqtgA2FQQsq1fu3ow+ABcdUrJa22wNP3CAUnzmlX/zpfZaA5xLLezKLNhFc3y+zwaakUW87cgHQ11B5ALIXtGlbSxxZeXrUyrmounZGi+7IsYjV4AiaKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmBENb18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmBENb18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB001F000FF;
	Mon, 28 Sep 2026 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617888;
	bh=Zvtie3LpoS/9zqsM6UsD1DZEMXyA6INfv8v4iQXijK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KmBENb18x9KDC/Qgd1MVSaYzjIxmg0qrCPMGsgxzbn/C35PZqiYU2aJeBz7p2FQ38
	 xOmaoFpPZkh0mw9K+s5zSboV8q/cMLVi9LFEDWSjULxgw6G0tqxZGPBsk+sThXg6ff
	 gfpHsGO8puBzFVRNG6ohbUgVenM1nYMW83IIVrw549NEamFviQ0a8VBtseQS2kdIBN
	 lzvJL8bCBWy3rWq5XdEOBCQbZvqzNN8Om5BD2ZOvfVV8YgBM08Vm37Luo/uHwy4nhr
	 FRfaCQEVn5OEGSXhvfQCKXvEWwZqIP7L7oYfp8gs7G4UIwwTE2pGvPzrGJBv1mGSJf
	 5v85rXOosYAWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197113924A77;
	Mon, 28 Sep 2026 17:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] doc/qualification: Add CSIP PICS file
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061781269.50268.16212351715366137468.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 17:50:12 +0000
References: <20260925124155.3344025-1-frederic.danis@collabora.com>
In-Reply-To: <20260925124155.3344025-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Sep 2026 14:41:54 +0200 you wrote:
> ---
>  doc/qualification/csip-pics.rst | 398 ++++++++++++++++++++++++++++++++
>  1 file changed, 398 insertions(+)
>  create mode 100644 doc/qualification/csip-pics.rst

Here is the summary with links:
  - [BlueZ,1/2] doc/qualification: Add CSIP PICS file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9066e2678b3b
  - [BlueZ,2/2] doc/qualification: add CSIP PTS tests documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7333d54ed785

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


