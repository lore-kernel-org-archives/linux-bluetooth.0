Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E323E32B
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461183; cv=none; b=QmBiwBCWvrc5OPEFsL/xw6qiXU5jg3elNkmc3yLsJbyC+D3h/Pu9C7KJqTk+Mw/amzfFpt4Fyb6CibUK+l1y2X6GbdcrakwiRT53jqiO/+6qUKnKV+99/OFFgluGXSyHv59hn18II0M1IBLpBYuvLQtuzqyQOLzCn3UFuycYn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461183; c=relaxed/simple;
	bh=6v2fnBBAlm497kCRDJ4wAOdXDG1NAQzQc2j76gRF+Sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3j/M21GGt9DM0LQhHacNcxHkjzKAkFsD0E/k26EN1pFUyzH5gs8KD09ZMgKIzEUCO9+6wHp9Es7Mpxh1tK4TvsvLAsDCZ7Q/oSr92X1R9zbXsSZhP+4M34kKyPR3cumDQeduindgLbsSxuKwTJ/v2P8zrmI9WsUurjrh74tNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX8dKgRE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX8dKgRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93674C4CEED;
	Wed,  2 Jul 2025 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751461182;
	bh=6v2fnBBAlm497kCRDJ4wAOdXDG1NAQzQc2j76gRF+Sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kX8dKgREvyHrinY3dCmCVBGFVrqqvtx5GybVRPYtRH7rvyS/iIhy7c0zM5zaHfUJu
	 F0hXmmKq7Zj/dJwfrvFDRnB6v4etx7na7bPIcvoEk/aAEeZxHx6uYC7fJFDZNZxgpt
	 1X6SqEH41u7qCJu9eYdXbrMa+9TIA6IrGo7nrRS3bPeXRIebbQY3JB8F6Kx3mQYb4K
	 XqnbQtFGUq2tlJ8Y9Jh3JlpK3WKKxhLyrtstXJsgO8ZOzzJRtbGXiTyqtRqb0zpN2g
	 efs6Z3G+i1bTWfugJ/+anTbToy8z2++4d2NL1zFQ2hYXk/zdWa9HFW4S6pecA0savv
	 x5OhgmBwDfCpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6D383B273;
	Wed,  2 Jul 2025 13:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] error: Add dedicated error domain for BREDR
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175146120708.707706.15182522703175676107.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 13:00:07 +0000
References: <20250701203446.1227837-1-luiz.dentz@gmail.com>
In-Reply-To: <20250701203446.1227837-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Jul 2025 16:34:46 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds dedicated error domain org.bluez.Error.BREDR for BREDR bearer
> and then use it on the likes of btd_error_profile_unavailable.
> ---
>  doc/org.bluez.Device.rst | 1 +
>  src/device.c             | 3 +--
>  src/error.c              | 5 ++---
>  src/error.h              | 1 +
>  4 files changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] error: Add dedicated error domain for BREDR
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=248a671e5185

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


