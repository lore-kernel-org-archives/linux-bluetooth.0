Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35742511182;
	Fri,  4 Sep 2026 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541035; cv=none; b=OYvtYk8XvBzZYG3Ezkgq2/J44dzt2sh+talLiuvN6fCVYYPu9ARx5KQSBxsInm8ixWNJJGFdn41PdbrRV/FPM9u4zsCTzmEucB7Xz1Qa5orgMdemmKoBBdiVbf7InoqUKJVUDUvLhjN+sIhuDXDPVvdAG52VDmY4p1hsWJqopDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541035; c=relaxed/simple;
	bh=9hsQngopXeX/43jM/okOAMpFP6zLqdSd/duza3/wtNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dlh5cvgQSvaMcUviA2Naq+SjIH5wEmLUG5Qj/3FHXXlIMc6/iIxTSZJpBEq/23fmsZcFtP+VsNndx6gDxxNY3VYYCrBvlwEl+b48aiqZT7vDw4/HiwKVapiOuiOewn2VbZhpoeK95TiEFlNPwDt1Xec8ATErs0H/LBLXP8/+9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSgBLx+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSgBLx+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA731F00A3D;
	Fri,  4 Sep 2026 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541034;
	bh=xabdaO3IbSw3DlsVAql6lRQ1S3qSQfiJpEo6vzrmN1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hSgBLx+pijXXzrmcbzXuGbTBw19fLChxq4CrUG85C7bm1L9eBS7gqGTLK3NcUSEDl
	 0TcTqYLJxlTDXbkAq2KbLnPB/xxz+q+KYP4MVvgFuxrqRFIwl4vyQEKGsuIVKNFept
	 jdo06rO76FgiQiUXSfGLulruXOhosN71QDOF3Bs3SHDPA7oL4pJ306v4DLqNgSrMj9
	 FgoJDuGp1AQs84b7rLNQGQnDnOIpzvHgxVYe6HBES0LAjA2C+wEtzPfULDvrUTwF9E
	 brYxQxbNMZ82bELHAZFCqo7ko75Jolk9NNGHNn9B8NrFaHvty1jm/0ZMlBdJR+cw2A
	 UmIhMlIUq90/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199AB3924A50;
	Fri,  4 Sep 2026 16:56:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: add Synaptics BCM4384 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854097463.344939.15117475136422300719.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:14 +0000
References: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
In-Reply-To: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linusw@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihsin.chung@synaptics.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Aug 2026 17:27:21 +0800 you wrote:
> Add support for the Synaptics BCM4384 Bluetooth controller.
> 
> The first patch adds the BCM4384 Device Tree compatible string.
> The second patch adds the controller support to the Broadcom
> Bluetooth driver.
> 
> kaihsin (2):
>   dt-bindings: net: bluetooth: add BCM4384
>   Bluetooth: btbcm: Add Synaptics 4384 chip support Add support for the
>     Synaptics 4384 Bluetooth controller by adding the corresponding chip
>     IDs.
> 
> [...]

Here is the summary with links:
  - [1/2] dt-bindings: net: bluetooth: add BCM4384
    https://git.kernel.org/bluetooth/bluetooth-next/c/29d82dcf7273
  - [2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support Add support for the Synaptics 4384 Bluetooth controller by adding the corresponding chip IDs.
    https://git.kernel.org/bluetooth/bluetooth-next/c/9aa9447804c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


