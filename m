Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87126AE8
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767229; cv=none; b=Mlg/BkkNY7BAzakV+2/zM+fJFXDiUONdqePg37XzFzPR9/4HtJ3PFrdYLQZTsG3ZKGiyFHfc/6itTLDK2LUK68CWNhV4FiQz7s5tFYJwC7+b48ItZP5WXVfxg76zjIeAlIdieD+6Drd148Mo/zFgTulO+mDbKOPzqLTtYjydBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767229; c=relaxed/simple;
	bh=tVhkg+8LzXpzQNRN4pgi3ZVqPglsTW5ZAwoR6pUcFjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=trUSHCTO/e63WoXBZ9xJOHFVYVetYQ+DftexKPKpABRioum6IK2ltUhiHXmSWhexjmRnENrQ1rF9rR4lJO2dM2InaoXZEGxbCuQ0g5Z9qJ1PRf/ZkMCHoOOrXWegoWkxOCuSqwKOwAmpAlrPKy41/ZhusCPDWO76RWCd0zgGJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE+S4xrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE+S4xrY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F7E5C43390;
	Wed, 10 Apr 2024 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712767228;
	bh=tVhkg+8LzXpzQNRN4pgi3ZVqPglsTW5ZAwoR6pUcFjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HE+S4xrYxhunGFPmufdW0SyHxcO3F18fwSYI5qt6rQ1erh54dS4QwURdV4blfsZaK
	 1xTpy0Qbo+WvnUzAl/AZvHttajt1WRo0QaXSMvxgnggITXg7qpWzxLJ1Wat93Vv6DA
	 IAavnyCpl5pGgjtJovDEtoAnD5WnV8S6tlw8m04UKTe/iirEAfg0HK332axCIAXaiV
	 uY8GruqkTu+dJHRo4Gva9vP/4zmzVzsrYmcsZUNIvWIuGix+Bo9pkLrslPg84um3Cw
	 1KdZ0BtScS7mH0sAs5Ft/zbP3O6h3EX+N8YqkfCxtnjQlZG8PGF8mAXaXNuNkymdq3
	 1n/6SLjuTc7hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D3A4C395F6;
	Wed, 10 Apr 2024 16:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/5] Add BT_POLL_ERRQUEUE experimental feature and tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171276722857.12421.3691393429177194345.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 16:40:28 +0000
References: <cover.1712503073.git.pav@iki.fi>
In-Reply-To: <cover.1712503073.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  7 Apr 2024 18:18:33 +0300 you wrote:
> Add BT_POLL_ERRQUEUE mgmt experimental feature, and tests for the
> corresponding socket option.
> 
> Pauli Virtanen (5):
>   lib: add BT_POLL_ERRQUEUE socket option
>   adapter: add support for setting POLL_ERRQUEUE experimental feature
>   mgmt-tester: update for Poll Errqueue experimental fature
>   iso-tester: add test for BT_POLL_ERRQUEUE
>   shared/util: add uuid for Poll Errqueue experimental feature
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] lib: add BT_POLL_ERRQUEUE socket option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=138e97020d5f
  - [BlueZ,2/5] adapter: add support for setting POLL_ERRQUEUE experimental feature
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1c178f96a07
  - [BlueZ,3/5] mgmt-tester: update for Poll Errqueue experimental fature
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c777c55ab662
  - [BlueZ,4/5] iso-tester: add test for BT_POLL_ERRQUEUE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=141f66411ca4
  - [BlueZ,5/5] shared/util: add uuid for Poll Errqueue experimental feature
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe71fa3dfe26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


