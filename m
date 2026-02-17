Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53882376468
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355413; cv=none; b=dA35XqPkyWVGKonQaEhHPkSCrvJb+FBNArMGfwJ2CFatdg2RE94MK+L2jUD0skN2/3j2soB7JLSuZdh4as4clbosK+V1YkQ9ls/IX/ASkHLjalrJOAqyYuQI4+NdWvnKUChufNsmzGnqfrh7LAwaS/BtYuGqZ0RO9T19IPvGWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355413; c=relaxed/simple;
	bh=PuxvVeY7Lc1psNiHIblvoX6kyIIYxxLfysAhnVRxF38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bOV/JXHApamC+hrKlbsIBqEr/lAPwIOJwdi1xHL4QgfMESzpdOOJYJSW8HNBa/bZp/KJzbyOAjZVvukB7DYTAppmnUeHC2ZrxvfN4XhMcTj/v8pPqgY5k2yAcTgJ8L+HKzmJFpi+mVEgW3IN1g91P5oQWc3D8bU8n3T4bxUA5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC/MRdd+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC/MRdd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB598C4CEF7;
	Tue, 17 Feb 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355413;
	bh=PuxvVeY7Lc1psNiHIblvoX6kyIIYxxLfysAhnVRxF38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LC/MRdd+bPUmnGU3T3GFN7ti+5BrtmZmNfWcE6jtA23WR9EyDRJl5XO6gpVE3fVnN
	 dMo/WiGtQs1ZiG1pFXZUBH72k0+YEmH9JIucRC/9UFD+Q/OGq/Gn5/uVEHp9QrGAf7
	 f01VeKTfJzw+Z3BWO4vXLN26jRImXTfWziKJU5F3Oxe4SLrVtWhsRhQKvXagHWaA9R
	 srhQA9CuKO4cPfN+PVtKJGq34UzQEXpLwlfxG9+tFhTeXZGC7BeFNS0v9cD0dQ5C/O
	 2S3i7rRIQNNiwA51UPYylKP4VHUdGTtPepxGi89VEhRHYd+YWB7j+iluA4qYVU1RtO
	 AnIH20qxT9E0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B3913806667;
	Tue, 17 Feb 2026 19:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/btpclient: Fix build warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177135540483.607841.10984152678075811659.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 19:10:04 +0000
References: <20260217153616.394716-1-frederic.danis@collabora.com>
In-Reply-To: <20260217153616.394716-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Feb 2026 16:36:16 +0100 you wrote:
> client/btpclient/gap.c:2359:3: warning: Value stored to 'reply' is never
> read [deadcode.DeadStores]
>  2359 |     reply = l_dbus_message_new_error(ag->pending_req,
>       |     ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  2360 |                                     "org.bluez.Error.Rejected",
>       |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  2361 |                                     "Passkey mismatch");
>       |                                     ~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> [...]

Here is the summary with links:
  - [BlueZ] client/btpclient: Fix build warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=99845224fd4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


