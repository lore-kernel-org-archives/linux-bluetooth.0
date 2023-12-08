Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23811208C1
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTmKQNjW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7CEAC433CB;
	Fri,  8 Dec 2023 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702048224;
	bh=UvKqfuV1L21PHkSTeE5c+4mB7kaNHtNPBik9i2ccAvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lTmKQNjWXCEMgPgNE12THfK7DKRZnbW3VGIJVdYlbniBc4vjT2M5Gj6/crXIkCueG
	 8Dq/Tl0O399I+u+I9PNz8lU1sRV8+vH+j9u2afSBE7pA2XcXH7J6XL2MQ7KKiOE4v8
	 DlWPgyxoCZms9Y3ZcDndGyDohR97oq0EMTOw2MKE7sQoxJs0pnLY0x6z1aUxqy6Rqz
	 fdqcAQYohRykIcCcvSNNjRvW0mAzGMt2NZXibStTvHqgzMUz8NXVDxeCD+e4qOWCpG
	 Glx7xdcbTCgGBEkGOCJjMeDlsUMBSncoJHAVGUrNc8gXn7Wr07su0diQnXhJ/4Rw61
	 n8fDYVYiTHeaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0D94DD4F1E;
	Fri,  8 Dec 2023 15:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Bluetooth: Support SCO offload for QCA2066
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170204822465.3151.16308014426635349043.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 15:10:24 +0000
References: <1702000287-22538-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1702000287-22538-1-git-send-email-quic_zijuhu@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 8 Dec 2023 09:51:25 +0800 you wrote:
> This patch series are to support HFP offload for QCA2066.
> 
> Changes form V3->V4:
> - Bluetooth: hci_conn:
> - - Move non NULL checking into configure_datapath_sync()
> - Bluetooth: qca:
> - - Optimize commmit messages and comments and function names
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: hci_conn: Check non NULL function before calling for HFP offload
    (no matching commit)
  - [v4,2/2] Bluetooth: qca: Support HFP offload for QCA2066
    https://git.kernel.org/bluetooth/bluetooth-next/c/3d41844703fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


