Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2D383305
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850663; cv=none; b=gJD5dIxsXbiBlZxASX9Qv5dYRKufXLlwpSM0MAZZ2Vx0WXZsJ1jtltrDR2zs+gTkyDuIiJhu19t4Iw6Uq0bXz6tQ+4088nestn/L0nHIG6lAFWFSTBlvx7VuDob7enL17CniEmiCIHua6WZx/Lg7htfuTGAbKVXM3HnoQe0F5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850663; c=relaxed/simple;
	bh=GsdGSiiLEHbqTnUQZTzs6gIiMC7GgKpM1YG07TXyNGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIaFY+NvKcrqwTUoEZ594T+kLQPn/a+6dk50LqRcXyMGX23Nr9Qqs8KuEgU0zxkDq+gYWRzRm9pdiCogLdNc/wEj0m2KhPxjArYTmxcGtMNCiqkr7Af+DJ7uCN1svyd0zP7djlOMeMMduql2VM14E+I5QpBuKATJMEMoGNZGASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGrgJ7/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGrgJ7/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938971F00A3A;
	Thu, 27 Aug 2026 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850662;
	bh=nDhj4BABLt2hqqlp3AV3nDT5UsSXGlHu/WIvmVBuG9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QGrgJ7/KnO7dsSlks2bfmJPIMZGSsoza/r9qnAkyX4EoNmP91xYJ0DV6N9x13rnc6
	 /ahDdZ9pilfWX5RTsQkfuh0P/fZBXt+0c5jRZs7Ikr9y3paEy6F9IwkRMCxB0/8jew
	 JnaOxzfS4qXJMUEHQCH8laoyV+Oo8PGg6/zrOtlIDZzoe27JKkLYe+ZoTA8GjtpoTX
	 tSAcAYbz9dQ21hDDq7DWXl2c6Vpcm7NxM7Jz/p6CDwvj2e51i4qM0znCOt5a1QfAql
	 oG2fYC+jl6npSwrPWQp3OblqTnYrU8xhjdscNaq4KJU3NTlTM74sY/07KnNH5ZMbue
	 AkKJdSQF0Id9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567B33809A89;
	Thu, 27 Aug 2026 17:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] all: Fix typo in AVRCP_ATTRIBUTE_ILEGAL
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178785060788.1754949.15269152334555825176.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 17:10:07 +0000
References: <20260827145742.1568129-1-hadess@hadess.net>
In-Reply-To: <20260827145742.1568129-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Aug 2026 16:57:38 +0200 you wrote:
> It's "illegal" not "ilegal".
> ---
>  monitor/avctp.c        | 6 +++---
>  profiles/audio/avrcp.c | 2 +-
>  profiles/audio/avrcp.h | 2 +-
>  tools/parser/avrcp.c   | 6 +++---
>  unit/avrcp-lib.c       | 8 ++++----
>  unit/avrcp-lib.h       | 2 +-
>  6 files changed, 13 insertions(+), 13 deletions(-)

Here is the summary with links:
  - all: Fix typo in AVRCP_ATTRIBUTE_ILEGAL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=73ccf6d83e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


