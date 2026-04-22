Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBD2D8385
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776878442; cv=none; b=c86ty/+0cmxD6U8i6k/GgjdVCxWb43WExARZhNnTKvgQUqmsqIK+OP4TvbtYuSI1jxwS5KE7yYqVHulEncPi6NqR04zV9l3JQgdHCTYTB/3Vn2vQUlhqT5U/Spu5O3dtSU7DsDH8GBIZ4Xk+AVPUsLeiwVeubdoNtx3N4vESaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776878442; c=relaxed/simple;
	bh=/0Brot5J7/hMKNiDSKFnU0wOwnd1lYnc1hcGqL1Ppqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QcVVGlxAM+273OFqUsIzbHN5lZL8acLirVAdKzs1PgllBA+zoS29+jyp2B76CgsFVqo+I2/KkQcc6Y9rfl187g1azNOg88Be9aglBRxlLRzQW9vA3m51kS9SM1+3vnMhFOgNnqWI9lLzkWS/kNTLhuVx6k+ONHmrrszcuV+vLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtSbTe8N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtSbTe8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ACDC19425;
	Wed, 22 Apr 2026 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776878441;
	bh=/0Brot5J7/hMKNiDSKFnU0wOwnd1lYnc1hcGqL1Ppqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dtSbTe8NUvLUCtf+HudIzMNb4A4Mz/vFFZxYMAFyhPSmrOGY7UqUAT1QqWzuRpCB4
	 GH4p84GQlTKwVpaJqRJGsK6k/aarLsvZTAwxzOPJK3RrpJN/7M4HW8cDPneDh3p0vN
	 B1ECdWTJmH/uyWT+b4r0jRvpcEqkk20SMQxsYedopBo3Db3e3PPZOOM9w47wfDyWCs
	 tLNd54UjckP4ZbGc0FBM1kZfGufUR+/SO4GT4HORntp32Oby/E/Wvt8/tUygNW+H+Y
	 wTQepnF4iPwSBKUQwWEt/i4UVcjBUAN8dwHyNxnSrBJTQ3qpJ/cvLuFEK8QzqBnrxQ
	 9R0t1knyuPSow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF123930235;
	Wed, 22 Apr 2026 17:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: 6lowpan: fix cyclic locking warning on
 netdev
 unregister
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177687840430.3877699.8350209661251408341.git-patchwork-notify@kernel.org>
Date: Wed, 22 Apr 2026 17:20:04 +0000
References: 
 <afc0037c7237e101b50b68d969cc4202bede5f92.1775931137.git.pav@iki.fi>
In-Reply-To: 
 <afc0037c7237e101b50b68d969cc4202bede5f92.1775931137.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 Apr 2026 21:15:09 +0300 you wrote:
> 6lowpan.c has theoretically conflicting lock orderings, which lockdep
> complains about:
> 
>     a) rtnl_lock > hdev->workqueue
> 
>     from 6lowpan.c:delete_netdev -> rtnl_lock -> device_del
>     -> put_device(parent) -> hci_release_dev -> destroy_workqueue
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister
    https://git.kernel.org/bluetooth/bluetooth-next/c/87151e363b7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


