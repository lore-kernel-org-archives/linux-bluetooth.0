Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666575349AE
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666275; cv=none; b=cQBoTtTdubwb6qEGNht20103zd1XEPu/Gizr4FyZyJEakwpB7cE9p1X1GoNOpfa0uBs3iQBsCJKiu5IbTRo/yI6nMXVNfaG6PZKb0razNvP7igdmBlZegfsBPmGRwVLAkW+V2bzlorHP2VeV1eYtOXmRoZj9J6ANKafRPqqouM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666275; c=relaxed/simple;
	bh=bGVM47mB3HmFGULnc5Julujv7bn1zhVkGReX20C2hD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfa8rOexchzDKKKXdtXAabwsVU95eCjn3zZaugzJYmhOADsvSnIcvGPFW1XJ4e+kZmikolqW9rjWpxXTFgLMauu7SgThV+AlYayi4u1t2HCsC7dZcitO6W/hL64cFDvpNvrOdzDffVqAE9SA2dsNc0Bo81nm5Cuiy7u/7Hw6dB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTY2uEbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTY2uEbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C99E1F00893;
	Thu, 17 Sep 2026 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789666272;
	bh=g3crRsXgYWeelSCmewRkR7jQX0C9RKfRsozRq3IfXNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JTY2uEbb1qgKm03eKSkOkanFBzqrM7KdxCX+SfegLsd0rgNYRCOx50VywfWdG0jXJ
	 Hu3U+KMwAOmLll0vtDX2OEmCGbH3GdPjGtk0L5GbIrH4VmFb4cOUMyHgCXQ31i3cTZ
	 FJW2KsGmVkTzfLVhRdHcLnuRhRhmCkCNCqXJircIw7tSTXYKb8Nei5/bsNdCDSkgpq
	 AlrbNhjI8iOVXF6Ibi9MO2iuQrfHx/EUoJuFQuOqAS9IRuuok1an2WI97ITp8WTCUc
	 7UVIk0d5UixnvPB03kyfT0F9JWlpidBwLN5iofDkG1x9ZxT+9ZNDWv/rtnlEsUsrCw
	 QQ7BA4GmJwrMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B7381197E;
	Thu, 17 Sep 2026 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] emulator: bthost: add function for sending
 raw
 L2CAP sig commands
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178966620587.3782583.17922597380682982550.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 17:30:05 +0000
References: 
 <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
In-Reply-To: 
 <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 30 Aug 2026 22:57:22 +0300 you wrote:
> Add bthost_l2cap_sig_raw() that tests can use to send raw L2CAP
> signaling commands.
> ---
> 
> Notes:
>     v2:
>     - no changes
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] emulator: bthost: add function for sending raw L2CAP sig commands
    (no matching commit)
  - [BlueZ,v2,2/3] tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server
    (no matching commit)
  - [BlueZ,v2,3/3] tools/l2cap-tester: test closing sockets with ECRED defer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9b6ee3808ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


