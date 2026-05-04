Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946723182D;
	Mon,  4 May 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914657; cv=none; b=ffqgPPozymVD58B6CBg3v/3Oq+okCNi2vzNFxyMAKpJd9L5rclooL9/eJ0AT4oRycigiHw2FpS3DcRVvw1UlSISavLfVSr63+boVKVHNXzFlCUwrjs3IUQQCQfTRtcSzx0yg9akzsSgai/+4NHLc4Qn7UMFgI48LglnI0d541yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914657; c=relaxed/simple;
	bh=D4YhOgBZNTxSJowFxaFazJ1bXvvGRxwIkaYlBW/yE84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNTMlCBe4w/jViUZQh+ZpmvJ9ByRIJD4t4hZsNQsat1KDOhUzOoTzsZatLRziQNdcC6S5A6Y7kDLjTfFfj/S8dfGSpEJ6Nh6rSU+z1S+r54z+eIyCs+5XKELlKFYbHzTkUSyVaIu+9LwztoTrkZnCj1MTbD8vX8T9fdh8/CmwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdNQUORG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdNQUORG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80E1C2BCB8;
	Mon,  4 May 2026 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777914656;
	bh=D4YhOgBZNTxSJowFxaFazJ1bXvvGRxwIkaYlBW/yE84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sdNQUORG+YvusuuJqsUEqZFHT1hAPFYumnyvJHd9nLn1QFY0lbSxfbfcXnZ5WflSv
	 e4BfetDgMtLBWXo7U6FxWao+A6oMzjVV6+eVY1qbPrccrEbATFjEH4eUFboy2xuGMY
	 VirGzQPmmXYXi5NKPSlgAmHtQCY2Ht3Zgjwz5eL5cKePVZQ6fh2zMcY4PoOfGdHL28
	 oYYn+HnAvJ+gvffq7DQvPVzs9fCwZLqYC5yxZIufhCFyAkTRexzsZq5kNJF0w+aiTD
	 RtPh7ZDfCuQJBCAioXV2lCbiB19NdFPlruPOdI9qJs5HDEBzwFsPm4fhIR4vOMFNp6
	 W5ncAZsPxC1PA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1C3930032;
	Mon,  4 May 2026 17:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177791460780.801187.11382504961071070541.git-patchwork-notify@kernel.org>
Date: Mon, 04 May 2026 17:10:07 +0000
References: <20260429151343.28142-1-alexej@sidorenko.cz>
In-Reply-To: <20260429151343.28142-1-alexej@sidorenko.cz>
To: Alexej Sidorenko <alexej@sidorenko.cz>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Apr 2026 17:13:43 +0200 you wrote:
> RTL8761B and RTL8761BU devices report HCI version 5.1 but do not
> support the LE Extended Scan commands. This causes repeated failures
> with Opcode 0x2042 (LE Set Extended Scan Parameters) returning -EBUSY
> when BlueZ attempts extended scanning while a connection is active.
> 
> Set HCI_QUIRK_BROKEN_EXT_SCAN for CHIP_ID_8761B to make BlueZ fall
> back to legacy LE scan commands which the firmware supports correctly.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan
    https://git.kernel.org/bluetooth/bluetooth-next/c/89edeb1e260b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


