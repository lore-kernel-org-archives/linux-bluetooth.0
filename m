Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598084A04
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620205; cv=none; b=ERpd5viQxmfHLp0F2xa2htwP4Xx9Qy1iojMv73ayIFzoW0ow+Drtekh5NumelDKSjXhdN+cxi/acTossr5tecTv+uszGFAIWIDKgpK9U5oqnokhQEB48CAsoEvgazmm5MfOUtF+gi9H5q8Ojil/pTlJKDP09rzgWsCub/V9OccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620205; c=relaxed/simple;
	bh=g4WhvLB9lsJzHYHWVq2MBXKZDNc+3h2NPKWaH2tBO68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HolcRb2lQmr61I4m+hhlMVSiiBsWGynwVsMc7dRhLypFWnJuszqpat3BMXgq+Z7XF7yxuYsQHjXZdY69GwtJr3DouWzoeEia2V7UY9dg14tdhkJL8lNrHnwO8PD2VJyOLhHdP+krAM0k5/KOhHv0dElUTBJ4y27c4Wm0RdcvsVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn7E1wG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn7E1wG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3956C4CEF0;
	Thu, 11 Sep 2025 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757620204;
	bh=g4WhvLB9lsJzHYHWVq2MBXKZDNc+3h2NPKWaH2tBO68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nn7E1wG6L69MMdaqigX/EXMFNEsMPJmSnX0jHdbbEEzJGF9/cI4ygjCQzU6nf/6Vi
	 xv09CCHq/7Qt+L4s0mLD36kDpcAUObs+oASsA9G9FdJTyc03AZlou6dlllpmnc+Ipf
	 3brkivFxJyRI0tGztm9wfLt3WZ8qwSZTCZ/iga9I47rLvbcOlSRsZRyWbc73OA+JYY
	 1kDIsFqxY5rkhlt5S7W9/flOdKCAi9TYqOf5SKVfxXNm9arjrlphKidHjAU4L6phev
	 A4K+/f8wWdmbbzK+uwswGPw1aPXfR9fkjCdrIBAtfCBgqRGR48k/yiAJmkFcyv9m3J
	 Gt0vlsY+9O6mQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1CB3383BF69;
	Thu, 11 Sep 2025 19:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] audio: Add support for specific error codes
 for
 A2DP configuration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175762020750.2297358.16857140842997847569.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 19:50:07 +0000
References: <20250911151930.1632922-1-pwaago@cisco.com>
In-Reply-To: <20250911151930.1632922-1-pwaago@cisco.com>
To: =?utf-8?b?UGVyIFdhYWfDuCA8cHdhYWdvQGNpc2NvLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Sep 2025 17:19:29 +0200 you wrote:
> The A2DP specification defines error codes that shall be used if
> the codec capabilities contain improper settings. This change allows
> clients to trigger the sending of these specific error codes by
> returning the corresponding error messages from
> MediaEndpoint1.SetConfiguration.
> 
> This update is fully backwards compatible: clients passing other error
> messages will continue to receive the default error code as before. On
> older BlueZ versions, these new errors will also result in the default
> error code, enabling clients to implement support for the new errors
> without breaking compatibility.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] audio: Add support for specific error codes for A2DP configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a887b1a1b91f
  - [BlueZ,v2,2/2] doc: Document error codes for A2DP MediaEndpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=befdacd236c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


