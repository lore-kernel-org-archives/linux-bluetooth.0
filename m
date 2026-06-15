Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE294028F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536815; cv=none; b=D+nMvKbKq3D4HvD/VaMsF/RhtfeEwu4oKhfK/i32HoAmAIob4UMYGiAh4ztOVLYsTPtvIIuS/2E4o4ndzqPLjcHskT3k0jLz6+WRoRmD2KoqpSXy9DZjfNYa3T7lDawgz6xwoD7FArMWyj6wiOqvXAaicw0nJARIQN22lVSsEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536815; c=relaxed/simple;
	bh=Qr6WtnZsydMRCCZPRXxQTel+iY07uRhTARmzZIolFOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m97elL+HlEHOBAKTrd6eBuFlmmq94ANndZBE9l5yVwB7ZtgreELpAkH1XfJSrcFOH0ta5maR9zhoj1i260gPOFcdwFz18M7Ro0kLarOmTgIJgkp+n9KwKpcM63O4tdyepiq0smqYn+f9s2scBgnNTONEwtRlKiotebLNBMuCdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY3wX8h1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY3wX8h1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62D41F000E9;
	Mon, 15 Jun 2026 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781536813;
	bh=yF2JtG1LfjlqiZYmI8Cul56plbgoQS+y8T6CplLzdMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JY3wX8h17Z9Fm320jZ81QggY2q6/zhIzpnvSZnl689LD04juyDv4U/9P2rfcd5qKO
	 0hoiGy+/ETzXPB2G1uaEL2JnJh+uIRWX+KfGhyjh2e1OgC0B9bj2wqfEpoEYprH6gL
	 vYr+bLlcxqWY2ktO91PVlHo6WZqr2CWMT8LBo7WPgCFAUPxIcQU0qhP6xehNAgYAWG
	 VQ5R/0Q1GaExultlRjjV6xSHMuV/ttvrwWfEizsl88mWId+B/dJI02G+xfNt3MJ23P
	 4Z+39euUMEm4+WY1JosVewfj+B3o29SPrQxEj8xEYiqsVwUt++uYlepqKxEUBFgn+m
	 lk1rm1vn64EkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1977A3811A64;
	Mon, 15 Jun 2026 15:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/bap: Transition ASE to QoS Configured
 on
 CIS loss
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178153680863.3644727.3015101124528960748.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 15:20:08 +0000
References: <20260614100208.1091560-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260614100208.1091560-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 14 Jun 2026 12:02:07 +0200 you wrote:
> stream_io_disconnected() only handled the Releasing state, leaving
> Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
> unexpectedly.
> 
> The ASE shall autonomously move to QoS Configured on loss of the
> CIS and notify the peer
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/bap: Transition ASE to QoS Configured on CIS loss
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=237d4d5d20a5
  - [BlueZ,v2,2/2] unit/bap: Add CIS loss test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=986e220b77ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


