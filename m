Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2A18FDBE
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293782; cv=none; b=T9jOs9h0/9S+mXhHNLgs1Myj4Ehu5VAOMQiCiiTfZbDweg4OWfsAWJWvwgu7CvmjU8WKqbILoXeUfTEH/QT6I6sq17Q/VjZkc9B9JB3xOGlO8w6FsX4LYo/MU9xDrLzBwyxi/f6IOUc6wfJ2e6+gzoijhgoI7Mye4tImLM5ER5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293782; c=relaxed/simple;
	bh=Qkbqn5FDoC9AG+srzjdEpxejwuFGHGLzwHrAqjOTNDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y9CiZiqHLcvNwqzbKbv5l96bUUyjvZqs2KvlSKad6abV57s7pLJ7Th1bq7u4tiah5eJeh4n+39ob//WY26k1Ui9rZX5/ITgpsotaombk9ZGJ1BXgg1jvgctIlhnzn/CflV8MVVjJSF/OS9v5vW4V+ySE35dRJx0cLkYdevhWy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh4tnCJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh4tnCJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181A2C4CEE3;
	Mon, 30 Jun 2025 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751293782;
	bh=Qkbqn5FDoC9AG+srzjdEpxejwuFGHGLzwHrAqjOTNDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hh4tnCJdsdCIpBGvBmuXR546oi3/d+L28HXWonCoq4Sq3lSOyGiPcQeV3+NS/YSxj
	 rCA1f+7mFaymkw3n2CUy4TGhamhNRgz6wNqx+qkPcQG3egqLT2KIEhNMBa3Oy9fjW6
	 87i+TBK/0kNKLCaG1TK8jEjuywA7ypD+Tr8oUc/tg3MDuAWMFI/mAX9s6joLJNMoN8
	 AxBbH4OeHuFStbCW04eL/jqoXRT5PlIJYFeyfrp0p5tyyt7wB2W1UWFVNTqYXTHxrE
	 k/PIT+6LovHC7i1NaTxZppHMZcCmlOZbayXZHNxcT9majBFAsBgLxgeRISCzcvtcoZ
	 rP6x6HBYne29g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710DC383BA00;
	Mon, 30 Jun 2025 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix not marking Broadcast Sink
 BIS
 as connected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175129380726.3403730.15842451370963161959.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jun 2025 14:30:07 +0000
References: <20250627151902.421666-1-luiz.dentz@gmail.com>
In-Reply-To: <20250627151902.421666-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Jun 2025 11:19:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Upon receiving HCI_EVT_LE_BIG_SYNC_ESTABLISHED with status 0x00
> (success) the corresponding BIS hci_conn state shall be set to
> BT_CONNECTED otherwise they will be left with BT_OPEN which is invalid
> at that point, also create the debugfs and sysfs entries following the
> same logic as the likes of Broadcast Source BIS and CIS connections.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected
    https://git.kernel.org/bluetooth/bluetooth-next/c/00cde9e6de29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


