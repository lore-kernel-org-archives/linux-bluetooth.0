Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B8132C18
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209828; cv=none; b=RE2zpTJt3EGbMdGfTF7LFBJzDSQ4dVTwQIDCBJk0zLXRpAHAiGyHvipZ0Rw2UALuaMPz3JXv1aPNS0UjqtYdyyBa9dX8SH27gCcYwcE8owoOJfc5Ewm8WkxFoi9SqZ/2kImtXCK/Q/TNkh1zXPdN/bTAKQxCPvUh01TrM38DIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209828; c=relaxed/simple;
	bh=l9rFpL82reHt/riVKjD6bCdJnQ6qKHgM8SZUJUp4aVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o4s2KTMRsYUdf5ZWA1XvNGl3mVwiU7sMkuaKkfAhzHgY3b02jw1dt2iLLNA/NuWyOnoWpwduqJFLpzwMk2IpVsKQ6ywm7sZbJuuy4omuun6K83Htg7ilftLd5Efx4iIdm3muRqIfKcjG66m902UPYQhaljFlpye0czYIjvrzdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmTluBIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmTluBIc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2FA2C433C7;
	Thu, 25 Jan 2024 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706209828;
	bh=l9rFpL82reHt/riVKjD6bCdJnQ6qKHgM8SZUJUp4aVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RmTluBIcTzo8V8+NgLSLaypblwBvwPNBm/9Y5tSK79yAiBkuCwTFWRUyWUT/ccQ2K
	 ap+fbZk44vAFWwbU/fE7Ds7PI2aqsT7GIcWmeu+E7kReE89H6IEGK2peOobdJ0u4ZK
	 l5AdDkoT8mX2OVg1hvsrJLkmTrTflFTyvatbkkzNEX47BO+yJAlD4+kIzsgcAUJILm
	 a6kRgyopZWpgBhhBHUKOSwM4zN9l0g8IU/KYAuZVEM5q0oaZr/b0d3BVVdobR0AoVV
	 kfrKDqeTv1NpZucobn0uKU6bhvSvZ7VKkfcaPZ9ARci1igSThbIiC6qfrKq5WBfhjQ
	 w4K8EtI7jr/kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDA9CDFF766;
	Thu, 25 Jan 2024 19:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] btdev: Fix not clearing le_pa_sync_handle on
 reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170620982790.23941.11815404873517456673.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 19:10:27 +0000
References: <20240125142936.3373953-1-luiz.dentz@gmail.com>
In-Reply-To: <20240125142936.3373953-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Jan 2024 09:29:34 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> le_pa_sync_handle needs to be clear on reset otherwise the coce won't
> be able to handle Create PA Sync commands.
> ---
>  emulator/btdev.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ,v1,1/3] btdev: Fix not clearing le_pa_sync_handle on reset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=460dd92431ea
  - [BlueZ,v1,2/3] device: Add btd_device_set_connectable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a1c6f31ed4f
  - [BlueZ,v1,3/3] bap: Mark device as connectable if a broadcast Endpoint is found
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=35858e173aad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


