Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8B3B47FA
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134838; cv=none; b=PUHJDOa9us2A18oF69DJyA5sztjhEVX21xPi9JH/vW+0h27ZnSE7f7swNLU/6Fhq6uf7V+bfb+6ulwm8XjpmxPUrW8O5JmaIZsejU4ahandlcnrxKLT8H9l1zUMg8V7MDvXX5yhlpzrRiP7Eb/765hqyAZlW8ga09+Tn3P6Sdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134838; c=relaxed/simple;
	bh=swH8suR1dN1D40c7CpfpWlyAlWOFopviWZ2jMh0OPZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FULbZ9JGGi0yTdNUwX0XlIwqDBVdS4IZO8c7wDtAaEHvPs9Bc7iafZ1UWWsETLW5xPys2v8B7R+BiAFQk5gGZeIz0o199YMO8YfxhRv1qBOt44/ONGXiybV1/uJaCHVZWU8s7f4xamp0J8zR/o8MJtzjOZHpjQrHPcVY2uAflOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM8rlFVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM8rlFVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4701F000E9;
	Wed, 15 Jul 2026 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784134837;
	bh=0R0PmlLBQ52LsiowfKaxuEv/jGlGKM3k0c71w9gVSW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nM8rlFVZ1/aDyU1ntSp4Yxd6z2jQoi2eDbWhiaoZH6YFdiiVuaiJqiERydYWZm2zX
	 rBi+xgHZ14dP8bW3i0SQ+IQLa5ovQxThf5+WUdFGN7xox/kuxZ7DGePHCGesmcBkGN
	 +G6GVsyW8GrX3Re+VWXyV2f165v671VlyG7EKQIrcIkeL7wpF6c36LLBUnnf59RZoF
	 dxp3UEjGqOKrgGXuC7mNmvB+mvZTEPxg+jSDJreSRbnUBizYthKh9sFHMcUi/JY7WE
	 FIidfMSnTmJUAnfK1/Lk/qxJT1wmqw6ZqO+54yavF2dF8VjXQESV46IWXTRkyC284B
	 SXsaw+SY+apBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567E0393AF94;
	Wed, 15 Jul 2026 17:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/8] plugin/admin: Make allowlist adapter-scoped
 and
 enforce at runtime
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178413481088.415350.6996338348568524976.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 17:00:10 +0000
References: <20260715090206.212130-1-frederic.danis@collabora.com>
In-Reply-To: <20260715090206.212130-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Jul 2026 11:01:58 +0200 you wrote:
> This series tightens AdminPolicy ServiceAllowList handling and makes
> its behavior consistent across adapter selection, adapter profile
> activation, local SDP service registration, and device service
> allowance checks.
> 
> The first part removes global AdminPolicy state and makes policy
> tracking per-adapter, which fixes D-Bus updates being emitted on the
> wrong adapter and avoids cross-adapter coupling.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/8] plugins/admin: make AdminPolicy state per-adapter
    (no matching commit)
  - [BlueZ,v2,2/8] client/bluetoothctl: make admin.allow controller-aware
    (no matching commit)
  - [BlueZ,v2,3/8] doc: document admin.allow optional controller argument
    (no matching commit)
  - [BlueZ,v2,4/8] src/adapter: enforce allowlist for local services
    (no matching commit)
  - [BlueZ,v2,5/8] plugins/admin: reapply allowlist on policy updates
    (no matching commit)
  - [BlueZ,v2,6/8] doc: describe admin allowlist runtime enforcement
    (no matching commit)
  - [BlueZ,v2,7/8] profiles/audio: fix UAF on external media service teardown
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7482aceece70
  - [BlueZ,v2,8/8] device: apply profile-aware admin allowlist checks for device services
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


