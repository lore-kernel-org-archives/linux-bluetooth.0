Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF1D52A;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384435; cv=none; b=RFu5VCXjGWgjMyeocyxrnT0X1KQztob7jcdOKJuzbe8vm2jkJtkX2nBjIgI2uif6WYdmA3UWgUyQ+xV5ObyYlQ1Z0sxD25UXaZkL4xVa5qLqVrGPhrdXbPPX3hjdYhddxtnaODUSOu26QyIcfcDapKqAaKw4R/xinbo316PkzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384435; c=relaxed/simple;
	bh=1alO+cd1mh47d3TO/QYAaOEpaUm8T9mi0DLUNE/yawM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lWOfvaxDOxyAdM+ZpP0BLl6rF7kL0L6U6c2qR1Z2WWvSf0Wg72nU0KGG8CIvRzRl+JbZJJHXtLLsKt4DZCYjqobEIE8dQVrv3ml+ABqQsL6RNzRUICuFtylJtMmrHlyzNtQ3khyMQnarl89N5fjN6XciII7D98wQvL/unRw8wC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG/pSVjm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG/pSVjm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43499C32786;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718384435;
	bh=1alO+cd1mh47d3TO/QYAaOEpaUm8T9mi0DLUNE/yawM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CG/pSVjmWu0ouRWteEDzcVwUy44GVQmKnYIVmaNL0oOU+JnlKaoMbQ3eCA145dBre
	 1YXF+wkVxvxjfV6VTU+V0mC9aAV7Nm9iWCg/NVo/VhgoGdSfljOHzaSgB35YM8vcYd
	 Ni/bgc1UhcOR8N1lxpgoVOe6dqGbQynwjlmDzx0/tjdK8JCDMe+SMp6rWV9vw53zlA
	 lb4SSVckZyCOyjNGIcCSehgv+SDz8NraKrwtSNPP2HS0DndndQNMoXIww/tQ1+LKI5
	 gym+GYn0yWVrLXtcVXavM1wuS1e7pF8eYDS7cdkz1mSKCVGbDE7YC4tveOiRndlHfU
	 fvSs6ByqsBv2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24823C4361A;
	Fri, 14 Jun 2024 17:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Add handling for boot-signature
 timeout errors
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171838443514.31311.14629068864868895620.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 17:00:35 +0000
References: <20240614082338.6530-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240614082338.6530-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Jun 2024 13:53:38 +0530 you wrote:
> This handles the timeout error codes sent by the chip as part of the
> bootloader signatures during firmware download process.
> 
> When the bootloader does not receive a response packet from the host
> within a specific time, it adds an error code to the bootloader
> signature while requesting for the FW chunk from the same offset.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
    https://git.kernel.org/bluetooth/bluetooth-next/c/96385cbdfb95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


