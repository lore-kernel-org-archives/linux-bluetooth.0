Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C144C654
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919668; cv=none; b=CfqpDH4IflSYo8j65FLKnmfbO3XWgQo/behXgUbZvlAVD3rOUPhRV41Ypmik0A17/zUXEl0RjtRQYlimhSIs85Ky8/7jdmOGr1MkQxkZyY2z5Yffbcq13g2R5WPuitEzBRl7wZhHnLd1O4cqiKOl6Nl0hr3C8BkGe5KEE6iQrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919668; c=relaxed/simple;
	bh=SKkjJBUpG5W9oZHN4tBRpsY6Cz5p/KRv/dSq7Yeanyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BKO+f2BK3EN32bPYtCBUA+oL8ZTWJDxxwPXk6MdzLbi4fORVbvIKtu9DDflO7MYZkYs3KJ5NjO7aWl7ggvLNc/3NyoXzs5mtNp5kLJwx0mpwJnpzjLwsNSleGbHHUFNNwcThzdUURAoCJNS0XRuX6EDRi6pXKRpgEdOk8mtGR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuO6VM1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuO6VM1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69721F0155A;
	Fri, 24 Jul 2026 19:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919647;
	bh=P26FdUD/7obYzUu6h1Yj2olB43dSZ+VHfhYDyny6qII=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MuO6VM1K1DXkzu6q2vEnny8mSEwrB1J9DX8hTFXKoJx7OG51+zpWYMCxZSRglL7ap
	 V1MJIxZO6/SyeKweRH9h1nU5HxpWuqwtM2EFjsYaeffRYbqsblY9vwt91fbB4Kjahf
	 YeFF51TcbOptIPS91l0akED21z7BdktlgHUz3W7TKUg0T75XGQ9Aw7/w0kMWKGMv8N
	 ASTtznVGPzFHpPwwh5bub3dmBwBST0ZL31IDkm7vA2S0l47ySsPRy5/AVmvn0dTo4Y
	 Abk01TcS9ABe8f4Y1fS8rQLnOn/R8QBeWS+TQjCx26CZ3blDAXRH3RT2A/ecRd5DHa
	 aJLh00Y1EBVQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568AD380CEF6;
	Fri, 24 Jul 2026 19:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: fix BT dependency for submodules
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178491961489.3273549.13331653859389655101.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 19:00:14 +0000
References: <20260722130849.7813-1-iva@yenya.net>
In-Reply-To: <20260722130849.7813-1-iva@yenya.net>
To: =?utf-8?q?Iva_Kasprzakov=C3=A1_=3Civa=40yenya=2Enet=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, xrabek1@fi.muni.cz, xkasprz@fi.muni.cz

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Jul 2026 15:08:49 +0200 you wrote:
> The modules rfcomm (BT_RFCOMM), bnep (BT_BNEP), hidp (BT_HIDP), and
> bluetooth_6lowpan (BT_6LOWPAN) are dependent on the bluetooth module
> (BT, tristate) only transitively through the boolean BT_BREDR for the
> first three and through the boolean BT_LE for the bluetooth_6lowpan.
> Therefore, the modules can be selected as built-in even if the BT=m.
> The combination of BT=m and =y for the said modules leads to the kernel
> build system silently ignoring those modules, without ever compiling
> them as built-in or as loadable modules.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: fix BT dependency for submodules
    https://git.kernel.org/bluetooth/bluetooth-next/c/646d8e385271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


