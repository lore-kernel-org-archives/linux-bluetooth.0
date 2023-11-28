Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744039AC8
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3ZMccG/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73C3EC433C9;
	Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701193229;
	bh=IUL5TeMAA//ssXpZ8DVs+5trAtRTa9PrkdStef/fLQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M3ZMccG/gdsUFtShB7fYuf0zZgHRjqmkpgULf0RvSkPv86mU0V2qH50l9sqbxvpip
	 foCjbaqAVtOXb4BUZ/i5Hv/Y3VKlqqNwNk0heQ7vdbd+3RYsB3MdIozC0gjfQc8Yew
	 galEqYcQwlQkx2APiNqsnAwnmxWu7H74nTk8MUWFH1Jm3e71iEs6MrrZ7NQMjnVErZ
	 7q62ndqIWy4R4KNpRXdk6EhQNBZEZ/QFj97zS89FIqfahKpefQ1NHmJviHY1W6Z0RD
	 JDZaUrcserQH70G2c+qa3PEC16eGh8TdBm2VVOVWZaP4T/HU5HY6qaTPw/i2AckgTo
	 MqAU+jv5i4vWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A046C39562;
	Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] isotest: Fix high-reliability QoS presets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170119322935.16253.16055552111898117657.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 17:40:29 +0000
References: <20231128153303.1731575-1-luiz.dentz@gmail.com>
In-Reply-To: <20231128153303.1731575-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Nov 2023 10:33:03 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This changes the high-reliability QoS presets to be conformant to
> BAP[1] specification:
> 
>   Table 5.2: QoS configuration support setting requirements for the
>   Unicast Client and Unicast Server
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] isotest: Fix high-reliability QoS presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee04d309651c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


