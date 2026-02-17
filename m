Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BF32E122
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339813; cv=none; b=BcGrYuh18vToohLxgHQtgrwUTnLwSDiRTVYsFUGNbKd7aSYsG1xJN6IlqN4gK5X1WWCpRw3zCRun9r8OaFpxC0FCxTAWpC2d5pY4CipZhF8X9kxyBqK2L+Cls64whkUU0VkYR8rRE0bmI/+yuzVRx8WmmkiO830uft9VqCoK8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339813; c=relaxed/simple;
	bh=xb9zEm032j2TZDqwRp3q5QIa1EchphOe/hTE4bcl4+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nDMIIJPi46Cqb6ruKJHdM4IkTxRNmaEd79D9M1vV3GJE2Tec4JJnJlovIve+pzmV3LdmzO0t+E9EVBnMOuSFpRfDPXmxHM3Rhr/C4jGH9Uo+nITDvZlvslIXHNb6i4THXrd8mBdXClqFBwBDCAolnVh5h67ty2anJyV1bIaDiII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHW2+7Ah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHW2+7Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207F8C4CEF7;
	Tue, 17 Feb 2026 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771339813;
	bh=xb9zEm032j2TZDqwRp3q5QIa1EchphOe/hTE4bcl4+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FHW2+7AhN5DzFL8YyY0NX9ekKMcxxn5k9gdNX1cgk0CJ75a6nOokUwZXMspIMzG7u
	 9VEpEuy1yUITOKUkmdvOtAdo8N68oNEO+6K3SYnqjInBZq5h3L9qoLrZB1F04asFyQ
	 kEqlCyX/WYF2fsW/G7m2YxXhcYsUta4TS4nkQ5NNdIkpKcm9roJB3fsafK5lnvc2/3
	 cF53cR+efQCJOz+fCsrNOVTK/ncdnazd4HHXNc1JjkXhHXGvaoehJAyTWneQ4nZ2T6
	 8I2ud4T2n8OaynB1OmtTWzCcgV+XoeFcIETVmw1Hmic+aw4xL9O8k2O6DH7D1BL5N1
	 Qzfe02Q5Zz/eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4818B380AAE0;
	Tue, 17 Feb 2026 14:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] tools/btpclient: Move btpclient to
 client/btpclient directory
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177133980508.109268.6813747240562081655.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 14:50:05 +0000
References: <20260216193136.292051-1-frederic.danis@collabora.com>
In-Reply-To: <20260216193136.292051-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Feb 2026 20:31:34 +0100 you wrote:
> This prepares the split of btp services in per profile files for
> easier maintenance.
> ---
>  .gitignore                                 |  4 ++--
>  Makefile.tools                             | 13 +++++++------
>  {tools => client/btpclient}/btpclient.c    |  0
>  {tools => client/btpclient}/btpclientctl.c |  0
>  4 files changed, 9 insertions(+), 8 deletions(-)
>  rename {tools => client/btpclient}/btpclient.c (100%)
>  rename {tools => client/btpclient}/btpclientctl.c (100%)

Here is the summary with links:
  - [BlueZ,v2,1/3] tools/btpclient: Move btpclient to client/btpclient directory
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a98f3d5abf14
  - [BlueZ,v2,2/3] client/btpclient: Move btp core service in its own file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e1c7988308e5
  - [BlueZ,v2,3/3] client/btpclient: Move btp GAP service in its own file
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


