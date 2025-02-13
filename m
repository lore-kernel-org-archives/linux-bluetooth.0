Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA615DBBA
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460611; cv=none; b=m2vr6+6gu0e6mAt6Ub7g/vhbec4mzOQXC9JkCVolz3nCoDQiOqcIk42WhTHvzYo568G9p2r8nnmUZhwxYODIpBU5nGizKLzk9Hc3ZbQ0Ok7njQxxnX5bYYdJRpjVYcxaZ8g/TUAMasCDTPSfnSytT6u9Gt7DJ8zti4XA+w1JQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460611; c=relaxed/simple;
	bh=91hZd4jD8dVQ5qCzKAQbTyr6XRovq8+AD2DXW8Ak+Lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qbfcAokR2FjrLfJ8ihXPrIAYPYKjpY45nFBX5KZa4uAUwOaXib3+o9g9wq7oHWVdbbqwGce7zM0iaLTOYrFplDyFANeT8Gd8MHW41ji6mpyHQbNDEVDXZWjHrgpZ6VhlWPCHwCFxbmiI4AxD6h8aBEYOzlHRPg13DcvM41H6US8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL8yFwVd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL8yFwVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86647C4CEE4;
	Thu, 13 Feb 2025 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460611;
	bh=91hZd4jD8dVQ5qCzKAQbTyr6XRovq8+AD2DXW8Ak+Lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XL8yFwVdL+0J34738Lw/BtkBzy/YTxvWGe6Vk1RAQpBI9rW6x5pvZvK+znEAELl70
	 q4V5TWtGMlyJLK0WuIlgDaSIQL0JCqjkeHBcNx064rdNO39OJ8nVLXcTeUOVyw9tsf
	 z/LU33AzOLdweskdk20N4QYAO6cLLCZMfsmDTDQEHnEYdsz1MYgY0FQQ8HXJ2Hv4gT
	 gHlfskbDky0Xpqk52MGaoPy7tmKfmC4Mc9eVQuEIIYt2qm5VwaHivIjcExZoqIxN66
	 WThX3xgoux7rahJAIdvAhTlB1fdOQxp7U5p2eNp+KYmBcyTOIa3cfMR197w+ikkWpK
	 q6oNlsUI4cnqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA9A380CEEF;
	Thu, 13 Feb 2025 15:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] btdev: Broadcast EXT_ADV packets based on its interval
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173946064078.1268037.4775776249401973438.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 15:30:40 +0000
References: <20250213122952.138986-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250213122952.138986-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Feb 2025 13:29:52 +0100 you wrote:
> Real BLE devices transmit LE advertisement report packages in given
> intervals (typically in range between 20 ms and 10.24 s). With current
> kernel module Bluetooth stack implementation it is possible that the
> first LE meta packet just after enabling scanning will be lost. It is
> not an issue for real devices, because more advertisement reports will
> be delivered later (in given interval time).
> 
> [...]

Here is the summary with links:
  - [v4] btdev: Broadcast EXT_ADV packets based on its interval
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa4d477ab535

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


