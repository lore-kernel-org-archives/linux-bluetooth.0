Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBB2D8DB5
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902010; cv=none; b=DZRj4e6CEGD3P3F+thkHiMRFsrsjaZ4zoupOw1M1ClQX6RLMOzBAe5CCp+Ggzk9gCoK4ZcsuVZ975UDKPlI02SidVDwgF1DGF402cYetdi/avZ5pbAViSR0hZeL6Bh7Y/lQ8QLyBe834kqjjFtfz4B+zoxiodOfuDcyOKwOAYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902010; c=relaxed/simple;
	bh=yaTFUVbnhwEb8UBDd0vb7JaiHGwM3UezILTXGAa3ofk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WhzIjLjTpApTUxpZzeDdfsDAVxJCa9DtZtPk1UvqG00vRiKUrwGeCn0KH+IDbV6T/pUkqKt6IOSFZxBUH5IHZgGX/9kkW4b26gXrRqe6vGh3MDEDMTKrUesPwjAWXM2aBz3wnPqenVIXJ3byy246/D68GiEkt9WrPF4FKY7ibkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XewtQvCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XewtQvCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB428C16AAE;
	Thu,  8 Jan 2026 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767902009;
	bh=yaTFUVbnhwEb8UBDd0vb7JaiHGwM3UezILTXGAa3ofk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XewtQvClSgiYssJ9wFXCAIHZM279skKDYjjcVyByDOD0Sr6FdCRPfq+gmP/k24PRd
	 UsrFhZ8uJkBEIWThLofO2J4tNUcJe0FtRaPMJwo8CIa2F8fMBCdvhe8eWIYseoUD6L
	 zg1F1CzkSHbhasZdshjkTV9S26vkvSdv0vxGBijO5IDOiB5XkBN8yhCpo8llVIk+cj
	 2gbmFJ37YvG9rXnSDOvUDd5D66ceQXCA+awllwUP1bprwwdMWbchafvRUQJQDcVv9r
	 BgF3maz5YAFZ2szh76bQBXu3v4LsVN1vRw9v920oYIBIJsLrv7ekGzB4g9zRv0svTz
	 AGwndbZnOlA3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A3D3AA9429;
	Thu,  8 Jan 2026 19:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] transport: distinguish BAP mic and playback
 volumes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176790180629.3782583.6297172225546713069.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 19:50:06 +0000
References: <cover.1767647222.git.pav@iki.fi>
In-Reply-To: <cover.1767647222.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Jan 2026 23:07:53 +0200 you wrote:
> v2:
> - Drop the bt_bap_stream_is_server() function. The direction can be
>   found based on bt_bap_stream_get_dir(), which for BAP Client indicates
>   the remote endpoint, and for BAP Server the local endpoint direction.
> 
>   Its return value is a bit strange for broadcast, as
>   lpac BCAST_SINK -> dir BCAST_SOURCE.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] transport: clean up volume set/get for A2DP and VCP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=76933585dc48
  - [BlueZ,v2,2/2] transport: distinguish BAP mic and playback volumes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1287ac9068b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


