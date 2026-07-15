Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53725B0AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134840; cv=none; b=bytSmmrjws5dVzT5IhvsMhY95p5gi2T76/gvgVB3PJ5fAgdBMBwjj0AHjw+MYdOFU9Uc9A230elWVGrRMGCCjCvORBkp2dzWANz51UriiQkUHE7GWGG72t4H8eIA2s1rEfxHVu6CE0HhIqNdPaPLNZTdB0tTOBAIlmbK4F+GMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134840; c=relaxed/simple;
	bh=aAfiu+fR3odgPPToSldNygxt/Vw9PU1Z1VzPsLldjXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gd+q9feHf3hEnZ+7rcEzz2j1zCU1KmjtD5/m8DS+BJWNhTmukpF78Scv+AlxND2nsnIdBXdS33ymfpNZO+JObqPSGCzd5FaSLLpS6v2atecwgjdDVqW0qq+CL7LHkB1FpZm2NXfNrE1jFaisjpYvY4XHmiWEEQC/mnE8jg2C1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LztzvC1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LztzvC1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A771F000E9;
	Wed, 15 Jul 2026 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784134838;
	bh=9ZFjpiKjfvdcIolUKeE/GNEtN3ccX7f3MDZDX7WAAJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LztzvC1p7gmBf4jKp4Pz4LsGo8Qs3PAukjxqdnb1Rf5SxYJrAw3uX4xKrn8SGjt00
	 RwRMDRkPVrRAPBftfmCUmWnenVhnfztV/5xZu0lbV4koRK/SnbgSh6bV3ym51wvYOJ
	 RkNkP8oYODzL7T/1Mg2XRKGt2PbUSOQVRnwMvfcId3SpjyWRMCcoefYNadQ7+x0ACC
	 5liKNN/wUNzycleXCzObYM3m+OuKMEC5NBHNvQMo/agj0M1sFGkHxMCxVz+yr50MIj
	 /9QR3uSTbeAxamYuI8S7N/bUpdU4pUYXgEo1qgvRx1V+vD1i6lqXuJ94MF16uSND02
	 7MaMniyseKBjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B6A393AF94;
	Wed, 15 Jul 2026 17:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] profiles/audio: fix UAF on external media service
 teardown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178413481238.415350.8497114981118430548.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 17:00:12 +0000
References: <20260715155144.264825-1-frederic.danis@collabora.com>
In-Reply-To: <20260715155144.264825-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Jul 2026 17:51:44 +0200 you wrote:
> Keep media_app endpoint/player queues in sync with object lifetime to
> avoid stale pointers during proxy removal.
> 
> When admin allowlist reapply removes audio services, endpoint/player
> objects may be destroyed through non-proxy paths first.
> Later proxy_removed_cb calls queue_remove_if() and matching by path
> can dereference freed endpoint/player memory.
> 
> [...]

Here is the summary with links:
  - [BlueZ] profiles/audio: fix UAF on external media service teardown
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7482aceece70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


