Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F12D8769;
	Mon, 23 Jun 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705793; cv=none; b=G9UKsUSIaW1QYgkGZw26Wd3i82zZ8dea/ut76h1m9yeOdCockGetWyR2fITB32XA0I3eI5Q0zk0STULyQiwYQAB4coRtBddUIid3bsH3POC3NcJ3T2EptWWdUp3tfhOT5OD/qhSl1Hjv4XecKq7rIE9xdJ9rAeufaopxcYY0oyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705793; c=relaxed/simple;
	bh=dIC8iXHT2Ton6AHWcHX7uuO0iaS/1Rb4HHBIODz5/jU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jzf2gMA4fE58UIb7DJIox5vWawpUI3eXYGRQGK13Kgy2VLw2ac3JUTCT26G3ljCmjOoDVcO4KQePkGGPUZw8ZMSj6iPxatYuRZ2J8Y30kPw0Jl63VpxrN14hpvVofvLJSORFUH2FkGUhvuFqIf+dco7X+GxgT7zXMSZDUcftGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9qX9AmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9qX9AmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2948FC4CEEA;
	Mon, 23 Jun 2025 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705792;
	bh=dIC8iXHT2Ton6AHWcHX7uuO0iaS/1Rb4HHBIODz5/jU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b9qX9AmQQ1HU3c1jCGOM4tvTMVq/VW/ypzNCIK/34qaKaz769n66FvgiFXJi9ZaGS
	 iBL+boFt2KPWUnXfcZHUcwTl1kZiQYO95BfbIDvGUwLu7HvDnycNSjMDG0j3/iiI4V
	 b4FoMSGMYP/u0M/45K6SxZNE+rCwfVRbJG0V2g84u+6rwQ/uZ+R6hZfsr1QqpsnZRo
	 ihvR/bAEmNmpVdVhPcecjNcOtHi2cT/j5lwTvFwGi8iEuCjxeb4qzs81FsAxBB00xs
	 E/WoNXqYLn9DUQsMYw5CwxmYOSWao5cZ/dVFPYr+85Dk9eITL6Dd4Bn2zerIMLBike
	 M3PIrr+budVUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E1138111DD;
	Mon, 23 Jun 2025 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M
 baudrate
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175070581924.3268784.15586224203689835626.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 19:10:19 +0000
References: <20250623091322.131502-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250623091322.131502-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, manjeet.gupta@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Jun 2025 14:43:21 +0530 you wrote:
> Add support for 4000000 as secondary baudrate for NXP chipsets
> supporting max baudrate as 4M, and are close to the host processor on
> same PCB. This mainly helps with faster FW download.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v6,1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
    https://git.kernel.org/bluetooth/bluetooth-next/c/16d150e3c9a4
  - [v6,2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
    https://git.kernel.org/bluetooth/bluetooth-next/c/03bddf7c2ed6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


