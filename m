Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918316D325
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621835; cv=none; b=AF0tjSHO/IgD0bc+3BFyp+ht+gKqno7bi5HcUTOSByfiBHSMll3ZfjMdldyX5DLLAN0U00z7L5l9/olukU1kW4bbn3/+R0Egw3/t+dCQdphZgaXGkC0U/K6/xwWqFfgc+4J3GxjbAhNo0Spphk5zqEaJxbxYNHwMz6704LJOOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621835; c=relaxed/simple;
	bh=2kbKkZx6vhRVJft/6BhsGKiINfaGAxZhesg0JMl0Qc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FAgnw8ZyyXZCFgkYen1VMaiLerBD9s11Nl3NYzHlzZh/kX68RuwQiel8oDfntlsTQY26AOkpQG6x/n1Wvvz5JhKlkp1zEL6M1gAUXaxZFr2lzfytLF7h1ciTNtYgGvHEJeSaTbXqb2fG5zK3QSFBvmNrCXYc8Gg1JkHk4azxIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq7b7svt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq7b7svt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 540F6C4AF0C;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621835;
	bh=2kbKkZx6vhRVJft/6BhsGKiINfaGAxZhesg0JMl0Qc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oq7b7svtbp3lslrOw3cqxGs6Bt6v0M+CM9St2xg4ciG7BcwOpAhhOZkkjnLe5gLEV
	 xzyWfTay4ZrmJsXo6wQTpLQSHKXVOtv4wVXY15Ugw1r5FzCI76PgVIpNlmiTpM/k4b
	 UEF6uatO/Q070VkD8edUBFxZM+aon5rMLcUMYfjvee3KCCcwsMI+mwSL9TlVUBQQTz
	 y5kerPoOWfwbBkocA97xfIKfbYuBcpxi/7QnMYkqxtUV6xfe2Wa/dTTENrjDL2zq+/
	 jvehltiktxolhf2anJ3rPd0zlk08Lsl55Lznil2Xq5FGhopkDhM19rUNJ2kincFc+6
	 27TvJ7PVJlRfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44C46DAE95B;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 resend 0/6] fix errors found by SVACE static analyzer
 #1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062183527.19459.12201260811829548361.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 14:30:35 +0000
References: <20240710141621.64394-1-r.smirnov@omp.ru>
In-Reply-To: <20240710141621.64394-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Jul 2024 17:16:13 +0300 you wrote:
> Several bug fixes.
> 
> Previous emails:
> https://lore.kernel.org/linux-bluetooth/20240702085508.30513-1-r.smirnov@omp.ru/
> https://lore.kernel.org/linux-bluetooth/20240702134106.102024-1-r.smirnov@omp.ru/
> https://lore.kernel.org/linux-bluetooth/20240704090756.31351-1-r.smirnov@omp.ru/
> https://lore.kernel.org/linux-bluetooth/20240704104928.43336-1-r.smirnov@omp.ru/
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,resend,1/6] gatt: add a check to sock_io_send()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e56fc72fc667
  - [BlueZ,v3,resend,2/6] shared/vcp: add NULL checks to foreach_aics_service()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba70a116d971
  - [BlueZ,v3,resend,3/6] client/player: add error code handling to transport_recv()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12525371ef08
  - [BlueZ,v3,resend,4/6] shared/vcp: prevent dereferencing of NULL pointers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ffc08dd78d6
  - [BlueZ,v3,resend,5/6] player: fix the order of args in cmd_register_endpoint()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cf3d80a01f1f
  - [BlueZ,v3,resend,6/6] gatt-client: add NULL check to discover_secondary_cb()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a45038dc1e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


