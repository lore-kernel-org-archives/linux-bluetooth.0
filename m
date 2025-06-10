Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63D2620F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749583201; cv=none; b=K9RXQ9nOnT+NWUu25uY7v0SOGuAkz9hxSxMZxvHOlVI9eHS2yc+K336evnOC9lVOGOUxXQXCehIVqaouHHRVhkEOj3EdEeLHesbLqCTyXnMDRQdda10kaHUPOFbeOdb0j80ViuDIwqCpHLDRj32WP8S0Hu1x+T4SvK39PiHKABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749583201; c=relaxed/simple;
	bh=Za0i36mNYtuKqmh0OMZPjz6/zqHkEUygb82KVl78tgE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CQnN4pjAVG7XNZGeolgVS6A9U4LMZRCgEPNL3XqErKco4aVl8EyVg0Kyrtjd7rY4nnNtjUSk+63KzF2fPcMqF7jrxrtPo/CDDi/ydYZ3lbES7+Me/zOSHen43EMKN+PU9hEqF1BZOxxbAF5Nk/R0775718ZqKOQ1/flZQvoHgTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6pqMYgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6pqMYgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B073C4CEED;
	Tue, 10 Jun 2025 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749583201;
	bh=Za0i36mNYtuKqmh0OMZPjz6/zqHkEUygb82KVl78tgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P6pqMYgRi90T0bRE1OFkBeLJ6S3SfkUGEWmBrU1oIxB4tVSjjDzNHDFpQkxz/cTHd
	 Bc8XRCH7DWQOwpPSpdnPO3jp5c+Xj4XRGnD617Pd5uNeJRfH14axoT90i+e9/LnqSs
	 jAAEpzm2+i3J+/++xZmo9DcXkUVmBK+1Nc5CxWD0agKbl9VrDUNxaywnxGyRtRr3fK
	 QjsaAnPEqpM2aTGnW+A7YAQXIcGN3L78UWv03Dzco7T8p27Gd3dwiQPb+38zPwtdsG
	 IoivUnCWA4r46EloMpC3IT4UvkaNGkofuSKZ+2Qgcu26b9yyUpOfWuswL5SZooCKW9
	 LwlaWFhF7jE5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB5739D6540;
	Tue, 10 Jun 2025 19:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: eir: Fix possible crashes on
 eir_create_adv_data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174958323123.2576109.6795975540565597196.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 19:20:31 +0000
References: <20250610142833.1048451-1-luiz.dentz@gmail.com>
In-Reply-To: <20250610142833.1048451-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Jun 2025 10:28:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> eir_create_adv_data may attempt to add EIR_FLAGS and EIR_TX_POWER
> without checking if that would fit.
> 
> Link: https://github.com/bluez/bluez/issues/1117#issuecomment-2958244066
> Fixes: 01ce70b0a274 ("Bluetooth: eir: Move EIR/Adv Data functions to its own file")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: eir: Fix possible crashes on eir_create_adv_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/2814f02508c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


