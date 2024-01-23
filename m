Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057F81ACC
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035285; cv=none; b=M2X1jmtWyHeeJG3BYFdiHC97EkQwZZ5d3RTm8NY9JwjHjngJyVLNZB97ScKUE1UJDvyqz4V9cE0n2RIF0zNjL4zvNDenJvradlFLtHMAWjQ3pT3+GInGTq1C35sFhJyb93AVVf5RzbLg+IhzAs0vnWmCyr5B+TrX0oA7zaqWY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035285; c=relaxed/simple;
	bh=Nt31G/wavNp6AJFlBRL3O7s/21fty7hWfESZv5OdV9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CYm5BW3XOlgP+XxnwNMHVb6aVc9vS9LH0p2RVPfnooOEUlVoSPFTEPTzIqGMULjAQehzZJ0WJ1IAUU8Bc3PVKE4W+t+6UR4RIxOWwFBWSI7Pt8Zsi+gZu1WwP7YjJh9y/ZZlJgAC3jxx8uWCyufRCRMu12Vtk6GtcTlZtH6/KJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPeWMawJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPeWMawJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAA9CC433C7;
	Tue, 23 Jan 2024 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706035284;
	bh=Nt31G/wavNp6AJFlBRL3O7s/21fty7hWfESZv5OdV9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZPeWMawJrDjsfabfwBLDlWg0KmUw44SyvsYHuVVYxLgVRysJ8DDyMAesyo8hPxmdN
	 IFXjPQMhxTTHwZqXS5QzcUlDi/2dvXIOjGFwbPESnN1EHIrDhvY3rkCLUrdJ1tTvgW
	 Cf7ZOyJElUw9B6v21/QyXKMCJ3OfOamuS1s7cwaTxZq/2TgeHa4Ps2y/OoGt/aBAZw
	 t3r9RPx6qY1bsbnaFbGIvprR1fugKAY0PJkJjKDsVPswc+FzTdhsB/N94dL+KB1RWY
	 xbQNsGxhu5HH0QTkUxZmYX4TfQnbUS+kXmdjCvR+IXlRx2nVt53Xu+cBC3KhLaPfoX
	 mqVaBa0UpLPJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0455DFF762;
	Tue, 23 Jan 2024 18:41:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/3] Add code to support dynamically generated BASE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170603528465.29536.14545199730796417084.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 18:41:24 +0000
References: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Jan 2024 14:51:42 +0200 you wrote:
> This removes hardcoded BASE from client/player and adds support to
> dynamically generate BASE from preset provided when configuring
> a broadcast source endpoint.
> 
> Silviu Florian Barbulescu (3):
>   shared/bap: Add code to support dynamically generated BASE from
>     presets
>   client/player:Remove hardcoded BASE for broadcast to use presets
>   bap: Use the information in SetConfiguration to generate BASE
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/3] shared/bap: Code to generate bcast source BASE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e4a35bc1e2cd
  - [BlueZ,v4,2/3] client/player: Remove hardcoded BASE from player
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba943aadd0e2
  - [BlueZ,v4,3/3] bap: Use SetConfiguration info to generate BASE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=15e7d5a4d24a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


