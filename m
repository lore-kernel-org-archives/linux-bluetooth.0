Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1D1E880
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881233; cv=none; b=AKv80gWysZXvfgEY570yeZa40FBCW7jSzaBGJjN5H5NVVGJGnHtoPAYo/VBz726FWgWaGUu9IXZ3arkdjxaK0ioy3HpTh6Q9agY2H/+ymeQXOiQ3bnEF84uxu3SnsikCJajTnpBDljinh606/sN840PqQyRzb8F4oQvJ6s6l/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881233; c=relaxed/simple;
	bh=7zWH2zj54Xq/HwvDJR8VE9lQFzkslzEXJ5qYp6eickM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eWvII6lFi2baJP73HOcswVOFvlSJUbwfkBVxwb5wpM+l1UbbBFE6MHh20yMrRU/Hj6+/1G4U0xyBLy+k3J9DETvXS5TxDz2BklEAknCpOP2luM29ngPRRQiiqjAG2atE01dYEFWRgKOgqEd6xYFdOvtKa/ZkEWGvYy8L2BWBt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfHgKOMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfHgKOMK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22DECC32781;
	Thu, 16 May 2024 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715881233;
	bh=7zWH2zj54Xq/HwvDJR8VE9lQFzkslzEXJ5qYp6eickM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hfHgKOMK50fkshItMO4bFT5qpGSvYj/TLQ40zuL2QqDadkmf0Hepd6t+zJwuPDW2G
	 FsXAQ8mrSBX3lfbQv5UjaZIDb8xEd3Ol+YEA88iVCGpBUnWQIX9dI+cvtNo+oebwxS
	 mZWSA8PY8fjSB4OW/n1RXFN325S2w3ycUQV8nueXfKK1wNIA1g2R64eOKoSuvKjfmk
	 9V8QPmh9yY+KpkcmDqlfMDjVfwMsyj2F8yHMz7y5caeD2KOpYzJ9gQjQNbE+o4wW44
	 Y4qocDsf9c9cd5I0/dHKcLklADzPRsFbg1h52N+8Bmfg1wWMfVhF3d+19r++9n5iIb
	 2KM1jfUvw52Sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E372C54BBB;
	Thu, 16 May 2024 17:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/6] Create transports for matching BISes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171588123305.10202.16565510212790050530.git-patchwork-notify@kernel.org>
Date: Thu, 16 May 2024 17:40:33 +0000
References: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
In-Reply-To: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 May 2024 16:03:54 +0300 you wrote:
> This patch refactors the flow for the BAP Broadcast Sink.
> After observing the BASE information, streams and transports will be
> generated for each BIS that matches local PAC capabilities.
> Because endpoints are not available any more, local PAC (which contain
> local registered capabilities) has a new list of setups. Each setup is
> generated based on the matching BIS observed.
> Then, the setup is used to configure a stream which then generates a
> MediaTransport.
> The transport is in the TRANSPORT_STATE_IDLE state until someone
> acquires it. The "Acquire" procedure results in creating the IO using
> BIG Create Sync. The successful reply of it causes the transport to be
> advanced in TRANSPORT_STATE_ACTIVE state.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/6] shared/bap: Update stream management to avoid PACs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98818da25b23
  - [BlueZ,v5,2/6] shared/bap: Add function to check the validity of a BIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=db8c96059c02
  - [BlueZ,v5,3/6] bap: Update BIS management
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32d147959b8e
  - [BlueZ,v5,4/6] shared/bap: Remove not needed function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7aecf3bbcdb2
  - [BlueZ,v5,5/6] shared/bap: Return the local PAC when matching a BIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b1e0e503cb8
  - [BlueZ,v5,6/6] shared/bap: Add stream ops for get_location, get_dir and get_state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=745f324de589

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


