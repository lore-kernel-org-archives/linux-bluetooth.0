Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2E2DF14D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470634; cv=none; b=aTQfd6fUAZw5XGi1YS42jnTKV1KK9eeWJQMMLVb66f/KwZYsn8MixbWDvDmLmh08kLPYt8WlZS6FkMpu/M2Nfdd4hk1tZ/dnTc4eo2+u+rvyTaeRDw/QqOLpyk7HA2UuheYFn0HbkMBIoihRQWiSbuzeCj0/Tc8rMd4fvfilIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470634; c=relaxed/simple;
	bh=EI5M52ikHt/RsEhYRGz5itobI0kiG7p6ZLrTHFKDuAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AzmsCguQdsIky4oPQbDFDoSFnyD/CS9oUT8KFRZB80XEXCnzLfWhB4/4FbkBqcCxAUZAR0mBQDNnnUq+8YzBm+RgFw36ebLswtRWQRlWfDJNjV3GB0whO3YciYGXMcnC2hLk+dxxvPZexZD8Ir6BZg4U6yULCRmCCXiNR+aLj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eheW55iI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eheW55iI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75364C4CEF7;
	Thu,  6 Nov 2025 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762470634;
	bh=EI5M52ikHt/RsEhYRGz5itobI0kiG7p6ZLrTHFKDuAA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eheW55iII6EOyuLlKZHyngV8jmWRZiStgPK3Iim+zjUiSHrmGuqtqbuWqYCjI5OtW
	 nHvTXv/OrbTRmo4g1tryEZfkp4Gru65iAlXzGay4DDnNj/L0XnskPsuxGfa0/iRw3P
	 /OU9LRa5s7IlDjEf8sDOYG4RXgIwBTVSTR8oqSPUaFzK02vD/Fntk5C37cjORB2kYw
	 0ayjXiHu5qfQ/WYqk4J0iostpvzP/zRvR/8gEMpPaMYGuIdFICtYV5QW36q/0qjmz+
	 1gCKK4oGM6q8qqoWvf84iJZ2qSg1V9MFb4Ws5v67Ayusx9wKRmpFE5Sh7/LMgSrE//
	 etcqTQw9hakXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5839EF96E;
	Thu,  6 Nov 2025 23:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] transport: always show A2DP Delay property as sink
 if
 DelayReporting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176247060726.383880.16161167619776519044.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 23:10:07 +0000
References: 
 <9c8c3680e82cbc31b8f9cc3a64997c3668220ddb.1762367086.git.pav@iki.fi>
In-Reply-To: 
 <9c8c3680e82cbc31b8f9cc3a64997c3668220ddb.1762367086.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Nov 2025 20:26:52 +0200 you wrote:
> The Delay property is currently not shown to sound server unless remote
> side has acked delay reporting.  However, when we are A2DP Sink, we
> reply to delay report requests with the current value, so the value
> logically exists and is active.  This behavior was apparently changed in
> commits 05f8bd489fd1 and 5d4efe960fd.
> 
> Show Delay value for local A2DP Sink endpoint if it has DelayReporting.
> 
> [...]

Here is the summary with links:
  - [RESEND] transport: always show A2DP Delay property as sink if DelayReporting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=14f868fd141a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


