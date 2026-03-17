Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154D2EDD78
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763213; cv=none; b=jMMyajSLeE5w/vUyUyQAx9OwKGC7xB5fasD4oVeEUG0eRxcjprLIE072X9+MDPShpRG1bdPeFH7ZBzAxs/GZGCFsKD7w0TxBEeju5jVG2dFCrKxO/ZlNO9B3flDwRARjadbu32YO6XJmkOMA+GhXIatM4Ic17jgShlKQYXm+XtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763213; c=relaxed/simple;
	bh=iqwhfh4PvMlzavpFz4qbRQJpKIXcYfbnTimt8B/jyDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ahgDBMG9rFFQM1TajjQw+C4LK/125/IwzaUUi/yFfq3p2XJZHIedtAha14JND5BxKIP/XR6k/GJvcgthisnPrM7hTJdP0MsmOzrHJYTWr1Kj5MlCzmmGJ9iS/UVp0IC2prhiz0aRCykx1xig03A0LPHlz8X/OpDrbicS/S2kGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsnWYLBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsnWYLBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF235C4CEF7;
	Tue, 17 Mar 2026 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773763212;
	bh=iqwhfh4PvMlzavpFz4qbRQJpKIXcYfbnTimt8B/jyDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qsnWYLBbWX2OtZOCcJ0rcJ91lnWSmEY5mqFY5/0TX+Q2Q4i+0rA1N8QGFnhsaaOzU
	 +JmaX9AJ3Svb2pEbPMwdb5CPUtVKcdiojDOGV7ij6Onpk22tclU4YUq6pS2BHLDySN
	 UtbaIu16zUznzhEDpoYoxS6Fe85+1GJ/B3PzhGwQYz2VR/1CF0U5GO155HEppzbsua
	 wVrAfVb44L6Qx8B8S8HHKPyFv2+/gshSM7WlibUybCsJUBT/+18pYzZEHg0l7ZeDfK
	 HRTiioeiYgkct+tCC0+lMXrncrf0vsXRBMu5ZlsVQV+aUgGpRHwJw4e6nI/pE7p0wU
	 b0QCGtRJ6vVRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCE43808200;
	Tue, 17 Mar 2026 16:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/ad: Fix not checking length on
 ad_replace_name
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177376320479.3681898.6063927404009163659.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 16:00:04 +0000
References: <20260316204320.57220-1-luiz.dentz@gmail.com>
In-Reply-To: <20260316204320.57220-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Mar 2026 16:43:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> iov may carry move then HCI_MAX_NAME_LENGTH in which case it is
> truncated so it doesn't overflow utf8_name.
> ---
>  src/shared/ad.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] shared/ad: Fix not checking length on ad_replace_name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=11d05ece674f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


