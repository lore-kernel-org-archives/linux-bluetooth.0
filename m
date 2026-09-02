Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033737883C
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363666; cv=none; b=QTUypDEciu5tbZ0x3FPcDMhvnNccrZrqn4XwQFyo+fgzOTmmBi6drdg+6Qw89AGPHRxEI37zQzOYQDX7wziwzdypv7sWLw1zeXcArexZiFRE3SjHUJoNVbwgXSvwdrBe3uP8d86chru1RY9QJhHwtUBjwMATzByoM8Z7qbZWFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363666; c=relaxed/simple;
	bh=qEbxgGMvjsF8FLYKS9iZYQF19SG7loT0fi/pMC+s9ww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tJJvoA+tbIfkdnru1tuaEBD/DSawBakeO58CvBe+KbMGkgwZqfm8F87HOCItMnukrq7Ia+nDSXGzgjwbyg4Sr+cprKiWFO5VfR5lDRYj3Wh9FMVaO1p70HbB+kDrFBopLsZb8ZauXjBKlYjMLDJgme9r4NGL+NHg2A4UETICkig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoIGm6PS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoIGm6PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770321F000E9;
	Wed,  2 Sep 2026 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363664;
	bh=pWwJR+NEiCnO4A12wadfsHPdecrjjPgsq+qBVmaVWfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LoIGm6PSFksI0lR3PyC34G8o1ZG4bn39w25MnsVi2z4z/w14SbYmlrZf1D75MSQqy
	 qteWhCA5NKtx4CrDjU6fMGmidvRq+PrKH3v11CEfYBXDOqKAXcizTITo5K6xUjS/AX
	 vmC7sT4B6gv4edMgFlqD0KSB2rVd2yYWOnmad03SRveRAUIGRYwdv1iwv2wjqeUwS5
	 PiMCWGOQgHVZhx1zFH/oQ0UtWR2uOhkPWJV+uIu15PfJZzRuu1W3CTLIa44Uitu1kA
	 z1J1xdbahN2hdiEQ5ys5vZ1zTT0rn42Hro6K3TPToGB3IUgZ0/jLUrTuxtZmZSnZgf
	 WXCGBkfjSTI2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A53926648;
	Wed,  2 Sep 2026 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: Fix use-after-free in bt_bap_detach
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178836360614.2802406.4817688876298487049.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 15:40:06 +0000
References: <20260831144437.127711-1-frederic.danis@collabora.com>
In-Reply-To: <20260831144437.127711-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Aug 2026 16:44:37 +0200 you wrote:
> bt_bap_detach() invoked the pending request's completion callback via
> bap_req_detach(bap->req) before clearing bap->req. Since the completion
> callback (req->func) can trigger synchronous cleanup that re-enters
> bt_bap_stream_cancel() for the same stream, and bt_bap_stream_cancel()
> frees bap->req whenever it still matches the request being canceled,
> the request could be freed while bap_req_complete() was still executing
> on it, causing bap_req_complete() to dereference the now-freed request
> once the callback returned.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: Fix use-after-free in bt_bap_detach
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a909d5d303cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


