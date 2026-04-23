Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B631E85B;
	Thu, 23 Apr 2026 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973244; cv=none; b=CYLPE/6b6p4oA3Jzn50YWyPjeNV38pR///IgBOnNVPmLW69/qO7ZfY6ZndkNwo/xHgG4ysE6DH0X7B6oGSAhy9C/7ZQgaic/hetytQ4xmjbsy9JCfaBCbmP/VBq/rK80UKlxZr0Ywmz5S1F0hNJo5LaZb+zQBksJ9tNAI7Ozpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973244; c=relaxed/simple;
	bh=sgBRUR3Uo1wvMCKYnLrpPwt2H8BQAT+V7WanqXMgtLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=czTYN8tSZ6aYMaj6JpSvaxzZPAkRdBasJ96R2WKlWp79WCydPNB3fp+i0lVzMTwWoF1i7mZUustO3i48Hfeh6rWY+fyny2NpJFCebYpSOLl2EMo88Je2Sq2frVK0pTSH5g/NnzMWtc721crBVjCiEXmUVfAg+lZloZSR3wdRvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZaOt3VJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZaOt3VJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DD5C2BCAF;
	Thu, 23 Apr 2026 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776973243;
	bh=sgBRUR3Uo1wvMCKYnLrpPwt2H8BQAT+V7WanqXMgtLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DZaOt3VJZDk5+RdnIffUhQFprwfD4pW+sl5H/7Ax2tOma7LHvstnGGyVYip8uqwoW
	 mw776mXSZ35ZINmbgEKuN7SqWm77CPIzRP5kAF/hQeB0mpU2Xm8132wW+D5PH65xal
	 ECM22CsxUpcUdsCJJmqlFi5bnz6JWF7pU6tfty2mTKRNbBu5wLYnTstlxDC60XhAae
	 DF9A4FnYexwmWhsl+06+7aXALZ75YiM3nF7j8qBMFCIQUrY5576N9n+uIWYgHVfmpt
	 20eyuL2bXtfZPDxwg6pW4+EDb3sKK/ME3wIXr3UInTX9pZqLONRqg5SgV78k9j6Gqs
	 aG94YljaMXT9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE793809A90;
	Thu, 23 Apr 2026 19:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add Mercusys MA530 for Realtek
 RTL8761BUV
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177697320505.737023.10944769967331956271.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:40:05 +0000
References: <20260422212647.62497-1-hrvoje.nuic@gmail.com>
In-Reply-To: <20260422212647.62497-1-hrvoje.nuic@gmail.com>
To: Hrvoje Nuic <hrvoje.nuic@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Apr 2026 23:26:47 +0200 you wrote:
> Add the USB ID for the Mercusys MA530 Bluetooth adapter. The device uses
> a Realtek RTL8761BUV controller and works with the existing Realtek setup
> path.
> 
> The device reports vendor ID 0x2c4e and product ID 0x0115, and loads the
> rtl_bt/rtl8761bu_fw.bin firmware successfully with this quirk.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV
    https://git.kernel.org/bluetooth/bluetooth-next/c/0105c3e2a97e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


