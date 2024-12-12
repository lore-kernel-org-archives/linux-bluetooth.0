Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323D222D7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027017; cv=none; b=ANz7YdZkwHICJN0yVXVrRLH+KSg/Bi7XnFQ76nLdjWP7CrtUl2X+PctLCj9xMVq/QerjNlmblS0rYJoy4DFig6UdQ6VElhq2qA7A9yoNmD4mk5cmfifAk0nyso9Zn/zv108sQOTJqf37v8apLoEzaWMCwTkyaCzIMUNIn1fckTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027017; c=relaxed/simple;
	bh=RqDRQLGBbtxZO57onAAMdjtff/P9eA6BXa21w5nDpFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pXO1kw40UhsJ99y+y/2ey+VUpLOpR/NPw717BekizQaEziiEpNwLKKY9DTHD+Lj3CshbSg8k+WL5hnBh43Pv9WLzFPrKo4i8GMgJITKkjtTzzdPyOSVHYauajMj+kGvpM1S7oAdx21xmXZJ+WxG6kJSs9ERcpNjgQHjYJocM98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXhYiOEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXhYiOEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79081C4CECE;
	Thu, 12 Dec 2024 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734027016;
	bh=RqDRQLGBbtxZO57onAAMdjtff/P9eA6BXa21w5nDpFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lXhYiOEjYj5XhtZU+w6ael2x3ivpiIWRaOuEnmeDhERXyQvmqr1WFA75aPUWsdVsF
	 kdqCKtzoL2IyuKphFwqcUWe6FeXdxUWYnz1fHjPoD6eQJ7Zp1klBuzJ7xx1GbjgFo2
	 DhqWapdtFhadnPx+IAzNTxQsnmji4HY4SjUcf7A/0vuIkitfAcjN9KAFdT/IoSYssP
	 Vj7Hffhpt3fvXdro3GtLShmyoB0yTE+vucvTriq1+Q45BEvlhkV3uwFmhQRLpoKBZE
	 DC8r5kIeOuxxKJZEQjAMSY8bAOs1+4ZM2XW5XICPKVjrp1HEp2MKZvcGMWdljAkaqH
	 wkoLJqmgyrtSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02D380A959;
	Thu, 12 Dec 2024 18:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/5] tools: Use '>' as prompt end marker
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173402703274.2391244.9155452097327964395.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 18:10:32 +0000
References: <20241211192210.1864347-1-luiz.dentz@gmail.com>
In-Reply-To: <20241211192210.1864347-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Dec 2024 14:22:06 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This replaces the use of '#' with '>' as prompt end marker since the
> former is used to describe comments on the script which might be
> confused with prompt.
> ---
>  client/main.c            | 6 +++---
>  client/mgmt.c            | 6 +++---
>  tools/bluetooth-player.c | 2 +-
>  tools/btpclientctl.c     | 2 +-
>  tools/mesh-cfgclient.c   | 2 +-
>  tools/mesh-gatt/util.c   | 2 +-
>  tools/mesh/util.c        | 2 +-
>  tools/meshctl.c          | 4 ++--
>  8 files changed, 13 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/5] tools: Use '>' as prompt end marker
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5f0ec38851e1
  - [BlueZ,v2,2/5] bluetoothctl: Update documentation to use '>' as prompt end marker
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d1eb37042d9d
  - [BlueZ,v2,3/5] share/hci: Introduce bt_hci_send_data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=560dcd2ea3d2
  - [BlueZ,v2,4/5] client: Add HCI submenu
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5527c88bc717
  - [BlueZ,v2,5/5] client: Add bluetoothctl-hci.1 man page
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6905331e2cd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


