Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442417C205
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903035; cv=none; b=rBsp1s+5O9xYo4abTn/El8vBCxFvXDflrLaolIg1f6VoIIoOxmyZh5XDcwtj2wfoyjGhSwnfWEos+72kpnmimvT/8KIxAlUPWapgQyGCWL+fvEJqrwIsZJqImfLWb5ixxvW8lJ0JxnUhCMkUahvyHZlVlAxmGx3PavI6N8IQp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903035; c=relaxed/simple;
	bh=qnITf+Zlv5TGOVV/dRvsk4CD+Vz3LB7M8d1HKRVtRRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ORGbkMIKcTwKgi1BqnuKYOllAGUSj1xSYQBOLUTGOUf0tjkcfMWYKCfD8kMrpmYA+h4HjxpMgt+ALprElO+C0PcR+clXBLMpgocHZ5tJzcQULbLEKxLLvxRijdNc15vDk2xPAUfBEkyORGYrWsqevSDMsYtm5NrJt5ECVzG1yTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEgTdCFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEgTdCFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE430C4DE04;
	Mon,  9 Sep 2024 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725903034;
	bh=qnITf+Zlv5TGOVV/dRvsk4CD+Vz3LB7M8d1HKRVtRRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iEgTdCFq+G1hLdosEP7JfCGITzG6dE0P4XhqNzkAfd5JDe08g0lKh2NEM9rufqIy3
	 ijTILMxjNw+Q920KBLgr3Ss5eRbMI9Ja1JMXl8o/laE4XxKqLNqzltUu4vlklVMYfw
	 pn3tPoI/A+B6rrjwBTpC3/e4SmjqO69OYRQlFkEIH1UleEgoc1K7XFEb8TaNsUQQHU
	 /0RmMpbYEewmZOLXw+FtJMTuh3BwHxZm7/uT+Z/T3lPxzluW0ht3d2CC3oaq8euzdR
	 6FJ6xjhcsCiqVN1WqwcbwHQNdDy25qFHs/hiMIYfoFlKSox+OeNvAnIxFYkGR0vVsI
	 ggjbHO36wIdAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB23A3806654;
	Mon,  9 Sep 2024 17:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] client/assistant: Enter Broadcast Code as string
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172590303578.3870513.111390566313147975.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 17:30:35 +0000
References: <20240829132507.4545-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240829132507.4545-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Aug 2024 16:25:05 +0300 you wrote:
> Currently, the user sets the Broadcast Code as an array of bytes
> when prompted from the assistant submenu. However, the Bluetooth
> Core Specification requires that, on the UI level, the Broadcast
> Code shall be represented as a string (Vol 3, Part C, 3.2.6).
> 
> This patch makes the Broadcast Code be parsed as a string from
> the assistant prompt. The bluetoothctl-assistant.rst is also
> updated.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] client/assistant: Enter Broadcast Code as string
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ec779935496
  - [BlueZ,2/2] bluetoothctl-assistant.1: Update push command example
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f30cbaa43d28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


