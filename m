Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF501D557
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOkAh8Qp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EF97C433C9;
	Wed,  3 Jan 2024 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704316226;
	bh=TxomDpCN7o6xDLvYseJWsP3NmONb5TZ3RDGU25n/XmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hOkAh8QpZ5qIG5DcDqeIiRMdKBR8N/QYfp0thFpnJhFDygMJk9ZBREt8DBrnuA2Nw
	 7f31dIeukOxAmFbis5X0y1fPY+FYyAGHshGxc1MmgwTdazMbIz99WRbXmz9vsR30WJ
	 bZ2HRe4vo9wj2fMudKVeWLhexT55SwOk8Sgts/tmqeMLePUoelKTPId/H/4SwBZuZp
	 S9iwYE7iX9VRYp1dD7TjynqeuzDtY4mIvH8ygMqzpY70PER/EuxkTuq5Cd/P/+aGaL
	 eGrLkBORCjNgQpsHXmGgxjkWEEgpfUWxFu4A7pQanhvAcLZI1Xwe7Sepko2CEuZJfl
	 Hwf0lwHg6xPUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C7D9C43168;
	Wed,  3 Jan 2024 21:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] mgmt: Fix crash after pair command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170431622630.16433.863044364192870086.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 21:10:26 +0000
References: <20231219062801.307-1-vinit.mehta@nxp.com>
In-Reply-To: <20231219062801.307-1-vinit.mehta@nxp.com>
To: Vinit Mehta <vinit.mehta@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
 nitin.jadhav@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Dec 2023 11:58:00 +0530 you wrote:
> Hello Maintainers
> 
> This patch fixes assertion in bluetoothctl client process
> 
> After pair command, if the user doesn't provide any input on bluetoothctl
> CLI interface after receiving the prompt(yes/no), than subsequent CLI
> command will trigger a call to DBUS library function
> (dbus_message_get_no_reply) with a NULL message pointer which triggers
> assertion in DBUS library causing the bluetoothctl process to crash.
> The change is done in confirm_response callback to trigger a DBUS
> API error call only if the pending_message pointer is not NULL so
> as to avoid the assertion.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] mgmt: Fix crash after pair command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=60d60166e4bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


