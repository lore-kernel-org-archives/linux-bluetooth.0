Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC32C862
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914832; cv=none; b=PV00+QqlWfwdBjKDJXuey0Ei91Aw3ooip9JK9cXem6CZucTywrUCQe0dRp5zdvpwm9hebGDCdegmbYhiG6At+GPWH5L7HypN7THdqaIL0rNgIdidDfm6kBUP8OoO44hTl3gbIbw74avvPgr9TPwXvcU8idZYEylNn3/Mphlk8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914832; c=relaxed/simple;
	bh=LvL9lA4xohcCF4yVN4E2t6eNxrqFQ+KAUFaTRkdkeNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j1W5Au0yP+PIsLNlyrpzWQZlPdwsF5Jbiyf0gfSemjAObdsFrMvSvHPMgYzBeB+V34iczxXAxP3GBayJZ4IVUXC3b32hpwSUy+xiTRiN3oo4gvAEQwadVl55C5lhOv/f9bqHCK1e3NPXeDhMa1frHcTO5CZq6upuDlSH4EBcUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St2z9ghq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St2z9ghq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE1FEC43394;
	Fri,  8 Mar 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914831;
	bh=LvL9lA4xohcCF4yVN4E2t6eNxrqFQ+KAUFaTRkdkeNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=St2z9ghq4w48YP8DPwDmxxSEJWTtsBdhPekJmurhwTyEvsKWt5qaLCkItzGraJS35
	 0vK2RpaxJ51ikzCfAW/hNpKkeCbxBzhtJpaju3UngkuvpMZa6v5pDkqQSrYN+3WIIb
	 r30Ct5g4z3E7/y6E9dLZm+N0hXP9UEfXn+ufwvizm/RV7OADRFGGPugRoOhr08Mm9s
	 h3Pv3H9arJ+uHL8MjgnSvcVcerL3+oUB/Ja8yAlE+vfdOvJhXTiZbCKMpizm1UKduF
	 NTBVupxRrRv17KyayTAjTemC7pj45OXkXlujHbFQelRnRuFszKj+aMS+OUUk2hw+4H
	 p5mJw4KjNCAmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5ACCD84BD9;
	Fri,  8 Mar 2024 16:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bluetooth: Add BT_ISO_SYNC_TIMEOUT
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170991483180.24074.320922338627503897.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 16:20:31 +0000
References: <20240307170118.4096656-1-luiz.dentz@gmail.com>
In-Reply-To: <20240307170118.4096656-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Mar 2024 12:01:18 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This defines BT_ISO_SYNC_TIMEOUT(20 sec) which shall be considered the
> default sync_timeout and make all instance previously hardcoding a
> value to use it.
> ---
>  lib/bluetooth.h      | 2 ++
>  profiles/audio/bap.c | 6 +++---
>  src/shared/bass.c    | 4 ++--
>  tools/iso-tester.c   | 4 ++--
>  4 files changed, 9 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] bluetooth: Add BT_ISO_SYNC_TIMEOUT
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa7a814690d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


