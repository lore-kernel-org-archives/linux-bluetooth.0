Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7371C8FD6
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545024; cv=none; b=NTKOlOWHVOp5CSPh56cp2MXYoR+4F3mnLb/Fw1HyGIXYtVZB5rUrgfk1p7bBYiKKnGAcJhdnyLKb57e2/96Egh5nJEPkpCTrFXrL06tnLYJIX1WD77vVuDVVzuUgtxv/W9VwWYQxMPKpHDp0oCBCcRI1/I8tJWKNOcyXhTk3ZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545024; c=relaxed/simple;
	bh=9jAXS5OhtXQuDbT2LYHsFayRz9DUjPh6ZxvYefilsY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WZV1BYIioGqsplxbvFNHolW7ULNXuCIz4r76ROxRHpmi1Tep0amOk9CYD0EpaG9spxKY7dj7B34T2zY44qHhTVG+TJ6VRqHdLY7xFKJEaFBJm76qS/RgLPvikLgh76mawXI/IgKqk+QdMORlT96cZAW6+ueIaM0cFURbcfr4wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv8VHJLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv8VHJLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4FFC4CEC3;
	Mon, 21 Oct 2024 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729545023;
	bh=9jAXS5OhtXQuDbT2LYHsFayRz9DUjPh6ZxvYefilsY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hv8VHJLS9UZamJDyDqOITzyxjjsKD+XkuiSdo2z1zE5yGYlLJ6XCC/Wt59V7RqYV7
	 3KCcWXQf+P8xLwhNWAAeenGJxN4pQNQ5F3lJ+IiIYvWv2eFRIfKRii06HXtEZ/zN4c
	 LAHdu6AUAvkNwYKtlpXeCzZVjsYkHmamGseENrPk+Z5Geqp7qBfW4IrKWd63fhEXXP
	 dI27e4w+lm4L+ZLRBcXumAICAulPogG1roBID7NUrbfrsbwhIFbBXqF+AG507DEuS1
	 ihzoxHHl822I8ER3Gt8QmPkmsy0rlRbHHQdTs70KcqvBX4TweNWAOiT2L+KWWq+Kms
	 yuEhxwr50SwiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C963809A8A;
	Mon, 21 Oct 2024 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: btusb: Add quirks for ATS2851
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172954503001.445881.1439242520713535031.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 21:10:30 +0000
References: <20241021122246.1569235-1-danstiv404@gmail.com>
In-Reply-To: <20241021122246.1569235-1-danstiv404@gmail.com>
To: Danil Pylaev <danstiv404@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, uhrmar@gmail.com,
 raul.cheleguini@gmail.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 marcel@holtmann.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Oct 2024 12:22:43 +0000 you wrote:
> The controller based on ATS2851 advertises support for the "LE
> Extended Create Connection" command, but it does not actually
> implement it. This issue is blocking the pairing process from
> beginning.
> 
> To resolve this, add the quirk HCI_QUIRK_BROKEN_EXT_CREATE_CONN.
> This will avoid the unsupported command and instead send a regular "LE
> Create Connection" command.
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: Add new quirks for ATS2851
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff4565bd7117
  - [2/3] Bluetooth: Support new quirks for ATS2851
    https://git.kernel.org/bluetooth/bluetooth-next/c/90f7f7538d07
  - [3/3] Bluetooth: Set quirks for ATS2851
    https://git.kernel.org/bluetooth/bluetooth-next/c/017dced0da79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


