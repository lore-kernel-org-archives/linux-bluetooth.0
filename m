Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6D1B2EC5;
	Fri, 30 Aug 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035429; cv=none; b=dcG8NymQFE/kqKmS8ujD/ss0OUab5vREqFNzxf2XhYNgpnFy/p5/XkQ2J0pYxZexeXYwBiNp3/XRw4mKNIf1slr9l7H9DIlYoR3kNyj1s95FYP8lI0eBUuc8jJ1AlbVLGazfoOahm1eV6iOFQOPTikdzfqlUtCk/bSgGw1h5XCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035429; c=relaxed/simple;
	bh=kLwFn1Uc2Gr4pxTN+hSImb9jArLkR+hKmintZzt+71I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DDAC55kpF0MzYSqPeEA+cl6fs06kmvjiIJqAzqySZfUt6ZACfrKSnmfW8rO0A71n/qyz5wZCk4aq0LpJeNB5k/+o1riHx17jqRrjpd/iGkqEs0JGfX6EEEIyS0nhfrJT9rQblAsBOmCITYk13xf6du7M8caFWWhD+oSjulLZblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vP6eIvKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vP6eIvKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF9CC4CEC5;
	Fri, 30 Aug 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725035429;
	bh=kLwFn1Uc2Gr4pxTN+hSImb9jArLkR+hKmintZzt+71I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vP6eIvKmeYoOIZw5Qsnd2+ILYw2CBUu+RTtIg9jDh0QOc0tmxVwglFW1bl8/xp49p
	 5G8i6s6Qt9mUxDFgZN1B8gwTlzyflDAwbRGiK1pJMOz4zQsLJEnJv6g0TOaPao5DW7
	 5w4+90Np/oKZB0nVKYS+afmTdf0weF9TK+LPnRbz/gOK+XAh7G0dXhw73lW0vtIfgA
	 d4WGZavP641TQM4zISOWTcxizTZTPpUFhESKwRlaunR4+sDVgAPMA9gGd4gTVX+akQ
	 WPwAoJzuGcgN+bfh7iFLHD3X5ejA1ZFnAOIph3X78GpB7QXSq0mhqYfW2QAsgeyKc0
	 Pn7Y7gP0vFl6A==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C25F93809A82;
	Fri, 30 Aug 2024 16:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 RESEND] Bluetooth: btrtl: Set MSFT_EXT_ADDRESS_FILTER quirk
 for RTL8852B
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172503543079.2648350.6843292974799885307.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 16:30:30 +0000
References: <20240828095620.663466-1-hildawu@realtek.com>
In-Reply-To: <20240828095620.663466-1-hildawu@realtek.com>
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Aug 2024 17:56:20 +0800 you wrote:
> Set HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk for RTL8852B.
> 
> The quirk to support tracking multiple devices concurrently.
> Commit 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by
> address filter")
> 
> With this setting, when a pattern monitor detects the device, this
> feature issues an address monitor for tracking that device. Let
> pattern monitor can keep monitor new devices.
> 
> [...]

Here is the summary with links:
  - [V2,RESEND] Bluetooth: btrtl: Set MSFT_EXT_ADDRESS_FILTER quirk for RTL8852B
    https://git.kernel.org/bluetooth/bluetooth-next/c/e278dcc0a237

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


