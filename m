Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155226739F
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548803; cv=none; b=Iu4nKtMyy9XiS9MwsfRLtdeR/hEhb8qUuTOxRrt89TVAts7agMoE5UEzGUpH93iAewTiHLa3zIv7CQEJMjJeZYTftrILI8//hTCbXxbyE1/9CjPa5wD3cMA2XQKlywFlFGCxctYds+8MzqETjgNcV7zjpWfxFQBWDvEx+ZBTCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548803; c=relaxed/simple;
	bh=M3z0n/a7z8Bgs+MEZgMUVjI2Ag/ycaEhpb3xK3H2hcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nricx5rFH7P/ur7koOxI4rHs3/QKPMWIV7TmVEvrN8dGxJOZx/Om+Z8ltP9zostPjpNo8TYssoCEISH6NnAnIgAkOG4IDa0+enVqzRQDhntMU4QD9B4ck5GViNg7OBPKabKvz48VlyS3ZNvwj82/vlp02Vn7vhHWXomcNF7fxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVQK8Nws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVQK8Nws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F962C4CED1;
	Fri, 14 Feb 2025 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548802;
	bh=M3z0n/a7z8Bgs+MEZgMUVjI2Ag/ycaEhpb3xK3H2hcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WVQK8NwsTMLhsbdSJXq+sq9KAsEa5GuIu4L/WdSk7UEpVAGXvloqJswPRXKUyHmfq
	 mZTPyHSwX2tALsxow8ojT7B2zfXXI8MELmQX49txxdnflRI3byFMonZpQFa6wWLOZI
	 DH1uDs/TcYDnLwFDlmk9W+2Nv40Ke1y1nhr8MAgHhJBvt78AZyvOgFwaXMfWhoXX9B
	 5F/BjjFmuwOkgguwO6inIUGVNejVlTnLrKaeY58+Q1uddI/9Chb6nqMy7X1ctjlHYf
	 EDp+60sMlqWXZINFRdZxDRqIo9fng6XKZnLeovCjTVFu81iWm8jD6M4OAJ6aoCu4Nn
	 lCkUr69zoHbEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E69380CEE8;
	Fri, 14 Feb 2025 16:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] device: Clear pending_flags on error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173954883205.2022852.14606289925102380605.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 16:00:32 +0000
References: <20250128115659.23655-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250128115659.23655-1-ludovico.denittis@collabora.com>
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Jan 2025 12:56:59 +0100 you wrote:
> If setting WakeAllowed, or the device privacy, fails, we may end up in a
> situation where `pending_flags` is still set to some `DEVICE_FLAG_*`
> values, for example from `device_set_wake_allowed()` or
> `adapter_set_device_flags()`.
> 
> This can confuse further requests because they'll assume that there is
> still a pending request in progress.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] device: Clear pending_flags on error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=264bf951f2d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


