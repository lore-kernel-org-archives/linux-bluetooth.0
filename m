Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23E2BE7D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156194; cv=none; b=D+q/OCEVnt1wlqVvyqEnBKmwFAVSBbCuipOjLKIzWfu9d5aglNzWaABr1mbi4dCe7ulZKGOca8oKg4ZirxnORygo2X6hGgJoSrXZ0GfoKTQoymOUwwhpCuMaThth8+Cx7okbYWaCOfWBmM+6MrDKP7BfdI8wLSjYN2HMMmVBSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156194; c=relaxed/simple;
	bh=ZjUdDy6m04m/AeG/UeSo9ezQvl7JVDxOPXuEJRwj4/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nf3ab+iZ9waPJLh0LBFWsSTAwppIXoyI7JGRfwRUIxJ9gEwq2kDxi1K8kUCf3W60UiiCLPrzgxGBTyKTUI/FFDRR8VereIFgO5TwjgUqCptoB+SW3UW3EE1SwCiId8UsheWmn7EX7OyUej5Sm2zVOajG4+L/yrfcQfv+GSWLpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvD9J9uy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvD9J9uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC385C4CEEF;
	Tue, 13 May 2025 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747156193;
	bh=ZjUdDy6m04m/AeG/UeSo9ezQvl7JVDxOPXuEJRwj4/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SvD9J9uyIo6kb/MYMpt0O5Rb5KhTg7eYmNwzLh+hZdpkB4DYnBnYK1UqFQTZsQsnO
	 oGS96LdBLKLibbvstLZDfhQz/IStqMdNkid3w7TGrePLl+fo6smydj0vk6SCw2o9YB
	 rjRIOzSed91DtyycHwVayZrv/4tH3efnIdjeURgrvXgXp1+TTYwekFPN8tahdSZD3S
	 03j+qWJ9MwEik05cOiqdlN//ZN3KIzYO65CT1BSbQQ6aal8Pm3+c22LlIUJw+uNFaj
	 6YKXUsjh3wg0MX7+LTGfJrjuMpa4CMJGGeeZm8VQV6XhuIpePfNWJK9mJJrqS5AcUf
	 cXvL6y/ncmdtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5739D61FF;
	Tue, 13 May 2025 17:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ v4 0/9] Fix bluetoothctl --help hanging if daemon isn't
 running
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174715623127.1734353.17270826037952803389.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 17:10:31 +0000
References: <20250513093913.396876-1-hadess@hadess.net>
In-Reply-To: <20250513093913.396876-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 May 2025 11:38:10 +0200 you wrote:
> The changes are still made in a way that there's never a commit where
> something is broken that wasn't before, hence the function split
> happening first, before we enable and use pre_run.
> 
> Let me know if you want me to rejig this, I think that the end result is
> fine, but you might have a different opinion about the way we get to
> that result.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/9] client: Split installing submenu and doing I/O
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b36c39102e02
  - [BlueZ,v4,2/9] client: Install submenus before contacting bluez daemon
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c0ed04ab07b8
  - [BlueZ,v4,3/9] shared/shell: Add function to handle early help calls
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80c810ec9e72
  - [BlueZ,v4,4/9] client: Fix --help hanging if bluetoothd is not running
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=773cce6b378d
  - [BlueZ,v4,5/9] shared/shell: Add pre_run menu callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=102b9f3d075b
  - [BlueZ,v4,6/9] client: Port "admin" menu to pre_run
    (no matching commit)
  - [BlueZ,v4,7/9] client: Port "player" menu to pre_run
    (no matching commit)
  - [BlueZ,v4,8/9] client: Port "mgmt" menu to pre_run
    (no matching commit)
  - [BlueZ,v4,9/9] client: Port "assistant" menu to pre_run
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


