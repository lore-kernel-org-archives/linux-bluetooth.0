Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8B3C09E7;
	Thu,  4 Jun 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601404; cv=none; b=KKKmdpg754tx+qf+//WzkYYsUL9CSuxKfNeuxub7+zTqT9haHNxpBQRMpyFXQx7SSv+ndFgJCQyiJqLPG5kswH6+AWZFG6nqKsgX1kcVmd6R7GoYy4qT72R/aw9S5t0IanopRab3WFjMoAKbHen1AF1r/fcdB0HsjbH/MgmcZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601404; c=relaxed/simple;
	bh=5XJfN+kpYzQ0R0WO0s0fSxfgPncy8zFT7dWnc4O5DAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SyXth4TUzP3H81ZfSNDxpUGA5vbjcB44xDAhVTFbx238VwxjQh3rQvTnFzYtrZgEHRRo5MvvEhpUoy2hbFjEwNvhLhx6qMKBgzpyPUH/rrZETqxL4OwsMA5/BnPWDSM6fhmBirpQxRKK2kz7NqwPcXHblJlUzwM72tg5rB4wMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHbTtFFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHbTtFFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949B81F00893;
	Thu,  4 Jun 2026 19:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780601403;
	bh=gndSq+aQU+A+JoBb8rEfmEv4rTCNDJOrluBEKlY/vM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MHbTtFFWAsBEDfj+uSHXj3klzyPmhcBQY3vTmnKRrmgrUJ3FFzBwjGhRyBOi78ZBu
	 q7IDZ0FMTsg93PHOpfUWcQMJ+yjtBsemX4m5BLHczhmOLEaPzklIlcyoLsQmJSPb6F
	 FG31xAUuV44CY/D0DKfDtm9b6b1tezPggGmozWREEKl2bSCMhO7ZS0Dj9s5IHhTeNy
	 WqpdSthl+3hqp+RqgCId9XXRsbnvtdkHyJ0tcEbfsmf1O4RShz+KSRo+vgVwoPtNDj
	 aMyqRimQos/j0TxDRHizATHbcnh4evLE9GgjAqMCPXbF5Dxr7FYZobVPMvdMXIEWlj
	 ICghubDB7qrYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AA23930A18;
	Thu,  4 Jun 2026 19:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Add SPDX id lines to some source files
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178060140441.2988649.4114962772148712857.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 19:30:04 +0000
References: <20260604170633.730139-1-tim.bird@sony.com>
In-Reply-To: <20260604170633.730139-1-tim.bird@sony.com>
To: Tim Bird <Tim.Bird@sony.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, jannh@google.com,
 kuba@kernel.org, kiran.k@intel.com, chharry@chromium.org,
 gustavo@padovan.org, prameela.j04cs@gmail.com, maxk@qualcomm.com,
 tim.bird@sony.com, linux-bluetooth@vger.kernel.org,
 linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jun 2026 11:06:33 -0600 you wrote:
> Many bluetooth source files are missing SPDX-License-Identifier
> lines. Add appropriate IDs to these files, and remove other
> license lines from the headers.
> 
> Leave the warranty disclaimer in files where the license ID is
> GPL-2.0 but the wording of the disclaimer is slightly different
> from that of the GPL v2 disclaimer.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Add SPDX id lines to some source files
    https://git.kernel.org/bluetooth/bluetooth-next/c/ae283ad45b1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


