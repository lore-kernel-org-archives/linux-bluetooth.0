Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3D1A2388;
	Thu,  6 Mar 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294821; cv=none; b=lviboxwgxTjnJLEcoHFd6IS7lonkFzVHLKRF5q46R9BZ0w+XjQ1Piko5Bqu8auYud1b7hNuVWBOaQYUn5LigOZJKSdTA4Yg8GFn9wtYPHoWimuP0u3JqrDU4pqyQSUAfKTVZx/LMnJl7HaACYgiCtlZGEpiAhS0VIqjMZe784vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294821; c=relaxed/simple;
	bh=gORW4LVeTalVDv6t0vSAwbDC1wBVx5TXKWfeBqkbyVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QW3mzXE1PFzxNtkXFTuvVIf1qcEv5inGpiWWpPbRacPll00GSSGnyGJ7FYXNV05vfKKlgwFdzrJ+FCU7xx0TLRoDnFlimD8B2A1O5XP0SqztsugE5TCkz4VI/w2qUVzq7F2QYEnK8gdchU4fUeUqVdiR1C4h9KY68NglWOf8oEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmvIQ5oe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmvIQ5oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8CFC4CEE0;
	Thu,  6 Mar 2025 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294820;
	bh=gORW4LVeTalVDv6t0vSAwbDC1wBVx5TXKWfeBqkbyVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jmvIQ5oeSZmEyfBmPx9Q9x5C5bbAUlZRUlWdPDJRxb3xKjwUafjyQEMC0MI57VsqE
	 x2qMqIkEzITaah2bkQxhezxVrHJwo1pRSnKcl7HFy8Z4AOjRQIVxcQUl9JhsW/4UOk
	 61YPucFA3JTejUJ60/EenyzPrGlLP5HULANMSaCELgiqL6LrqHbwW47QKNdcFWUU0g
	 tLPEyuoNxDZ5TuHGPgCp/J/N9Xq7CuRfdu+gH+lnFfacFrTzBJXitShlFfzrHpGGuL
	 236dshxdsrG5LoBLa3+0gj3sPjNm6tghMyTOaJGPAsHw1L8FXE3pOTAQDUMmLyzYaB
	 yRm8FY5tOrZgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB6380CEE6;
	Thu,  6 Mar 2025 21:00:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 1/2] dt-bindings: net: bluetooth: nxp: Add support to set
 BD address
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174129485427.1775969.5271390106327673978.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 21:00:54 +0000
References: <20250303112752.7292-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250303112752.7292-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, ziniu.wang_1@nxp.com,
 johan.korsnes@remarkable.no, kristian.krohn@remarkable.no,
 manjeet.gupta@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Mar 2025 16:57:51 +0530 you wrote:
> Allow user to set custom BD address for NXP chipsets.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v2: Add allOf and unevaluatedProperties: false (Krzysztof)
> v3: Drop local-bd-address: true (Krzysztof)
> 
> [...]

Here is the summary with links:
  - [v7,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
    https://git.kernel.org/bluetooth/bluetooth-next/c/cd4886af1930
  - [v7,2/2] Bluetooth: btnxpuart: Add support to set BD address
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


