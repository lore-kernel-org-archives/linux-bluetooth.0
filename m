Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA94497B6D
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299409; cv=none; b=DqK/8V1V9eyNGhhfF0keKqGJzWuy+m19zpOd2EyweyUxEBIxkAqIBmrD4QjmNJIhjmtXjR62tfQFNTuEmXUC3VCfu4yyLqa9m4Xxrz5TzQKrx+c08LpEACAhjxgUDaSJrHjsYpm2sEsKTqQ3QbkobtxdhYHLutZFXtojJaev4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299409; c=relaxed/simple;
	bh=BfYpMnRf9tVGWlJhQRaEGjiHEUFx2nfzES7DTOQuTZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=txJbtqVqbvooiV3l4LBUoVxVdjjupo1tGFL9coW5gCvFWkcrEC9a4aIeWyDCRgbMqQC8FN/aV7JUPBQRp4+R1g3WyUJN3/ZU/cH5FBzD5u5jOIFGajLxtNVXfKuAeFCKZ/HZKqAZS9/Ue+ifPlPdoAAcq/ppT8HSGJXoF6Bw6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoXs1Adw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoXs1Adw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C731F0089B;
	Tue,  6 Oct 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299408;
	bh=3fnenyZ2muygVcrCJEVG9EiqIey0WSaZFGcrbpMh6kQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eoXs1Adw+Vp6+d7/UhYl7OMsGAdi1h3SuIygyIbXzXfmYLiDHIUnM9w7zMsgUbg/r
	 uBUs7sznd+tZ1V97HddxbXwW+z5SGCNGwdtl/THx2ycOWFsN5fC05/rSulWe0wwtc7
	 HIU1/HhgbDogX0mpdxLja2J/FExLfLOs7W1tNIkmW3ZTFuXyM9NF+NxLhs0I9j4L1a
	 GuNl/KFlQ4J/t8cVzqx/jM4XV82rL7tImpPfqRGgUpu0pbEohQ8mVBpti8bNTUViRK
	 f3KANUo3SF0WwNConDR2Z26e8JP/X1ybdFOkeJqESfoPXpQMwl8UvNn9kJQSC3uRSV
	 Mi/TJOM9f0byw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13AB39D5FF4;
	Tue,  6 Oct 2026 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/4] Bluetooth: MGMT: Fix advertising instances with
 Global
 Advertising
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179129940679.2669348.4817363571989252284.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 15:10:06 +0000
References: <20261006141502.3789138-1-luiz.dentz@gmail.com>
In-Reply-To: <20261006141502.3789138-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Oct 2026 10:14:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Global Advertising, enabled with MGMT_OP_SET_ADVERTISING, uses instance
> 0 and with extended advertising it has its own advertising set, but
> instances were still being treated as if they shared the same set:
> 
>  - Add Advertising and Add Extended Advertising Data would return
>    success without ever enabling the instance.
>  - Removing the last instance would disable all advertising sets,
>    stopping Global Advertising while leaving its setting enabled.
>  - Disabling Global Advertising would disable all sets, including
>    active instances.
> 
> [...]

Here is the summary with links:
  - [v5,1/4] Bluetooth: MGMT: Fix advertising instances with Global Advertising
    https://git.kernel.org/bluetooth/bluetooth-next/c/cbfccc737d71
  - [v5,2/4] Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
    https://git.kernel.org/bluetooth/bluetooth-next/c/8c3e3b25a916
  - [v5,3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd07d6f51b82
  - [v5,4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
    https://git.kernel.org/bluetooth/bluetooth-next/c/68d479844d57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


