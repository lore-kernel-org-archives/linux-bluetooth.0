Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415124E4B4;
	Mon, 30 Mar 2026 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902020; cv=none; b=F4uaDKFl2W6csqk+xhGCnwS9qT6laX/txFVa7hBkHmGvxpY/Os9C3zh8z3bxOjpu4h3wOcKwMAk8zYDa2nk+ykwQjSvZ6IrZmr/wChMNQuUfyq8eDJ+2YJsurr9dfSLEMj6Ai6WK1NFpQ/XkRUg91TkWuZHg1gZbcq0+LuteRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902020; c=relaxed/simple;
	bh=De30MD4HVsKtgCSeSc8Ud/KNBRQdS/FWgRphaiCve10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uDahVtUFAP6Aj7vbBN0emZuMI/8vzGm246tcQfiotQz8FiseY+QjXBEYEPXXIwhilN/f0nXCYQvgd6YVf3HDK8UAZyLUZDLLU91a+q8X/24ffB1YmWGKSX/uQyqEEh17qWS5yPG5XVVToJw/h1oHoX8RV1iDwJOIBRYKOaVLn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izd48unN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izd48unN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46496C4CEF7;
	Mon, 30 Mar 2026 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774902020;
	bh=De30MD4HVsKtgCSeSc8Ud/KNBRQdS/FWgRphaiCve10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=izd48unNSUHD4s1F9wbtFmQDg/fH4svjnUwSA5PuOTmC+9qeLwau5ZDALA/dtRE5J
	 lFvTwGI+HkAco9Cx4qWSKcqmXC1R3IrNaXg/MxNBAmR8xr+/0QVJmjTG7vjgEXK6h5
	 Idipmst63L6sAeveT0/JUDMStGL7vJrkPcquxV33Dyp2JXlezhSm0hT9wH1K+DNC7y
	 uBhodnOBKOpbG0qbA1Jdn5iSMwmdQcaZofK6q5caMdt83RPpeZHS8wveD0mimGJXdP
	 0NAU8g0D1U59JDoLAZtJIygEUhhaRbmdIureiv559ip1tMWVUNyNxNZS3S94ge9K+2
	 0+EP2f1X+PQmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CED8392FF83;
	Mon, 30 Mar 2026 20:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: refactor endpoint lookup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177490200429.1507090.8195707868117459808.git-patchwork-notify@kernel.org>
Date: Mon, 30 Mar 2026 20:20:04 +0000
References: <20260330094134.1622788-1-johan@kernel.org>
In-Reply-To: <20260330094134.1622788-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Mar 2026 11:41:32 +0200 you wrote:
> Use the common USB helper for looking up bulk and interrupt endpoints
> instead of open coding.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   Bluetooth: btusb: refactor endpoint lookup
>   Bluetooth: btmtk: refactor endpoint lookup
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btusb: refactor endpoint lookup
    https://git.kernel.org/bluetooth/bluetooth-next/c/8b686971c812
  - [2/2] Bluetooth: btmtk: refactor endpoint lookup
    https://git.kernel.org/bluetooth/bluetooth-next/c/d01e702fc7a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


