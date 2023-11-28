Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747E39ACD
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6uDQAq4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83BE6C433C8;
	Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701193229;
	bh=uE5AIGH2oamF8b24T/eEO4nQxlBAUa1KygbfjW0OLOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6uDQAq4wfr+Q8+uTMgPS4DRdBf9eEfMfVnOeNmbaH1PT3kctqTn/OOXQJX9aZ4vO
	 M+Luwt0e7FrIWK+mo3hI1AWwL/l61ajT5SaXQ4KmG9g2Vl43TtBUNDxTmfCo0AEIb+
	 EYlS+TF8sIvm+5d4IumElU4nvlOOCnO5URdb4+IMUFQmXVjB40QBmPfGV4EBLesTm0
	 QHniiUv4Qz/8JBbuTfCcnagUdkypbceosZUpzgStKUo+SoxUH3N4oBcbGH4zBgdXj9
	 ojr/lSIKlnYSVW/znKLt9XlRdDGmwjosqQ0uTM+o19eyFyhpyjLEIDUyjdczxV2qkG
	 aEAvnoZURKeXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66196DFAA80;
	Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6 0/5] Add support for bcast multiple BISes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170119322939.16253.4423205736477387431.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 17:40:29 +0000
References: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com, iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Nov 2023 23:59:30 +0200 you wrote:
> Add support for multiple BISes
> Register the broadcast source endpoint
> endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> After registration a new remote endpoint is created
> Use the endpoint.config command to set the BIS codec configuration by
> specifying the BIS when prompted by the command
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
> [/local/endpoint/ep0] BIG (value): 0
> [/local/endpoint/ep0] BIS (value): 1
> Based on the number of BISes seted in the base_lc3_16_2_1 more
> remote endoints wil be created (If more then one bis is setted)
> Use the endpoint.config command to set the BIS codec configuration by
> specifying the BIS when prompted by the command
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
> [/local/endpoint/ep0] BIG (value): 0
> [/local/endpoint/ep0] BIS (value): 2
> Use the endpoint config command to configure all the BISes
> After all BISes are configured, use the transports to send data
> 
> [...]

Here is the summary with links:
  - [BlueZ,v6,1/5] shared/bap: Fix source+sink endpoint registration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b93690e72d9e
  - [BlueZ,v6,2/5] audio/bap: Fix source+sink endpoint registration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd5342fdf46a
  - [BlueZ,v6,3/5] Add support for multiple BISes
    (no matching commit)
  - [BlueZ,v6,4/5] audio/transport.c: Add support for multiple BISes
    (no matching commit)
  - [BlueZ,v6,5/5] client/player.c: Add support for multiple BISes
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


