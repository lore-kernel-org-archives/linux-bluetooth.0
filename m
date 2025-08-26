Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D52139C9
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215598; cv=none; b=ThamSfOCZINEAzj/nQsWSVrnTKhsgemWJBYLGx0JDDOA7fTwRCLMucXhoNVZVZP/usfscFZZ0YkgOx1sVw+9nkxuKOEzmfnXstOjvzgh86rpKzeywBuSKgaRgPvXMFuypXPGeAVOIT02rnDtEn5u0K65GseQA6YAh2Y3PscHgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215598; c=relaxed/simple;
	bh=EMVDKcoImT5G2yTBtGA1ORuvaYDWLOiCavYu4MA5oY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gq5oYvB8dBRByjrQXSbYriQGqB13Ko3f+5tKz4ZuMHrToKyeoqspy7Ek9FDIpS0FURsl16Sn/LCcbxFNqdzRkyMS7Uiiqi6nxivb96bCFX6mKmm4cv5vW4KzF9UyDoTXM0RVIfgpaQKYbLwvLue+UDKD68PA2B2A/M/aY3qAvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erWTNno9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erWTNno9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777FEC4CEF1;
	Tue, 26 Aug 2025 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756215598;
	bh=EMVDKcoImT5G2yTBtGA1ORuvaYDWLOiCavYu4MA5oY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=erWTNno9UhNqhWxFBH5v5pHzqlsiNuPwJv3esIUFT4yZDJY185/IG/Br9adiO8qdi
	 P/y1YTCsIamPzmrjiIu1lGLB8aNNaZIdHUDaxIPreeiF5oJy/+KE8PgBGF4DOYhN3B
	 UVj3Kc72LenvlA2MQXR3FiNqYt5iW2FGDRuP5gSOYMkG7RCLpmQJgdRAZgUNMjGfQk
	 bU/Acy2p4Y5HHZkENA6/AULBBE2AFi4ZcCcj5bTPxXHh9yEoJ6uC5FvKVtDtQojVa+
	 F5aLVT44oNeHaiwr1mXfHYRt4sGOw/7effVRNBET5YIgK1MNlbfk8cLg1AK/3OI3D+
	 krZvAG6ASU/6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71378383BF70;
	Tue, 26 Aug 2025 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: fix auto connect with private addresses
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175621560625.4176029.14734266863951866482.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 13:40:06 +0000
References: <20250826114347.839227-1-andreas@kemnade.info>
In-Reply-To: <20250826114347.839227-1-andreas@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Aug 2025 13:43:47 +0200 you wrote:
> When an app is registered and a device gets paired,
> device_set_auto_connect() can be called before the address is resolved.
> Do not ignore the request but rather record the auto connect request so
> that it can be enabled in device_update_addr.
> ---
>  src/device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] device: fix auto connect with private addresses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa2ebfd5fbff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


