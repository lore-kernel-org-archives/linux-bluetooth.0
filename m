Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA81BDD5
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395628; cv=none; b=LQf4rWZ5tufsUQbAWwl2yiDa/hN7rlDlFgfT5ksvN6E+XaC2yGwPZgEzSKhhxH6W6eNA385cXg4tzfGWb3R8Nt5iASD/rVXPbZ/2xNhpS8Z1DI6kXfJ2z+mv4ZNrQhgt96drUBtDYNL/rX5m0/X8N7KcNtmF1g4cLRGbJZK1wvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395628; c=relaxed/simple;
	bh=PaDaqEYz1EfTz/6/BNX3oYiwc8EAowgreYfcsv/v6y0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pQOTK/dkpT2tJ8iSwOxKzjz0KPwph9v653La3qlIlKGbHft4UMr2SaMM2W81qsHlQKBrWqGmrzAkqdEqK6UmYACfWfcsEydqzkB14m7qmOQOi8I9Lc3sUO3DE4bU7BqLwoMrOVsN5/y0uOMNlHMG6LPn0vXBWb7oBml1+sjCGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVs5uou8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVs5uou8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3913FC43390;
	Mon, 25 Mar 2024 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711395628;
	bh=PaDaqEYz1EfTz/6/BNX3oYiwc8EAowgreYfcsv/v6y0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aVs5uou8xStJIa2lFm5f8pjSfvzxtopAkFb0mhIxZNWWgNzC0mfqeLHrTabqvIiOM
	 YQZvRgWteGCzOancrMM3kx5EATPINrg6WONg8xLX5ZqzhCXCcJ1SwOf528BN8HVHKZ
	 HsgMM5u3kaG/cTO78Wd8r777t25mhU+8Esgmi0bj89EG8ahMeyrwQGjUewksHrwsZM
	 JT3FgDbxkKe2A819cIOkdpxxqa+LczPIEjDZttTWOsaK18FM65t7vrwDRnDJz9q8Bc
	 bquaot8ZQ+50GQ6PDrPsh/DyssEJCnO1TqFWPSpXOzymWjehVKrsOTzLwMtBLazU+6
	 s+H/JlIYIDvag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BB4BD2D0ED;
	Mon, 25 Mar 2024 19:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] bap: Fix setting adapter address type for unicast
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171139562810.16755.8919583029643175434.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 19:40:28 +0000
References: <20240325131910.324811-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240325131910.324811-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 Mar 2024 15:19:09 +0200 you wrote:
> This fixes the settin of the adapter address type for unciast
> scenario. Currently the address type is searched in data->adapter
> however, this pointer is null and leads to the crash listed at the
> end of this message. Instead, the address type should be taken from
> the adapter variable, which is initialised using device_get_adapter
> at the beggining of the function.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bap: Fix setting adapter address type for unicast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=74545026520a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


