Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D926200132
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339794; cv=none; b=B35YtC2LJBSDg1GfqLqfhjml3BrDIIZSsIgh5n2TC1FjyBzjVis8feOox6rjPG3dF4m1Vm4cVmrUpQdiYZgIzlj5B3mQe6c6k2dB5u/3YWPXj1JJU36KX2RTuCBx5DIxaG0toA37VEN8AzVuhg+0zoCK7o8V7DghycNJS/LwaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339794; c=relaxed/simple;
	bh=PIEkHhjZwBIrBxb+oImxq/QtHymDhQRTgU+Tt6jga7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NP14tCsGW7q6MZEFsyLehbujub9LQZwFEXt2v6tcwrBVZ0Lzn/yR0NCAZ/bUoJ0FU3yHFjb5hXsLyrUuOx7tx5szgXawXZN6ohKH9lA7YMStwwFvxw8wo6u9hPhYCdbDfky4mcXu9c9B+1HLw0HjYlATDCn3nr0HV3WIwgtWvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl+5DC2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl+5DC2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B2EC4CEE7;
	Thu, 15 May 2025 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747339792;
	bh=PIEkHhjZwBIrBxb+oImxq/QtHymDhQRTgU+Tt6jga7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kl+5DC2XT9OuTTAOYMOmGoBJJNbH523hXyadw+eNDTv3d0sMFTPWbNjy14Sk94dYF
	 yOLNyfo3jwhITBSEF/TOKnX8u4fipw3D0Zt+G1Btt4bIESbBtRaij5OSV1ok03DoPI
	 Zz4xhfSKlSdawFDkHk3hfGjr6RqY7vnSj3zQvbjSAAfcRIeFi0pa/Kpq5zqf9NnXCP
	 36+CXMLNq+yFOd4R4dxoZYo6+D1PWENbBFvxHE/J5Mz49GdBZ/uWKi5GAzljOdCklI
	 TJjltq8EYBxApOJ5y0rSoltd4uuMH5Xd6aTpwHtvJLiXtLExufeR6RBeBHFNENrmma
	 76TT3r1MQgaZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADA33806659;
	Thu, 15 May 2025 20:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] device: Reply br-connection-key-missing on
 connection bonding error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174733982976.3234907.15623202795049448255.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 20:10:29 +0000
References: <20250515163448.189497-1-frederic.danis@collabora.com>
In-Reply-To: <20250515163448.189497-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 May 2025 18:34:48 +0200 you wrote:
> Currently when connection is removed while the client is waiting for
> Connect() the failed message is br-connection-canceled, even if this
> is due to bonding error.
> 
> Implement to reply with br-connection-key-missing, when the connection
> request fails due to a bonding authentication error, allowing the client
> to differentiate connection failure reasons.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] device: Reply br-connection-key-missing on connection bonding error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=00969bdb17ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


