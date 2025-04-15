Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D223F296;
	Tue, 15 Apr 2025 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748402; cv=none; b=koDrsaMjtwnPmf3zUHez9jN3qKraPeM68DF46I3UL8jvP6vFZa2eaEIlnFDX2jJj3arI72W4Ozughx6TXVJXJR7/EK1XT1zIBSSSoZ2qmwgH6Mxd7uzcZZuiAXmsNM6yg5KE0nP+GFaRE4dcp87oGErYq8W/4MFgrQj9uZ4xaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748402; c=relaxed/simple;
	bh=BTVHxfwszv+QzVr8FjiW30VF6RoRPkqcT3VCI2IXrEY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gmKQDyaDN4JQU0HY7DRDx/Col3CM0Ss1olCJ5dY/eTXW2ZxALUZD3Ev86x7pGJCQ2Bdb+kE6K9iBa3xHMyw+kp3NOmTQtucoY+Yr4vvt9ylmJXCkhzTLoYjPFyy8UKNXINo2bCpm58sTkDlu8IeyvU6CCqMFe5n6DXgmskjz0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHc9hdjk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHc9hdjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFBDC4CEE7;
	Tue, 15 Apr 2025 20:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748402;
	bh=BTVHxfwszv+QzVr8FjiW30VF6RoRPkqcT3VCI2IXrEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LHc9hdjk+eSBeP6RmnrXBGbMJvOWZKHymnViEIyWOQ9DxguglAt1hc9B56w3CT2B+
	 HRIU7mrRfqX+DX5riDt10ND7pD9AxOUCQHJpN8ca2RoyKwTbcgme6fDqwcdwwUKv4Z
	 lfn8KoatbWLl6uNrcsvnEds6Tc1jxQvjI3Do09t32FNv4SPKuv8okxx5bUcahjZN/y
	 2/fTEU22hcvvNjlj7xC+xbkPU+VqHZGSwglmpz6oKcP8R+7ln/gh3GDYT1J8+ffYY3
	 FoI2QxCqHHOl+2/gqJ6jqc4xxFM91C7m0U/V0AzGEmw/FwU91d863x4362njB3ywB/
	 QAh+Tb6FAbt8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E733822D55;
	Tue, 15 Apr 2025 20:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 host-wakeup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174474844000.2765712.3519619421796978194.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 20:20:40 +0000
References: <20250414175952.403002-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250414175952.403002-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, manjeet.gupta@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Apr 2025 23:29:51 +0530 you wrote:
> Add support for host wakeup on interrupt.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Use interrupt instead of host-wakeup-gpios. (Rob Herring)
> v3: Fix errors in dt_binding_check. (Neeraj Kale)
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
    https://git.kernel.org/bluetooth/bluetooth-next/c/f68f62f57917
  - [v3,2/2] Bluetooth: btnxpuart: Implement host-wakeup feature
    https://git.kernel.org/bluetooth/bluetooth-next/c/75ca28852d29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


