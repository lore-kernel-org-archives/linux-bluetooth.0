Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA192BE7C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513418; cv=none; b=oZ8su5ot72cPbbt1wl6qDSGfeljR05Qr381IbRTSMoxi6oORK6QW9s/DUJJnWHkyV+2SXpgjrcH117IHsO5Pn42AqzSk5mvN/1ixjqF9UxtS5ggdHVyz3l3NJGnnHSxxYtMBzsDUwQSLK6vMckawdb89Wm3CZAo5XiPaxfNIm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513418; c=relaxed/simple;
	bh=UWKTbhp4ba96Lwq3ngYYpku8vFKDXh8Z/rZW6q+px90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZ5h/tMD153X68wVLAY7psu1fd+EhgT+oynlNw1A22xJsCrcLoccxB2CREsR3d7p/6kazQRpNIuz+rRLOci3wzHm4sGTmV7nYmPGV4j4PVda9IywfiNGK6dYB31V82h6H71i4cHzgO2giQ+97/lymP3JQzP9UZsrQGrIpD1ptDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTTKcYh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTTKcYh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA57C116D0;
	Thu, 15 Jan 2026 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768513418;
	bh=UWKTbhp4ba96Lwq3ngYYpku8vFKDXh8Z/rZW6q+px90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FTTKcYh1VcHU68NYGGgcZE96aoVzukUUz+ZlbwxPPCQhSbZNOIMOoVwZE7+dY1RSJ
	 GPWBcJeBrC4ELlvns0fq5ZNjeDSkM/03FLVZxB4oNe1G5n2X4+NkDx5A7RheHfa5+U
	 iumOIG3MQtxoSgff8BHO00Ijw4xXr4EEaT6RCXxEA/otQxjqHUpGAZY8U598k1qLx6
	 PFH1GFhoUEkPTQvJzdAfvdsZvhz1WF7jtr3kcy3ZpNAPCYq1TvmyWA4SczVK8bTsJ4
	 wDZHJuMQDnwvub/QhEIF2mqACD3SW+DWXowU/455caCYq5dqxcUTnAkW01hSruuTTv
	 jZjM2J0AX4CIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7897B380AA42;
	Thu, 15 Jan 2026 21:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools/btpclient: Fix discovery filter setup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176851321026.4178208.146640821419019259.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 21:40:10 +0000
References: <20260115143609.12559-1-frederic.danis@collabora.com>
In-Reply-To: <20260115143609.12559-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Jan 2026 15:36:09 +0100 you wrote:
> Fix transport mode test to use 'auto' only when both BREDR and LE are
> set.
> 
> Add an empty filter to discover all devices.
> 
> This allows to pass GAP/BROB/OBSV/BV-01-C and GAP/BROB/OBSV/BV-02-C
> tests with auto-pts.
> 
> [...]

Here is the summary with links:
  - [BlueZ] tools/btpclient: Fix discovery filter setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d2f98ff2d5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


