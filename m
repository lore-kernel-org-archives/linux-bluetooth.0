Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61551038
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbEQhh2B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6802C433C8;
	Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702320024;
	bh=MLfsW1yb4mP4Q+UtDoixxMXXkhNxJhGSqDESUeva5kQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cbEQhh2BW3SKuTF0yGhzKbpmfIUCcVoaOuZ2u4DS3E8y4C9jEJDf5T9+/nZ3FGQ1A
	 pmNeJAft9Xs87Sb3UfjnW/os6wfmtpus5rO9Nn0a3TFocMaKI1J9+DkL36UZcuiKHP
	 XgV5Qhgg4m5IrV7X4FMrU6vb1V7pL5AfLRqwRrzb2zCOGvJ63JpHOgTQHiY+gqcIhp
	 28e6C7r5R8dmLto2OXRGRUg9iwdqIG734xa9tSkC9V+uK2kyQvwUo1sgopjzKmpC3f
	 bOWzViRjzskBH3gVcQlESfw+LNXuc5lGeqfFDNeaMjD4jE1WR/9JDFixJBrWnyMY9i
	 G8AL32qUKWg5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A11F2C4314C;
	Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170232002465.25763.975828867553046058.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 18:40:24 +0000
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
In-Reply-To: <20231211162729.1183207-1-xiaokeqinhealth@126.com>
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, xiaoyao@rock-chips.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Dec 2023 00:27:28 +0800 you wrote:
> From: Xiao Yao <xiaoyao@rock-chips.com>
> 
> According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3,
> Part H, 2.4.24/2.4.25, The LE LTK and BR/EDR link keys can be
> converted between each other, so the addr type can be either
> BREDR or LE, so fix it.
> 
> [...]

Here is the summary with links:
  - [1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d5536e0cd431
  - [2/2] device: Add notifications when the bdaddr_type changes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba9fda12d26b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


