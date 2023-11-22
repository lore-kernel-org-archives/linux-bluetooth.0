Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4853800
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqAgrgMu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 718D9C433CB;
	Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700674824;
	bh=SonejxZcTHqWO1jy0K425Oliek+tjKbIPRvz6sd9uXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hqAgrgMuur10jmC2Za5Fx/go1JZV/fNMGd1tQmvEIof7Wa46705F0bUNET5NYiaRr
	 0jDNpJFe3HW8t+1100V69KftJ3u4kmecbqaXHHxBDcrmXhwhbUwYaUQP284VGpS60R
	 OhPhzrWhLPqw58+HCNyQUctKRuwp034dDneQfaeVwe4XByVJ3MIsLNw3DDk+ir0xjX
	 kWec10OvJT6iAN2Wkc9SBBO3hCfoDEU1Gjr3Iy/ta8hI3ldxReI3CrA66BiX8coswC
	 LxBg6G+i5R9SDPYC3eaUyCNjWK7WpLlq93S6IP4Xqlh6UrFkGKrvKN09QeZDXqb/0u
	 Wf8vTQy+zZ7uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54A89C595D0;
	Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add documentation to exported functions in lib
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170067482434.16276.15670962527244628798.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 17:40:24 +0000
References: <GV1PR10MB6563B895FB2E3677DB984302E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV1PR10MB6563B895FB2E3677DB984302E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Nov 2023 22:06:36 +0530 you wrote:
> Most functions in `net/bluetooth/lib.c` lack propper
> documentation.
> 
> This patch adds documentation to all exported functions
> in `net/bluetooth/lib.c`.
> Unnecessary or redundant comments are also removed to
> ensure the file looks clean.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add documentation to exported functions in lib
    https://git.kernel.org/bluetooth/bluetooth-next/c/1b70ac811a14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


