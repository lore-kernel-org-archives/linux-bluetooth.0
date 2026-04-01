Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BD40243C;
	Wed,  1 Apr 2026 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775068221; cv=none; b=OFfvImC5NLRBbLNBriLXDgqWbOazr3u7/65whvDotRcwPWtHeLAukOollVVZ0XPxBg32CI1/6X10vBMtAyZpmWLIXx0jkwq3N4EhmXEef2IbTC26IG3ULhy25yUO4nZn1/8PYJZlYNW4+nXm+MwLH8b85r++tCUK5kiroQitpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775068221; c=relaxed/simple;
	bh=3n1VRJk7W1aVTtGMSinVRkfsNGhmE7mHhe3GVwXdwcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZGmrG6aFEgEuhWuu1yvF/LSVBy/qQI3Yd9zTEIwdsrQdi1jpv2airGCUBDCcKRha88Oxcda2xflhzDNv7ZSyXUi2AUrjY/ujhutMsIW6ywbsYwyYeEqc4VzB8EfjXpP6Db2sab1A9CuPCT1uOnS/9gPzcBnfja6m0G02RV5zFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VezQ2fxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VezQ2fxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69713C4CEF7;
	Wed,  1 Apr 2026 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775068221;
	bh=3n1VRJk7W1aVTtGMSinVRkfsNGhmE7mHhe3GVwXdwcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VezQ2fxlHPyFZpNdOKRb5lqn0FON4/7IakPNbyeDaFiJdvRqYYrjxuCT1XjGauVxT
	 FncpN2gQiKCRXFyvQNEEgXug1aXQ6mhut70Wm3QXXym7ZDkQBwiMBEMO/uR0CJimcb
	 o+KHzLIhA7cEVUSYodymUVyUf4ycuIblWV+9Eg7x0RWRUx+CM6PMzR8yCetBWaaZg1
	 fxymyXJDQteZCTSybwYEjvKWS2iSIlEaL/Lw4Qnr8JdXWUV/Z5BnDBKSjq6Qt2sS04
	 e8T3PgCI65VJj2b+nzlMY1EI0tULnN4qKQps1/zYBcdH0CnjtxBZu/ml4zWC3n0nhP
	 kYjfdtJRYLFPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE813808203;
	Wed,  1 Apr 2026 18:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: MGMT: validate mesh send advertising
 payload
 length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177506820429.3813163.15864121769222548802.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 18:30:04 +0000
References: <20260401142532.332943-1-keenanat2000@gmail.com>
In-Reply-To: <20260401142532.332943-1-keenanat2000@gmail.com>
To: Keenan Dong <keenanat2000@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Apr 2026 22:25:26 +0800 you wrote:
> mesh_send() currently bounds MGMT_OP_MESH_SEND by total command
> length, but it never verifies that the bytes supplied for the
> flexible adv_data[] array actually match the embedded adv_data_len
> field. MGMT_MESH_SEND_SIZE only covers the fixed header, so a
> truncated command can still pass the existing 20..50 byte range
> check and later drive the async mesh send path past the end of the
> queued command buffer.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: MGMT: validate mesh send advertising payload length
    https://git.kernel.org/bluetooth/bluetooth-next/c/2c12536623ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


