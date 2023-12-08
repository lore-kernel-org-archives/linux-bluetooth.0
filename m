Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0AF1DFFE
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUMO2TPH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BFF1C433C7;
	Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702047630;
	bh=tZk+axX8BYLOHsACx4OxxbQ9aD7WTDbQJ1TuqK3MTh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FUMO2TPHItNcS/lQn3G4ZCfOq0uPikOATs4MmFarxe7bFEuBSUltLUHrppWf5U/l9
	 B70fx/pHoRSBeAmIXYBpyTfa1MKt5O9U6oIz53VPdEYvaGjtrpl1UiD4VaFvs1SkvU
	 nCttyzUHb6epr/kcnVo1esGTBm3vrhEiAgDms8WcERCPHWKp0rfkZd8hb9hHrsQ7aV
	 U/JuZWDimOFUfRh+NOc/rsNbyLlj87gCsbP6bKdK6/bZiwGneY2NI7FTg0J2/rQxCp
	 MIeynkAhFDpLj1TF9aZegaSzSNw1HZxzkoG1R31bTEVxWaW8Qrjv+L/hEIoQOQ5lx7
	 hs3fqrPEYfmDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31B7CC04E24;
	Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] Pattern match on service- and manufacturer data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170204763019.28520.7832975435305918666.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 15:00:30 +0000
References: <20231207061900.194-1-sebastif@axis.com>
In-Reply-To: <20231207061900.194-1-sebastif@axis.com>
To: Sebastian Forslund <sebastian.david.forslund@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, sebastif@axis.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Dec 2023 07:19:00 +0100 you wrote:
> When advertisement monitoring, manufacturer data and service data was
> not being matched against. This made it so that advertisement monitoring
> with or_patterns did not work that type of data.
> 
> We must start matching against the data in the manufacturer_data and
> service_data queues. Run a different match-function depending on the
> type of monitor that is being matched against.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] Pattern match on service- and manufacturer data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0656c2cf14d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


