Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A082899;
	Thu, 10 Jul 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154783; cv=none; b=gMxnPLuShiWAz9X9YzsIwvRX4nEGbbUQKml/srUPRTdAbHXP6MxHfknPCzoOPcj/sPJXzXgN3OWlQH65Tz51SVQJex1mtmEQQ4Pn7x/Iy4Az3URUbW1A78twFSYeKqx+nBgg3Kvu4z2NGqQRCYu2QmIrQ6o9aU9DM8TR/Xf7AUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154783; c=relaxed/simple;
	bh=hpjqH8X5i6AmridXNIySZqrp3EDuij8q15mmyoIDiPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ETiNa+/MZZYdUAVTEy5vxagll+zFy45w+4ncfEraD3xjEkaoSdRn6hAmHKrRpYOjpANS0mH7FMQreIubZIukaOujqbkfo3H2lnjHhlkIjkP5bBmc/SuChlXomRf65+r86waNh8miCKypZJEW5LpjDgP42UXvWwSc8dKgzTXVY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt64iVkC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt64iVkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A25C4CEE3;
	Thu, 10 Jul 2025 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752154783;
	bh=hpjqH8X5i6AmridXNIySZqrp3EDuij8q15mmyoIDiPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pt64iVkC9rVL8lbvB4aubSGyVEK42TNwlTEHHyOKi6lKkZ+BJntGMpUBsTwmgAJSj
	 +5+UeN2E7kKwJBAOxq0OQhhc0zzwnSNyUDawjqvb9yIZpO2cpLQot9CB+KDBv2OT9o
	 caZ8aFdkow/C8bV82jO05HgaNpMyLHRVc1bTxiDU8muvFEZ11Y9V2IRX83d8DaDFHG
	 3SlER48f6hwe7LFELjTzYy+NOapIR2HSbtZ072swUFtqL3rrtOEfP8bXE/lchV8Vic
	 whCwHroftOejvA+N1bCacHs1wIhOcZQZIW5BVd/qjq7jhglnNkSoGIdovV1Plv1PSf
	 1Ks59/COZuZWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE186383B261;
	Thu, 10 Jul 2025 13:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next v4 1/2] dt-bindings: net: bluetooth: nxp: add support
 for
 supply and reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175215480543.1497178.3228150604167061799.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 13:40:05 +0000
References: <20250702114105.2229008-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20250702114105.2229008-1-catalin.popescu@leica-geosystems.com>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 m.felsch@pengutronix.de, conor.dooley@microchip.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Jul 2025 13:41:04 +0200 you wrote:
> Add support for chip power supply and chip reset/powerdown.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v4:
> - rebase on linux-next tag next-20250701
> v3:
> - rebase on linux-next tag next-20250409
> v2:
> - rebase on linux-next tag next-20250227
> - add acked-by
> 
> [...]

Here is the summary with links:
  - [next,v4,1/2] dt-bindings: net: bluetooth: nxp: add support for supply and reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/92b12500ef1c
  - [next,v4,2/2] Bluetooth: btnxpuart: implement powerup sequence
    https://git.kernel.org/bluetooth/bluetooth-next/c/366116cab739

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


