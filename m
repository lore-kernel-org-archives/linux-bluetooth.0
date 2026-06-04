Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A93998AB
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588350; cv=none; b=A3In4fr9YdIt/TXM77UlUELovumwzicE2SypGH+GTOGurQc9KfY/uUoblJc+Nx+lmO4FzCkVmuPOEd8O6iO4GrzNJEVUYvJpWiQZjn6Jl1x5OQdn+r6tzdgDsVSA4pMvvtNoXUAuLbGpUKVZRF32LEUkldzGnJvZkPJt1AIQT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588350; c=relaxed/simple;
	bh=DDFTjamTD7/U+8jaBUUxhJGyVda4eUOX7NVKrlZfY6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bHabHkEb+YbTG+lqNg/TszDUyL3IDrsMnhWgtJZXdQFaQSfuU4gIz2tUn8ccfrVDebNcfm0xf+nMOI5AgnG+k3E+7sbvF2Rm092EUTKc3oJGzKA0rKm+8zMkjz9d92ziInYTXhe2hLpoFA3jddj5YUBadsYWRR8d/9hxsqb3VNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCkIgyww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCkIgyww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF78E1F00898;
	Thu,  4 Jun 2026 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588345;
	bh=S9amAW+xgWFUi4soW4BK/EadjRo6f16yrgfogq2kp/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bCkIgywwt7F4Ny9g2hRyH33DV7vOwQGn3cynoOedhfbwXUaONyNWoaa2tF8hMYIoX
	 mKF2yReB4CrtA1DW5WZ1E4KEtfKbJRlALwA8lubd2LUlHJ0j0EZF3S2OdXJwOBRz8a
	 M5eFHaJXmHkCJtHzPHINan22HBMTWdymGJVO6D4d3dLqujoK+OJnIKuk9ixUgyDjuP
	 wTJKYeYsLTg13A+S7qnmkdRU2B0yLk2SMx3ewOm3rKPQoB1iZLC22tau7Gslq56w5S
	 4uyWJOKW3IftHuleDukQoeys/DQZmpSMfygMvIgOQqAbm3T7NN5rbuLa+rHvNceqvK
	 P0y+V8VgFzHDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990F39309B7;
	Thu,  4 Jun 2026 15:52:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Add support for smart trigger
 dump
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178058834564.2488052.3262071716807569421.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:52:25 +0000
References: <20260603155415.50855-1-kiran.k@intel.com>
In-Reply-To: <20260603155415.50855-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Jun 2026 21:24:15 +0530 you wrote:
> Based on the debug configuration, firmware can raise MSI-X interrupt with
> firmware trigger cause bit set on specific events like Disconnection,
> Connection Timeout, Page Timeout etc.
> 
> Upon receiving an MSI-X interrupt with the firmware trigger cause bit
> set, the driver performs the following actions:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Add support for smart trigger dump
    https://git.kernel.org/bluetooth/bluetooth-next/c/b08dac7cce62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


